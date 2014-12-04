% ------------------------------------------------- disptime(total_seconds)
% DISPTIME(total_seconds) displays the given total time in seconds in 
%                         format:   hr  min  sec      
%
% Inputs:
%
%   total_seconds == time to display, in seconds
%
% Examples:
%       disptime(5)
%       disptime(3 * 3600 +  7 * 60 + 9)
% -------------------------------------------------------------------------



function [] = disptime(total_seconds)


seconds_mid_hour    = mod(total_seconds,3600);
seconds_mid_minute  = mod(seconds_mid_hour ,60);

  hours   = num2str( (total_seconds      - seconds_mid_hour  ) / 3600 );
minutes   = num2str( (seconds_mid_hour   - seconds_mid_minute) / 60   );
seconds   = num2str( floor(seconds_mid_minute*10)/10                  );

if length(minutes) == 1, minutes = [' ',minutes]; end
if length(seconds) == 3, seconds = [' ',seconds]; end
if length(seconds) == 1, seconds = [' ',seconds,'.0']; end

time_string = [hours,' hr  ',minutes,' min  ',seconds,' sec'];

disp(time_string)
    