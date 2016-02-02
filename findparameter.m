function [c,ind] = findparameter(str, key)
% FINDPARAMETER returns a numerical value following a key string in a data string
%
%   Example:
%       c = FINDPARAMETER('$Re  = 1000;', 'Re = '); returns 1000.
%       [c,ind] = FINDPARAMETER('$Re  = 1000;', 'Re = '); also returns the
%           starting index of the matched string, 2 in this case.
%
%   See also STRFIND, SSCANF, REGEXP

%===============================================================================
%     File: findparameter.m
%  Created: 01/25/2016, 17:41
%   Author: Bernie Roesler
%
% Last Modified: 01/25/2016, 17:46
%===============================================================================

ind = strfind(str, key);
c = sscanf(str(ind(1) + length(key):end), '%g', 1);

end % functions
%===============================================================================
%===============================================================================
