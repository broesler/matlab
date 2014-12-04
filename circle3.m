function h = circle3(r, xc, yc, zc, plot3_plane,linestyle)
%
% CIRCLE3 plot a circle of radius r, centered at (xc,yc,zc)
%
%   CIRCLE3() plots a unit circle centered on the origin in the xy-plane
%
%   h = CIRCLE3() returns the handles to the circle
%
%   CIRCLE3(r) draws a unit circle of radius r, centered at the origin, in the
%       xy-plane
%
%   CIRCLE3(r,xc,yc) draws a circle of radius r, centered at (xc,yc), in the
%       xy-plane
%
%   CIRCLE3(r, xc, yc, zc) centers at (xc,yc,zc)
%
%   CIRCLE3(r,xc,yc,zc,linestyle) accepts a linestyle as a string
%
%   CIRCLE3(linestyle) draws a unit circle at the origin with linestyle as a
%       string
%
%   CIRCLE3(r,xc,yc,zc,plot3_plane) plots the circle in the plane given by
%       plot3_plane = 1 xy-plane
%                   = 2 xz-plane
%                   = 3 yz-plane
%
%   CIRCLE3(r,xc,yc,zc,plot3_plane,linestyle)
%
%   Example:
%
%   figure(1)
%       h = circle3(3);
%       set(h, 'LineWidth', 2)
%
%   See also PLOT3
%--------------------------------------------------------------------------

theta = linspace(0,2*pi, 1000);

if nargin == 0          % Plot a unit circle centered at the origin
    r = 1;
    xc = 0;
    yc = 0;
    zc = 0;
    linestyle = 'k-';   % Default linestyle is solid black
    plot3_plane = 1;
elseif nargin == 1
    if ischar(r)        % check if argument is a linestyle
        linestyle = r;
        r = 1;
    else
        linestyle = 'k-';
    end
    xc = 0;
    yc = 0;
    zc = 0;
    plot3_plane = 1;
elseif nargin == 2      % could just give x-value, keep on xy-plane
    yc = 0;
    zc = 0;
    linestyle = 'k-';
    plot3_plane = 1;
elseif nargin < 5
    plot3_plane = 1;
    linestyle = 'k-';
elseif nargin == 5
    if ischar(plot3_plane)
        linestyle = plot3_plane;
        plot3_plane = 1;
    else
        linestyle = 'k-';
    end
end

% Define coordinates
if plot3_plane == 1         % xy-plane
    x = xc + r*cos(theta);
    y = yc + r*sin(theta);
    z = zc*ones(size(theta));
elseif plot3_plane == 2     % xz-plane
    x = xc + r*cos(theta);
    y = yc*ones(size(theta));
    z = zc + r*sin(theta);
elseif plot3_plane == 3     % yz-plane
    x = xc*ones(size(theta));
    y = yc + r*cos(theta);
    z = zc + r*sin(theta);
end

if nargout == 1         % Return handle to the circle for style changes
        h = plot3(x,y,z, linestyle);
else                    % suppress output
        plot3(x,y,z, linestyle);
end

return
end % function CIRCLE
%--------------------------------------------------------------------------