function [a,b,c] = quadfit(x,y)
% QUADFIT create a quadratic least squares fit from given data points
%
%
% [a,b,c] = QUADFIT(x,y) returns the coefficients of y = a*x^2 + b*x + c
% A = QUADFIT(x,y) returns the coefficients as a vector:
%       y = A(3)*x^2 + A(2)*x + A(1)
%
% Input:    x   = x-values of data points
%           y   = y-values of data points
% Output:   A, or {a,b,c} = coefficients of y = ax + b
%

%===============================================================================
%     File: linefit.m
%  Created: 27/10/2015, 11:20
%   Author: Bernie Roesler
%===============================================================================

% create X matrix to solve equation X*A=f for A (coefficients)
m = length(x); % number of data points

X = [  m       sum(x)    sum(x.^2); 
     sum(x)    sum(x.^2) sum(x.^3);
     sum(x.^2) sum(x.^3) sum(x.^4) ];
 
F = [ sum(y);
	  sum(y.*x);
      sum(y.*x.^2) ];

% solve for coefficients
A = X\F;

switch nargout
case 1
    a = A;
case 2
    error('No enough output arguments. Usage: A = quadfit(x,y); or [a,b,c] = quadfit(x,y)')
case 3
    a = A(3);
    b = A(2);
    c = A(1);
end

end
%===============================================================================
%===============================================================================