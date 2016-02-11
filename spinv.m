function [C, sigmaAllowed, sigma] = spinv(A, tol, plot_flag)
%
% SPINV compute the pseudo-inverse of A with tuneable parameters.
%
%   C = SPINV(A) returns the pseudo-inverse of a rectangular matrix A,
%       using the default parameters.
%
%   C = SPINV(A, tol) uses only the singular values greater than tol 
%
%   C = SPINV(A, tol, 1) plots the singular values, showing those within
%       the chosen tolerance
%
%   [C,SA] = SPINV(A,...) returns the allowed singular values used to 
%       compute the pseudo-inverse
%
%   [C,SA,S] = SPINV(A,...) returns also returns a vector of all of the
%       singular values
%   
%   Example:
%       A = randn(5,3)*randn(3,10);   % 5 x 10 matrix not full rank
%       tol = 1e-9;
%       plot_flag = 1;
%
%       C = SPINV(A,tol,plot_flag);
%
%   See also PINV, SPINV, SVD.
%

%    Author: Bernie Roesler
%   Created: 05/12/15
%
% Last Modified: 02/04/2016, 15:57
%--------------------------------------------------------------------------

% % UNCOMMENT TO TEST CODE:
% clear all; close all; clc;
% nargin = 3;
% A = randn(5,3)*randn(3,10);   % 5 x 10 matrix not full rank
% tol = 1e-9;
% plot_flag = 1;

if (nargin < 2)
    tol = 1e-9;        % Default order of magnitude
end

if (nargin < 3)
    plot_flag = 0;
end
    
% (1) -------------------------------- Perform singular value decomposition
[U,S,V] = svd(A);

% singular values are on the diagonal of S, ordered largest to smallest
sigma = diag(S);   

%----------------------------------------------- Find number of sigma > TOL
% Find the indices of all sigmas > tol
ind = find( sigma >= tol );

% Vector of all allowed sigmas
sigmaAllowed = sigma(ind);

%--------------------------------------------------------------------------
if plot_flag == 1
    % Plot the singular values vs. index
    figure;
    semilogy(sigma, 'rx', 'MarkerSize', 10)
    hold all
    
    % Highlight allowed sigma values
    semilogy(ind, sigmaAllowed, 'bx', 'MarkerSize', 10)
    
    % Include line at cutoff point
    semilogy([1 length(sigma)], [tol tol], 'r--', 'LineWidth', 1)

    xlabel('Index')
    ylabel('\sigma')

    grid on
end

% (2) ----------------------- Extract square of S using only allowed sigmas
maxind = max(ind); 

S1 = diag(sigmaAllowed);    % maximum size of S is < maxind x maxind >

U1 = U(:,1:maxind);         % Take maxind columns of U and V
V1 = V(:,1:maxind);

% (3) ----------------------------------------- Compute pseudo-inverse of A
C = V1 * (S1 \ U1');


% % TEST CODE: THESE SHOULD ALL BE 0!!
% maxval(abs( U1*S1*V1' -      A  ))
% maxval(abs(    C      - pinv(A) ))
% maxval(abs(    U'     -  inv(U) ))
% maxval(abs(    V'     -  inv(V) ))

%==============================================================================
%==============================================================================
