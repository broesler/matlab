function fh = movefigs(fh, xy)
% MOVEFIGS move groups of figure windows
%
%   movefigs() moves all open figure windows to default position
%
%   h = movefigs() also returns a vector of handles to each figure.
%
%   movefigs(h) only operates on figure handles in vector h.
%   movefigs(h, xy) specifies the x and y coordinates of the figures
%
%   movefigs('all', xy) specifies the x and y coordinates for all figures
%
%   SEE ALSO RESIZEFIGS, CLEARFIGS, CLEANUPFIGS

% Created: 01/24/2017, 15:11
%  Author: Bernie Roesler
%===============================================================================

if nargin < 1 || strcmp(fh, 'all')
    fh = findall(0,'type','figure');
end

if nargin < 2
    pos = get(0, 'DefaultFigurePosition');
    xy = pos(1:2);
end

%------------------------------------------------------------------------------- 
%        Resize figures
%-------------------------------------------------------------------------------
for i = 1:length(fh)
    % Get current size of figure
    pf = get(fh(i), 'Position');
    set(fh(i), 'Position', [xy pf(3) pf(4)]);
end
