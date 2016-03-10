function H = markov_hankel(Y,N,m,k)
% MARKOV_HENKEL create Hankel matrices from system Markov parameters
%
%  H = markov_hankel(Y,N,m,k) returns the Hankel matrix of order k, size m,
%    given by
%    H(k-1) = [ Y(k)     Y(k+1) Y(k+2) ... Y(k+b-1)
%               Y(k+1)   Y(k+2)  ...   .   Y(k+b)
%               ...      ...     ...   . 
%               Y(k+a-1) Y(k+a)  ...   .   Y(k+a+b-2) ];
%
%    For example:
%      H(0) = [ CB    CAB   CA^2B ... CA^(N-1)B 
%               CAB   CA^2B    ...    CA^NB
%               CA^2B    ...                   ];
%      H(1) = [ CAB   CA^2B CA^3B ... CA^(N-1)B 
%               CA^2B CA^3B    ...    CA^NB
%               CA^3B    ...                   ];
%
%    where Y = [ D CB CAB CA^2B ... CA^(N-1)B ];
%
%  INPUTS:
%    Y  q x (N+1)*r matrix of system Markov parameters
%    N  1 x 1       scalar number of Markov parameters
%    m  1 x 1       scalar size of Hankel matrix = m*q x m*r 
%    k  1 x 1       order of Hankel matrix
%
%  OUTPUTS:
%    H  m*q x m*r Hankel matrix
%
%  See also MARKOV, HANKEL

%  Created: 02/11/2016, 17:55
%   Author: Bernie Roesler
%
% Last Modified: 03/09/2016, 20:40
%===============================================================================

% Input checking
if (nargin < 3)
    error('Usage: H = markov_hankel(Y,N,k)')
end

% Allocate sizes
q = size(Y,1);
r = size(Y,2) / (N+1);

H = zeros(m*q, m*r);

if (m > N/2)
    error('m must be less than or equal to N/2 to form full Hankel matrices.')
end

% Build H matrix
for i = k:k+m-1
    j = i - k; 
    H(j*q+1:j*q+q, :) = Y(:, [i*r+1:i*r+m*r] + r);

    % NOTE:
    %+  H row indices do not change with k
    %+  Shift Y cols by r to skip D (Y = [ D CB CAB ... ])
end

%===============================================================================
%===============================================================================
