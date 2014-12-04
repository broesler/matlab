%==========================================================================
%
% Bernie Roesler
%
% ENGS 150 - Intermediate Fluid Dynamics
% HW2 - Group Speed vs. Phase Speed
%
% Date: 04/22/14
%
%==========================================================================

clear variables, close all, clc

saveAnimation_flag = 0;

%--------------------------------------------------------------------------
A = 1;      % Amplitude

w = 2;      % frequency     % {w,k} = {2,1} OR {1,2}
k = 1;      % wave number

dw = 0.1;   % slight change in frequency
dk = 0.1;   % slight change in wavenumber

% Time vector
t_start = 0;
t_end   = 5*pi;
dt      = 0.1;

t = t_start : dt : t_end;
% t = 0;      % TEST CODE @ t=0

N = length(t);

x_start = 0;
x_end   = 30*pi;
dx      = 0.1;

% Position vector
x = (x_start : dx : x_end)';
% x = 0;

M = length(x);

% Define Wave height as a function of x,t
ng = zeros(M,N);
np = zeros(M,N);

for i = 1:N
    % Height of group wave
    ng(:,i) = A*cos(dk*x - dw*t(i));
    
    % Height of individual waves (in phase)
    np(:,i) = A*cos(dk*x - dw*t(i)) .* cos(k*x - w*t(i));
end


%--------------------------------------------------------------------------
% Plot waves as a function of time

filename = ['./Figures/w' num2str(w) '_k' num2str(k)];


for i = 1:N
    figure(1); clf, hold on, grid on, blackfig,
    set(gcf, 'Position', [120  828  1368 510])
    
    plot(x, ng(:,i), 'g')
    plot(x, np(:,i), 'r')
    
    title(['\omega = ' num2str(w) ', k = ' num2str(k)], 'Color', 'w')
    xlabel('t')
    ylabel('\eta (x,t)')
    %     legend('Wave Group', 'Individual Waves', 'Location', 'SouthEast')
    
    if saveAnimation_flag == 1
        saveastight(1, [filename '_' num2str(i)], 'pdf')
    end
    
    pause(0.01)
    hold off
    
    figure(gcf)
end














