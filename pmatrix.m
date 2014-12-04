function [P,hh] = pmatrix(A,B,C,p,plot_flag)
%
% PMATRIX builds P as a lower block diagonal matrix.
%
%   P = PMATRIX(A,B,C,p) returns the block diagonal matrix P such that
%       dy = P*du where d is the difference operator:
%                       dz_j(k) = z_j(k) - z_{j-1}(k)
%
%       P = [ CB           0         0      ...  0
%             CAB          CB        0      ...  0
%             CA^2B        CAB       CB     ...  0
%              ...         ...       ...    ... ...
%             CA^(p-1)B CA^(p-2)B CA^(p-3)B ...  CB  ];
%
%       P is size < mp x rp >
%
%       A is size < n x n >     where n = states
%       B is size < n x r >           r = inputs
%       C is size < m x n >           m = outputs
%
%   P = PMATRIX(A,B,C,p,plot_flag) also calls spy(P) to show the
%       sparsity of P, illustrating the lower block diagonal structure.
%
%       %----- EXAMPLE:
%       n = 4;
%       r = 2;
%       m = 3;
%       p = 5;
%       plot_flag = 1;
% 
%       A = diag(randi(10,n,1));
%       B = randi(10,n,r);
%       C = randi(10,m,n);
%
%       [P,h] = PMATRIX(A,B,C,p,plot_flag)
%
%==========================================================================

if nargin < 5
    plot_flag = 0;
end

r = size(B,2);
m = size(C,1);

% Initialize matrix
P = zeros(m*p, r*p);

% Create lower diagonal structure
for i = 1:p
    for j = i:p
        P(1+(j-1)*m:j*m, 1+(j-i)*r:(j-i+1)*r ) = C*A^(i-1)*B;
    end
end

% Plot matrix to check for errors
if plot_flag == 1
    figure; grid on
        spy(P)
        title('P matrix Non-Zero Elements')
        
    figure; grid on
        surf(P)
        view(-70,40)
end


end % function
%==========================================================================