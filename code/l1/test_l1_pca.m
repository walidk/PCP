% Compares:
% - sequencial l_1 PCA, referred to as Analysis view of PCA (finds one 
% direction at a time, then projects on the complement and solves for the 
% next component). Two flavors are tested:
%   - constrained: at each iteration, solve a constrained problem (norm(p, inf) = 1)
%   - projected: at each iteration, solve an unconstrained problem then
%   project the solutions (p,q)
% - Batch l_1 PCA, referred to as Synthesis view of PCA (solves for all 
% components simultaneously, using a block coordinate descent algorithm)
% - RPCA with lambda = 1/sqrt(N)

%% Constants ==============================================================
N1 = 20;       % number of rows
N2 = 10;        % number of columns
K = 100;        % support of the sparse component
rk = 3;         % rank of the low rank component
sigma_max = 10; % largest sigular value
S_max = 0.1;     % magnitude of the sparse component
T = 1;         % number of test cases in each plot point
toCompare = [true, false, true, true];
%[M, L, slim_U, slim_V, sigma] = generate_noisy_low_rank(N, K, rk, sigma_max, S_max);
%S = M - L;



%% As a function of rank ==================================================
rk_max = 5;
rk_min = 1;
MM = zeros(rk_max - rk_min + 1, T, N1, N2);
LL = zeros(rk_max - rk_min + 1, T, N1, N2);

for t=1:T
    for rk=rk_min:rk_max
        [MM(rk, t, :, :) LL(rk, t, :, :)] = generate_noisy_low_rank_fast(N1, N2, K, rk, sigma_max, S_max);
    end
end

l1_pca_compare(MM, LL, rk_min:rk_max, 'rank(L)', toCompare)




%% As a function of noise =================================================
K_max = 5;
K_min = 0;
MM = zeros(K_max - K_min + 1, T, N1, N2);
LL = zeros(K_max - K_min + 1, T, N1, N2);

for K=K_min:K_max
    for t=1:T
        [MM(K, t, :, :) LL(K, t, :, :)] = generate_noisy_low_rank(N1, N2, K, rk, sigma_max, S_max);
    end
end

l1_pca_compare(MM, LL, K_min:K_max, 'supp(S)')