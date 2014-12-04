% ------------------------------------------------------------- y = minn(x)
% MINN(x) returns the overall minimum value of matrix x 
%
% Outputs:
%           y = min(x(:))
%
% Note: 
%  For matrices, MIN(x) is a row vector containing the minimum element 
%                from each column, whereas MAXX(x) is the overall minimum. 
%  
%
% Example:
%       x = [1, 2, 9, 3.4, 0.05; 1,2,3,4,5]
%       minn( x )
%        min( x )
%
% See also:
%   MIN
% -------------------------------------------------------------------------

function m = minn(x)

m = min(x(:));