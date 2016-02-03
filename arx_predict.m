function y = arx_predict(u,yt,P)
%
%  ARX_PREDICT runs ARX model forwards in time given inputs, IC and P matrix
%
%  y = ARX_PREDICT(u,yt,P) returns output values given input sequence
%
%  INPUTS:
%   u   l+1 x r   input sequence
%   yt  p   x q   initial values for starting model, need p steps
%   P   1   x p   row vector of coefficients P = [a1 a2 ... ap B0 B1 ... Bp]
%
%  OUTPUTS:
%   y   l+1 x q   output values predicted by ARX model
%

%===============================================================================
%     File: arx_predict.m
%  Created: 02/02/2016, 17:04
%   Author: Bernie Roesler
%
% Last Modified: 02/02/2016, 17:34
%===============================================================================

if (nargin < 3)
    error('Usage: y = arx_predict(u,y,P)')
end

l = size(u,1) - 1;  % number of time steps
p = size(yt,1);     % initial condition "true" values

if (p ~= (size(P,2) - 1)/2)
    error('P must be size 2p + 1 = [a1 a2 ... ap B0 B1 ... Bp].')
end

% Initialize solution
y = zeros(l+1,1);
y(1:p,:) = yt;

for k = p+1:l+1
    y(k) = sum(P .* [y(k-1:-1:k-p)' u(k:-1:k-p)']);
end

%===============================================================================
%===============================================================================
