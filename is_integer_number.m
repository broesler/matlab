%--------------------------------------------------------------------------
% is_integer_number.m
%
% Input:  x = any number
% 
% Output:
%   1   if x is an integer
%   0   if x is not an integer
%
%--------------------------------------------------------------------------


function output = is_integer_number(x)


if  x == floor(x);
    output = 1;
else
    output = 0;
end