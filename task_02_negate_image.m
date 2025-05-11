clc;
clear;
close all;

img = imread('images/image3.jpg');


[h, w, ch] = size(img);

negative_img = zeros(h, w, ch, 'uint8');

for i = 1:h
    for j = 1:w
        for k = 1:ch
            negative_img(i, j, k) = 255 - img(i,j, k);
        end
    end
end

figure(1);

subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(negative_img);
title('Negative Image');

imwrite(negative_img, 'images/image3_negated.jpg');