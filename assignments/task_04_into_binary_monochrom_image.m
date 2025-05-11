clc;
clear;
close all;

gray_img = double(imread('images/image3_gray.jpg'));


[h, w] = size(gray_img);

sum_val = 0;
for i = 1:h
    for j = 1:w
        sum_val = sum_val + gray_img(i, j);
    end
end
mean_val = sum_val / (h*w);
threshold = mean_val;

bin_img = zeros(h, w, 1, 'uint8');

for i = 1:h
    for j = 1:w
        if gray_img(i, j) >= threshold
            bin_img(i, j) = 255;
        end
    end
end

figure(1);

subplot(1, 2, 1);
imshow(uint8(gray_img));
title('Original Gray Image');

subplot(1, 2, 2);
imshow(uint8(bin_img));
title('Binary/Monochrom Image');

imwrite(bin_img, 'images/image3_binary_monochrome.jpg');