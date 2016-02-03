function [T, rankind, sigma] = isObservable(O,TOL)
%
% ISOBSERVABLE determine if a system is observable based on its
%   observability matrix
%
%   T = ISOBSERVABLE(O) returns a logical 1 for an observable system, 0
%   if system is unobservable
%
%   [T, rankind] = ISOBSERVABLE(O) returns a logical value and the rank of
%   the observability matrix
%
%   [T, rankin, sigma] = ISOBSERVABLE(O) also returns the singular values
%   of O
%
%   ISOBSERVABLE makes us of the MATLAB function SVD to determine the
%   rank of the observability matrix. If the rank is equal to the number
%   of rows in O (= n = number of rows in A = number of states).
%
%   See also SVD

%==============================================================================
%     File: isObservable.m
%  Created: 5/12/14
%   Author: Bernie Roesler
%
% Last Modified: 02/03/2016, 17:32
%===============================================================================

% Count all non-negative indices. TOL is tolerance within which values will
% be considered 0
if (nargin < 2)
    TOL = 1e-13;
end

% initialize output variable
T = false;

% Decompose O using singular-value decomposition, O = U*S*V', where S is a
% diagonal matrix of the eigenvalues of O. The number of non-negative
% eigenvalues is the rank.
[U,S,V] = svd(O);

% Take the diagonal of S
sigma = diag(S);

ind = find(abs(sigma) > TOL);

rankind = length(ind);
n       = length(sigma);

if (rankind == n)
    T = true;
end

%===============================================================================
%===============================================================================
