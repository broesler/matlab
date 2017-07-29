%===============================================================================
%     File: ticks_test.m
%  Created: 05/18/2017, 14:29
%   Author: Bernie Roesler
%
%  Description: Test out ticks function
%
%===============================================================================
clear; clearfigs();

xmax = 3*pi;
x = linspace(0,xmax,100);
y = sin(x);

figure(1); %hold on; grid on; box on;
plot(x,y)

ylim([-1.1 1.1])
xlim([-0.5 xmax+0.5])
xticks = [0:pi/4:3*pi];
ticks(gca, xticks, [-1:0.125:1])

%===============================================================================
%===============================================================================
