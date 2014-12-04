function O = observability(C, A, n)
%
% OBSERVABILITY determine the observability of a system from {A,B}
%
%   O = OBSERVABILITY(C,B) returns the observability matrix O using the
%       formula O = [C; CA; ...; CA^(n-1)], where n is the number of
%       states. A is sized n x n, B is n x r (r is the number of inputs).

if nargin < 3       % take n from size(A,1), else n is given
    n = size(A,1);  % number of rows in A == number of states
end

m = size(C,1);      % number of outputs (always) = # rows in C

Orows = m*n;        % could add more rows to O than minimum
Ocols = size(A,2);  % (always) number of states = number of rows/cols in A

O = zeros(Orows, Ocols);
          
row_start = 1;
row_end   = m;

for i = 0:(n-1)
   
    O(row_start:row_end, :) = C * A^i;
    
    row_start = row_start + m;
    row_end   = row_end   + m;
end


end % function observability
%--------------------------------------------------------------------------