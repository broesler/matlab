function setfigsize(varargin)
%  setfigsize Set figure size without changing position
%
%  setfigsize([width height]) sets the width and height (in current units) of
%       the current figure gcf
%
%  setfigsize(h, [width height]) sets the width and height of figure handle h
%

%  Created: 12/20/2016, 16:45
%   Author: Bernie Roesler
%===============================================================================
if nargin == 1
    h = gcf;
    width = varargin{1}(1);
    height = varargin{1}(2);
else
    h = varargin{1};
    width = varargin{2}(1);
    height = varargin{2}(2);
end

pos = get(h,'Position');
set(h, 'Position', [pos(1) pos(2) width height]);
