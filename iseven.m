%--------------------------------------------------------------------------
% iseven.m
%
% Input:  n = integer
% 
% Output:
%   1   if n is even
%   0   if n is odd
%  NaN  if n is not an integer
%
%--------------------------------------------------------------------------


function output = iseven(n)


output = 1 - mod(n,2);

if (output ~= 0) && (output ~= 1)
    output = NaN;
end