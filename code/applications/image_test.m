close all; clear all; clc;

path(path, '../RPCA_algorithms');
path(path, '../RPCA_algorithms/PROPACK');
path(path, '../RPCA_algorithms/BLWS');

num_img = 5;

image_rgb{1} = imread('Lobby/SwitchLight2260.bmp');
image_rgb{2} = imread('Lobby/SwitchLight2250.bmp');
image_rgb{3} = imread('Lobby/SwitchLight2270.bmp');
image_rgb{4} = imread('Lobby/SwitchLight2280.bmp');
image_rgb{5} = imread('Lobby/SwitchLight2290.bmp');

[m_img n_img n_chanel] = size(image_rgb{1});

%% for gray scale image
% for i = 1:5
%     image_in(:, :, i) = im2double(rgb2gray(image_rgb{i}));
% end
% 
% 
% [image_lr image_sp] = image_rpca(image_in);
% 
% figure;
% for i = 1:num_img
%     subplot(2, 3, i); imshow(image_in(:, :, i), []);
% end
% figure;
% for i =1:num_img
%     subplot(2, 3, i); imshow(image_lr(:, :, i), []);
% end
% 
% figure;
% for i =1:num_img
%     subplot(2, 3, i); imshow(image_sp(:, :, i), []);
% end

%% for rgb image

for i = 1:5
    image_in_r(:, :, i) = im2double(image_rgb{i}(:, :, 1));
    image_in_g(:, :, i) = im2double(image_rgb{i}(:, :, 2));
    image_in_b(:, :, i) = im2double(image_rgb{i}(:, :, 3));
end

tic
[image_r_lr image_r_sp] = image_rpca(image_in_r);
[image_g_lr image_g_sp] = image_rpca(image_in_g);
[image_b_lr image_b_sp] = image_rpca(image_in_b);
time_rpca = toc;

image_r_sp = nomalize_scale(image_r_sp);
image_g_sp = nomalize_scale(image_g_sp);
image_b_sp = nomalize_scale(image_b_sp);

for i = 1:5
    image_out_lr{i} = reshape([image_r_lr(:, :, i) image_g_lr(:, :, i) image_b_lr(:, :, i)], [m_img n_img 3]);
    image_out_sp{i} = reshape([image_r_sp(:, :, i) image_g_sp(:, :, i) image_b_sp(:, :, i)], [m_img n_img 3]);
end


figure;
for i = 1:num_img
    subplot(1, 5, i); imshow(image_rgb{i}, []);
end

figure;
for i =1:num_img
    subplot(1, 5, i); imshow(image_out_lr{i}, []);
end

figure;
for i =1:num_img
    subplot(1, 5, i); imshow(image_out_sp{i}, []);
end