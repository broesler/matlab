% TEST CODE:
clr,

grey   = [0.8 0.8 0.8];
green  = [0.0 0.5 0.0];
purple = [0.5 0.0 1.0];

N = 10;
c = colorfade(purple, green, N, 'quad2');

t = 0:0.1:20;

for i = 1:N
    x =  sin(1/i * t);
    
    figure(1); hold on; grid on;
    plot(t,x, 'Color', c(i,:))

end