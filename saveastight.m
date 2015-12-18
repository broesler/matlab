function saveastight( h, filename, format )
% SAVEASTIGHT save figure with border set to figure window
%   SAVEASTIGHT(h,filename) saves figure handle h to pdf.
%   SAVEASTIGHT(h,filename,format) saves to eps, epsc, jpg, pdf, tiff.
%
%   See also SAVEAS, PRINT.

% Created: 12/4/2014
%  Author: Bernie Roesler
%--------------------------------------------------------------------------

% Change paper units and figure units to inches
set(h, 'PaperUnits','inches')
set(h, 'Units','inches')

% Get current position of figure
pos = get(h,'Position');

% Set the paper size to match the figure
set(h, 'PaperSize', [pos(3) pos(4)]);
set(h, 'PaperPositionMode', 'auto');
set(h, 'PaperPosition',[0 0 pos(3) pos(4)]);

% Save the figure
switch format
    case 'pdf'
%         print( h, '-dpdf', filename)
        saveas(h, filename, 'pdf')
    case 'eps'
        saveas(h, filename, 'eps')
%         print(h, '-deps', filename)
    case 'epsc'
        saveas(h, filename,'epsc')
%         print(h, '-depsc', filename)
    case 'ps2'
        saveas(h, filename,'ps2')
%         print(h, '-dps2', filename)
    case 'psc2'
        saveas(h, filename,'psc2')
%         print(h, '-dpsc2', filename)
    case 'jpg'
        saveas(h, filename,'jpg')
    case 'png'
        saveas(h, filename,'png')
    case 'bmp'
        saveas(h, filename,'bmp')
    case 'tiff'
        saveas(h, filename,'tiff')
    case 'svg'
        saveas(h, filename,'svg')
    otherwise
        print( h, '-dpdf', filename)
end

% Reset the units of h to the default 'pixels' for future calcs
set(h, 'Units', 'pixels')


end