function saveastight( h, filename, format )
% SAVEASTIGHT save figure with border set to figure window
%   SAVEASTIGHT(h,filename) saves figure handle h to pdf.
%   SAVEASTIGHT(h,filename,format) saves to eps, epsc, jpg, pdf, tiff.
%
%   See also SAVEAS, PRINT.

% Created: 12/4/2014
%  Author: Bernie Roesler
%--------------------------------------------------------------------------

% get all axes
a = findall(h,'type','axes');

% expand plot view
for i = 1:length(a)
    % Ignore axes corresponding to legends
    if (strcmp(get(a(i),'Tag'),'legend'))
        continue
    end
    ti = get(a(i),'TightInset');
    op = get(a(i),'OuterPosition');
    set(a(i),'Position',[op(1)+ti(1) op(2)+ti(2) op(3)-ti(3)-ti(1) op(4)-ti(4)-ti(2)]);
end

% calculate papersize
set(a,'units','centimeters');
xpapermax = -inf; 
xpapermin = +inf;
ypapermax = -inf; 
ypapermin = +inf;

for i = 1:length(a)
    pos = get(a(i),'Position');
    ti = get(a(i),'TightInset');

    if (pos(1)+pos(3)+ti(1)+ti(3) > xpapermax) 
        xpapermax = pos(1)+pos(3)+ti(1)+ti(3);
    end

    if (pos(1) < xpapermin) 
        xpapermin = pos(1);
    end

    if (pos(2)+pos(4)+ti(2)+ti(4) > ypapermax) 
        ypapermax = pos(2)+pos(4)+ti(2)+ti(4);
    end

    if (pos(2) < ypapermin) 
        ypapermin = pos(2);
    end
end
% paperwidth = xpapermax - xpapermin;
% paperhight = ypapermax - ypapermin;
paperwidth  = xpapermax;
paperheight = ypapermax;

% adjust the papersize
set(h, 'PaperUnits','centimeters');
set(h, 'PaperSize', [paperwidth paperheight]);
set(h, 'PaperPositionMode', 'manual');
set(h, 'PaperPosition',[0 0 paperwidth paperheight]);

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
