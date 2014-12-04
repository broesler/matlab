%--------------------------------------------------------------------------
% isodd.m
%
% Input:  n = integer
% 
% Output:
%   1   if n is odd
%   0   if n is even
%  NaN  if n is not an integer
%
%--------------------------------------------------------------------------


function output = isodd(n)


output = mod(n,2);

if (output ~= 0) && (output ~= 1)
    output = NaN;
end