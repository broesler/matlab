function [M,Cd,K] = getMCK(Ar,Br,Cr,Dr,C,Bf,sptol,plot_flag)
% GETMCK identify physical parameters from recovered system matrices {{{
%
%  [M,Cd,K] = getMCK(Ar,Br,Cr,Dr) returns the mass, damping, and stiffness
%    matrices of the continuous-time state-space system
%       dx/dt = Ar*x(t) + Br*u(t)
%        y(t) = Cr*x(t) + Dr*u(t)
%    where {Ar,Br,Cr,Dr} are "realized" through system ID techniques (i.e. ERA).
%    It is assumed that a full set of position sensors and force actuators is
%    used.
%
%  [M,Cd,K] = getMCK(Ar,Br,Cr,Dr,C,Bf,sptol,plot_flag) allows specification of
%    the desired C matrix in physical coordinates (i.e. C = [I 0] for position
%    measurements), the actuator location matrix Bf, tolerance for singular
%    values of the pseudo-inverse, and a flag to plot singular values
%
%  [M,Cd,K,R,G] = getMCK(Ar,Br,Cr,Dr) also returns the coefficient matrix and
%    RHS matrix used to solve for {M,Cd,K}
%

%  Created: 03/09/2016, 22:25
%   Author: Bernie Roesler
%
% Last Modified: 03/14/2016, 13:34
%============================================================================}}}

%-------------------------------------------------------------------------------
%       Input checking  {{{
%-------------------------------------------------------------------------------
if (size(Ar,1) ~= size(Ar,2))
    error('Ar matrix must be square.')
end

if (size(Br,1) ~= size(Ar,2))
    error('Ar and Br matrices must have same number of rows.')
end

if (size(Cr,2) ~= size(Ar,2))
    error('Ar and Cr matrices must have same number of columns.')
end

if (size(Dr,2) ~= size(Br,2))
    error('Br and Dr matrices must have same number of columns.')
end

if nargin < 6
    Bf = eye(size(Ar,1)/2, size(Ar,2)/2);
end

if nargin < 7
    sptol = 1e-9;
end

if nargin < 8
    plot_flag = 0;
end
% }}}

%-------------------------------------------------------------------------------
%       Perform calculations
%-------------------------------------------------------------------------------
% Assign sizes
n = size(Ar,1);      % number of system states
q = size(Cr,1);      % number of outputs
r = size(Br,2);      % number of inputs

I =   eye(n/2,n/2);
O = zeros(n/2,n/2);

% HACK FOR NOW:
if ( norm(abs(C - [ I O ])) > 1e-12 )
    error('C matrix must be [ I 0 ] (full set of position measurements)!!!')
end

% Define Q matrix to find starred matrices -- need to make Q square
Q = [ Cr; 
      randn(q,n) ];

% "/Q" == "*inv(Q)"
As = Q*Ar/Q;
Bs = Q*Br;
Cs = Cr/Q;

% Define transformation matrix
T = [       I           O;
      As(1:n/2,1:n/2) As(1:n/2,(n/2+1):n) ];

% Transform starred matrices back to physical coordinates
Ac = T*As/T;
Bc = T*Bs;
Cc = Cs/T;

X = -Ac( (n/2+1):n, 1:n/2     );
Y = -Ac( (n/2+1):n, (n/2+1):n );
Z =  Bc( (n/2+1):n, :);

% If Bf is square and full-rank (i.e. we have a full set of actuators), 
% solution is trivial:
if (size(Bf,1) == size(Bf,2)) && (srank(Bf) == size(Bf,2))
    % "/Z" == "*inv(Z)"
    M  = Bf/Z;
    Cd = M*Y;     % == Bf/Z*Y;
    K  = M*X;     % == Bf/Z*X;

% Otherwise we need to get schwifty:
else
    % Define R matrix using Kronecker product kron() and stack operator (:)
    R = [ kron(X',I)                zeros(n^2/4,n^2/4)    -eye(n^2/4,n^2/4);
          kron(Y',I)                 -eye(n^2/4,n^2/4)   zeros(n^2/4,n^2/4);
          kron(Z',I)                zeros(n^2/4,n^2/4)   zeros(n^2/4,n^2/4);
          kron(X',I) - kron(I,X')   zeros(n^2/4,n^2/4)   zeros(n^2/4,n^2/4);
          kron(Y',I) - kron(I,Y')   zeros(n^2/4,n^2/4)   zeros(n^2/4,n^2/4) ];

    G = [ O(:);
          O(:);
          Bf(:);
          O(:);
          O(:); ];

    % Unknowns P = [MS; CdS; KS];
    P = spinv(R,sptol,plot_flag) * G;

    % Extract all unknowns from system
    M  = reshape( P(        1:  n^2/4), n/2,n/2);
    Cd = reshape( P(  n^2/4+1:2*n^2/4), n/2,n/2);
    K  = reshape( P(2*n^2/4+1:3*n^2/4), n/2,n/2);

    % Compact Form: gives same answer as above, but uniquely coded for our case
    % % Define R matrix using Kronecker product kron() and stack operator (:)
    % R = [ kron(Z',I);
    %       kron(I,X') - kron(X',I);
    %       kron(I,Y') - kron(Y',I) ];
    %
    % G = [ Bf(:); 
    %       O(:);
    %       O(:)  ];
    %
    % % Calculate stacked mass matrix from R*M(:) = G(:)
    % MS = spinv(R,sptol,plot_flag) * G;
    %
    % % Reshape M into 2x2 and find Cd,K
    % M  = reshape(MS,n/2,n/2);
    % Cd = M*Y;
    % K  = M*X;
end

%===============================================================================
%===============================================================================
