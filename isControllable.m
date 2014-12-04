function [T, rankI, diagS] = isControllable(C)
%
% ISCONTROLLABLE determine if a system is controllable based on its
%   controllability matrix
%
%   T = ISCONTROLLABLE(C) returns a logical 1 for a controllable system, 0
%   if system is uncontrollable
%
%   [T, rank] = ISCONTROLLABLE(C) returns a logical value and the rank of
%   the controllability matrix
%
%   [T, rank, diagS] = ISCONTROLLABLE(C) also returns the singular values
%   of C
%
%   ISCONTROLLABLE makes us of the MATLAB function SVD to determine the
%   rank of the controllability matrix. If the rank is equal to the number
%   of rows in C (= n = number of rows in A = number of states).
%
%   See also SVD

T = false;

% Decompose C using singular-value decomposition, C = U*S*V', where S is a
% diagonal matrix of the eigenvalues of C. The number of non-negative
% eigenvalues is the rank.

[U, S, V] = svd(C);

% Take the diagonal of S
diagS = diag(S);

% Count all non-negative indices. TOL is tolerance within which values will
% be considered 0
TOL = 1e-13;

I = find(abs(diagS) > TOL);

rankI = length(I);
n     = length(diagS);

if rankI == n
    T = true;
end

end % function isControllable
%--------------------------------------------------------------------------