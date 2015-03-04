function [A, B] = powerc2d(Ac, Bc, dt, n)
%
% POWERC2D convert continuous-time ss system to discrete time using power
%   series.
%
% [A, B] = POWERC2D(Ac,Bc,dt) returns coefficient matrices A,B for a time
%          step of dt, using 5 terms in the series.
% [A, B] = POWERC2D(Ac,Bc,dt,n) returns coefficient matrices A,B for a time
%          step of dt, using n terms in the series.
%

%    Author: Bernie Roesler
%   Created: 05/12/15
%--------------------------------------------------------------------------

if nargin < 4
    n = 5;
end

A = zeros(size(Ac));
B = zeros(size(Bc));

for i = 0:n
    A = A + (1/factorial(i)) * Ac^i * dt^i;
    
    B = B + ((1/factorial(i+1)) * Ac^i * dt^(i+1)) * Bc ; 
end

end % function powerc2d
%--------------------------------------------------------------------------