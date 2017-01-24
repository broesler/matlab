function fh = resizefigs(fh, wh)
% RESIZEFIGS resize groups of figure windows
%
%   resizefigs() resizes all open figure windows to default size
%
%   h = resizefigs() also returns a vector of handles to each figure.
%
%   resizefigs(h) only operates on figure handles in vector h.
%   resizefigs(h, wh) specifies the width and height of the figures
%
%   resizefigs('all', wh) specifies the width and height for all figures
%
%   SEE ALSO MOVEFIGS, CLEARFIGS, CLEANUPFIGS

% Created: 01/24/2017, 14:35
%  Author: Bernie Roesler
%===============================================================================

if nargin < 1 || strcmp(fh, 'all')
    fh = findall(0,'type','figure');
end

if nargin < 2
    pos = get(0, 'DefaultFigurePosition');
    wh = pos(3:4);
end

%------------------------------------------------------------------------------- 
%        Resize figures
%-------------------------------------------------------------------------------
for i = 1:length(fh)
    % Get current position of figure
    pf = get(fh(i), 'Position');
    set(fh(i), 'Position', [pf(1) pf(2) wh]);
end
