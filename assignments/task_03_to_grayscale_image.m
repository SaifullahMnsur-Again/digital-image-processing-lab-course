clc;
clear;
close all;

img = imread('images/image5.jpg');


[h, w, ch] = size(img);

gray_img = zeros(h, w, 'uint8');

for i = 1:h
    for j = 1:w
        gray_img(i,j) = img(i, j, 1) * 0.299 + img(i, j, 2) * 0.587 + img(i, j, 3) * 0.114;
    end
end

figure(1);

subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(gray_img);
title('Gray Image');

imwrite(gray_img, 'images/image5_gray.jpg');