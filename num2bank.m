function [str]=num2bank(num)
% NUM2BANK converts a number to a string and adds commas to it every 3 digits

%===============================================================================
%     File: num2bank.m
%  Created: 11/05/2015, 18:24
%   Author: Bernie Roesler
%
% Last Modified: 11/05/2015, 18:28
%===============================================================================

str = arrayfun(@(x) num2bankScalar(x) , num, 'UniformOutput', false);

end % function
%===============================================================================
%===============================================================================
