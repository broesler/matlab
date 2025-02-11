% Labels every other tick mark on the axis.
%
% Need to give an odd number of tick marks, or else you won't label the end point
%
% Example:  alt_yticks(gca,[1:0.1:2])

function alt_yticks(axis,yticks)

yticklabels = cell(1,length(yticks));

for i = 1:2:length(yticks)
    yticklabels(i) = {num2str(yticks(i))};
    
    if (i < length(yticks))
        yticklabels(i+1) = {''};
    end
end

set(axis,'YTick',yticks,'YTickLabel',yticklabels)
