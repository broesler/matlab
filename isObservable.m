function [T, rankI, diagS] = isObservable(O)
%
% ISOBSERVABLE determine if a system is controllable based on its
%   controllability matrix
%
%   T = ISOBSERVABLE(O) returns a logical 1 for a controllable system, 0
%   if system is uncontrollable
%
%   [T, rank] = ISOBSERVABLE(O) returns a logical value and the rank of
%   the controllability matrix
%
%   [T, rank, diagS] = ISOBSERVABLE(O) also returns the singular values
%   of O
%
%   ISOBSERVABLE makes us of the MATLAB function SVD to determine the
%   rank of the controllability matrix. If the rank is equal to the number
%   of rows in O (= n = number of rows in A = number of states).
%
%   See also SVD

%--------------------------------------------------------------------------
T = 0;

% Decompose O using singular-value decomposition, O = U*S*V', where S is a
% diagonal matrix of the eigenvalues of O. The number of non-negative
% eigenvalues is the rank.

[U, S, V] = svd(O);

% Take the diagonal of S
diagS = diag(S);

% Count all non-negative indices. TOL is tolerance within which values will
% be considered 0
TOL = 1e-13;

I = find(abs(diagS) > TOL);

rankI = length(I);
n     = length(diagS);

if rankI == n
    T = 1;
end

end % function isObservable
%--------------------------------------------------------------------------