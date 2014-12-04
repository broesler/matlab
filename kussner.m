function [psi,h] = kussner(tbar, plot_flag)
%
% KUSSNER the Kussner function for step response to w_gust
%
%   phi = KUSSNER(tbar) returns an approximation to the Kussner function as
%       a function of non-dimensional time, tbar = 2*U*t/c
%
%   [phi,h] = KUSSNER(tbar,plot_flag) with plot_flag == 1 will plot the
%       function and return the handle to the axes
%
%--------------------------------------------------------------------------

% % TEST CODE:
% % tbar = linspace(0,10,1000);
% % plot_flag = 1;

if nargin < 2
    plot_flag = 0;
end

psi = 1 - 0.5*exp(-0.13*tbar) - 0.5*exp(-1.0*tbar);

if plot_flag == 1
    % Plot function
    figure
        h = plot(tbar, psi);
        
        grid on
        figure(gcf)
end


end % function
%==========================================================================