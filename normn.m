function c = normn(A,dim);
%  NORMN finds the norm of elements in a matrix along given dimension
%
%  c = normn(A,dim) finds the norm of elements in A along dimension dim
%       c will be a vector along the same dimension as dim
%
%  SEE ALSO: norm

%===============================================================================
%     File: normn.m
%  Created: 11/17/2015, 14:57
%   Author: Bernie Roesler
%
% Last Modified: 11/17/2015, 15:03
%
%===============================================================================
if (dim > 2)
  error('Usage: normn(A,dim) requires dim <= 2')
end

N = size(A,dim);

if dim == 1
  c = zeros(N,1);
  for i = 1:N
    c(i) = norm(A(i,:),2);
  end
else
  c = zeros(1,N);
  for i = 1:N
    c(i) = norm(A(:,i),2);
  end
end

end % function
%===============================================================================
%===============================================================================
