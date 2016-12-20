function setallfigsize(sizes)
%  setfigsize Set figure size without changing position
%
%  setfigsize([width height]) sets the width and height (in current units) of
%       all open figures
%

%  Created: 12/20/2016, 16:55
%   Author: Bernie Roesler
%===============================================================================
if nargin < 1 || length(sizes) ~= 2
    error('setallfigsize expects one input argument setallfigsize([width height]).')
end

width = sizes(1);
height = sizes(2);

h = findall(0,'type','figure')

for i = 1:length(h)
    pos = get(h(i),'Position');
    set(h(i), 'Position', [pos(1) pos(2) width height]);
end
