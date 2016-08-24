function S = whodat(varargin)
% WHODAT whos but with custom formatting to show max/min values
%
%  A = WHODAT(...) returns a structure with fields:
%      name           char
%      size           1x2 double
%      bytes          1x1 double
%      class          char
%      global         logical
%      sparse         logical
%      complex        logical
%      nesting        1x1 struct with fields:
%         function        char
%         level           int
%      persistent     logical
%
%  Example:
%    a = exp(1)*1e8;                                    % large number
%    b = 15;                                            % standard float
%    v = [-8:6];                                        % vector
%    c = v + 1i*0.25*v;                                 % complex vector
%    l = true;                                          % logical
%    str = 'this is a very very big string.';           % string
%    t = struct('a',a,'b',b,'c',c,'v',v,'str',str);     % struct
%    r = {a, b, c; v, str, t};                          % cell array
%
%    whodat
%
%   See also WHO, CLEAR, CLEARVARS, SAVE, LOAD.

%  Created: 01/06/2016, 14:50
%   Author: Bernie Roesler
%===============================================================================

%-------------------------------------------------------------------------------
%       Parse Inputs: 
%-------------------------------------------------------------------------------
% -file takes first argument following it (not including '-regexp') as parameter
% -regexp|none takes *all* arguments except the first after '-file' as patterns,
%   regardless of its position in the input
%
% Parse inputs for filename or regexp

% TEST CODE:
% varargin = {'wM'}; % one name
% varargin = {'err*'}; % wildcard
% varargin = {'-file','test.mat'}; % file with wildcard
% varargin = {'-file','test.mat','err*'}; % file with wildcard
% varargin = {'-regexp','^e.*'}; % regexp
% varargin = {'-file','test.mat','-regexp','^err'}; % file with regexp
% varargin = {'-regexp','^err','-file','test.mat'}; % file with regexp
% varargin = {'^err','-file','test.mat','-regexp'}; % file with regexp
% varargin = {'-file'}; % file with no filename
% nargin = length(varargin);

% Set defaults
file_flag   = false;
regexp_flag = false;
pats        = {};

if nargin > 0
    % Check for '-file' and/or '-regexp' flags, and store indices in varargin
    fileidx     = find(strcmp(varargin, '-file'));
    regexpidx   = find(strcmp(varargin, '-regexp'));
    filenameidx = [];

    % Check for a regexp request
    if ~isempty(regexpidx)
        regexp_flag = true;
    end

    % Check for a file request
    if ~isempty(fileidx) 
        file_flag = true;

        % if '-file' is the last argument, throw an error
        if fileidx == nargin
            error('File name not given.')
        else
            if ~regexp_flag
                % if we don't have a regexp, then just get the filename
                filename = varargin{fileidx+1};
                filenameidx = fileidx+1;
            else
                % if the next argument after '-file' is not '-regexp'
                if (fileidx+1 ~= regexpidx)
                    filename = varargin{fileidx+1};
                    filenameidx = fileidx+1;
                else
                    % else take the first argument after '-regexp'
                    filename = varargin{regexpidx+1};
                    filenameidx = regexpidx+1;
                end
            end
        end
    end

    % The rest of the inputs are patterns
    patidx = setdiff(1:nargin,[fileidx filenameidx regexpidx]);

    if ~isempty(patidx)
        pats = varargin{patidx};
    end
end

%-------------------------------------------------------------------------------
%        Main Process:
%-------------------------------------------------------------------------------
% NOTE: Using arguments like whos does not work, because 
%    A = evalin('caller','whos N x y') 
% is an invalid MATLAB expression, but 
%    evalin('caller', 'A = whos('N','x','y')')
% just assigns A in the caller's workspace, defeating the purpose.
%
% Instead, implement arguments when printing things out, below.

% Get structure of variables in calling function workspace (i.e. main)
if file_flag
    A = whos('-file',filename);
    M = matfile(filename,'Writable',false);    % load matfile for parsing
else
    A = evalin('caller','whos');
end

% Make sure we have variables to list
if isempty(A)
    return
end

% Get all names matching patterns
allnames = {A.name}';

if isempty(pats)
    matchidx = 1:numel(A); % print all items
else
    % Else search for patterns
    if regexp_flag
        matchidx = [];
        for i = 1:length(pats)
            ismatch = ~cellfun(@isempty, regexp(allnames,pats{i}));
            matchidx = [matchidx; find(ismatch)];
        end
    else
    end
end

% Number of variables matching patterns
N = length(matchidx);

% Arrays to be printed in each column
names       = cell(N,1);
sizes1      = cell(N,1);
sizes2      = cell(N,1);
classes     = cell(N,1);
mins        = cell(N,1);
maxs        = cell(N,1);
attributes  = cell(N,1);
ndim        = zeros(N,1);

%-------------------------------------------------------------------------------
%       loop over each variable to build columns
%-------------------------------------------------------------------------------
% Stab at vectorization:
% logical indexing for if statements
% names = {A(:).name}';
% sizes = cellfun(@(x) sprintf('%d', x), {A.size}); 

for i = matchidx
    % Varable names
    names{i} = A(i).name;

    %---------------------------------------------------------------------------
    %       Size column
    %---------------------------------------------------------------------------
    ndim(i) = length(A(i).size);

    sizes1{i} = num2str(A(i).size(1));
    if (ndim(i) == 2)
        sizes2{i} = num2str(A(i).size(2));
    elseif (ndim(i) == 3)
        sizes2{i} = sprintf('%dx%d', A(i).size(2), A(i).size(3));
    else
        sizes2{i} = sprintf('%d-D', ndim(i));
    end

    %---------------------------------------------------------------------------
    %       Type of variable
    %---------------------------------------------------------------------------
    classes{i} = A(i).class;

    %---------------------------------------------------------------------------
    %       Max/min values
    %---------------------------------------------------------------------------
    % Get actual value as a temp variable
    if file_flag
        % use "dynamic field name"
        temp = M.(A(i).name);
    else
        % evaluate the variable in the parent workspace
        temp = evalin('caller', A(i).name);
    end

    if isnumeric(temp)
        if isreal(temp)
            mins{i} = sprintf('%.5g', full(min(temp(:))));
            maxs{i} = sprintf('%.5g', full(max(temp(:))));
        else % iscomplex...
            nr_min = full(min(temp(:)));
            nr_max = full(max(temp(:)));

            rstr_min = sprintf('%.5g',  abs(real(nr_min)));
            istr_min = sprintf('%.5gi', abs(imag(nr_min)));

            rstr_max = sprintf('%.5g',  abs(real(nr_max)));
            istr_max = sprintf('%.5gi', abs(imag(nr_max)));

            % print signs correctly
            if (real(nr_min) < 0)
                rstr_min = ['-' rstr_min];
            end

            if (real(nr_max) < 0)
                rstr_max = ['-' rstr_max];
            end

            if (imag(nr_min) < 0)
                istr_min = [' - ' istr_min];
            else
                istr_min = [' + ' istr_min];
            end

            if (imag(nr_max) < 0)
                istr_max = [' - ' istr_max];
            else
                istr_max = [' + ' istr_max];
            end

            mins{i} = [rstr_min istr_min]; 
            maxs{i} = [rstr_max istr_max]; 
        end
    elseif ( islogical(temp) && isscalar(temp) )
        if (temp)
            mins{i} = 'T';
            maxs{i} = 'T';
        else
            mins{i} = 'F';
            maxs{i} = 'F';
        end
    % For logical arrays, strings, structs, cells, etc. max/min not defined
    else
        mins{i} = '-';
        maxs{i} = '-';
    end

    %---------------------------------------------------------------------------
    %       Attributes
    %---------------------------------------------------------------------------
    attributes{i} = '';

    if A(i).global
        attributes{i} = 'global';
    end

    if A(i).sparse 
        if ~isempty(attributes{i})
            attributes{i} = [attributes{i} ',sparse'];
        else
            attributes{i} = 'sparse';
        end
    end

    if A(i).complex 
        if ~isempty(attributes{i})
            attributes{i} = [attributes{i} ',complex'];
        else
            attributes{i} = 'complex';
        end
    end

    if A(i).persistent 
        if ~isempty(attributes{i})
            attributes{i} = [attributes{i} ',persistent'];
        else
            attributes{i} = 'persistent';
        end
    end
    
    % Print strings in attributes
    if ischar(temp)
        nchar = 18;
        strlen = length(temp);

        % If string is too long, print with elipses
        pstr = ['''' sprintf('%.*s',nchar,temp)];
        if (strlen <= nchar)
            pstr = [pstr ''''];
        else
            pstr = [pstr(1:end-3) '...'];
        end

        % Print string in attribute list
        if ~isempty(attributes{i})
            attributes{i} = [attributes{i} ', ' pstr];
        else
            attributes{i} = pstr;
        end
    end

    % Print number of fields in struct
    if isstruct(temp)
        nf = length(fieldnames(temp));
        pstr = sprintf('%d fields', nf);

        if ~isempty(attributes{i})
            attributes{i} = [attributes{i} ', ' pstr];
        else
            attributes{i} = pstr;
        end
    end

    % Print in-line functions
    if isa(temp,'function_handle')
        pstr = sprintf('%s', func2str(temp));

        if ~isempty(attributes{i})
            attributes{i} = [attributes{i} ', ' pstr];
        else
            attributes{i} = pstr;
        end
    end
end

%-------------------------------------------------------------------------------
%       Create format specifiers
%-------------------------------------------------------------------------------
% TODO: Add formatting for N-dim array sizes (i.e. 5x10x1000)
% find longest string in each cell, or length of header
nlen  = max( length('Name'), max(cellfun(@length, names)) );
slen1 = max( 1, max(cellfun(@length, sizes1)) );
slen2 = max( 2, max(cellfun(@length, sizes2)) );
clen  = min( 8, max(cellfun(@length, classes)) ); % ignore long matlab classes
milen = max( length('Min'), max(cellfun(@length, mins)) );
malen = max( length('Max'), max(cellfun(@length, maxs)) );
alen  = max( length('Attributes'), max(cellfun(@length, attributes)) );

nfmt  = ['%-' num2str(2+nlen)  '.' num2str(nlen)  's'];
sfmt  = ['%-' num2str(1+slen1+slen2) 's'];
sfmt1 = ['%'  num2str(slen1) 's']; 
sfmt2 = ['%-' num2str(slen2) 's']; 
cfmt  = ['%-' num2str(1+clen)  '.' num2str(clen)  's'];
mifmt = ['%'  num2str(1+milen) '.' num2str(milen) 's'];
mafmt = ['%'  num2str(1+malen) '.' num2str(malen) 's'];
afmt  = ['%-' num2str(2+alen)  '.' num2str(alen)  's'];

%-------------------------------------------------------------------------------
%       Print output
%-------------------------------------------------------------------------------
if nargout == 1
    S = A;  % output with no printing
else
    % Header line
    fprintf(['  ' nfmt '  ' sfmt '   ' cfmt ' ' mifmt ' ' mafmt '  ' afmt '\n\n'],...
        'Name', 'Size', 'Class', 'Min', 'Max', 'Attributes')

    % List variables
    for i = 1:N
        if (ndim(i) < 4)
            fprintf(['  ' nfmt '  ' sfmt1 'x' sfmt2 '   ' cfmt ' ' mifmt ' ' mafmt '  ' afmt '\n'],...
                names{i}, sizes1{i}, sizes2{i}, classes{i}, mins{i}, maxs{i}, attributes{i}) 
        else
            % Need format to ensure class is aligned with the rest of classes
            fprintf(['  ' nfmt '     ' sfmt cfmt ' ' mifmt ' ' mafmt '  ' afmt '\n'],...
                names{i}, sizes2{i}, classes{i}, mins{i}, maxs{i}, attributes{i}) 
        end
    end
    fprintf('\n')
end

end % function
%===============================================================================
%===============================================================================
