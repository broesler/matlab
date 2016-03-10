function [Ap,Bp,Cp,sigma] = realizeERA(H0,H1,m,tol,plot_flag)
% REALIZEERA perform ERA algorithm to recover system matrices (A,B,C) from
% identified system Markov parameters, via Hankel matrices
%
%  [Ap,Bp,Cp] = REALIZEERA(H0,H1,m) returns the primed system matrices A',B',C'
%    given the Hankel matrices H(0), H(1) 
%
%  [Ap,Bp,Cp] = REALIZEERA(H0,H1,m,tol) allows specification of the tolerance
%    for non-zero singular values
%
%  [Ap,Bp,Cp] = realizeERA(H0,H1,m,tol,plot_flag) also plots the singular
%    values of H(0) in figure(plot_flag) for plot_flag > 0
%
%  [Ap,Bp,Cp,sigma] = realizeERA(H0,H1,m,tol,plot_flag) also returns the vector
%    of singular values
%
%  See SVD, HANKEL, MARKOV_HANKEL, MARKOV

%  Created: 02/15/2016, 16:56
%   Author: Bernie Roesler
%
% Last Modified: 03/09/2016, 20:46
%===============================================================================

% Input checking
if (nargin < 3)
    error('Usage: [Ap,Bp,Cp] = realizeERA(H0,H1,tol,plot_flag).')
end

if (size(H0) ~= size(H1))
    error('Hankel matrices must be the same size.')
end

if (nargin < 4)
    tol = 1e-9;
end

if (nargin < 5)
    plot_flag = 0;  % Don't plot by default
end

% H(0) is <mq x mr>
q = size(H0,1)/m;       % number of system outputs
r = size(H0,2)/m;       % number of system inputs

%-------------------------------------------------------------------------------
%       Perform singular value decomposition
%-------------------------------------------------------------------------------
[U,S,V] = svd(H0);

% singular values are on the diagonal of S, ordered largest -> smallest
sigma = diag(S);   

% Find the indices of all sigmas > tol
ind = find( sigma >= tol );
sigmaAllowed = sigma(ind);
n = length(sigmaAllowed);

% Extract useful parts of matrices
Sn = diag(sigmaAllowed);
Un = U(:,1:n);
Vn = V(:,1:n);

%-------------------------------------------------------------------------------
%       ERA Algorithm result
%-------------------------------------------------------------------------------
Ap = Sn^(-1/2) * Un' * H1 * Vn * Sn^(-1/2);

% B' is first r columns
Bp_temp = Sn^(1/2) * Vn';
Bp = Bp_temp(:,1:r);

% C' is first r rows
Cp_temp = Un * Sn^(1/2);
Cp = Cp_temp(1:r,:);

%-------------------------------------------------------------------------------
%       Plot singular values
%-------------------------------------------------------------------------------
if (plot_flag > 0)
    % Plot the singular values vs. index
    figure(plot_flag);
    semilogy(sigma, 'rx', 'MarkerSize', 20)
    hold on;
    
    % Highlight allowed sigma values
    semilogy(ind, sigmaAllowed, 'bx', 'MarkerSize', 20)
    
    % Include line at cutoff point
    semilogy([1 length(sigma)], [tol tol], 'r--', 'LineWidth', 1)
    
    xlim([1 length(sigma)])
    xlabel('Index')
    ylabel('\sigma')
    grid on
end

%===============================================================================
%===============================================================================
