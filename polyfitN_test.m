%===============================================================================
%     File: polyfitN_test.m
%  Created: 10/27/2015, 11:20
%   Author: Bernie Roesler
%
% Last Modified: 10/27/2015, 11:38
%
%  Description: test function for polyfitN()
%
%===============================================================================

% clear workspace
clear; close all; clc;

check = 0;
tol = 1e-15;

%-------------------------------------------------------------------------------
%       Input Data
%-------------------------------------------------------------------------------
x = [ 0  
      7  
      10 
      16 
      20 
      26 
      33 
      38 
      42 
      48 ];

y = [ 1.949844e+09
      6.165949e+08
      3.235938e+08
      1.348963e+08
      6.760829e+07
      2.630268e+07
      1.148154e+07
      5.128614e+06
      2.089297e+06
      8.709637e+05 ];
  
%-------------------------------------------------------------------------------
%       Check improper input
%-------------------------------------------------------------------------------
try
    A = polyfitN(x,y,length(x) + 10);
catch
    % if error is found... do this:
    A = tol;
end

%-------------------------------------------------------------------------------
%       Constant "fit" to data (i.e. the mean)
%-------------------------------------------------------------------------------
error_mean = abs(polyfit(x,y,0) - mean(y))/mean(y);

%-------------------------------------------------------------------------------
%       Linear Fit to data
%-------------------------------------------------------------------------------
% find coefficients of y = a*x + b
[al,bl] = linefit(x,y);
A_linear = polyfitN(x,y,1);

error_linear = norm([al - A_linear(2), bl - A_linear(1)]);

%-------------------------------------------------------------------------------
%       Quadratic Fit to data
%-------------------------------------------------------------------------------
[aq,bq,cq] = quadfit(x,y);
A_quad = polyfitN(x,y,2);

error_quad = norm([aq - A_quad(3), bq - A_quad(2), cq - A_quad(1)]);

%-------------------------------------------------------------------------------
%       Check for errors
%-------------------------------------------------------------------------------
% We expect error to be thrown, so only have a "failure" if error is not thrown
if A ~= tol
    warning('Improper input failed!')
    check = check + 1;
end

if error_mean > tol
    warning('Mean failed!')
    check = check + 1;
end

if error_linear > tol
    warning('Linear fit failed!')
    check = check + 1;
end

if error_quad > tol
    warning('Quadratic fit failed!')
    check = check + 1;
end

if check == 0
    disp('All tests passed!')
end

%===============================================================================
%===============================================================================