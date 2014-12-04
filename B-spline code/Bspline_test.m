% -------------------------------------------------------------------------
% B-spline tests
% -------------------------------------------------------------------------
clr,

%%
% To evaluate a B-spline given spline amplitudes:
%   A       [Ms,1]  spline amplitude vector
%   S(t)    [Mt,1]  spline values at t (function that A represents), where

%            S    == B*A    
%            S(i) == sum(B(i,1:Ms).*A(1:Ms),   S(i) === S(t(i))

% ----------- RUN THIS CODE -----------
n = 6;         % number of spline segments
t = 0:0.01:1;  % field points

[B, D1, D2, knot, tstar] = Bspline_basis(t,n,4);

A = [1 2 3 4 5 3 2]'; % n+1 spline amplitudes (vertices)

S = B*A;  

figure, hold on,
    plot(tstar,A,'o--g')
    plot(t    ,S,'r')
    grid on
% --------------------------------------
% -------------------------------------------------------------------------

%%
% -------------------------------------------------------------------------
% To approximate a function F(t) with spline S(t):
%   F(t)    [Mt,1] function values at t
%
%            A    == linsolve(B,F)
%            S    == B*A  ~~ F, 
%
% Note if Ms == Mt, then S == F, otherwise S approximates F smoothly
%
% ----------- RUN THIS CODE -----------
n  = 4;
k  = 4;
t  = [0 : 0.1 : 1]';  % field points
F  = t .* (1-t);      % function
F1 = 1 - 2*t;         % 1st derivative
F2 =   - 2;           % 2nd derivative
   
[B, D1, D2, knot, tstar] = Bspline_basis(t,n,k);   

A = linsolve(B,F);  % if the number of splines is less than the number of data points, then possibly need to run: A = pinv(B)*F;

S  = B *A;
S1 = D1*A;
S2 = D2*A;

% Evaluate the spline on a finer resolution
tt   = linspace(0,1,100); 

[BB, DD1, DD2, ~, ttstar] = Bspline_basis(tt,n,k);

SS  = BB *A;
SS1 = DD1*A;
SS2 = DD2*A;


% Display plots
figure(1), hold on, grid on, box on,
    plot(t,F ,'r.-')
    plot(t,S ,'g.','markersize',16);
    plot(tt,SS,'k-');
    plot(tstar, A,'o--k','markersize',10);  % vertices

figure(2), hold on, grid on, box on,
    plot(t,F1 ,'r.-')
    plot(t,S1 ,'g.','markersize',16);
    plot(tt,SS1,'k-');    
 
figure(3), hold on, grid on, box on,
    plot(t,F2 ,'r.-')
    plot(t,S2 ,'g.','markersize',16);
    plot(tt,SS2,'k-');
    
    
figure(4); hold on, grid on, box on,
    for i = 1:n+1
        plot(t,B(:,i))
    end    

    for i = 1:n+1
        plot(tt,BB(:,i),'k')
    end
% --------------------------------------
% -------------------------------------------------------------------------