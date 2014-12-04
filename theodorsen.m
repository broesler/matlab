function c = theodorsen(k)
%
% THEODORSEN compute the Theodorsen lag function from reduced frequency.
%
%   c = THEODORSEN(k) returns the Theodorsen lag function value given reduced
%       frequency k. For an oscillating airfoil, k = omega*c/(2*U);
%
%   The THEODORSEN function is given in terms of standard and modified Bessel
%   functions:
%
%     H_0(k) = J_0(k) - iY_0(k); H_1(k) = J_1(k) - iY_1(k)
%
%                            H_1(k)
%               C(k) = ------------------
%                       H_1(k) + iH_0(k)
%
%   See also BESSELH, BESSELJ, BESSELY
%-------------------------------------------------------------------------------

c = besselh(1,2,k) ./ (besselh(1,2,k) + 1i*besselh(0,2,k));

end