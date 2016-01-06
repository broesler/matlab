% WHODAT whos but with custom formatting to show max/min values
%
%   See also WHOS

%===============================================================================
%     File: whodat.m
%  Created: 01/06/2016, 14:50
%   Author: Bernie Roesler
%===============================================================================
function whodat

% structure of all variables in parent workspace
A = evalin('caller','whos');   
N = numel(A);

% Cell arrays of strings to be printed in each column
names       = cell(N,1);
sizes       = cell(N,1);
classes     = cell(N,1);
mins        = zeros(N,1);
maxes       = zeros(N,1);
attributes  = cell(N,1);

% loop over each variable
for i = 1:N
    names{i} = A(i).name;
    sizes{i} = sprintf('%dx%d',A(i).size(1),A(i).size(2));
    classes{i} = A(i).class;
    mins(i) = min(eval(A(i).name));
    maxes(i) = max(eval(A(i).name));
end

end % function
%===============================================================================
%===============================================================================
