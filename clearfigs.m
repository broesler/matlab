function fh = clearfigs()
% CLEARFIGS clear all open figure windows.
%
%   clearfigs() clears all open figure windows, and closes any empty figures
%
%   h = clearfigs() also returns a vector of handles to each figure
%

fh = findall(0,'type','figure');

for i = 1:length(fh)
    % if figure is already empty, just close it
    if isempty(get(fh,'Children'))
        close(fh);
    else
        clf(fh(i));
    end
end
