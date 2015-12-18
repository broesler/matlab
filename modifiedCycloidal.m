function beta = modifiedCycloidal(phi,a,e,phase)
%
% MODIFIEDCYCLOIDAL calculates a modified cycloidal blade motion as defined in
%   CyROD v1.16+, assuming phi increases with rotation about the -y axis
%
%   beta = MODIFIEDCYCLOIDAL(a,e,phi) returns the angles beta with amplitude a,
%       eccentriciy e, and rotational angles phi
%

%-------------------------------------------------------------------------------

% Set defaults on inputs
if nargin < 1
    phi = linspace(0,2*pi,1000);
end

if nargin < 2
    a = 1;
end

if nargin < 3
    e = 0.5;
end

if nargin < 4
    phase = 0;
end

% Calculate beta
beta = - a * atan2( e*sin(phi - phase), (1 + e*cos(phi - phase)) );

end % function modifiedCycloidal