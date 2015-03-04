function [P,Y,V] = sarx(u,y,p,tol,plot_flag)
%
% SARX Solve ARX system ID problem Y = PV.
%
%   P = SARX(u,y) returns estimates of the system parameters
%       P = [a1, a2, ..., ap, b1, b1, ..., bp] using the pseudoinverse of V
%       with a default p = 2, and tol = 3 orders of magnitude (for spinv).
%       
%       y is assumed to be size < L x m >
%       u is assumed to be size < L x r >
%
%       ai will be size < m x m > 
%       bi will be size < m x r >  (Both scalars for SISO system)
%
%       where L = number of time-steps
%             r = number of inputs
%             m = number of outpus
%
%   [P,Y,V] = SARX(u,y) also returns the matrices Y and V in the form:
%
%       Y = [y(p), y(p+1), ..., y(L)];
%
%       V = [y(p-1)  y(p)   ...  y(L-1) 
%            y(p-2)  y(p-1) ...  y(L-2) 
%             ...     ...   ...   ...
%            y(0)    y(1)   ...  y(L-p) 
%            --------------------------
%            u(p-1)  u(p)   ...  u(L-1) 
%            u(p-2)  u(p-1) ...  u(L-2) 
%             ...     ...   ...   ...
%            u(0)    u(1)   ...  u(L-p) ];
%
%       where L is the number of time-steps, p is chosen by the user.
%
%   P = SARX(u,y,p,tol) allows specification of
%       p   = the number of time-steps in the history that are used to
%             estimate the parameters
%       tol = the (integer) number of orders of magnitude below the largest
%             singular value of V used to calculate the pseudo-inverse
%
%   P = SARX(u,y,p,tol,plot_flag) will also plot the singular values of V,
%       generated by spinv(V,tol,plot_flag)
%
%   See also PINV, SPINV.
%

%    Author: Bernie Roesler
%   Created: 05/12/15
%--------------------------------------------------------------------------

if nargin < 3
    p = 2;          % Default values of p and tol
end

if nargin < 4
    tol = 3;
end

if nargin < 5
    plot_flag = 0;
end

% Initialize matrices
m = size(y,2);   % y is size < L x m >
r = size(u,2);   % u is size < L x r >
L = size(y,1)-1; % Both y and u have time as dim 1, # time-steps is dim - 1

Y = zeros(m, L-p+1);
P = zeros(m, p*(m+r));
V = zeros(p*(m+r), L-p+1);

% Define known matrices

% shift indices + 1 for MATLAB
Y = y(p+1:L+1,:)';        % Need row vector for Y

% y block
% move in blocks of m rows, each y is < 1 x m >
% Need index shift 1:m*p --> 0:m*p-1 to account for MATLAB 1-indexing
for i = 0:m:m*p-1   
    
    V(i+1:i+m,:)   = y(p-i:L-i,:)';
    
end
    
% u block
% move in blocks of r rows, each u is < 1 x r >
for i = 0:r:r*p-1         
    
    V(i+p+1:i+p+r,:) = u(p-i:L-i,:)';
    
end

% Find Vinv
Vinv = spinv(V,tol,plot_flag);

% Calculate P = YVinv
P = Y*Vinv;


end % function
%==========================================================================