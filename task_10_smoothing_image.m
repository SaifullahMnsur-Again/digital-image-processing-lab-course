clc;
clear;
close all;

img = double(imread('images/image6_gray.jpg'));
[h, w, ch] = size(img);

kernel_size = input('Enter kernel size: ');

if kernel_size < 1 || kernel_size > h*w
    error('Invalid kernel size. Must be between 1 and min(image height or width).');
end

new_h = h - kernel_size + 1;
new_w = w - kernel_size + 1;
smooth_img = zeros(new_h, new_w, ch, 'uint8');

for i = 1: h - kernel_size + 1
    for j = 1 : w - kernel_size + 1
        for k = 1: ch
            sum_val = 0.0;
            for ii = 0: kernel_size-1
                for jj = 0: kernel_size-1
                    sum_val = sum_val + img(i + ii, j + jj, k);
                end
            end
            mean_val = sum_val / (kernel_size * kernel_size);
            smooth_img(i, j, k) = uint8(mean_val);
        end
    end
end

figure(1);

subplot(1, 2, 1);
imshow(uint8(img));
title('Original Image');

subplot(1, 2, 2);
imshow(uint8(smooth_img));
title(['Smooth Image [Kernel: ', num2str(kernel_size), 'x', num2str(kernel_size), ']']);