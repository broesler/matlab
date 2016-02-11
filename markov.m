function Y = markov(A,B,C,N)
%  Created: 02/11/2016, 17:30
%   Author: Bernie Roesler
%
% Last Modified: 02/11/2016, 17:38
%===============================================================================

%-------------------------------------------------------------------------------
%       Input checking
%-------------------------------------------------------------------------------
if (size(A,1) ~= size(A,2))
    error('A matrix must be square.')
end

if (size(B,1) ~= size(A,2))
    error('A and B matrices must have same number of rows.')
end

if (size(C,2) ~= size(A,2))
    error('A and C matrices must have same number of columns.')
end

if (nargin < 4)
    N = 2;
end

% Assign sizes
q = size(C,1);      % number of outputs
r = size(B,2);      % number of inputs

%-------------------------------------------------------------------------------
%       Calculate Markov parameters
%-------------------------------------------------------------------------------
Y = zeros(q,N*r);

for i = 0:N-1
    % i.e. CB, CAB, CA^2B, CA^3B, ...
    Y(:, i*r+1:i*r+r) = C * A^(i) * B;
end

%===============================================================================
%===============================================================================
