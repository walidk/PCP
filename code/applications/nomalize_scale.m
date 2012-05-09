function image_out = nomalize_scale(image_in)

[m n num] = size(image_in);
max_val = max(max(max(image_in)));
min_val = min(min(min(image_in)));
image_out = (image_in - min_val*ones(m, n, num))/(max_val - min_val);

end