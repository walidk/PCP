function [L_hat, P, Q] = l1_pca_higher_rank_block(Z, rk, varargin)
% [L, P, Q] = higher_rank_l1_pca_block(Z, rk, varargin)
% Computes a rank rk approximation of Z, by solving the optimizaion problem
% minimize ||Z - L_hat||
% subject to norm(p_r, 1) = 1
%            L_hat = \sum_{r = 1}^rk p_r q'_r
% This will solve for 
% projection_method:
%   0: at each iteration, solves the constrained problem, with ||p|| = 1
%   1: at each iteration, solves an unconstrained problem then normalizes p
%      and q (infinity norm)
% output:
%   L_hat is the approximation, L_hat = P*Q'


% Constants ===============================================================
max_iter = 400;
thresh = 1e-04;

% Init ====================================================================
[N1 N2] = size(Z);
L_hat = zeros(N1,N2);
P = zeros(N1,rk);
Q = zeros(N2,rk);

if(length(varargin) == 1)
    Q = varargin{1};
else
    Q = rand(N2, rk);
end

% Define a function that normalizes a vector ==============================
function normalized_x = normalize(x)
    norm_x = norm(x, inf);
    if(norm_x > 0)
        normalized_x = x / norm_x;
    else
        normalized_x = x;
    end
end

% Iterate =================================================================
dist = 1;
i = 1;

while(dist > thresh && i < max_iter)
    for r=1:rk
        % normalize q_r
        Q(:,r) = normalize(Q(:,r));
        q = Q(:,r);
        % solve for p_r
        P(:,r) = zeros(N1,1);
        p = wmed(Z' - Q*P', q);
        p = normalize(p);
        P(:,r) = p;
        % solve for q_r
        Q(:,r) = zeros(N2,1);
        q = wmed(Z - P*Q', p);
        Q(:,r) = q;
    end
    diff = L_hat - P*Q';
    dist = norm(diff(:), 2);
    L_hat = P*Q';
    i = i+1;
    fprintf('.')
end

% Display message =========================================================
if(dist <= thresh)
    disp(['converged after ', num2str(i), ' iterations'])
else
    disp('did not convere')
end
end


