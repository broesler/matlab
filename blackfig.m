function blackfig(fig_handle, legend_handle)
% BLACKFIG set background color of figure to black
%   BLACKFIG()  Set background color to black (axes to white)
%

% Created: 12/4/2014
%  Author: Bernie Roesler
%
% Last Modified: 03/02/2016, 13:43
%--------------------------------------------------------------------------

% Use current axes
ax_handle = gca;

% Default to current figure
if nargin < 1
    fig_handle = gcf;
end

% Only if legend is specified
if nargin == 2
    
    % Change legend text to white, background to black
    set(legend_handle, 'Color', 'k', 'TextColor', 'w')
end

% Change figure background to black, axes to white
set(ax_handle, 'Color', 'k', ...
               'XColor','w', ...
               'Ycolor','w', ...
               'GridColor', 'w', ...
               'GridAlpha', 0.5);
set(fig_handle, 'Color', 'k');
set(fig_handle, 'InvertHardCopy', 'off');

end
