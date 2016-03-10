function [M,Cd,K,T] = getMCK(Ar,Br,Cr,Dr,C,Bf,sptol,plot_flag)
% GETMCK identify physical parameters from recovered system matrices {{{
%

%  Created: 03/09/2016, 22:25
%   Author: Bernie Roesler
%
% Last Modified: 03/09/2016, 22:39
%============================================================================}}}

%-------------------------------------------------------------------------------
%       Input checking 
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

if nargin < 7
    sptol = 1e-9;
end

if nargin < 8
    plot_flag = 0;
end

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

% Use forward slash for post-multiplying inv(Q)
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

% Define R matrix using Kronecker tensor product kron() and stack operator (:)
R = [ kron(I,X') - kron(X',I);
      kron(I,Y') - kron(Y',I);
             kron(Z',I)       ];

G = [ O(:);
      O(:);
      Bf(:) ];

% Calculate mass matrix from R*M(:) = G(:)
MS = spinv(R,sptol,plot_flag) * G;

% Reshape M into 2x2 and find Cd,K
M  = reshape(MS,2,2);
Cd = M*Y;
K  = M*X;

%===============================================================================
%===============================================================================
