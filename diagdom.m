function c = diagdom(A,opt)
% DIAGDOM Check if matrix is diagonally dominant
%
%  c = DIAGDOM(A) returns a logical T if A is simply diagonally dominant,
%    meaning that the magnitudes of its diagonal elements are greater than or
%    equal to the sum of the magnitudes of the off-diagonal elements in each row
%
%  c = DIAGDOM(A,'strict') returns a logical T if A is strictly diagonally
%    dominant, meaning that the magnitudes of its diagonal elements are greater
%    than (but not equal to) the sum of the magnitudes of the off-diagonal
%    elements in each row
%
%  Example:
%    diagdom([1 0; 
%             0 1]) == 1
%    diagdom([0 1;
%             1 0]) == 0
%    diagdom([ 3  2 -1; 
%              1 -3  2;
%             -1  2  3])           == 1
%    diagdom([ 3  2 -1;
%              1 -3  2; 
%             -1  2  3], 'strict') == 0
%
%  See also DIAG
%

%===============================================================================
%     File: diagdom.m
%  Created: 04/20/2016, 12:02
%   Author: Bernie Roesler
%
% Last Modified: 
%===============================================================================

% Input checking
if nargin < 2
    opt = 'simple';
elseif ~strcmp(opt, 'strict')
    warning('Option not recognized, using simple diagonal dominance...')
    opt = 'simple';
end

[m,n] = size(A);

if m ~= n
    error('A must be square!')
end

%-------------------------------------------------------------------------------
%        Check for diagonal dominance
%-------------------------------------------------------------------------------
diagA = abs(diag(A));                % n x 1 vector of magnitudes of diagonal elems
offdiagA = sum(abs(A),2) - diagA;    % n x 1 vector of magnitudes of off-diag elems

c = false;
if strcmp(opt, 'strict')
    if all(diagA > offdiagA)
        c = true;
    end
elseif strcmp(opt, 'simple')
    if all(diagA >= offdiagA)
        c = true;
    end
else
    error('Option not recognized!')
end
%===============================================================================
%===============================================================================
