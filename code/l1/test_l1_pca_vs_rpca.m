% Compares:
% - l_1 PCA with with rk rank one l_1 approximate solutions
% - l_1 PCA with block coordinate descent
% - RPCA with lambda = 1/sqrt(N)

N = 20;         % size of the matrix
K = 8;          % support of the sparse component
rk = 2;         % rank of the low rank component
sigma_max = 10; % largest sigular value
S_max = 10;     % magnitude of the sparse component
T = 10;         % number of test cases in each plot point

%[M, L, slim_U, slim_V, sigma] = generate_noisy_low_rank(N, K, rk, sigma_max, S_max);
%S = M - L;



% As a function of rank ===================================================
rk_max = 5;
MM = zeros(rk_max, T, N, N);
LL = zeros(rk_max, T, N, N);

for t=1:T
    for rk=1:rk_max
        [MM(rk, t, :, :) LL(rk, t, :, :)] = generate_noisy_low_rank(N, K, rk, sigma_max, S_max);
    end
end

l1_pca_compare(MM, LL, 1:rk_max, 'rank(L)')




% As a function of noise ==================================================
% K_max = 5;
% MM = zeros(K_max, T, N, N);
% LL = zeros(K_max, T, N, N);
% 
% for K=1:K_max
%     for t=1:T
%         [MM(K, t, :, :) LL(K, t, :, :)] = generate_noisy_low_rank(N, K, rk, sigma_max, S_max);
%     end
% end
% 
% l1_pca_compare(MM, LL, 1:K_max, 'supp(S)')