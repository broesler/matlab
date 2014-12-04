function [Y,I] = minval(A)
% MAXVAL Smallest component of matrix A
%   Y = MINVAL(A) returns the value of the largest element in A
%
%   [Y,I] = MAXVAL(A) returns the indices of the value in vector I. If the
%   values along the first non-singleton dimension contain more than one
%   minimal element, the index of the first one is returned.
%
%   Use in place of: min(min(A))
%
%   See also MAX, MIN, MINVAL
%


Y = min(min(A));












end