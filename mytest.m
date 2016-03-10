function n = mytest(a,b,ztol)
% MYTEST Test if two variables are numerically equivalent {{{
% 
%  MYTEST(a,b) prints the norm of the absolute value of the difference between
%    variables a and b, assuming a value < 5e12 is "0"
%
%  n = MYTEST(a,b,ztol) allows specification of the zero-tolerance, and returns
%    the norm(abs(a - b))
%

%  Created: 03/10/2016, 10:19
%   Author: Bernie Roesler
%
% Last Modified: 03/10/2016, 10:40
%============================================================================}}}
if nargin < 3
    ztol = 5e-12;
end

% Get strings for names of variables being compared
s1 = inputname(1);
s2 = inputname(2);

% Take norm of difference
n = norm(abs(a - b)); 
if (n < ztol)
    fprintf('%8s =? %-8s \tpassed! norm = %8.4e\n', s1, s2, n)
end

%===============================================================================
%===============================================================================
