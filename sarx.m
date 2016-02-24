function [P,Y,V] = sarx(u,y,p,tol,plot_flag)
% SARX Solve ARX system ID problem Y = PV. {{{
%
%   P = SARX(u,y) returns estimates of the system parameters
%       P = [a1, a2, ..., ap, b1, b1, ..., bp] using the pseudoinverse of V
%       with a default p = 2, and tol = 1e-9 (for spinv).
%       
%       y is assumed to be size < l x m >
%       u is assumed to be size < l x r >
%
%       ai will be size < m x m > 
%       bi will be size < m x r >  (Both scalars for SISO system)
%
%       where l = number of time-steps
%             r = number of inputs
%             m = number of outpus
%
%   [P,Y,V] = SARX(u,y) also returns the matrices Y and V in the form:
%
%       Y = [y(p), y(p+1), ..., y(l)];
%
%       V = [y(p-1)  y(p)   ...  y(l-1) 
%            y(p-2)  y(p-1) ...  y(l-2) 
%             ...     ...   ...   ...
%            y(0)    y(1)   ...  y(l-p) 
%            --------------------------
%            u(p)    u(p+1) ...  u(l)
%            u(p-1)  u(p)   ...  u(l-1) 
%             ...     ...   ...   ...
%            u(0)    u(1)   ...  u(l-p) ];
%
%       where l is the number of time-steps, p is chosen by the user.
%
%   P = SARX(u,y,p,tol) allows specification of
%       p   = the number of time-steps in the history that are used to
%             estimate the parameters
%       tol = the zero-tolerance used to calculate the pseudo-inverse
%
%   P = SARX(u,y,p,tol,plot_flag) will also plot the singular values of V,
%       generated by spinv(V,tol,plot_flag)
%
%   See also PINV, SPINV.
%

%    Author: Bernie Roesler
%   Created: 05/12/15
%
% Last Modified: 02/23/2016, 16:23
%----------------------------------------------------------------------------}}}

% % TEST CODE: {{{
% clear all; close all; clc;
% nargin = 3;
% p = 2;
% N = 10;
% y = randn(N,3);     % m = 3
% u = randn(N,4);     % r = 4
% }}}

if nargin < 3
    p = 2;          % Default values of p and tol
end

if nargin < 4
    tol = 1e-9;
end

if nargin < 5
    plot_flag = 0;
end

% Initialize matrices
m = size(y,2);   % y is size < l x m >
r = size(u,2);   % u is size < l x r >
l = size(y,1)-1; % Both y and u have time as dim 1, # time-steps is dim - 1

Y = zeros(m, l-p+1);                % [ y(p) y(p+1) ... y(l) ]
P = zeros(m, p*m + (p+1)*r);        % [ a1 a2 ... ap B0 B1 B2 ... Bp ]
V = zeros(p*m + (p+1)*r, l-p+1);

% shift indices + 1 for MATLAB
Y = y(p+1:l+1,:)';        % transpose for row vector for Y

% y block
% move in blocks of m rows, each y is < 1 x m >
% Need index shift 1:m*p --> 0:m*p-1 to account for MATLAB 1-indexing
for i = 0:p-1   
    V(i*m+1:i*m+m,:) = y(p-i:l-i,:)';               % transpose y to < m x 1 >
end
    
% u block
% move in blocks of r rows, each u is < 1 x r >
for i = 0:p
    V(i*r+1+m*p:i*r+r+m*p,:) = u(p-i+1:l-i+1,:)';   % transpose u to < r x 1 >
end

% Find Vinv
Vinv = spinv(V,tol,plot_flag);

% Calculate P = YVinv
P = Y*Vinv;

%===============================================================================
%===============================================================================
