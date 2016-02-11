function [xhat,yhat] = observe(A,B,C,D,G,u,y,x0)
% OBSERVE create state prediction from input and output histories 
%
%   xhat = OBSERVE(A,B,C,D,G,u,y) returns the system state estimate given the
%       discrete-time system matrices {A,B,C,D}, the observer gain matrix G,
%       the input history u, and the output history y assuming 0 initial
%       conditions:
%
%       xhat(k+1) = A*xhat(k) + B*u(k) - G*[y(k) - yhat(k)]
%         yhat(k) = C*xhat(k) + D*u(k)
%
%   xhat = OBSERVE(A,B,C,D,G,u,y,x0) allows specification of non-zero IC's
%
%   [xhat,yhat] = OBSERVE(A,B,C,D,G,u,y,x0) also returns the estimated output
%
%   INPUTS:
%       A   n x n matrix
%       B   n x r matrix
%       C   q x n matrix
%       D   q x r matrix
%       G   n x 1 vector
%       u   l x r matrix, u(k,:) is 1 x r, l is number of time steps
%       y   l x q matrix, y(k,:) is 1 x q, l is number of time steps
%       x0  n x 1 vector  initial condition
%
%   OUTPUTS:
%       xhat   l x n matrix, xhat(k,:) is 1 x n, l is number of time steps
%       yhat   l x q matrix, yhat(k,:) is 1 x q, l is number of time steps

%  Created: 02/11/2016, 14:48
%   Author: Bernie Roesler
%
% Last Modified: 02/11/2016, 15:52
%===============================================================================

%-------------------------------------------------------------------------------
%       Input checking
%-------------------------------------------------------------------------------
if (size(A,1) ~= size(A,2))
    error('A matrix must be square.')
end

if (size(B,1) ~= size(A,2))
    error('A and B matrices must have same number of rows.')
end

if (size(C,2) ~= size(A,2))
    error('A and C matrices must have same number of columns.')
end

if (size(D,2) ~= size(B,2))
    error('B and D matrices must have same number of columns.')
end

if (size(u,2) ~= size(B,2))
    error(['u is formatted as u(k,:) where k is the time-step.' ...
           ' u and B must have the same number of columns.'])
end

% Assign sizes
n = size(A,1);      % number of system states
q = size(C,1);      % number of outputs
r = size(B,2);      % number of inputs
l = size(u,1);      % number of time steps

% Check for IC's
if (nargin < 8)
    % Assume zero IC
    x0 = zeros(n,1);
elseif (size(x0,1) ~= size(A,1))
    error('A matrix and x0 vector must have same number of rows.')
end

%-------------------------------------------------------------------------------
%       Run state estimator
%-------------------------------------------------------------------------------
% Initialize output
yhat = zeros(l,q);     % y(k) is <qx1> vector
xhat = zeros(l,n);     % x(k) is <nx1> vector

% Initial conditions
xhat(1,:) = x0';

for k = 1:l-1
    yhat(k,:)   = C*xhat(k,:)' + D*u(k,:)';
    xhat(k+1,:) = A*xhat(k,:)' + B*u(k,:)' - G*(y(k,:)' - yhat(k,:)');

    % OR:
    % xhat(k+1,:) = (A + G*C)*xhat(k,:)' + (B + G*D)*u(k,:)' - G*y(k,:)';
end

% Final output
yhat(l,:) = C*xhat(l,:)' + D*u(l,:)';

%===============================================================================
%===============================================================================
