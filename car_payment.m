clear; close all;

D = 1750;           % [$] down payment
P = 17995;          % [$] present value
r = 3.25 / 100;     % fraction rate APR
t = 75;             % number of months of payments

payment = (P - D) * (r/12) / (1 - (1 + r/12)^(-t));

total_cost = D + t * payment;

thousands = floor(total_cost/1000);

percent_overpay = (total_cost / P - 1) * 100;

fprintf('  %2d months @ %4.2f%%\n', t, r*100);
fprintf('  Payment   =  $ %9.2f\n    Total   =  $ %2.0f,%06.2f\n',...
    payment, thousands, total_cost - thousands*1000)
fprintf('  Over by:    %4.2f%%\n', percent_overpay)
fprintf('------------------------\n')

% %===============================================================================
% cpay = payment;                                         % comparison payment
% rr   = 1.49 / 100;                                      % comparison rate
% PP   = D + cpay * (1 - (1 + rr/12)^(-t)) / (rr/12);     % comparison principal
% 
% total_cost_c = D + cpay * t;
% 
% thousands = floor(PP/1000);
% 
% percent_overpay_c = (total_cost_c / PP - 1) * 100;
% 
% fprintf(' For the same total cost, at this rate you can afford this principal:\n')
% fprintf('  %2d months @ %4.2f%%\n', t, rr*100)
% fprintf('  Payment   =  $ %9.2f\n', cpay)
% fprintf('  Principal =  $ %2.0f,%06.2f\n', thousands, PP - thousands*1000)
% fprintf('------------------------\n')