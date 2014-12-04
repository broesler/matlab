function c = colorfade(C1, C2, N, type)
%
% COLORFADE produce color matrix fading between two colors
%
%   c = COLORFADE(C1,C2,N) returns matrix c size < N x 3 > containing color
%       vectors for each step 1:N, with a linear transition between them.
%
%   c = COLORFADE(C1,C2,N,type) allows the choice of transition:
%       'linear' = linear transition
%       'quad1'  = quadratic, with slope = 0 at C1
%       'quad2'  = quadratic, with slope = 0 at C2
%
%   Inputs {C1, C2} can also be MATLAB default color characters
%
%   Example:
%
%       grey   = [0.8 0.8 0.8];
%       purple = [0.5 0.0 1.0];
%       N = 10;
%       c = colorfade(grey, purple, N, 'quad1')
%       t = 0:0.1:10;
% 
%       for i = 1:N
%           x =  sin(i*0.1*t);
%     
%           figure(1); hold on; grid on;
%           plot(t,x, 'Color', c(i,:))
%       
%       end
%
%--------------------------------------------------------------------------

if nargin < 4
    type = 'linear';    % default fading scheme
end

if ischar(C1)
    switch C1
        case 'b', C1 = [0 0 1];
        case 'g', C1 = [0 1 0]; 
        case 'r', C1 = [1 0 0];
        case 'c', C1 = [0 1 1];
        case 'm', C1 = [1 0 1];
        case 'y', C1 = [1 1 0];
        case 'k', C1 = [0 0 0];
        case 'w', C1 = [1 1 1];
    end
end

if ischar(C2)
    switch C2
        case 'b', C2 = [0 0 1];
        case 'g', C2 = [0 1 0]; 
        case 'r', C2 = [1 0 0];
        case 'c', C2 = [0 1 1];
        case 'm', C2 = [1 0 1];
        case 'y', C2 = [1 1 0];
        case 'k', C2 = [0 0 0];
        case 'w', C2 = [1 1 1];
    end
end

c = zeros(N,3);
c(1,:) = C1;

for i = 2:N
    if strcmp(type, 'linear')
        c(i,:) = abs(i*(C2 - C1)/N + C1);
    elseif strcmp(type, 'quad1')
        c(i,:) = abs( (C2 - C1)/N^2 * i^2 + C1 );
    elseif strcmp(type, 'quad2')
        c(i,:) = abs( (C1 - C2)/N^2 * i^2 + 2*(C2 - C1)/N * i + C1 );
    end
end


end % function
%--------------------------------------------------------------------------