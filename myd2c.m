function [Ac,Bc,C,D] = myd2c(A,B,C,D,dt,method)
% MYD2C convert discrete-time system matrices to continuous-time {{{
%
%  [Ac,Bc,C,D] = myd2c(A,B,C,D,dt) converts the discrete-time system
%       x(k+1) = Ax(k) + Bu(k)
%         y(k) = Cx(k) + Du(k)
%    with sampling time dt to the continuous-time system
%       dx/dt = Acx(t) + Bcu(t)
%        y(t) =  Cx(t) +  Du(t)
%    assuming a zero-order hold on the input u(t).
%
%  [Ac,Bc,C,D] = myd2c(A,B,C,D,dt,method) allows specification of a conversion
%    method among {'zoh','foh','tustin','matched'}
%
%    INPUTS:
%       A   n x n matrix
%       B   n x r matrix
%       C   q x n matrix
%       D   q x r matrix
%       dt  1 x 1 singleton
%
%    OUTPUTS:
%       Ac  n x n matrix
%       Bc  n x r matrix
%       C   q x n matrix
%       D   q x r matrix
%
%  See also SS, D2C, C2D, D2D

%  Created: 03/10/2016, 08:51
%   Author: Bernie Roesler
%
% Last Modified: 03/10/2016, 10:01
%============================================================================}}}

if nargin < 6
    method = 'zoh';
end

% Convert to continuous-time system matrices
sysd = ss(A,B,C,D,dt);   % need special Matlab structure for d2c()
sysc = d2c(sysd,method);

Ac = sysc.a;
Bc = sysc.b;
C  = sysc.c;
D  = sysc.d;

%===============================================================================
%===============================================================================
