function [str] = num2bankScalar(num)
% NUM2BANKSCALAR adds commas to a number and returns it as a string

%===============================================================================
%     File: num2bankScalar.m
%  Created: 11/05/2015, 18:25
%   Author: Bernie Roesler
%
% Last Modified: 11/05/2015, 18:30
%===============================================================================

num = floor(num*100)/100;
str = num2str(num);
k = find(str == '.', 1);

if (isempty(k))
  str = [str,'.00'];
end

FIN = min(length(str), find(str == '.') - 1);
for i = FIN-2:-3:2
  str(i+1:end+1) = str(i:end);
  str(i) = ',';
end

end % function
%===============================================================================
%===============================================================================
