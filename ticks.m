% Labels every other tick mark on the axis.
%
% Need to give an odd number of tick marks, or else you won't label the end point
%
% Example:  ticks(gca,[1:0.1:2],[0:0.1:1])


function ticks(axis,xticks,yticks, xtickscale,ytickscale)

tol = 1e-8;

if nargin < 4
    xtickscale = 1;
    ytickscale = 1;
elseif nargin < 5
    ytickscale = 1;
end

x_pi1_flag = 0;
x_pi2_flag = 0;
x_pi4_flag = 0;
x_pi8_flag = 0;

if     all( abs(mod(xticks/(pi/1),1)) < tol  |  abs(mod(xticks/(pi/1),1) -1) < tol  |  abs(mod(xticks/(pi/1),1) +1) < tol )  % if xticks are even multiples of pi.  Can't do mod(...) == 1, since mod might return 0.000000002 or 0.9999999998
    x_pi1_flag = 1;
    
elseif all( abs(mod(xticks/(pi/2),1)) < tol  |  abs(mod(xticks/(pi/2),1) -1) < tol  |  abs(mod(xticks/(pi/2),1) +1) < tol )  % if xticks are even multiples of pi/2
    x_pi2_flag = 1;
    
elseif all( abs(mod(xticks/(pi/4),1)) < tol  |  abs(mod(xticks/(pi/4),1) -1) < tol  |  abs(mod(xticks/(pi/4),1) +1) < tol )  % if xticks are even multiples of pi/4
    x_pi4_flag = 1;
    
elseif all( abs(mod(xticks/(pi/8),1)) < tol  |  abs(mod(xticks/(pi/8),1) -1) < tol  |  abs(mod(xticks/(pi/8),1) +1) < tol )  % if xticks are even multiples of pi/8
    x_pi8_flag = 1; 
end

xticklabels = cell(1,length(xticks));

for i = 1:2:length(xticks)

    if abs(xticks(i)) < tol
        xticklabels(i) = {'0'};
    elseif abs(xticks(i) - pi) < tol
        xticklabels(i) = {'\pi'};
    else
        if     x_pi1_flag == 1
            xticklabels(i) = { [num2str(xticks(i)/pi),'\pi'] };
            
        elseif x_pi2_flag == 1
            % pi/2  pi 3*pi/2 2*pi 5*pi/2 3*pi ...
            xticklabels(i) = { [num2str(xticks(i)/pi),'\pi'] };
            
        elseif x_pi4_flag == 1
            xticklabels(i) = { [num2str(xticks(i)/pi),'\pi'] };
            
        elseif x_pi8_flag == 1
            xticklabels(i) = { [num2str(xticks(i)/pi),'\pi'] };
        else
            xticklabels(i) = {  num2str(xticks(i)/xtickscale)};
        end
    end
        
    if i < length(xticks)    
        xticklabels(i+1) = {''};
    end
end

yticklabels = cell(1,length(yticks));

for i = 1:2:length(yticks)
    yticklabels(i) = {num2str(yticks(i)/ytickscale)};
    if i < length(yticks)    
        yticklabels(i+1) = {''};
    end
end

set(axis,'XTick',xticks,'XTickLabel',xticklabels)
set(axis,'YTick',yticks,'YTickLabel',yticklabels)
