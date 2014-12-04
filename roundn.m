% ------------------------------------------------------------- roundn(x,n)
% ROUNDN(x,n) returns x rounded to n digits.
%
%    If n is not given, then n = 1 is assumed.
%
% See also:
%   ROUND
% -------------------------------------------------------------------------

function y = roundn(x,n)

if nargin == 1
    y = round(x);
else
   
    y = round(10^n*x)/10^n;
      
end