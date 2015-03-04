function [C, sigmaAllowed, sigma] = spinv(A, tol, plot_flag)
%
% SPINV compute the pseudo-inverse of A with tuneable parameters.
%
%   C = SPINV(A) returns the pseudo-inverse of a rectangular matrix A,
%       using the default parameters.
%
%   C = SPINV(A, tol) uses only the singular values greater than tol orders
%       of magnitude less than the maximum singular value
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
%       A = magic(100);
%       tol = 3;
%       plot_flag = 1;
%
%       C = SPINV(A,tol,plot_flag);
%
%   See also PINV, SPINV, SVD.
%

%    Author: Bernie Roesler
%   Created: 05/12/15
%--------------------------------------------------------------------------

% % TEST CODE
% A = magic(100);
% tol = 3;
% plot_flag = 1;

if nargin == 1
    tol = 3;        % Default order of magnitude
    plot_flag = 0;
elseif nargin == 2
    plot_flag = 0;
end
    
% (1) -------------------------------- Perform singular value decomposition
[U,S,V] = svd(A);

% singular values are on the diagonal of S, ordered largest -> smallest
sigma = diag(S);   

%----------------------------------------------- Find number of sigma > TOL
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
    semilogy(sigma, 'rx', 'MarkerSize', 10)
    hold all
    
    % Highlight allowed sigma values
    semilogy(ind, sigmaAllowed, 'bx', 'MarkerSize', 10)
    
    % Include line at cutoff point
    semilogy([1 length(sigma)], [minAllowed minAllowed], 'r--', 'LineWidth', 1)
    grid on
    figure(gcf)
end

% (2) ----------------------- Extract square of S using only allowed sigmas
maxind = max(ind); 

S1 = diag(sigmaAllowed);    % maximum size of S is < maxind x maxind >

U1 = U(:,1:maxind);         % Take maxind columns of U and V
V1 = V(:,1:maxind);

% (3) ----------------------------------------- Compute pseudo-inverse of A
C = V1 * (S1 \ U1');


% % % TEST CODE: THESE SHOULD ALL BE 0!!
% % maxval(abs( U1*S1*V1' -      A  ))
% % maxval(abs(    C      - pinv(A) ))
% % maxval(abs(    U'     -  inv(U) ))
% % maxval(abs(    V'     -  inv(V) ))

end % function spinv
%==========================================================================