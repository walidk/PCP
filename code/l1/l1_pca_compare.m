function  l1_pca_compare(MM, LL, x, x_label, toCompare)
% l1_pca_compare(MM, LL, x, x_label, [toCompare])
% Computes and plots:
% - error: sum(sum(abs(L - Lhat))) the 
% - rank(Lhat) the rank of the low-rank component
% - supp(Shat) the support of the recovered sparse component
% each point in the plot is obtained by averaging T tests
% Compares:
% (1) l1 PCA iter: l_1 PCA with with rk rank one l_1 approximate solutions
% (2) l1 PCA block: l_1 PCA with block coordinate descent
% (3) RPCA: RPCA with lambda = 1/sqrt(N)
% Can compare only a subset of these with the Boolean vector toCompare. For
% example, if toCompare is [false, true, true], will only compare l1 PCA
% block and RPCA

%% Constants ==============================================================
z_thresh = 1e-3;                % threshold for considering an entry is zero
plotPoints = size(MM, 1);       % number of plot points
T = size(MM, 2);                % number of tests for each plot point
N1 = size(MM, 3);               % size of the matrices
N2 = size(MM, 4);               % size of the matrices
lambda = 1/sqrt(max(N1, N2));   % regularization parameter in the RPCA problem

%% Init ===================================================================
if(nargin < 5)
    toCompare = [true, false, true, true];
end
nbToCompare = sum(toCompare);
error = zeros(plotPoints, nbToCompare);
perc_recovery = zeros(plotPoints, nbToCompare);
rank_Lhat = zeros(plotPoints, nbToCompare);
supp_Shat = zeros(plotPoints, nbToCompare);



%% Solve optimization problems ============================================
for p=1:plotPoints
    disp(['Plot point ', num2str(p), ' ==========================================================='])
    for t=1:T
        m = 1;
        
        % extract the matrices
        M = squeeze(MM(p, t, :, :));
        L = squeeze(LL(p, t, :, :));
        rk = rank(L);

        if(toCompare(1))
            % l1 pca iter
            disp('l1 PCA iter ========================')
            Lhat = l1_pca_higher_rank(M, 1, rk);
            Shat = M - Lhat;
            
            error(p, m) = error(p, m) + sum(sum(abs(L - Lhat)));
            perc_recovery(p, m) = perc_recovery(p, m) + (sum(sum(abs(L - Lhat)))/max(N1,N2) < z_thresh);
            rank_Lhat(p, m) = rank_Lhat(p, m) + rank(Lhat, z_thresh);
            supp_Shat(p, m) = supp_Shat(p, m) + supp(Shat, z_thresh);
            m = m + 1;
        end
        
        if(toCompare(2))
            % l1 pca iter constrained
            disp('l1 PCA iter const ===================')
            Lhat = l1_pca_higher_rank(M, 0, rk);
            Shat = M - Lhat;
            
            error(p, m) = error(p, m) + sum(sum(abs(L - Lhat)));
            perc_recovery(p, m) = perc_recovery(p, m) + (sum(sum(abs(L - Lhat)))/max(N1,N2) < z_thresh);
            rank_Lhat(p, m) = rank_Lhat(p, m) + rank(Lhat, z_thresh);
            supp_Shat(p, m) = supp_Shat(p, m) + supp(Shat, z_thresh);
            m = m + 1;
        end
        
        if(toCompare(3))
            % l1 pca block
            disp('l1 PCA block =======================')
            Lhat = l1_pca_higher_rank_block(M, rk);
            Shat = M - Lhat;

            error(p, m) = error(p, m) + sum(sum(abs(L - Lhat)));
            perc_recovery(p, m) = perc_recovery(p, m) + (sum(sum(abs(L - Lhat)))/max(N1,N2) < z_thresh);
            rank_Lhat(p, m) = rank_Lhat(p, m) + rank(Lhat, z_thresh);
            supp_Shat(p, m) = supp_Shat(p, m) + supp(Shat, z_thresh);
            m = m + 1;
        end
        
        if(toCompare(4))
            % RPCA
            disp('RPCA ===============================')
            cvx_begin
                variable Lhat(N1, N2)
                minimize( norm_nuc(Lhat) + lambda * sum(sum(abs(M - Lhat))) )
            cvx_end
            Shat = M - Lhat;

            error(p, m) = error(p, m) + sum(sum(abs(L - Lhat)));
            perc_recovery(p, m) = perc_recovery(p, m) + (sum(sum(abs(L - Lhat)))/max(N1,N2) < z_thresh);
            rank_Lhat(p, m) = rank_Lhat(p, m) + rank(Lhat, z_thresh);
            supp_Shat(p, m) = supp_Shat(p, m) + supp(Shat, z_thresh);
        end
    end
end

% normalize
error = error/T;
perc_recovery = perc_recovery/T;
rank_Lhat = rank_Lhat/T;
supp_Shat = supp_Shat/T;

%% Plot ===================================================================
figure(1)

% create the legend
leg = {};
m = 1;
if(toCompare(1))
    leg{m} = 'l_1 PCA';
    m = m + 1;
end
if(toCompare(2))
    leg{m} = 'l_1 PCA an constr';
    m = m + 1;
end
if(toCompare(3))
    leg{m} = 'l_1 PCA synth';
    m = m + 1;
end
if(toCompare(4))
    leg{m} = 'RPCA';
end


subplot(2,2,1)
plot(x, error)
legend(leg)
xlabel(x_label)
ylabel('||L - Lhat||')

subplot(2,2,2)
plot(x, perc_recovery)
legend(leg)
xlabel(x_label)
ylabel('exact recovery %')

subplot(2,2,3)
plot(x, rank_Lhat)
legend(leg)
xlabel(x_label)
ylabel('rank(Lhat)')

subplot(2,2,4)
plot(x, supp_Shat)
legend(leg)
xlabel(x_label)
ylabel('supp(Shat)')


% save figure
filename = ['out/', num2str(N1), 'x', num2str(N2), '_', x_label];
savefig(filename, 'pdf');
end