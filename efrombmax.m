function [e,phi] = efrombmax(bmax,a,phi,phase,pitch_flag)
% EFROMBMAX calculates eccentricity of amplified cycloid to achieve desired
%   maximum pitch angle at given phi angle
%
%   e = EFROMBMAX(bmax) calculates eccentricity for phi = pi/2 [rad]
%
%   e = EFROMBMAX(bmax,phi) uses given phi value
%
%   Input:    bmax  [rad]: maximum pitch angle
%             a     [rad]: [1] amplitude of cycloidal motion
%             phi   [rad]: [pi/2] angle where maximum will occur
%             phase [rad]: [0] phase angle between beta and phi
%             pitch_flag : [0] high pitch function, 1 == low pitch function
%
%   Output:   e      [-]: eccentricity
%             phi  [rad]: rotation angle where max pitch occurs
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

%-------------------------------------------------------------------------------
% Default values:
%-------------------------------------------------------------------------------
if nargin < 2
    a = 1;
end

% set max at quarter-cycle (phi = 0 at top dead center)
%   NOTE: -bmax will occur at phi + pi, giving -e, abs(e) corrects this issue
if nargin < 3
    phi = pi/2;     
end

% Phase shift of original beta(phi) function
if nargin < 4
    phase = 0;
end

% Default is high pitch
if nargin < 5
    pitch_flag = 0;
end

%-------------------------------------------------------------------------------
%       Calculate eccentricity
%-------------------------------------------------------------------------------
% beta function:
% beta(phi) = - a * arctan( e*sin(phi) / (1 + e*cos(phi)) )

if pitch_flag == 0
    % high pitch: beta_max = max(beta_abs) = max(beta(phi) + phi)
    alpha = (phi-bmax)/a;
else
    % low  pitch: beta_max = max(beta(phi))
    alpha = -bmax/a;
end

e = tan(alpha)/(sin(phi - phase) - cos(phi - phase)*tan(alpha));

% ensure e > 0
e = abs(e);     

return
%===============================================================================
