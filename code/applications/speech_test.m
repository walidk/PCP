clear all; close all; clc;

% path(path, './exact_alm_rpca');
% path(path, './exact_alm_rpca/PROPACK');
% path(path, './inexact_alm_rpca');
% path(path, './inexact_alm_rpca/PROPACK');

path(path, '../RPCA_algorithms');
path(path, '../RPCA_algorithms/PROPACK');
path(path, '../RPCA_algorithms/BLWS');

clean = load('FAK_18A_clean.ascii');
snr0 = load('FAK_18A_SNR0.ascii');
snr5 = load('FAK_18A_SNR5.ascii');
snr15 = load('FAK_18A_SNR15.ascii');
snr_5 = load('FAK_18A_SNR-5.ascii');

dim_n = 600;

clean = clean(:,3:dim_n);
snr0 = snr0(:,3:dim_n);
snr5 = snr5(:,3:dim_n);
snr15 = snr15(:,3:dim_n);
snr_5 = snr_5(:,3:dim_n);

feat = snr0;

[m n]=size(clean);

lambda = 0.4*1/sqrt(max(m, n));
%[low_rank sparse] = exact_alm_rpca(feat, lambda);
[low_rank sparse iter] = inexact_alm_rpca(feat, lambda, -1, -1);



sparse(find(0<=sparse &  sparse < 1e-5)) = 1e-5;
sparse(find(0>sparse & sparse > -1e-5)) = -1e-5;


figure;
surf(clean(:,2:n)','edgecolor','none'); view(2);axis tight;
title('clean');
xlabel('Frame','fontsize',24); ylabel('Feature index','fontsize',24);
set(gcf, 'Renderer', 'ZBuffer')

figure;
surf(feat(:,2:n)','edgecolor','none'); view(2);axis tight;
title('snr');
xlabel('Frame','fontsize',24); ylabel('Feature index','fontsize',24);
set(gcf, 'Renderer', 'ZBuffer');

figure;
surf(low_rank(:,2:n)','edgecolor','none'); view(2);axis tight;
title('low-rank');
xlabel('Frame','fontsize',24); ylabel('Feature index','fontsize',24);
set(gcf, 'Renderer', 'ZBuffer');

%%
figure;
surf(sparse(:,2:n)','edgecolor','none'); view(2);axis tight;
title('sparse');
xlabel('Frame','fontsize',24);ylabel('Feature index','fontsize',24);
set(gcf, 'Renderer', 'ZBuffer');

%%
figure;
surf([sparse(:,2:n)' low_rank(:,2:n)'],'edgecolor','none'); view(2);axis tight;
title('sparse + low-rank');
xlabel('Frame','fontsize',24);ylabel('Feature index','fontsize',24);
set(gcf, 'Renderer', 'ZBuffer');

diff_ori = clean - feat;
diff_sparse = clean - sparse;

norm_diff_ori = norm(diff_ori(:));
norm_diff_sparse = norm(diff_sparse(:));

diff_ori = clean - feat;
diff_sparse = clean - sparse;

norm_diff_ori = norm(diff_ori(:));
norm_diff_sparse = norm(diff_sparse(:));
