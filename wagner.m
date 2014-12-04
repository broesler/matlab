function [phi,h] = wagner(tbar, plot_flag)
%
% WAGNER the Wagner function for step response to heave rate, pitch, or
%        pitch rate
%
%   phi = WAGNER(tbar) returns an approximation to the Wagner function as a
%       function of non-dimensional time, tbar = 2*U*t/c
%
%   [phi,h] = WAGNER(tbar,plot_flag) with plot_flag == 1 will plot the
%       function and return the handle to the axes
%
%--------------------------------------------------------------------------

% % % TEST CODE:
% % tbar = linspace(0,10,1000);
% % plot_flag = 1;

if nargin < 2
    plot_flag = 0;
end

phi = 1 - 0.165*exp(-0.045*tbar) - 0.335*exp(-0.3*tbar);

if plot_flag == 1
    % Plot function
    figure
        h = plot(tbar, phi);
        
        grid on
        figure(gcf)
end


end % function
%==========================================================================