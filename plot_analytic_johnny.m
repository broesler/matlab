function plot_analytic()
    a = .5;
    b = 1.5;
    sigma_1 = .5;
    sigma_2 = 1.5;

    N = 24;
    A = (2*b*sigma_2)/(a^2*sigma_2 - a^2*sigma_1 + b^2*sigma_1 + b^2*sigma_2);
    B = (b*sigma_1 + b*sigma_2)/(a^2*sigma_2 - a^2*sigma_1 + b^2*sigma_1 + b^2*sigma_2);
    C = -(a^2*b*(sigma_1 - sigma_2))/(a^2*sigma_2 - a^2*sigma_1 + b^2*sigma_1 + b^2*sigma_2);
    
    figure();
    theta = (0:(N-1))*2*pi/N.';
    U = B*b*cos(theta) + (C/b)*cos(theta);
    plot(U,'.-','DisplayName','$U_{2b}$-Analytic','MarkerSize',20);
    hold all;
    dU = B*cos(theta) - (C/(b^2))*cos(theta);
    plot(dU,'.-','DisplayName','$\frac{\partial U_{2b}}{\partial n}$-Analytic','MarkerSize',20);
    legend show;

    figure();
    theta = (0:(N-1))*2*pi/N.';
    U = A*a*cos(theta);
    plot(U,'b.-','DisplayName','$U_{1a}$-Analytic','MarkerSize',20);
    hold all;
    dU = A*cos(theta);
    plot(dU,'r.-','DisplayName','$\frac{\partial U_{1a}}{\partial n}$-Analytic','MarkerSize',20);
    legend show;
    
end

function plot_U2(r)
    a = .5;
    b = 1.5;
    sigma_1 = .5;
    sigma_2 = 1.5;

    A = (b + b*sigma_2)/(a^2*sigma_2 - a^2*sigma_1 + b^2*sigma_1 + b^2);
    B = (b + b*sigma_1)/(a^2*sigma_2 - a^2*sigma_1 + b^2*sigma_1 + b^2);
    C = -(a^2*b*(sigma_1 - sigma_2))/(a^2*sigma_2 - a^2*sigma_1 + b^2*sigma_1 + b^2);
    N = 24;

    theta = (0:(N-1))*2*pi/N.';
    U = B*r*cos(theta) + (C/r)*cos(theta);
    plot(U,'b.-','DisplayName','$U_{2b}$','MarkerSize',20);
    hold all;
    dU = B*cos(theta) - (C/(b^2))*cos(theta);
    plot(dU,'r.-','DisplayName','$\frac{\partial U_{2b}}{\partial n}$','MarkerSize',20);
    legend show;
    title('Analytic');
    fprintf('U2 = %d\n, dU2 = %d\n',B*r+C/r,B-C/(r^2));
end

function plot_U1(r)
    a = .5;
    b = 1.5;
    sigma_1 = .5;
    sigma_2 = 1.5;

    A = (b + b*sigma_2)/(a^2*sigma_2 - a^2*sigma_1 + b^2*sigma_1 + b^2);
    B = (b + b*sigma_1)/(a^2*sigma_2 - a^2*sigma_1 + b^2*sigma_1 + b^2);
    C = -(a^2*b*(sigma_1 - sigma_2))/(a^2*sigma_2 - a^2*sigma_1 + b^2*sigma_1 + b^2);

    N = 24;
    theta = (0:(N-1))*2*pi/N.';
    U = A*r*cos(theta);
    plot(U,'b.-','DisplayName','$U_{1a}$','MarkerSize',20);
    hold all;
    dU = A*cos(theta);
    plot(dU,'r.-','DisplayName','$\frac{\partial U_{1a}}{\partial n}$','MarkerSize',20);
    legend show;
    title('Analytic');
    fprintf('U1 = %d\n, dU1 = %d\n',A*r,A);
end
