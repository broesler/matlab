function O = observability(C,A)
%
% OBSERVABILITY determine the observability of a system from {A,B}
%
%   O = OBSERVABILITY(C,B) returns the observability matrix O using the
%       formula O = [C; CA; ...; CA^(n-1)], where n is the number of
%       states. A is sized n x n, B is n x r (r is the number of inputs).

%  Author: Bernie Roesler
% Created: 05/14/14
%
% Last Modified: 02/03/2016, 17:24
%-------------------------------------------------------------------------------

% Input Checking
if (size(A,1) ~= size(A,2))
    error('A matrix must be square.')
end

if (size(C,2) ~= size(A,2))
    error('A and C matrices must have same number of columns.')
end

% Build observability matrix
n = size(A,1);  % number of rows in A == number of states
m = size(C,1);  % number of outputs (always) = # rows in C

O = zeros(m*n, n);
          
for i = 0:(n-1)
    O(i*m+1:i*m+m, :) = C * A^i;
end

%===============================================================================
%===============================================================================
