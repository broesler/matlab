function h = subfigure(h, sizeFactor)
% SUBFIGURE resize figure to 3/4 of default size for use as subfigure in LaTeX

%  Created: 03/09/2016, 15:03
%   Author: Bernie Roesler
%
% Last Modified: 03/09/2016, 21:30
%===============================================================================
if nargin == 1
    if nargout == 1
        h = figure(h);
    else
        figure(h);
    end
else
    if nargout == 1
        h = figure;
    else
        figure;
    end
end

if nargin < 2
    sizeFactor = 0.75;
end

% Shrink size of figure to maintain fontsize proportion for subfigures in LaTeX
pos      = get(h, 'Position');               % maintain current screen position
figsize  = get(0, 'DefaultFigurePosition');  % only change size from default

set(h, 'Position', [pos(1) pos(2) sizeFactor*figsize(3) sizeFactor*figsize(4)]);

% Change font-size inversely with figure size to keep relative font-size
ha = findobj(h,'type','axes');
fontsize = get(0, 'DefaultAxesFontSize');
set(ha, 'FontSize', (1/sizeFactor)*fontsize);

%===============================================================================
%===============================================================================
