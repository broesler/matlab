function [Y,Ab,Bb] = obs_markov(A,B,C,D,G,N)
% OBS_MARKOV create system markov parameters
%
%  Y = OBS_MARKOV(A,B,C,D,G,N) compute observer Markov parameters from A,B,C,D,G
%    Yb = [ CBb CAbBb CAb^2Bb ... CAb^(N-1)Bb ];
%    where 
%       Ab = [Ab+GC]        n x n     matrix
%       Bb = [Bb+GD, -G]    n x (q+r) matrix
%       G  = observer gain  n x q     matrix
%
% [Y,Ab,Bb] = OBS_MARKOV(A,B,C,D,G,N) also returns the barred system matrices
%

%  Created: 02/11/2016, 17:30
%   Author: Bernie Roesler
%
% Last Modified: 02/23/2016, 13:39
%===============================================================================

% TEST CODE: {{{
% clear;
% n = 10;
% r = 4;
% q = 2;
% A = randn(n,n);
% B = randn(n,r);
% C = randn(q,n);
% D = randn(q,r);
% G = randn(n,q);
% N = 5;
% }}}

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
%       Calculate Observer Markov parameters
%-------------------------------------------------------------------------------
Y = zeros(q,N*r);
Y(:,1:r) = D;

% Barred system matrices
Ab = [A + G*C];         % n x n     matrix
Bb = [B + G*D, -G];     % n x (q+r) matrix

for i = 1:N
    % i.e. CB, CAB, CA^2B, CA^3B, ..., CA^(N-1)B
    Y(:, i*(r+q)-q+1:i*(r+q)+r) = C * Ab^(i-1) * Bb;
end

% TEST CODE: {{{
% size_check = [q, r + N*(r+q)];
% if all(size(Y) == size_check)
%     disp('Test passed!')
% end
% }}}
%===============================================================================
%===============================================================================
