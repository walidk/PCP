close all; clear all;

% path(path, './inexact_alm_rpca');
% path(path, './inexact_alm_rpca/PROPACK');
path(path, '../RPCA_algorithms');
path(path, '../RPCA_algorithms/PROPACK');
path(path, '../RPCA_algorithms/BLWS');

%% read object
obj = VideoReader('Movie2012-04-19at16.49.mov');
video = read(obj);
% imshow(video(:, :, :, 100));
% load video_16.49.mat;


num_img = 5;
write2video = 0;

for i = 1:num_img
    image_rgb{i} = video(:, :, :, 250+30*(i-1));
%     image_rgb{i} = video(:, :, :, i);
end;

% for i = 1:num_img
%     image_rgb{i} = imresize(image_rgb{i}, 1/3);
% end
[m_img n_img n_chanel] = size(image_rgb{1});

%% for gray scale image
% for i = 1:num_img
%     image_in(:, :, i) = im2double(rgb2gray(image_rgb{i}));
% end
% 
% tic
% [image_lr image_sp] = image_rpca(image_in);
% running_time = toc;
% 
% figure;
% for i = 1:num_img
%     subplot(3, 5, i); imshow(image_in(:, :, i));
% end
% 
% for i =1:num_img
%     subplot(3, 5, num_img+i); imshow(image_lr(:, :, i));
% end
% 
% for i =1:num_img
%     subplot(3, 5, 2*num_img+i); imshow(image_sp(:, :, i), []);
% end
% 
% %% write to video file
% if write2video
%     new_video_obj = VideoWriter('newfile.avi');
% 
%     open(new_video_obj);
%     for i = 1:num_img
%         writeVideo(new_video_obj, uint8(255*(image_lr(:, :, i))));
%     end
%     close(new_video_obj);
% end

%% for rgb image

for i = 1:num_img

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


for i = 1:num_img
    image_out_lr{i} = reshape([image_r_lr(:, :, i) image_g_lr(:, :, i) image_b_lr(:, :, i)], [m_img n_img 3]);
    image_out_sp{i} = reshape([image_r_sp(:, :, i) image_g_sp(:, :, i) image_b_sp(:, :, i)], [m_img n_img 3]);
end


figure;
for i = 1:num_img
    subplot(3, 5, i); imshow(image_rgb{i});
end

for i =1:num_img
    subplot(3, 5, num_img+i); imshow(image_out_lr{i});
end

for i =1:num_img
    subplot(3, 5, 2*num_img+i); imshow(image_out_sp{i});
end

if write2video
    new_video_obj = VideoWriter('newfile.avi');

    open(new_video_obj);
    for i = 1:num_img
        writeVideo(new_video_obj, uint8(255*(image_out_lr{i})));
    end
    close(new_video_obj);
end