function [image_lr image_sp] = image_rpca(image_array)

[m_img n_img num_img ] = size(image_array);

I = reshape(image_array, [m_img*n_img num_img]);

mean_I = repmat(mean(I, 2), 1, num_img);
num_bigger = (sum((I - mean_I)>0, 2));
offset = -10*(num_bigger > num_img/2);
offset = repmat(offset, 1, num_img);

% offset = zeros(m_img*n_img, num_img);
% for i = 1:(m_img*n_img)
%     num_bigger = sum((I(i, :) - mean_I(i, :))>0);
%     if( num_bigger > num_img/2)
%         offset(i, :) = -10*ones(1, num_img);
%     else
%         offset(i, :) = 10*ones(1, num_img);
%     end
% end

I = I + offset;

[m n] = size(I);
lambda = 1.5*1/sqrt(max(m, n));

[L_est S_est] = inexact_alm_rpca(I, lambda);
% [L_est S_est] = BLWS_ialm_rpca(I, lambda);
% [S_est, L_est] = robustpcarankonev4(m,n, I);

L_est = L_est - offset;


image_lr = reshape(L_est , [m_img, n_img, num_img]);
image_sp = reshape(S_est , [m_img, n_img, num_img]);

end