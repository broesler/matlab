%STARTUPSAV   Startup file
%   Change the name of this file to STARTUP.M. The file 
%   is executed when MATLAB starts up, if it exists 
%   anywhere on the path.  In this example, the
%   MAT-file generated during quitting using FINISHSAV
%   is loaded into MATLAB during startup.

%   Copyright 1984-2000 The MathWorks, Inc. 
%   $Revision: 1.4 $  $Date: 2000/06/01 16:19:26 $

% load matlab.mat

global GIT_EDITOR

GIT_EDITOR = 'TextEdit';

set(0, 'DefaultAxesFontName', 'Times')
set(0, 'DefaultTextFontName', 'Times')
set(0, 'DefaultAxesFontSize', 14)
set(0, 'DefaultLineLineWidth', 2)

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


% MATLAB 2014b ColorOrder
% color_grover      =  [ 0         0.4470    0.7410 ];  % i.e. faded blue
% color_beaker      =  [ 0.8500    0.3250    0.0980 ];  % i.e. orange
% color_extracheesy =  [ 0.9290    0.6940    0.1250 ];  % i.e. yellowish orange
% color_grimace     =  [ 0.4940    0.1840    0.5560 ];  % i.e. purple
% color_kermit      =  [ 0.4660    0.6740    0.1880 ];  % i.e. faded green
% color_twitter     =  [ 0.3010    0.7450    0.9330 ];  % i.e. sky blue
% color_pumbaa      =  [ 0.6350    0.0780    0.1840 ];  % i.e. chipotle red