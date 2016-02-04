function [T, rankO, sigma] = isObservable(O,TOL)
%
% ISOBSERVABLE determine if a system is observable based on its
%   observability matrix
%
%   T = ISOBSERVABLE(O) returns a logical 1 for an observable system, 0
%   if system is unobservable
%
%   [T, rankO] = ISOBSERVABLE(O) returns a logical value and the rank of
%   the observability matrix
%
%   [T, rankO, sigma] = ISOBSERVABLE(O) also returns the singular values
%   of O
%
%   ISOBSERVABLE makes us of the MATLAB function SVD to determine the
%   rank of the observability matrix. If the rank is equal to the number
%   of rows in O (= n = number of rows in A = number of states).
%
%   See also OBSERVABILITY, SVD

%==============================================================================
%     File: isObservable.m
%  Created: 5/12/14
%   Author: Bernie Roesler
%
% Last Modified: 02/04/2016, 16:17
%===============================================================================

% Count all non-negative indices. TOL is tolerance within which values will
% be considered 0
if (nargin < 2)
    TOL = 1e-9;
end

% initialize output variable
T = false;

n = size(O,1);

% srank returns:
%   [ the rank of O, 
%     the allowed singular values of O (ignored here),
%     all of the singular values of O ]
[rankO, ~, sigma] = srank(O, TOL);       % find using SVD

if (rankO == n)
    T = true;
end

%===============================================================================
%===============================================================================
