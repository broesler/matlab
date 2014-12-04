% name: string 'nacaXXXX', where XXXX is the 4-digit foil designation
%    N: intger number of points per side (total number of points is 2*N-1)

function [XB,YB,XD,YD] = XFOILnaca4(name,N,plot_flag,AirfoilFile)

if nargin < 3
      plot_flag = 0;
    AirfoilFile = [];
    
elseif nargin < 4
    AirfoilFile = [];
end

M =  str2num(name(5)) / 100;
P =  str2num(name(6)) / 10;
T = (str2num(name(7))*10 + str2num(name(8))) / 100;

% Drela "bunching parameter" scheme:
AN  = 1.5; 
ANP = AN + 1.0;
  
FRAC = (0:N-1)/(N-1);

XX   = 1.0 - ANP*FRAC.*(1.0-FRAC).^AN - (1.0-FRAC).^ANP;
        
        
YT   = ( 0.29690*sqrt(XX) ...
       - 0.12600*XX       ...
       - 0.35160*XX.^2     ...
       + 0.28430*XX.^3     ...
       - 0.10150*XX.^4) * T / 0.20;

YC     = 0*XX;
dYCdXX = 0*XX;

       ind  = find(XX < P);
    YC(ind) = M/P^2     * (2*P*XX(ind) -   XX(ind).^2);
dYCdXX(ind) = M/P^2     * (2*P         - 2*XX(ind));

       ind  = find(XX >= P);
    YC(ind) = M/(1-P)^2 * ((1-2*P) + 2*P*XX(ind) -   XX(ind).^2);
dYCdXX(ind) = M/(1-P)^2 * (          2*P         - 2*XX(ind));
   
% Find foil surface, and put all numbers in one list: 
%   trailing edge -> upper surface -> leading edge -> lower surface -> trailing edge

% ------------ Drela scheme:
% IB = 0; 
% 
% % Upper surface:
% for I = N:-1:1
%     IB = IB + 1;
%     XB(IB) = XX(I);
%     YB(IB) = YC(I) + YT(I);
% end
% % Lower surface:
% for I = 2 : N
%     IB = IB + 1;
%     XB(IB) = XX(I);
%     YB(IB) = YC(I) - YT(I);
% end
% 
% % Store Drela scheme data:
% XD = XB;
% YD = YB;
% ------------


% ------------
% Exact NACA scheme:
theta = atan(dYCdXX);

IB = 0;

% Upper surface:
for I = N:-1:1
    IB = IB + 1;
    XB(IB) = XX(I) - YT(I)*sin(theta(I));
    YB(IB) = YC(I) + YT(I)*cos(theta(I));
end

% Lower surface:
for I = 2 : N
    IB = IB + 1;
    XB(IB) = XX(I) + YT(I)*sin(theta(I));
    YB(IB) = YC(I) - YT(I)*cos(theta(I));
end

% ------------
if plot_flag == 1
    figure, hold on, 
%       plot(XD,YD,'r-')
      plot(XB,YB)
      grid on
      axis equal
      figure(gcf)
end

% ------------
if ~isempty(AirfoilFile)
    fid = fopen(AirfoilFile,'wt');

    fprintf(fid,[name,'\n']);

    for i = 1:2*N-1
        if YB(i) >= 0
            fprintf(fid, '%.16f\t % .16f\n',XB(i),YB(i));
        else
            fprintf(fid, '%.16f\t %.16f\n',XB(i),YB(i));
        end
%         fprintf(fid, '%.16f\t %.16f\t\n',XD(i),YD(i));
    end
    
    fclose(fid);
    
end    
    