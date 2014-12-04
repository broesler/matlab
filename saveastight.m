function saveastight( h, filename, format )
% SAVEASTIGHT save figure with border set to figure window
%   SAVEASTIGHT(h,filename) saves figure handle h to pdf.
%   SAVEASTIGHT(h,filename,format) saves to eps, epsc, jpg, pdf, tiff.
%
%   See also SAVEAS, PRINT.

% Change paper units and figure units to inches
set(h, 'PaperUnits','inches')
set(h, 'Units','inches')

% Get current position of figure
pos = get(h,'Position');

% Set the paper size to match the figure
set(h, 'PaperSize', [pos(3) pos(4)]);
set(h, 'PaperPositionMode', 'manual');
set(h, 'PaperPosition',[0 0 pos(3) pos(4)]);

% Save the figure
switch format
    case 'pdf'
%         print( h, '-dpdf', filename)
        saveas(h, filename, 'pdf')
    case 'eps'
        saveas(h, filename, 'eps')
    case 'epsc'
        saveas(h, filename,'epsc')
    case 'jpg'
        saveas(h, filename,'jpg')
    case 'tiff'
        saveas(h, filename,'tiff')
    otherwise
        print( h, '-dpdf', filename)
end

% Reset the units of h to the default 'pixels' for future calcs
set(h, 'Units', 'pixels')


end