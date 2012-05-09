close all; clear all;

% path(path, './inexact_alm_rpca');
% path(path, './inexact_alm_rpca/PROPACK');

path(path, '../RPCA_algorithms');
path(path, '../RPCA_algorithms/PROPACK');
path(path, '../RPCA_algorithms/BLWS');

vote_data = load('Senators4/senate_voting_data_only.mat');
senparts = load('Senators4/SenatorTagData.mat');

cov_mat = cov(vote_data.data);

[m n] = size(cov_mat);
lambda = 1*1/sqrt(max(m, n));

[L_est S_est] = inexact_alm_rpca(cov_mat, lambda);

M = L_est;
[V,D] = eigs(M);
point = zeros(2, m);
for i = 1:m
    point(1, i) = M(i, :)*V(:, 1);
    point(2, i) = M(i, :)*V(:, 2);
end

figure; hold on;
title('Standard PCA with first two principal components in low-rank component of covariance matrix', 'fontsize', 20);
xlabel('First PC', 'fontsize', 20);
ylabel('Second PC', 'fontsize', 20);
for i = 1:m
    if senparts.senparts(i) == 1
        plot(point(1, i), point(2, i), 'bo', 'MarkerSize', 14);
    else
        plot(point(1, i), point(2, i), 'ro', 'MarkerSize', 14);
    end
end
legend('Democratic Party', 'Republican Party');
set(gca, 'fontsize', 20);

large_diff = (abs(S_est)>0.08);

text(point(1, 1), point(2, 1)+0.05, '1 Specter', 'fontsize', 14);
text(point(1, 73), point(2, 73)+0.05, '73 Snowe', 'fontsize', 14);
text(point(1, 91), point(2, 91)+0.05, '91 Collins', 'fontsize', 14);
text(point(1, 35), point(2, 35)+0.05, '35 Jeffords', 'fontsize', 14);

text(point(1, 7), point(2, 7)+0.05, '7 Dorgan', 'fontsize', 14);
text(point(1, 56), point(2, 56)+0.05, '56 Conrad', 'fontsize', 14);

text(point(1, 17), point(2, 17)+0.05, '17 Inouye', 'fontsize', 14);
text(point(1, 18), point(2, 18)+0.05, '18 Akaka', 'fontsize', 14);

text(point(1, 48), point(2, 48)+0.05, '48 McCain', 'fontsize', 14);
text(point(1, 50), point(2, 50)+0.05, '50 Kyl', 'fontsize', 14);

text(point(1, 10), point(2, 10)+0.05, '10 Grassley', 'fontsize', 14);
text(point(1, 8), point(2, 8)+0.05, '8 Chambliss', 'fontsize', 14);
text(point(1, 12), point(2, 12)+0.05, '12 Hagel', 'fontsize', 14);

% text(data(:,91)'*sv1,data(:,91)'*sv2+0.1,names(91),'FontWeight','bold');
figure;
subplot(1,3, 1);imshow(cov_mat, []);
title('Covariant Matrix', 'fontsize', 16);
subplot(1,3, 2);
imshow(L_est, []);
title('Low-rank Components', 'fontsize', 16);
subplot(1,3, 3);
imshow(abs(S_est), []);
title('Sparse Components', 'fontsize', 16);

%(1, 73), (1, 91), (73, 91), (35, 73), (7, 56), (17, 18), (48, 50);