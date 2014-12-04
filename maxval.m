function [Y,I] = maxval(A)
% MAXVAL Largest component of matrix A
%   Y = MAXVAL(A) returns the value of the largest element in A
%
%   [Y,I] = MAXVAL(A) returns the indices of the value in vector I. If the
%   values along the first non-singleton dimension contain more than one
%   maximal element, the index of the first one is returned.
%
%   Use in place of: max(max(A))
%
%   See also MAX, MIN, MINVAL
%


Y = max(max(A));












end