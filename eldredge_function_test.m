%===============================================================================
%     File: eldredge_function_test.m
%  Created: 11/10/2015, 15:03
%   Author: Bernie Roesler
%
% Last Modified: 11/10/2015, 18:57
%
%  Description: Test of Eldredge function parameters for FLUENT cases
%
%===============================================================================
clear; clearfigs(); clc;

c = 1; % [m] chord length
U = 1; % [m/s] free-stream velocity

amp       =  25 * (pi/180);     % [rad] non-dimensional pitching amplitude (radians) or plunge amplitude
K         =  0.115;             % [-]   non-dimensional pitching rate     
tstar_end =  7;                 % [-]   non dimensional total time. 
coc_pp    =  1.0;               % [-]   chordwise poisition of pitching point as fraction of chord (c_pp/c)

smv    =  11;                   % smoothing parameter
dtstar = 0.015;                 % non dimensional time step. Ramesh 2014 uses delta_t_star = 0.015

dt    = dtstar *c/U;                % [s]  time step
Nw    = ceil(tstar_end / dtstar);   % Number of wake points (== # time steps)
t     = [1:Nw]*dt;                  % [s]  time vector  
tstar = [1:Nw]*dtstar;              % [-]  nondimensional time vector

t1   =  1 * c/U;                        % [s] time from t = 0 to start motion. Starting at t_star = 1
t2   =  t1 +    amp/(2*K);              % time at end of pitching
t3   =  t2 + pi*amp/(4*K) - amp/(2*K);  % time at end of hold
t4   =  t3 +    amp/(2*K);

% Eldredge function (no units)
ramp  =  log( ( cosh(smv*U*(t - t1)/c) .* cosh(smv*U*(t - t4)/c)) ./ ...
( cosh(smv*U*(t - t2)/c) .* cosh(smv*U*(t - t3)/c)) );

alpha =  amp * ramp / max(ramp);  % [rad] pitch as function of time

% Plot function
figure(1);
plot(tstar, alpha*180/pi)
hold on; box on; grid on;

xlim([min(tstar) max(tstar)])
% ylim([0 1.1*max(alpha*180/pi)])

xlabel('t*')
ylabel('\alpha [deg]')
%===============================================================================
%===============================================================================