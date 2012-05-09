function [L, P, Q] = l1_pca_higher_rank(Z, projection_method, rk, varargin)
% [L, P, Q] = l1_pca_higher_rank(Z, projection_method, rk, varargin)
% Computes a rank rk approximation of Z, by approximately solving the 
% optimizaion problem
% minimize ||Z - L||
% subject to norm(p_r, 1) = 1
%            L = \sum_{r = 1}^rk p_r q'_r
% The approximate solution is computed as a sum of rank-1 approximations
% projection_method:
%   0: at each iteration, solves the constrained problem, with ||p|| = 1
%   1: at each iteration, solves an unconstrained problem then normalizes p
%      and q (infinity norm)
% output:
%   L is the approximation, L = P*Q'

% Init ====================================================================
[N M] = size(Z);
L = zeros(N,M);
P = zeros(N,rk);
Q = zeros(M,rk);

% Iterate =================================================================
for r=1:rk
    if(length(varargin) == 1)
        [l, p, q] = l1_pca(Z - L, projection_method, varargin{1});
    else
        [l, p, q] = l1_pca(Z - L, projection_method);
    end
    L = L + l;
    P(:,r) = p;
    Q(:,r) = q;
end