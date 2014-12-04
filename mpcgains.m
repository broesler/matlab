function [G,H] = mpcgains(Gp, alpha, beta)
%
% MPCGAINS find I/O controller gains G, H from predictive controller gain
%
%   [G,H] = mpcgains(Gp, alpha, beta) returns the controller gain matrices
%       G and H given the predictive controller gain Gp, and system 
%       coefficients alpha and beta
%
%       Gp    is size < q*r x m*p >
%       alpha is size < m*p x  m  >, where alpha_i is < m x m >
%       beta  is size < m*p x  r  >, where  beta_i is < m x r >
%
%       G     is size < r x m*p >
%       H     is size < r x r*p >
%
%--------------------------------------------------------------------------
      
m = size(alpha,2);
r = size(beta, 2);
p = size(alpha,1)/m;

if mod(p,1) ~= 0
    disp('[IOSS.M]: alpha not formatted correctly.')
    return;
end

% Initialize arrays
G = zeros(r, m*p);
H = zeros(r, r*p);

for i = 1:p
    G(:,1+(i-1)*m:i*m) = Gp(:,1:p+1-i) * alpha(i:p,:);
    H(:,1+(i-1)*m:i*m) = Gp(:,1:p+1-i) *  beta(i:p,:);
end

end % function
%--------------------------------------------------------------------------