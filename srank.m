function [R, sigmaAllowed, sigma] = srank(A, tol, plot_flag)
%
% SRANK compute the effective rank of matrix A with tuneable parameters.
%
%   C = SRANK(A) returns the pseudo-inverse of a rectangular matrix A,
%       using the default parameters.
%
%   C = SRANK(A, tol) uses only the singular values greater than tol
%
%   C = SRANK(A, tol, 1) plots the singular values, showing those within
%       the chosen tolerance
%
%   [C,SA] = SRANK(A,...) returns the allowed singular values used to 
%       determine the rank
%
%   [C,SA,S] = SRANK(A,...) returns also returns a vector of all of the
%       singular values
%   
%   Example:
%       A = randn(5,3)*randn(3,10);   % 5 x 10 matrix not full rank
%       tol = 1e-9;
%       plot_flag = 1;
%
%       C = SRANK(A,tol,plot_flag);
%
%   See also PINV, SPINV, SVD, RANK.
%

%    Author: Bernie Roesler
%   Created: 05/12/15
%
% Last Modified: 02/04/2016, 16:25
%--------------------------------------------------------------------------

% UNCOMMENT TO TEST CODE:
% clear all; close all; clc;
% nargin = 3;
% A = randn(5,3)*randn(3,10);   % 5 x 10 matrix of rank 3
% tol = 1e-9;
% plot_flag = 1;

if (nargin < 2)
    tol = 1e-9;        % Default order of magnitude
end

if (nargin < 3)
    plot_flag = 0;  % Don't plot by default
end
    
%------------------------------------- Perform singular value decomposition
[U,S,V] = svd(A);

% singular values are on the diagonal of S, ordered largest -> smallest
sigma = diag(S);   

% Find the indices of all sigmas > tol
ind = find( sigma >= tol );

% Vector of all allowed sigmas
sigmaAllowed = sigma(ind);

%--------------------------------------------------------------------------
if plot_flag == 1
    % Plot the singular values vs. index
    figure;
    semilogy(sigma, 'rx', 'MarkerSize', 20)
    hold all
    
    % Highlight allowed sigma values
    semilogy(ind, sigmaAllowed, 'bx', 'MarkerSize', 20)
    
    % Include line at cutoff point
    semilogy([1 length(sigma)], [tol tol], 'r--', 'LineWidth', 1)
    
    xlabel('Index')
    ylabel('\sigma')
    grid on
end

% True rank of matrix
R = length(sigmaAllowed);

%==========================================================================
%==========================================================================
