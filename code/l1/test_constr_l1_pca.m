%compares the iterative solution with projection, and the iterative
%solution with constraints

N = 10;         % size of the matrix
K = 0;          % support of the sparse component
T = 10;         % number of test cases
rk = 1;         % rank of the low rank component
sigma_max = 10; % largest sigular value
S_max = 10;     % magnitude of the sparse component

[M, L, slim_U, slim_V, sigma] = generate_noisy_low_rank(N ,N, K, rk, sigma_max, S_max);
S = M - L;



% plot errors for both the constrained and projected version of 
result = zeros(T, 2);
for t=1:T
    disp(['Test case ', num2str(t), ' ==================='])
    q0 = rand(N, 1);
    
	disp('constrained problem')
    L_hat = higher_rank_l1_pca(M, 0, rk, q0);
    result(t, 1) = sum(sum(abs(L - L_hat)));
    
    disp('projected problem')
    L_hat = higher_rank_l1_pca(M, 1, rk, q0);
    result(t, 2) = sum(sum(abs(L - L_hat)));
end

plot(result)
legend('l_1 pca constrained','l_1 pca projected')