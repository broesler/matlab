%STARTUPSAV   Startup file
%   Change the name of this file to STARTUP.M. The file 
%   is executed when MATLAB starts up, if it exists 
%   anywhere on the path.  In this example, the
%   MAT-file generated during quitting using FINISHSAV
%   is loaded into MATLAB during startup.

%   Copyright 1984-2000 The MathWorks, Inc. 
%   $Revision: 1.4 $  $Date: 2000/06/01 16:19:26 $

% load matlab.mat

% global GIT_EDITOR
%
% GIT_EDITOR = 'TextEdit';

set(0, 'DefaultFigurePosition', [100 700 800 600]);
set(0, 'DefaultAxesFontName', 'Times')
set(0, 'DefaultTextFontName', 'Times')
set(0, 'DefaultAxesFontSize',  28)
set(0, 'DefaultLineLineWidth',  2)
set(0, 'DefaultLineMarkerSize', 8)

% Default Figure Position
% dposition = [440   378   560   420];

% New figure position
% position = [440 378 750 600];
% set(0, 'DefaultFigurePosition', position)

% Set sendmail preferences
myaddress = 'youremail@domain.com';
mypassword = 'yourpassword';

setpref('Internet','E_mail',myaddress);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',myaddress);
setpref('Internet','SMTP_Password',mypassword);

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', ...
                  'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');


clear all; close all; clc;
