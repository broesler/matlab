function [R, sigmaAllowed, sigma] = srank(A, tol, plot_flag)
%
% SRANK compute the effective rank of matrix A with tuneable parameters.
%
%   C = SRANK(A) returns the pseudo-inverse of a rectangular matrix A,
%       using the default parameters.
%
%   C = SRANK(A, tol) uses only the singular values greater than tol orders
%       of magnitude less than the maximum singular value
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
%       A = magic(100);
%       tol = 3;
%       plot_flag = 1;
%
%       C = SRANK(A,tol,plot_flag);
%
%   See also SPINV, SVD
%

%--------------------------------------------------------------------------
% % TEST CODE
% A = magic(100);
% tol = 3;
% plot_flag = 1;

if nargin < 2
    tol = 3;        % Default order of magnitude
end

if nargin < 3
    plot_flag = 0;  % Don't plot by default
end
    
%------------------------------------- Perform singular value decomposition
[U,S,V] = svd(A);

% singular values are on the diagonal of S, ordered largest -> smallest
sigma = diag(S);   

% Find number of sigma > TOL
%   Minimum allowed sigma is tol orders of magnitude < sigma(1)
minAllowed = floor(sigma(1)) / 10^(tol);

% Find the indices of all sigmas > minAllowed
ind = find( sigma >= minAllowed );

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
    semilogy([1 length(sigma)], [minAllowed minAllowed], 'r--', 'LineWidth', 1)
    grid on
    
    title('Singular Values')
    figure(gcf)
end

% True rank of matrix
R = length(sigmaAllowed);


end % function srank
%--------------------------------------------------------------------------