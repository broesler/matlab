% ----------------------------------------------------------- y = maxabs(x)
% MAXABS(x) returns the maximum absolute value of x
%
% Example:
%       x = [1, 2, -9, 3.4, 0.05; 1,2,3,4,5]
%       maxabs( x )
%
% See also:
%   MAX, ABS
% -------------------------------------------------------------------------

function y = maxabs(x)

y = max(abs(x(:)));