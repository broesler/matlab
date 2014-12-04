function [Ap,Bp,Cp] = ioss(alpha,beta)
%
% IOSS convert I/O form to state-space form.
%
%   [Ap,Bp,Cp] = IOSS(alpha,beta) returns the observable canonical form
%       matrices Ap, Bp, Cp given the system coefficients alpha, beta
%
%       alpha is size < m*p x m >, where alpha_i is < m x m >
%       beta  is size < m*p x r >, where  beta_i is < m x r >
%
%       Ap is size < m*p x m*p >
%       Bp is size < m*p x  r  >
%       Cp is size <  1  x  p  >
%
%   Example:
%       alpha = randn(9,3);
%       beta  = randn(6,2);
%       
%       [Ap,Bp,Cp] = ioss(alpha,beta);
%
%--------------------------------------------------------------------------

% % TEST CODE:
%       alpha = randn(9,3);
%       beta  = randn(6,2);
      
m = size(alpha,2);
r = size(beta, 2);
p = size(alpha,1)/m;

if mod(p,1) ~= 0
    disp('[IOSS.M]: alpha not formatted correctly.')
    return;
end

% Initialize arrays
Ap = zeros(m*p, m*p);
Bp = zeros(m*p,  r );
Cp = zeros( 1 ,  p );

% Fill matrices
Ap(:,1:m) = alpha;

for i = 1:p-1
    Ap(1+(i-1)*m:i*m, 1+i*m:(i+1)*m) = eye(m,m);
end

Bp = beta;

Cp(1) = 1;

end % function
%--------------------------------------------------------------------------