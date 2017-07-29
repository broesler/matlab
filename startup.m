%===============================================================================
% STARTUP   Startup file
%   Change the name of this file to STARTUP.M. The file 
%   is executed when MATLAB starts up, if it exists 
%   anywhere on the path.  In this example, the
%   MAT-file generated during quitting using FINISHSAV
%   is loaded into MATLAB during startup.

%   Copyright 1984-2000 The MathWorks, Inc. 
%   $Revision: 1.4 $  $Date: 2000/06/01 16:19:26 $
%===============================================================================

% Add path to Fortran compiler (gfortran)
setenv('PATH', [getenv('PATH') ':/usr/local/bin']);

% Add path to fortran libraries
setenv('DYLD_LIBRARY_PATH', '/usr/local/bin:/opt/local/lib:');

% Add MATLAB and all subdirectories to path
addpath(genpath('~/Documents/MATLAB/'));

% Set plotting options
% set(0, 'DefaultFigurePosition', [100 700 800 600]); % a bit large
set(0, 'DefaultFigurePosition', [100 700 600 450]);
set(0, 'DefaultAxesFontName', 'Times')
set(0, 'DefaultTextFontName', 'Times')
set(0, 'DefaultAxesFontSize',  20)
set(0, 'DefaultLineLineWidth',  2)
set(0, 'DefaultLineMarkerSize', 6)

clear; close all; clc;  % start fresh
%===============================================================================
%===============================================================================
