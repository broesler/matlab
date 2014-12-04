% ------------------------------------------------------------------ fig(H)
% FIG executes:  figure; hold on, box on, grid on,
% 
% Inputs:
% 
%   H  (optional) handle to an existing figure. 
% 
% If H is     given...      fig(H); executes:    figure(H); hold on, box on, grid on,
% If H is not given...  H = fig;    executes: H = figure;   hold on, box on, grid on,
%
%
% Example:
%       close all, figure(1), figure(2), fig(1); plot( [0,1], [1,1] )
%       
%       close all, H = fig; plot( [0,1], [1,1] )
%
% See also:
%   FIGURE.
% -------------------------------------------------------------------------

function H = fig(H)

if nargin == 1
    
    figure(H); hold on, box on, grid on,
    
else

    H = figure; hold on, box on, grid on,

end