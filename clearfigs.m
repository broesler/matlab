function fh = clearfigs()
% CLEARFIGS clear all open figure windows.
%
%   clearfigs() clears all open figure windows, and closes any empty figures
%
%   h = clearfigs() also returns a vector of handles to each figure
%

% Created: 01/24/2017, 14:35
%  Author: Bernie Roesler
%===============================================================================

fh = findall(0,'type','figure');

for i = 1:length(fh)
    % if figure is already empty, just close it
    if isempty(get(fh(i),'Children'))
        close(fh(i));
    else
        clf(fh(i));
    end
end
