function fh = clearfigs()
% CLEARFIGS clear all open figure windows.
%
%   clearfigs() clears all open figure windows
%
%   h = clearfigs() also returns a vector of handles to each figure
%

fh = findall(0,'type','figure');

for i = 1:length(fh)
     clf(fh(i));
end
