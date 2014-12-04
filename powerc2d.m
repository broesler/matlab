function [A, B] = powerc2d(Ac, Bc, dt, n)

% POWERC2D convert continuous-time ss system to discrete time using power
%   series.
%
% [A, B] = POWERC2D(Ac,Bc,dt) returns coefficient matrices A,B for a time
%          step of dt, using 5 terms in the series.
% [A, B] = POWERC2D(Ac,Bc,dt,n) returns coefficient matrices A,B for a time
%          step of dt, using n terms in the series.
%

if nargin == 3
    n = 5;
end

A = 0*Ac;
B = 0*Bc;

for ii = 0:n
    A = A + (1/factorial(ii)) * Ac^ii * dt^ii;
    
    B = B + ((1/factorial(ii+1)) * Ac^ii * dt^(ii+1)) * Bc ; 
end

end % function powerc2d
%--------------------------------------------------------------------------