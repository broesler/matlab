function [x,w] = lgwt(N,a,b)
% LGWT calculate Gauss points and weights of Legendre polynomials
%
% [x,w] = LGWT(N,-1,1) returns N Gauss points and weights on canonic interval
% [x,w] = LGWT(N,a,b)  returns N Gauss points and weights on any interval [a,b]
%
% Integral of f on [a,b] = sum(w.*f(x));
%
% INPUTS:
%   N     = number of points
%   a,b   = lower and upper bounds of interval, default [-1,1]
%   x     = Gauss point locations (symmetric about 0)
%   w     = weights 
%
% INTERNAL VARIABLES:
%   L     = Legendre-Gauss Vandermonde Matrix
%   Lp    = derivative of L
%

%    File: lgwt.m
% Created: 11/8/2015, 17:50
%  Author: Bernie Roesler
%          Adapted from lgwt.m by Greg von Winckel - 02/25/2004

%===============================================================================
% Declare constants
MAXITER = 1e3; 
eps = 1e-15;     % tolerance
Nm1 = N - 1;
Np1 = N + 1;

% Allocate temp arrays
Lp = zeros(N,1);
 L = zeros(N,Np1);

% initialize xu and n0vec
xu = linspace(-1.0,1.0,N)';     % want column vectors
n0vec = [0:Nm1]';

% Initial guess
y = cos((2*n0vec + 1.0)*pi ./ (2.0*Nm1 + 2.0)) + (0.27/N) * sin(pi*xu*Nm1/Np1);

% Compute the zeros of the (Nm1 + 1 == Nth) Legendre Polynomial
% using the recursion relation and the Newton-Raphson method

% Iterate until new points are uniformly within epsilon of old points
iter = 1;
error = 1;

while (error > eps)
    L(:,1) = 1.0;
    L(:,2) = y;

    for k = 2:N
        L(:,k+1) = ((2*double(k) - 1) .* y .* L(:,k) - (double(k) - 1)*L(:,k-1)) / double(k);
    end

    % Calculate derivative
    Lp = double(Np1)*(L(:,N) - y.*L(:,Np1)) ./ (1 - y.^2);

    % Update guess
    y0 = y;
    y = y0 - L(:,Np1) ./ Lp;

    % Calculate error
    error = max(abs(y - y0));

    % Count iterations
    iter = iter + 1;
    
    if (iter == MAXITER)
        warning('Reached maximum iterations. Error is %4.2e', error)
        break
    end
end

% Linear map from [-1,1] to [a,b]
x = (a*(1 - y) + b*(1 + y)) / 2;

% Compute the weights
w = (b - a) ./ ((1 - y.^2) .* Lp.^2) .* (double(Np1)/double(N)).^2;

end 
%===============================================================================
%===============================================================================