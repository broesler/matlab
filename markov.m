function Y = markov(A,B,C,D,N)
% MARKOV create system markov parameters
%
%  Y = markov(A,B,C,D,N) compute system Markov parameters from A,B,C,D
%    Y = [ CB CAB CA^2B ... CA^(N-1)B ];

%  Created: 02/11/2016, 17:30
%   Author: Bernie Roesler
%
% Last Modified: 02/15/2016, 15:34
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

if (size(D,2) ~= size(B,2))
    error('B and D matrices must have same number of columns.')
end

% Assign sizes
q = size(C,1);      % number of outputs
r = size(B,2);      % number of inputs

%-------------------------------------------------------------------------------
%       Calculate Markov parameters
%-------------------------------------------------------------------------------
Y = zeros(q,N*r);
Y(:,1:r) = D;

for i = 1:N
    % i.e. CB, CAB, CA^2B, CA^3B, ..., CA^(N-1)B
    Y(:, i*r+1:i*r+r) = C * A^(i-1) * B;
end

%===============================================================================
%===============================================================================
