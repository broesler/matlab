%STARTUPSAV   Startup file
%   Change the name of this file to STARTUP.M. The file 
%   is executed when MATLAB starts up, if it exists 
%   anywhere on the path.  In this example, the
%   MAT-file generated during quitting using FINISHSAV
%   is loaded into MATLAB during startup.

%   Copyright 1984-2000 The MathWorks, Inc. 
%   $Revision: 1.4 $  $Date: 2000/06/01 16:19:26 $

% load matlab.mat

% % global GIT_EDITOR
% % 
% % GIT_EDITOR = 'vim';

% Add path to Fortran compiler (gfortran)
% addpath(genpath('/usr/local/bin'));

% Set plotting options
set(0, 'DefaultAxesFontName', 'Times')
set(0, 'DefaultTextFontName', 'Times')
set(0, 'DefaultAxesFontSize', 24)
set(0, 'DefaultLineLineWidth', 2)

% Set sendmail preferences
myaddress = 'INSERT_YOUR_EMAIL_HERE';
mypassword = 'INSERT_YOUR_PASSWORD_HERE';

setpref('Internet','E_mail',myaddress);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',myaddress);
setpref('Internet','SMTP_Password',mypassword);

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', ...
                  'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

% clear workspace
clear all; close all; clc;