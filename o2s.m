function Y = o2s(Yb,p,N)
% O2S convert observer Markov parameters into system Markov parameters {{{
%
%  Y = O2S(Yb,p,N) returns a matrix Y of N system Markov parameters given a set
%    of barred system (observer) Markov parameters Yb, with p chosen such that
%    the Ab^p is sufficiently small to ignore the system initial conditions x(0) 
%
%  Inputs:
%    Yb    q x (r + p*(r+q))    = [D CBb CAbBb CAb^2Bb ... CAb^(p-1)Bb] 
%    p     1 x 1                scalar s.t. Ab^p ~ 0
%    N     1 x 1                scalar number of system Markov parameters
%
%  Outputs:
%    Y     q x (N+1)*r          = [D CB CAB CA^2B ... CA^(p-1)B] 
%
%  where q = # of system outputs, r = # of system inputs
%
%  See also SOKID.
%

%  Created: 02/24/2016, 13:01
%   Author: Bernie Roesler
%
% Last Modified: 02/24/2016, 15:26
%============================================================================}}}

% TEST CODE: {{{
% clear;
% q = 3;
% r = 4;
% p = 2;
% N = 10;
% Yb = randn(q, r+p*(r+q));
% % }}}

q = size(Yb,1);                 % number of outputs
r = (size(Yb,2) - p*q)/(p+1);   % number of inputs

Y = zeros(q, (N+1)*r);          % system Markov parameters

% First parameter does not change
Y(:,1:r) = Yb(:,1:r);           % == D direct transfer term

% Segregate Yb_k into 2 parts: 
%   Yb_k = [ C(A+GC)^(k-1)(B+GD), -C(A+GC)^(k-1)G]
%   Yb_k = [ Yb_k^(1) -Yb_k^(2) ]   NOTE: DO NOT FORGET MINUS SIGN!!!
%             q x r     q x q

% For Markov parameters up to i = p
for k = 1:p
    % Take first part of Yb_k (only go r columns over from first index)
    Yb_k1 = Yb(:,k*r+(k-1)*q+1:(k+1)*r+(k-1)*q);        % q x r

    Ysum = zeros(q,r);
    for i = 1:k
        % Second part of Yb_k (go q columns from first index)
        Yb_i2 = -Yb(:,(i+1)*r+(i-1)*q+1:(i+1)*r+i*q);   % q x q

        % Previously found system Markov parameters
        Y_kmi = Y(:,(k-i)*r+1:(k-i)*r+r);               % q x r

        Ysum = Ysum + Yb_i2*Y_kmi;                      % q x r
    end

    Y(:,k*r+1:k*r+r) = Yb_k1 - Ysum;    % q x r
end

% For Markov parameters from i = p+1:infty
for k = (p+1):N

    Ysum = zeros(q,r);
    for i = 1:p
        % Second part of Yb_k (go q columns from first index)
        Yb_i2 = -Yb(:,(i+1)*r+(i-1)*q+1:(i+1)*r+i*q);   % q x q

        % Previously found system Markov parameters
        Y_kmi = Y(:,(k-i)*r+1:(k-i)*r+r);               % q x r

        Ysum = Ysum + Yb_i2*Y_kmi;                      % q x r
    end

    Y(:,k*r+1:k*r+r) = -Ysum;    % q x r
end

% TEST CODE: {{{
% size_test = [q, (N+1)*r];
% if all(size(Y) == size_test)
%     disp('Size test passed!')
% end
% }}}
%===============================================================================
%===============================================================================
