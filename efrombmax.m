function e = efrombmax(bmax,a,phi)
% EFROMBMAX calculates eccentricity of amplified cycloid to achieve desired
%   maximum pitch angle at given phi angle
%
%   e = EFROMBMAX(bmax) calculates eccentricity for phi = pi/2 [rad]
%
%   e = EFROMBMAX(bmax,phi) uses given phi value
%
%   Input:    bmax [rad]: maximum pitch angle
%             a    [rad]: [1] amplitude of cycloidal motion
%             phi  [rad]: [pi/2] angle where maximum will occur
%
%   Output:   e      [-]: eccentricity
%
%   Example:
%       e = efrombmax(bmax,-a,pi/2)
%       e = efrombmax(bmax,-a,-pi/2)
%       e = efrombmax(bmax,-a,-3*pi/2)
%       e = efrombmax(bmax,-a,3*pi/2)
%   should all give the same result e = 2.7475
%
%   See also SIN, COS, TAN
%

% Default values:
if nargin < 2
    a = 1;
end

% set max at quarter-cycle (phi = 0 at top dead center)
%   NOTE: -bmax will occur at phi + pi, giving -e, abs(e) corrects this issue
if nargin < 3
    phi = pi/2;     
end

% beta(phi) = - a * arctan( e*sin(phi) / (1 + e*cos(phi)) )
alpha = (phi-bmax)/a;

e = tan(alpha)/(sin(phi) - cos(phi)*tan(alpha));

% ensure e > 0
e = abs(e);     

return
%===============================================================================
