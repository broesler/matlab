function [A,B,C,D] = myc2d(Ac,Bc,C,D,dt,method)
% MYC2D convert continuous-time system matrices to discrete-time {{{
%
%  [A,B,C,D] = myc2d(Ac,Bc,C,D,dt) converts the continuous-time system
%       dx/dt = Acx(t) + Bcu(t)
%        y(t) =  Cx(t) +  Du(t)
%    with sampling time dt to the discrete-time system
%       x(k+1) = Ax(k) + Bu(k)
%         y(k) = Cx(k) + Du(k)
%    assuming a zero-order hold on the input u(t).
%
%  [A,B,C,D] = myc2d(Ac,Bc,C,D,dt,method) allows specification of a conversion
%    method among {'zoh','foh','impulse','tustin','matched'}
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

%  Created: 03/10/2016, 10:00 
%   Author: Bernie Roesler
%
% Last Modified: 03/10/2016, 10:06
%============================================================================}}}

if nargin < 6
    method = 'zoh';
end

% Convert to discrete-time system matrices
sysc = ss(Ac,Bc,C,D);   % need special Matlab structure for c2d()
sysd = c2d(sysc,dt,method);

A = sysd.a;
B = sysd.b;
C = sysd.c;
D = sysd.d;

%===============================================================================
%===============================================================================
