% ------------------------------------------------------------- y = summ(x)
% SUMM returns the sum of all ements of matrix x.
%
% Outputs:
%           y = sum(x(:))
%
% Note: 
%  For matrices, SUM(x) is a row vector with the sum over each column,
%                whereas SUMM(X) is the sum of all elements. 
%  
%
% Example:
%       x = [1, 2, 9, 3.4, 0.05; 1,2,3,4,5]
%       summ( x )
%        sum( x )
%
% See also:
%   SUM
% -------------------------------------------------------------------------

function Y = summ(X)

Y = sum( X(:) );