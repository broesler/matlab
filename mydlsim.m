function [y,x] = mydlsim(A,B,C,D,u,x0)
% MYDLSIM  Simulation of discrete-time linear systems.
%    [Y,X] = MYDLSIM(A,B,C,D,U)  returns the response of the discrete system:
%
%        x[k+1] = Ax[k] + Bu[k]
%        y[k]   = Cx[k] + Du[k]
%
%    to input sequence U.  Matrix U must have as many columns as there
%    are inputs, U.  Each column of U corresponds to a new time point.
%    MYDLSIM(A,B,C,D,U,X0) can be used if initial conditions exist.
%
%    MYDLSIM returns the output and state time history in the matrices Y and X.
%    No plot is drawn on the screen.  Y has as many rows as there
%    are outputs and LENGTH(U) columns.  X has as many rows as there
%    are states and LENGTH(U) columns.
%
%    INPUTS:
%       A   n x n matrix
%       B   n x r matrix
%       C   q x n matrix
%       D   q x r matrix
%       u   l x r matrix, u(k,:) is 1 x r, l is number of time steps
%       x0  n x 1 vector  initial condition
%
%    OUTPUTS:
%       y   l x q matrix, y(k,:) is 1 x q, l is number of time steps
%       x   l x n matrix, x(k,:) is 1 x n, l is number of time steps
%
%    See also:  LSIM, STEP, IMPULSE, INITIAL.

%==============================================================================
%     File: mydlsim.m
%  Created: 01/28/2016, 14:26
%   Author: Bernie Roesler
%
% Last Modified: 01/28/2016, 14:30
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

% Assign sizes
n = size(A,1);      % number of system states
q = size(C,1);      % number of outputs
r = size(B,2);      % number of inputs
l = size(u,1);      % number of time steps

% Check for IC's
if (nargin < 6)
    x0 = zeros(n,1);
elseif (size(x0,1) ~= size(A,1))
    error('A matrix and x0 vector must have same number of rows.')
end

%-------------------------------------------------------------------------------
%       Compute system output history
%-------------------------------------------------------------------------------
% Initialize output
y = zeros(l,q);     % y(k) is <qx1> vector
x = zeros(l,n);     % x(k) is <nx1> vector

% Initial conditions
x(1,:) = x0';

for k = 1:l-1
    y(k,:)   = C*x(k,:)' + D*u(k,:)';
    x(k+1,:) = A*x(k,:)' + B*u(k,:)';
end

% Final output
y(l,:) = C*x(l,:)' + D*u(l,:)';


end % function
%===============================================================================
%===============================================================================
