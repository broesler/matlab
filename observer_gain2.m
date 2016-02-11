function G = observer_gain2(lambda,A,C)
% OBSERVER_GAIN2 finds elements of observer G given desired eigenvalues of (A+GC)
%
%   G = OBSERVER_GAIN2(lambda,A,C) returns a 2x1 vector G, given 2x1 lambda, 2x2 A,
%     and 1x2 C
%

%  Created: 02/04/2016, 17:19
%   Author: Bernie Roesler
%
% Last Modified: 02/11/2016, 14:21
%===============================================================================

% Input checking
if (size(lambda,1) ~= 2)
    error('Usage: lambda must be a 2x1 vector')
end

if (size(A,1) ~= size(C,2))
    error('A and C must have the same number of columns.')
end

% Build matrices
AA = [           C(1),                      C(2);
       A(2,2)*C(1) - A(2,1)*C(2), A(1,1)*C(2) - A(1,2)*C(1) ];

if (isreal(lambda))
    BB = [ lambda(1) + lambda(2) - (A(1,1) + A(2,2));
           lambda(1)*lambda(2) - A(1,1)*A(2,2) + A(1,2)*A(2,1)  ];
else
    g = real(lambda);
    h = imag(lambda);

    BB = [       2*g - (A(1,1) + A(2,2));
           h^2 + g^2 - A(1,1)*A(2,2) + A(1,2)*A(2,1)  ];
end

% Find observer gain
G = AA\BB;

%===============================================================================
%===============================================================================
