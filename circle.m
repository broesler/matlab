function h = circle(r, xc, yc, linestyle)
%
% CIRCLE plot a circle of radius r, centered at (xc,yc)
%
%   CIRCLE() plots a unit circle centered on the origin
%
%   h = CIRCLE() returns the handles to the circle
%
%   CIRCLE(r) draws a unit circle of radius r, centered at the origin
%
%   CIRCLE(r,xc,yc) draws a dircle of radius r, centered at (xc,yc)
%
%   CIRCLE(r,xc,yc,linestyle) accepts a linestyle as a string
%
%   CIRCLE(linestyle) draws a unit circle at the origin with linestyle as a
%       string
%
%   Example:
%
%   figure(1)
%       h = circle(3);
%       set(h, 'LineWidth', 2)
%
%   See also PLOT
%--------------------------------------------------------------------------

theta = linspace(0,2*pi, 1000);

if nargin == 0          % Plot a unit circle centered at the origin
    r = 1;
    xc = 0;
    yc = 0;
    linestyle = 'k-';   % Default linestyle is solid black
    
elseif nargin == 1
    
    if ischar(r)        % check if argument is a linestyle
        linestyle = r;
        r = 1;
    else
        linestyle = 'k-';
    end
    
    xc = 0;
    yc = 0;
    
elseif nargin == 2      % could just give x-value, keep on y-axis
    yc = 0;
    linestyle = 'k-';
    
elseif nargin < 4
    linestyle = 'k-';

end

% Define coordinates
x = xc + r*cos(theta);
y = yc + r*sin(theta);

if nargout == 1
    % Return handle to the circle for style changes
    h = plot(x,y, linestyle);
else
    % suppress output of 
    plot(x,y, linestyle);
end

return
end % function CIRCLE
%--------------------------------------------------------------------------