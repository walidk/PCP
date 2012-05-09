function [M, L, slim_U, slim_V, sigma] = generate_noisy_low_rank_fast(N1, N2, K, rk, sigma_max, S_max)
% [M, L, slim_U, slim_V, sigma] = generate_noisy_low_rank_fast(N1, N2, K, rank, sigma_max, S_max)
% generates a random matrix M = S + L where 
% L = \sum_{r = 1}^{rank} sigma(r)slim_U(:,r)slim_V(:,r)' is a low rank 
% matrix of
%   -size: N1 x N2
%   -rank: rk
%   -largest singular value: sigma_max
% S is a sparse matrix of
%   -size: N1 x N2
%   -cardinality of suport: K
%   -magnitude norm(S, inf): S_max
% returns:
%   -slim_U: N1 x r matrix of the left singular vectors of L.
%   -slim_V: N2 x r matrix of the right singular vectors of L.
%   -sigma: r vector of the sorted (descending) singular values of L.
% This function should be used only for large matrices, otherwise prefer
% generate_noisy_low_rank, which will generate singular vectors U and V
% uniformly on the set of orthogonal matrices.


% generate the low rank component =========================================
L = zeros(N1, N2);
% sorted vector of singular values, the largest is sigma_max
s = rand(rk, 1); 

for r=1:rk
    L = L + s(r)*rand(N1,1)*rand(1,N2);
end

[U, Sigm, V] = svd(L, 0);
s = diag(Sigm);
s_max = max(s);
sigma = sigma_max * s(1:rk) / s_max;
L = sigma_max * L / s_max;
slim_U = U(:,1:r);
slim_V = V(:,1:r);

% add sparse component ====================================================
S = zeros(N1, N2);
for k=1:K
    i = floor(N1*rand(1)+1);
    j = floor(N2*rand(1)+1);
    S(i, j) = S_max * (2*rand(1)-1);
end
M = L + S;