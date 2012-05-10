function [L, P, Q] = l1_pca_higher_rank(Z, projection_method, rk, varargin)
% [L, P, Q] = l1_pca_higher_rank(Z, projection_method, rk, [q0])
% Computes a rank rk approximation of Z, by approximately solving the 
% optimizaion problem
% minimize ||Z - L||
% subject to norm(p_r, 1) = 1
%            L = \sum_{r = 1}^rk p_r q'_r
% The approximate solution is computed sequentially as a sum of rank-1 
% approximations
% input:
% -optional argument q0 specifies the initial guess for the singular vector q
% -projection_method:
%   0: at each iteration, solves the constrained problem, with ||p|| = 1
%   1: at each iteration, solves an unconstrained problem then normalizes p
%      and q (infinity norm)
% output:
% -L is the approximation, L = P*Q'

%% Init ===================================================================
[N1 N2] = size(Z);
L = zeros(N1,N2);
P = zeros(N1,rk);
Q = zeros(N2,rk);

%% Iterate ================================================================
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