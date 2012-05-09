function  l1_pca_compare(MM, LL, x, x_label)
% Computes and plots:
% - error: sum(sum(abs(L - Lhat))) the 
% - rank(Lhat) the rank of the low-rank component
% - supp(Shat) the support of the recovered sparse component
% each point in the plot is obtained by averaging T tests
% Compares:
% - l_1 PCA with with rk rank one l_1 approximate solutions
% - l_1 PCA with block coordinate descent
% - RPCA with lambda = 1/sqrt(N)



z_thresh = 1e-4;            % threshold for considering an entry is zero
plotPoints = size(MM, 1);   % number of plot points
T = size(MM, 2);            % number of tests for each plot point
N = size(MM, 3);            % size of the matrices

lambda = 1/sqrt(N); % regularization parameter in the RPCA problem


error = zeros(plotPoints, 3);
rank_Lhat = zeros(plotPoints, 3);
supp_Shat = zeros(plotPoints, 3);

for p=1:plotPoints
    disp(['Plot point ', num2str(p), ' ==========================================================='])
    for t=1:T
        % extract the matrices
        M = squeeze(MM(p, t, :, :));
        L = squeeze(LL(p, t, :, :));
        rk = rank(L);

        % l1 pca iter
        disp('l1 PCA iter')
        Lhat = l1_pca_higher_rank(M, 1, rk);
        Shat = M - Lhat;

        error(p, 1) = error(p, 1) + sum(sum(abs(L - Lhat)));
        rank_Lhat(p, 1) = rank_Lhat(p, 1) + rank(Lhat);
        supp_Shat(p, 1) = supp_Shat(p, 1) + supp(Shat, z_thresh);

        % l1 pca block
        disp('l1 PCA block')
        Lhat = l1_pca_higher_rank_block(M, rk);
        Shat = M - Lhat;

        error(p, 2) = error(p, 2) + sum(sum(abs(L - Lhat)));
        rank_Lhat(p, 2) = rank_Lhat(p, 2) + rank(Lhat);
        supp_Shat(p, 2) = supp_Shat(p, 2) + supp(Shat, z_thresh);
        
        % RPCA
        disp('RPCA')
        cvx_begin
            variable Lhat(N, N)
            minimize( norm_nuc(Lhat) + lambda * sum(sum(abs(M - Lhat))) )
        cvx_end
        Shat = M - Lhat;

        error(p, 3) = error(p, 3) + sum(sum(abs(L - Lhat)));
        rank_Lhat(p, 3) = rank_Lhat(p, 3) + rank(Lhat);
        supp_Shat(p, 3) = supp_Shat(p, 3) + supp(Shat, z_thresh);
    end
end

error = error/T;
rank_Lhat = rank_Lhat/T;
supp_Shat = supp_Shat/T;

figure(1)

subplot(1,3,1)
plot(x, error)
legend('l_1 PCA iter', 'l_1 PCA block', 'RPCA')
xlabel(x_label)
ylabel('||L - Lhat||')

subplot(1,3,2)
plot(x, rank_Lhat)
legend('l_1 PCA iter', 'l_1 PCA block', 'RPCA')
xlabel(x_label)
ylabel('rank(Lhat)')

subplot(1,3,3)
plot(x, supp_Shat)
legend('l_1 PCA iter', 'l_1 PCA block', 'RPCA')
xlabel(x_label)
ylabel('supp(Shat)')
end