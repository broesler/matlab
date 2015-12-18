function S = num2money(N)
% S = NUM2MONEY(N)      Given a double, N, converts to string with commas
%                       separating every 3 digits
%

S = sprintf('%.2f', N);
S(2, length(S) - 6:-3:2) = ',';
S = S(S ~= char(0))';

end
