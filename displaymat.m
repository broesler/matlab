% ------------------------------------------------------- displaymat(X,m,n)
% DISPLAYMAT(X,m,n) displays the non-zero entries of matrix X
%
%
%       Symbol          Criterion  
%         x       abs(X(i,j))/max(X(:) >  1e-1 
%         o       abs(X(i,j))/max(X(:) >  1e-6
%         =       abs(X(i,j))/max(X(:) >  0 
%       (none)    abs(X(i,j))/max(X(:) == 0 
%
%
%
% Inputs:
%       X    == size [M,N] matrix
%     (m,n)  == (optional) scalar number of (rows,columns) to skip between   
%                          drawing a marker.  
%                          Note: M/m and N/n should be whole numbers.
%
% Examples:
%       displaymat( rand(20,30) )
%       displaymat( rand(20,30) ,4,6)
%       displaymat(  eye(10,6 ) ,2,2)
%       displaymat(  eye(12,12) + (1e-6)*randn(12,12) ,4,4)
%       displaymat(  eye(12,12) + (1e-3)*randn(12,12) ,4,4)
% -------------------------------------------------------------------------


function [] = displaymat(X,m,n)

disp(' ')

% Normalize the matrix so the max is 1
X = abs(X) / max(abs( X(isfinite(X)) ));

[M,N] = size(X);

if nargin == 1

    for i = 1:M
        Y = '';
        
        for j = 1:N
            if     abs(X(i,j)) > 0.1
                 Y = [Y,'x '];
            elseif abs(X(i,j)) > 1e-6
                 Y = [Y,'o '];
            elseif     X(i,j)  ~= 0
                 Y = [Y,'= '];
            else Y = [Y,'  '];
            end
        end

        disp(['|',Y,'|'])
    end


    disp(' ')


else
    disp(['||',repmat([repmat('-',1,2*n),'|'],1,N/n),'|'])
        
    for i = 1:M
               
        Y = '';
        
        for j = 1:N
            if     abs(X(i,j)) > 0.1
                 Y = [Y,'x '];
            elseif abs(X(i,j)) > 1e-6
                 Y = [Y,'o '];
            elseif     X(i,j)  ~= 0
                 Y = [Y,'= '];
            else Y = [Y,'  '];
            end
            
            if mod(j,n) == 0
                Y = [Y,'|'];
            end

        end

        disp(['||',Y,'|'])
        
        if mod(i,m) == 0
            % disp(['||',repmat('-',1,length(Y)),'|'])
            disp(['||',repmat([repmat('-',1,2*n),'|'],1,N/n),'|'])
            
        end

    end


    disp(' ')

end
