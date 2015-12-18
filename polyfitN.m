function A = polyfitN(x,y,N)
% POLYFITN creates a general Nth order polynomial least squares fit
%
% A = POLYFITN(x,y,N) returns the coefficients as a vector:
%       y = A(N+1)*x^N + A(N)*x^(N-1) + ... +  A(2)*x + A(1)
%
% Input:    x   = x-values of data points
%           y   = y-values of data points
% Output:   A   = coefficients of polynomial
%

%===============================================================================
%     File: polyfitN.m
%  Created: 10/27/2015, 11:20
%   Author: Bernie Roesler
%===============================================================================

% Input error checking
if length(x) < N+1
    error('Improper input. # data points must be >= coefficient number.')
end

% create X and F matrices to solve equation X*A = F for A (coefficients)
X = zeros(N+1,N+1);
F = zeros(N+1,1);

% X matrix takes the form:
%  [  m        sum(x)         ... sum(x.^N)
%    sum(x)    sum(x.^2)      ... sum(x.^(N+1))
%     ...      ...            ... ...
%    sum(x.^N) sum(x.^(N+1))  ... sum(x.^(2N))  ]
%
% F vector takes the form
%  [ sum(y*x^0) sum(y*x^1) ... sum(y*x^N) ]'

for i = 1:N+1
    for j = i:N+1
        X(i,j) = sum(x.^(j+i-2));
        X(j,i) = X(i,j);            % symmetric matrix
    end
    
    F(i) = sum(y .* x.^(i-1));      % increasing powers of x down column
end

% solve for coefficients
A = X\F;

end
%===============================================================================
%===============================================================================