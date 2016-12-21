function fh = cleanupfigs()
% CLEARFIGS closes all empty figure windows.
%
%   cleanupfigs() closes all empty figure windows
%

fh = findall(0,'type','figure');

for i = 1:length(fh)
    % if figure is already empty, just close it
    if isempty(get(fh(i),'Children'))
        close(fh(i));
    end
end
