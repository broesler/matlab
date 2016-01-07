% WHODAT whos but with custom formatting to show max/min values
%
% A = WHODAT returns a structure of all variables in workspace, with fields:
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
%   See also WHOS

%===============================================================================
%     File: whodat.m
%  Created: 01/06/2016, 14:50
%   Author: Bernie Roesler
%===============================================================================
function S = whodat(varargin)

% Allowing arguments like whos does not work, because 
%+    A = evalin('caller','whos N x y') 
%+ is an invalid MATLAB expression, but 
%+    evalin('caller', 'A = whos('N','x','y')')
%+ just assigns A in the caller's workspace, defeating the purpose.

% Structure of variables in calling function workspace (i.e. main)
A = evalin('caller','whos');

% Make sure we have variables to list
if isempty(A)
    return
else
    N = numel(A);
end

% Arrays to be printed in each column
names       = cell(N,1);
sizes1      = cell(N,1);
sizes2      = cell(N,1);
classes     = cell(N,1);
mins        = cell(N,1);
maxes       = cell(N,1);
attributes  = cell(N,1);
ndim        = zeros(N,1);

%-------------------------------------------------------------------------------
%       loop over each variable to build columns
%-------------------------------------------------------------------------------
for i = 1:N
    names{i} = A(i).name;

    % Check for number of dimensions
    ndim(i) = length(A(i).size);

    sizes1{i} = num2str(A(i).size(1));
    if (ndim(i) == 2)
        sizes2{i} = num2str(A(i).size(2));
    elseif (ndim(i) == 3)
        sizes2{i} = sprintf('%dx%d', A(i).size(2), A(i).size(3));
    else
        sizes2{i} = sprintf('%d-D', ndim(i));
    end

    classes{i} = A(i).class;

    % Report actual values if numeric
    temp = evalin('caller', A(i).name);
    if (isnumeric(temp))
        mins{i}  = num2str(min(temp(:)));
        maxes{i} = num2str(max(temp(:)));
    else
        mins{i} = '-';
        maxes{i} = '-';
    end

    % Create attribute list
    attributes{i} = '';

    if (A(i).global)
        attributes{i} = 'global';
    end

    if (A(i).sparse) 
        if (~isempty(attributes{i}))
            attributes{i} = [attributes{i} ',sparse'];
        else
            attributes{i} = 'sparse';
        end
    end

    if (A(i).complex) 
        if (~isempty(attributes{i}))
            attributes{i} = [attributes{i} ',complex'];
        else
            attributes{i} = 'complex';
        end
    end

    if (A(i).persistent) 
        if (~isempty(attributes{i}))
            attributes{i} = [attributes{i} ',persistent'];
        else
            attributes{i} = 'persistent';
        end
    end
end

%-------------------------------------------------------------------------------
%       Create format specifiers
%-------------------------------------------------------------------------------
% TODO Add formatting for N-dim array sizes (i.e. 5x10x1000)
% find longest string in each cell, or length of header
nlen  = max( length('Name'), max(cellfun(@length, names)) );
slen1 = max( 1, max(cellfun(@length, sizes1)) );
slen2 = max( 2, max(cellfun(@length, sizes2)) );
clen  = min( 8, max(cellfun(@length, classes)) ); % ignore long matlab classes
milen = max( length('Min'), max(cellfun(@length, mins)) );
malen = max( length('Max'), max(cellfun(@length, maxes)) );
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
                names{i}, sizes1{i}, sizes2{i}, classes{i}, mins{i}, maxes{i}, attributes{i}) 
        else
            % Need format to ensure class is aligned with the rest of classes
            fprintf(['  ' nfmt '     ' sfmt cfmt ' ' mifmt ' ' mafmt '  ' afmt '\n'],...
                names{i}, sizes2{i}, classes{i}, mins{i}, maxes{i}, attributes{i}) 
        end
    end
    fprintf('\n')
end

end % function
%===============================================================================
%===============================================================================
