% Labels every other tick mark on the axis.
%
% Need to give an odd number of tick marks, or else you won't label the end point
%
% Example:  axisticks(gca,[1:0.1:2],[0:0.1:1])


function axis_ticks(axis,xticks,yticks)


xticklabels = cell(1,length(xticks));

for i = 1:2:length(xticks)

        xticklabels(i) = {num2str(xticks(i))};
        
    
    if i < length(xticks)    

        xticklabels(i+1) = {''};
    end
end





yticklabels = cell(1,length(yticks));

for i = 1:2:length(yticks)

        yticklabels(i) = {num2str(yticks(i))};
        
    
    if i < length(yticks)    

        yticklabels(i+1) = {''};
    end
end






set(axis,'XTick',xticks,'XTickLabel',xticklabels)
set(axis,'YTick',yticks,'YTickLabel',yticklabels)