function [M, L, slim_U, slim_V, sigma] = generate_noisy_low_rank(N, K, rk, sigma_max, S_max)
% generate_noisy_low_rank
% [M, L, slim_U, slim_V, sigma] = generate_noisy_low_rank(N, K, rank, sigma_max, S_max)
% generates a random matrix M = S + L where 
% L = \sum_{r = 1}^{rank} sigma(r)slim_U(:,r)slim_V(:,r)' is a low rank 
% matrix of
%   -size: N x N
%   -rank: rk
%   -largest singular value: sigma_max
% S is a sparse matrix of
%   -size: N x N
%   -cardinality of suport: K
%   -magnitude norm(S, inf): S_max
% returns:
%   -slim_U: N x r matrix of the left singular vectors of L.
%   -slim_V: N x r matrix of the right singular vectors of L.
%   -sigma: r vector of the sorted (descending) singular values of L.


% generate the low rank component =========================================
L = zeros(N, N);
% sorted vector of singular values, the largest is sigma_max
sigma = sigma_max * sort([1; rand(rk-1, 1)], 1, 'descend'); 

U = RandOrthMat(N);
V = RandOrthMat(N);
slim_U = U(:,1:rk);
slim_V = V(:,1:rk);

for r=1:rk
    L = L + sigma(r)*U(:,r)*V(:,r)';
end

% add sparse component ====================================================
S = zeros(N);
for k=1:K
    i = floor(N*rand(1)+1);
    j = floor(N*rand(1)+1);
    S(i, j) = S_max * (2*rand(1)-1);
end
M = L + S;