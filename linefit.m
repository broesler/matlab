function [a,b] = linefit(x,y)
% LINEFIT create a linear least squares fit from given data points
%
% [a,b] = LINEFIT(x,y) returns the coefficients of y = m*x + b
% A = QUADFIT(x,y) returns the coefficients as a vector, y = A(2)*x + A(1)
%
% Input:    x   = x-values of data points
%           y   = y-values of data points
% Output:   a,b = coefficients of y = ax + b
%

%===============================================================================
%     File: linefit.m
%  Created: 27/10/2015, 11:20
%   Author: Bernie Roesler
%===============================================================================

% create X matrix to solve equation X*A=f for A (coefficients)
m = length(x); % number of data points

X = [  m    sum(x); 
     sum(x) sum(x.^2) ];
 
f = [ sum(y);
	  sum(y.*x) ];

% solve for coefficients
A = X\f;

if nargout == 1
    a = A;
else
    a = A(2);
    b = A(1);
end

end
%===============================================================================
%===============================================================================