% --------------------------------------------------------------------- mem
% MEM displays memory usage to the command window.
%
%
% See also:
%   WHOS
% -------------------------------------------------------------------------

clc
mem_temp_WORKSPACE      = whos;
mem_temp_WORKSPACEbytes = [mem_temp_WORKSPACE.bytes];

[mem_temp_WORKSPACEbytes   mem_temp_WORKSPACEsort] = sort(mem_temp_WORKSPACEbytes(:),1,'descend');
 mem_temp_WORKSPACEname = {mem_temp_WORKSPACE(mem_temp_WORKSPACEsort).name}';

clc
disp(['The total memory used is:  ',num2str(sum([mem_temp_WORKSPACE.bytes])/1e6),' MB.'])
disp(' '), disp('The largest items are:')
for mem_tempi = 1:min(40,length(mem_temp_WORKSPACEbytes))

    % Skip a line between orders of magnitude
    if mem_tempi > 1
    if floor(log10(mem_temp_WORKSPACEbytes(mem_tempi))) - floor(log10(mem_temp_WORKSPACEbytes(mem_tempi-1))) == -1
        disp(' ')
    end
    end
    
    % Display formatted memory usage data:
    mem_temp = [cell2mat(mem_temp_WORKSPACEname(mem_tempi))];
    disp(sprintf('%s%s%0.5f\t MB',mem_temp,repmat([' '],1,17-length(mem_temp)),(mem_temp_WORKSPACEbytes(mem_tempi)/1e6)))
end

clear mem_temp_WORKSPACE mem_temp_WORKSPACEbytes mem_temp_WORKSPACEsort mem_temp_WORKSPACEname mem_temp mem_tempi