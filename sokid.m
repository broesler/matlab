function [P,Y,V] = sokid(u,y,p,tol,plot_flag)
% SOKID Solve ARX system ID problem Y = PV. {{{
%
%   P = SOKID(u,y) returns estimates of the observer Markov parameters
%       P = [D CB CAB CA^2B ... CA^(p-1)B] using the pseudoinverse of V
%       with a default p = 2, and tol = 3 orders of magnitude (for spinv).
%       
%       y is assumed to be size < l x q > s.t. y(k,:)' = < q x 1 >
%       u is assumed to be size < l x r > s.t. u(k,:)' = < r x 1 >
%
%       D     will be size < q x r > 
%       CA^iB will be size < q x (q+r) > 
%
%       where l = number of time-steps
%             r = number of inputs
%             q = number of outpus
%
%   [P,Y,V] = SOKID(u,y) also returns the matrices Y and V in the form:
%
%       Y = [y(p), y(p+1), ..., y(l)];
%
%       V = [u(p)    u(p+1) ...  u(l) 
%            v(p-1)  v(p)   ...  v(l-1) 
%             ...     ...   ...   ...
%            v(0)    v(1)   ...  v(l-p) ];
%
%       where l is the number of time-steps, p is chosen by the user.
%
%   P = SOKID(u,y,p,tol) allows specification of
%       p   = the number of time-steps in the history that are used to
%             estimate the parameters
%       tol = the (integer) number of orders of magnitude below the largest
%             singular value of V used to calculate the pseudo-inverse
%
%   P = SOKID(u,y,p,tol,plot_flag) will also plot the singular values of V,
%       generated by spinv(V,tol,plot_flag)
%
%   Inputs:
%     u  l x r  matrix of r system  inputs for l timesteps
%     y  l x q  matrix of q system outputs for l timesteps
%     p  1 x 1  number of Markov parameters to return
%
%     Optional:
%     tol       1 x 1 value below which singular values will be considered == 0
%     plot_flag 1 x 1 if == 0, no plot of singular values, 
%                     otherwise use figure(plot_flag)
%
%   Outputs:
%     P  q x (r + p*(r+q))  matrix of system Markov parameters
%     
%     Optional:
%     Y  q x (l-p+1)                matrix of system output values 
%     V  (r + p*(r+q)) x (1-p+1)    matrix of input and output values on RHS
%
%   See also PINV, SPINV, SARX.
%

%    Author: Bernie Roesler
%   Created: 05/12/15
%
% Last Modified: 03/14/2016, 18:18
%----------------------------------------------------------------------------}}}

% TEST CODE: {{{
% clear;
% nargin = 3;
% p = 2;
% N = 10;
% y = randn(N,3);     % q = 3
% u = randn(N,4);     % r = 4
% }}}

if (nargin < 4)
    tol = 1e-9;
end

if (nargin < 5)
    plot_flag = 0;
end

if (size(u,1) ~= size(y,1))
    error('Usage: u and y must have the same number of columns.')
end

% Initialize matrices
q = size(y,2);   % y is size < l x q >
r = size(u,2);   % u is size < l x r >
l = size(y,1)-1; % Both y and u have time as dim 1, # time-steps is dim - 1

Y = zeros(q, l-p+1);                % [ y(p) y(p+1) ... y(l) ]
P = zeros(q, r + p*(r+q));          % [D CB CAB CA^2B ... CA^(p-1)B]
V = zeros(r + p*(r+q), l-p+1);      % defined above

% shift indices + 1 for MATLAB
Y = y(p+1:l+1,:)';        % transpose for row vector for Y

% u block (first "row" of V only)
V(1:r,:) = u(p+1:l+1,:)';
    
% v block
v = [u'; y'];   % < (r+q) x l > matrix
for i = 1:p
    V(i*(r+q)-q+1:i*(r+q)+r ,:) = v(:,p-i+1:l-i+1);
end

% Find Vinv
Vinv = spinv(V,tol,plot_flag);

% Calculate P = YVinv
P = Y*Vinv;

% TEST CODE: {{{
% size_test = [q, p*(r+q) + r];
% if all(size(P) == size_test)
%     disp('Size test passed!')
% end
% }}}

%===============================================================================
%===============================================================================
