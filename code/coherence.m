%INCOHERENCE: 
%
%   This function computes the coherence parameter mu of a matrix which 
%   plays an important role in various forms of the Robust PCA problem. 

% Copyright:   227A project group
% Last edited:   Apr 09, 2012


function mu = coherence(L)

    % extract information about the matrix and compute its SVD
    [m,n] = size(L);
    [U,S,V] = svd(L,'econ');
    
    % get the rank
    r = rank(S);
    
    % compute value mu_a
    mu_a = m/r*max(sum(abs(U').^2,1));
    
    % compute value mu_b
    mu_b = n/r*max(sum(abs(V').^2,1));
    
    % compute value mu_c
    UVt = U*V';
    mu_c = m*n\r*norm(UVt(:),inf);
    
    % the actual mu is the maximum of the mu_i of the three conditions
    mu = max([mu_a,mu_b,mu_c]);
    
end




