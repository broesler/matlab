function vv = pchip2d(x,y,v,xx,yy)

% ----------------------------------------------------------------- pchip2d
%
% 2D extension of pchip1D.
%
%  vv = pchip2d(x,y,v,xx,yy) finds the shape-preserving piecewise cubic
%  interpolant P(x,y), with P(x(i),y(j)) = v(i,j), and returns vv(ii,jj) = P(xx(ii),yy(jj)).
%
%   RESTRICTIONS:
%       This formulation requires rectangularly-gridded data, such that
%           x(i,:) == x(i)
%           y(:,j) == y(j)
%
%   INPUTS: 
%       x  = size [Nx,Ny]
%       y  = size [Nx,Ny]
%       v  = size [Nx,Ny]
%       xx = size [Nxx,Nyy]
%       yy = size [Nxx,Nyy]
%
%   OUTPUTS:
%       vv = size [Nxx,Nyy]
% -------------------------------------------------------------------------
% 
% clr,
% [x,y] = ndgrid([0:0.1:0.5],[0:0.2:0.6]);
% v = x.^3-6*y+sqrt(y)+exp(x);
% % fig; surf(x,y,v)
% 
% [xx,yy] = ndgrid([0.05:0.01:0.45],[0.1:0.02:0.5]);
% vv = pchip2d(x,y,v,xx,yy);
% % -------------------------------------------------------------------------
% clr,
% [x,y] = ndgrid([0:0.1:0.5],[0:0.1:0.6]);
% 
% 
% v = exp(-(2*x-0.2).^2 - (3*y-0.3).^2) - exp(-(8*x-0.4).^2 - (5*y-0.5).^2);
% 
% [xx,yy] = ndgrid([0:0.01:0.5],[0:0.02:0.6]);
% vv = pchip2d(x,y,v,xx,yy);
% 
% 
% fig; surf(xx,yy,vv)
% plot3(x,y,v,'.')
% % -------------------------------------------------------------------------
% clr,
% [x,y] = ndgrid([-0.5:0.1:0.5]*10,[-0.6:0.1:0.6]*10);
% 
% 
% v = peaks(x,y);
% 
% % v = exp(-(2*x-0.2).^2 - (3*y-0.3).^2) - exp(-(8*x-0.4).^2 - (5*y-0.5).^2);
% 
% [xx,yy] = ndgrid([-0.5:0.01:0.5]*10,[-0.6:0.02:0.6]*10);
% vv = pchip2d(x,y,v,xx,yy);
% 
%  
% fig; surf(xx,yy,vv)
% plot3(x,y,v,'.')
% 
% vv2 = peaks(xx,yy);
% 
% fig; surf(xx,yy,vv2)
% % -------------------------------------------------------------------------


% -------------------------------------------------------------------------
% Size of matrices for memory allocation
[Nx, Ny ] = size(x);
[Nxx,Nyy] = size(xx); 
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Check if x and y increasing, and flip index directions if necessary
if x(2,1) < x(1,1) % then x is decreasing
    x = x(Nx:-1:1,:);
    y = y(Nx:-1:1,:);
    v = v(Nx:-1:1,:);
end
if y(1,2) < y(1,1) % then y is decreasing
    x = x(:,Ny:-1:1);
    y = y(:,Ny:-1:1);
    v = v(:,Ny:-1:1);
end
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------  
% Estimate derivatives at (x,y)    
vx   = zeros(Nx,Ny);  % dv/dx
vy   = zeros(Nx,Ny);  % dv/dy

vxy1 = zeros(Nx,Ny);  % d(vy)/dx
vxy2 = zeros(Nx,Ny);  % d(vx)/dy
vxy  = zeros(Nx,Ny);  % d^2(v)/dxdy

% ----------- First derivatives -----------
% -----------
% vx = dv/dx
        for j = 1:Ny
            vx(:,j)= pchipslopes(x(:,j),v(:,j));  % each is size [Nx,1]
        end

% -----------
% vy = dv/dy
        for i = 1:Nx
            vy(i,:)= pchipslopes(y(i,:),v(i,:));  % each is size [1,Ny]
        end

% ---------------- Second derivative  ---------------
% ---------------------------------------------------
% vxy   = d^2(v)/dxdy = ( d(vy)/dx + d(vx)/dy ) / 2

% vxy1  = d(vy)/dx
        for j = 1:Ny
            vxy1(:,j)= pchipslopes(x(:,j),vy(:,j));  % each is size [Nx,1]
        end

% vxy2 = d(vx)/dy
        for i = 1:Nx
            vxy2(i,:)= pchipslopes(y(i,:),vx(i,:));  % each is size [1,Ny]
        end

vxy = (vxy1 + vxy2)/2;
% ---------------------------------------------------

clear vxy1 vxy2
% -------------------------------------------------------------------------  


            
                % % % -------------------------------------------------------------------------  
                % % %  Find subinterval indices (I,J) so that x(I,J) <= xx < x(I+1,J) and y(I,J) <= yy < y(I,J+1)
                % % %  Note: size(I) == size(J) == [Nxx,Nyy]
                % % 
                % % % METHOD 1
                % % I = ones(Nxx,Nyy);
                % % J = ones(Nxx,Nyy);
                % % 
                % % for i = 2:Nx-1
                % %     I(x(i,1) <= xx) = i;
                % % end
                % % 
                % % for j = 2:Ny-1
                % %     J(y(1,j) <= yy) = j;
                % % end
                % %    
                % %         % hx     = diff(x,1,1);                % size [Nx-1,Ny  ]
                % %         % hy     = diff(y,1,2);                % size [Nx  ,Ny-1]
                % %         % 
                % %         % hx(I,J) - (x(I+1,J)-x(I,J))   
                % %         % hy(I,J) - (y(I,J+1)-y(I,J)) 
                % %         
                % %         
                % % % METHOD 2
                % % I2 = ones(Nxx,Nyy);
                % % J2 = ones(Nxx,Nyy);
                % %  
                % % % for each field point...        *** ASSUMES RECTANGULARLY-GRIDDED DATA ***
                % % for ii = 1:Nxx
                % % for jj = 1:Nyy
                % %     
                % %     % Find indices (i,j,k) corresponding to neighboring baseline grid point 
                % %     [ij] = find(x <= xx(ii,jj) & y <= yy(ii,jj) ,1,'last');   
                % %     
                % %     j = floor(ij/Nx) + 1;
                % %     i = ij - (j-1)*Nx;
                % %     
                % %     I2(ii,jj) = i;
                % %     J2(ii,jj) = j;
                % % end
                % % end
                % % 
                % % I - I2
                % % J - J2
                % % % -------------------------------------------------------------------------  
  

% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% Interpolate at (xx,yy)
vv = zeros(Nxx,Nyy);   

% for each field point...        *** ASSUMES RECTANGULARLY-GRIDDED DATA ***
for ii = 1:Nxx
for jj = 1:Nyy    

                % % % Find indices (i,j) corresponding to neighboring baseline grid point 
                % % i = I(ii,jj);
                % % j = J(ii,jj);

    % Find indices (i,j) corresponding to neighboring baseline grid point, such that x(i) <= x <= x(i+1) 
    [ij] = find(x <= xx(ii,jj) & y <= yy(ii,jj) ,1,'last');   
    
    j = floor((ij-1)/Nx  ) + 1;
    i = ij -   (j-1)*Nx;
    
    if i == Nx, i = Nx-1; end  % Error check, such that x(i) <= x <= x(i+1)
    if j == Ny, j = Ny-1; end  % Error check, such that y(j) <= y <= y(j+1)
    
    % save temp    
    
    % Interval length, h
    hx = x(i+1,j  ) - x(i,j);
    hy = y(i  ,j+1) - y(i,j);
    
    % Sub-interval position, s
    sx = (xx(ii,jj) - x(i,j))/hx;
    sy = (yy(ii,jj) - y(i,j))/hy;
       

    % Evaluate Hermite polynomials
    HX1 = (1 - 3*sx^2 + 2*sx^3  );
    HX2 = (    3*sx^2 - 2*sx^3  );
    HX3 = (      sx   * (sx-1)^2) * hx;
    HX4 = (      sx^2 * (sx-1)  ) * hx;

    HY1 = (1 - 3*sy^2 + 2*sy^3  );
    HY2 = (    3*sy^2 - 2*sy^3  );
    HY3 = (      sy   * (sy-1)^2) * hy;
    HY4 = (      sy^2 * (sy-1)  ) * hy;

    
    % Evaluate interpolant
    vv(ii,jj) =    v(i  ,j  ) * HX1 * HY1 ...
               +   v(i  ,j+1) * HX1 * HY2 ...
               +   v(i+1,j  ) * HX2 * HY1 ...
               +   v(i+1,j+1) * HX2 * HY2 ...
               ...
               +  vx(i  ,j  ) * HX3 * HY1 ... 
               +  vx(i  ,j+1) * HX3 * HY2 ...  
               +  vx(i+1,j  ) * HX4 * HY1 ...
               +  vx(i+1,j+1) * HX4 * HY2 ...
               ...
               +  vy(i  ,j  ) * HX1 * HY3 ... 
               +  vy(i  ,j+1) * HX1 * HY4 ...  
               +  vy(i+1,j  ) * HX2 * HY3 ...
               +  vy(i+1,j+1) * HX2 * HY4 ...
               ...
               + vxy(i  ,j  ) * HX3 * HY3 ... 
               + vxy(i  ,j+1) * HX3 * HY4 ...  
               + vxy(i+1,j  ) * HX4 * HY3 ...
               + vxy(i+1,j+1) * HX4 * HY4;   
end
end
% ------------------------------------------------------------------------- 
% ------------------------------------------------------------------------- 
   



% -------------------------------------------------------------------------  
% -------------------------------------------------------------------------  
% -------------------------------------------------------------------------  


% % -------------------------------------------------------------------------  
% function d = pchipslopes(h,delta)
% %  PCHIPSLOPES  Slopes for shape-preserving Hermite cubic
% %  pchipslopes(h,delta) computes d(i) = P'(x(i)).
% 
% %  Slopes at interior points
% %  delta = diff(v)./diff(x).
% %  d(i)  = 0 if delta(i-1) and delta(i) have opposites
% %          signs or either is zero.
% %  d(i)  = weighted harmonic mean of delta(i-1) and
% %          delta(i) if they have the same sign.
% 
%    Nx   = length(h)+1;
%    d    = zeros(size(h));
%    i    = find(sign(delta(1:Nx-2)).*sign(delta(2:Nx-1))>0)+1;
%    w1   = 2*h(i)+h(i-1);
%    w2   = h(i)+2*h(i-1);
%    d(i) = (w1+w2)./(w1./delta(i-1) + w2./delta(i));
% 
% %  Slopes at endpoints
% 
%    d(1)  = pchipend(h(1),h(2),delta(1),delta(2));
%    d(Nx) = pchipend(h(Nx-1),h(Nx-2),delta(Nx-1),delta(Nx-2));
% 
% % -------------------------------------------------------

% -------------------------------------------------------------------------
%  pchipslopes - First derivative slopes for shape-preserving Hermite cubic
%
%  pchipslopes(x,v) computes d(i) = dvdx(x(i)).
%
%  Slopes at interior points
%       delta = diff(v)./diff(x)
%
%       d(i)  = 0 if delta(i-1) and delta(i) have opposites signs or either is zero.
%       d(i)  = weighted harmonic mean of delta(i-1) and delta(i) if they have the same sign.
%
% ASSUMES v = v(x) is 1D data

function d = pchipslopes(x,v)
   h     = diff(x);
   delta = diff(v)./h;
   
   Nx   = length(h)+1;
   d    = zeros(size(h));
   i    = find(sign(delta(1:Nx-2)).*sign(delta(2:Nx-1))>0)+1;
   w1   = 2*h(i)+h(i-1);
   w2   = h(i)+2*h(i-1);
   d(i) = (w1+w2)./(w1./delta(i-1) + w2./delta(i));

%  Slopes at endpoints

   d(1)  = pchipend(h(1),h(2),delta(1),delta(2));
   d(Nx) = pchipend(h(Nx-1),h(Nx-2),delta(Nx-1),delta(Nx-2));

% -------------------------------------------------------------------------


function d = pchipend(h1,h2,del1,del2)
%  Noncentered, shape-preserving, three-point formula.
   d = ((2*h1+h2)*del1 - h1*del2)/(h1+h2);
   if sign(d) ~= sign(del1)
      d = 0;
   elseif (sign(del1)~=sign(del2))&(abs(d)>abs(3*del1))
      d = 3*del1;
   end
