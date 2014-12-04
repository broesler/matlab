% ------------------------------------------------------------- y = maxx(x)
% MAXX(x) returns the overall maximum value of matrix x 
%
% Outputs:
%           y = max(x(:))
%
% Note: 
%  For matrices, MAX(x) is a row vector containing the maximum element 
%                from each column, whereas MAXX(x) is the overall maximum. 
%  
%
% Example:
%       x = [1, 2, 9, 3.4, 0.05; 1,2,3,4,5]
%       maxx( x )
%        max( x )
%
% See also:
%   MAX
% -------------------------------------------------------------------------


function y = maxx(x)

y = max(x(:));