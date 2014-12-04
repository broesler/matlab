function C = controllability(A, B, n)
%
% CONTROLLABILITY determine the controllability of a system from {A,B}
%
%   C = controllability(A,B) returns the controllability matrix C using the
%       formula C = [A^(n-1)*B, ..., AB, B], where n is the number of
%       states. A is sized n x n, B is n x r (r is the number of inputs).
%
%   C = controllability(A,B,n) allows any n > size(A,1).
%
%   See also OBSERVABILITY
%

if nargin < 3       % take n from size(A,1), else n is given
    n = size(A,1);  % number of rows in A == number of states
end

r = size(B,2);  % number of inputs

Crows = size(A,1);  % always
Ccols = n*r;        % could add more columns to C

C = zeros(Crows, Ccols);
          
col_start = 1;
col_end   = r;

for i = (n-1):-1:0
   
    C(:, col_start:col_end) = A^i * B;
    
    col_start = col_start + r;
    col_end   = col_end   + r;
end


end % function controllability
%--------------------------------------------------------------------------