function [L, p, q] = l1_pca(Z, projection_method, varargin)
% [p, q] = l1_pca(Z, projection_method, [q0])
% Computes the l1 rank one approximation of Z, by computing a
% block-coordinate descent of the optimization problem
% mininmize ||Z - \sigma p q^T||_1
% subject to norm(p, inf) = 1
% Input:
% q0: optional argument: initial guess for q
% projection_method:
%   0: at each iteration, solves the constrained problem, with ||p|| = 1
%   1: at each iteration, solves an unconstrained problem then normalizes p
%      and q (infinity norm)
% Output: 
% If Z is N x M
% L = p*q' is N x M
% p is N x 1 and normalized (infinity norm)
% q is M x 1

max_iter = 100;
thresh = 1e-07;

if(length(varargin) > 1)
    error('Incorrect number of arguments. Type help l1_pca for help')
end

[N M] = size(Z);

if(length(varargin) == 1)
    q = varargin{1};
else
    q = rand(M, 1);
end

dist = 1;
i = 1;
p_old = rand(N, 1);

% define a function that normalizes a vector ==============================
function normalized_x = normalize(x)
    norm_x = norm(x, inf);
    if(norm_x > 0)
        normalized_x = x / norm_x;
    else
        normalized_x = x;
    end
end

% Iterate =================================================================
while(dist > thresh && i < max_iter)
    if(projection_method == 0) % solve the constrained problem
        p = cwmed(Z', q);
        q = wmed(Z, p); % note: sometimes the optimal q is 0
    else % solve the unconstrained problem then project (both p and q)
        q = normalize(q);
        p = wmed(Z', q);
        p = normalize(p);
        q = wmed(Z, p);
    end
    dist = norm(p - p_old, 2);
    p_old = p;
    i = i+1;
end

L = p*q';

% Display =================================================================
if(dist <= thresh)
    disp(['converged after ', num2str(i), ' iterations'])
else
    disp('did not convere')
end
end