% Theodorsen Lag Function - Replicates Figure 7.10 in Drela
clr;

k = linspace(0, 2*pi, 1000);
% Ck = besselh(1,2,k) ./ (besselh(1,2,k) + 1i*besselh(0,2,k));
Ck = theodorsen(k);

%-----------------------------------------
% Plot Real and Imaginary Parts
figure(1), subplot(1,2,1), hold all
plot(k, real(Ck), 'b')
plot(k, imag(Ck), 'r')
plot(k, abs(Ck), 'Color', 'k')
plot(0.1, abs(theodorsen(0.1)), 'ok')
plot(0.5, abs(theodorsen(0.5)), 'ok')


% Plot asymptotes
plot(k, 0.5*ones(length(k)), '--', 'Color', [0 0.5 0], 'Linewidth', 1)
plot(k, 0*k, 'r--', 'Linewidth', 1)

grid on; box on;
axis([0 2*pi -0.2 1])
set(gca, 'ytick', [-0.2, 0, 0.2, 0.4, 0.6, 0.8, 1])

xlabel('k \equiv \omega c / 2U')
title('Theodorsen Lag Function Magnitude')
legend('Re\{C(k)\}', 'Im\{C(k)\}', '|C(k)|')

%-----------------------------------------     
% Plot Angle
figure(1), subplot(1,2,2), hold all
plot(k, angle(Ck)*180/pi, 'k')
plot(0.1, angle(theodorsen(0.1))*180/pi, 'ok')
plot(0.5, angle(theodorsen(0.5))*180/pi, 'ok')

% Plot asymptotes
plot(k, zeros(length(k)), '--k', 'LineWidth', 1)

grid on; box on;
axis([0 2*pi -16 0.1])
% set(gca, 'ytick', [-0.2, 0, 0.2, 0.4, 0.6, 0.8, 1])

xlabel('k')
title('Theodorsen Lag Function Angle [deg]')

set(gcf, 'Position', [100 375 1200 420])

saveastight(gcf, 'TheodorsenLag','pdf')
