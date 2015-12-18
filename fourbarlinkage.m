%===============================================================================
%
%    File: fourbarlinkage.m
%  Author: Sam Williams, Bernie Roesler
% Created: 03/05/2013, 07;06
%
% Description: Plots the output of R4 rotation over one full R1 rotation
%              Crank and rocker 4 bar linkage lengths are necessary
%
%===============================================================================

clr;

saveFigures_flag = 0;

%-------------------------------------------------------------------------------
%       *** USER INPUTS ***
%-------------------------------------------------------------------------------
R1 = 0.0254;  % [m] Input crank length == 1" == 0.0254 m
R2 = 0.4064;  % [m] Connecter bar length == 16" == 0.4064 m
R3 = 0.0762;  % [m] Lever arm length (on concentric shafts) == 2.38" or 3.00" == 0.06045 or 0.0762
R4 = 0.4064;  % [m] Distance between crank shaft and rotor shaft, 16" == 0.4064 m

%-------------------------------------------------------------------------------
%       Calculate
%-------------------------------------------------------------------------------
phi = 0:.01:2*pi;  % Input rotation of the crank (R1)

Beta = zeros(length(R3),length(phi));
for i = 1:length(R3)
    
    % Calculate beta based on geometry
    Ang1      = atan2( (sqrt(R2^2-R1^2) + R1*sin(phi)),     (R3(i)-R1*cos(phi))    );
    b         =  sqrt( (sqrt(R2^2-R1^2) + R1*sin(phi)).^2 + (R3(i)-R1*cos(phi)).^2 );
    Ang2      = acos((-R2^2+R3(i)^2 + b.^2) ./ (2*R3(i)*b)) ;
    Beta(i,:) = Ang1 - Ang2;
    
end

%-------------------------------------------------------------------------------
%       Plots
%-------------------------------------------------------------------------------
fig(1);
plot(phi*180/pi, Beta(1,:)*180/pi)
plot(phi*180/pi, 20*sin(phi))
% plot(theta*180/pi, Beta(2,:)*180/pi)
% plot(theta*180/pi, Beta(3,:)*180/pi)

% format figure
xlabel('\phi')
ylabel('\beta_{abs}')
xlim([0 360])

ylim([-25 25])
axis_ticks(gca,[0:30:360],[-20:5:20])

if saveFigures_flag == 1
    saveastight(gcf,'walvisstaart_four_bar_linkage.pdf','pdf');
end