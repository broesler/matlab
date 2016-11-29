function prunefigs()
% closeEmpty close all empty figure windows.
%
%   clearfigs() closes all figure windows with no children
%

fh = findall(0,'type','figure');

for i = 1:length(fh)
    if isempty(get(fh(i),'Children'))
        close(fh(i));
    end
end
