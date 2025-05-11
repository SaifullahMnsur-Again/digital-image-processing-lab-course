clc;
clear;
close all;

img1 = imread('images/image1.jpg');
img2 = imread('images/image2.jpg');

if size(img1) ~= size(img2)
    errpr('Different Image size!');
end

[h, w, ~] = size(img1);

added_img = zeros(h, w, 'uint8');
subtracted_img = zeros(h, w, 'uint8');

for i = 1:h
    for j = 1:w
        added_img(i, j) = min(img1(i, j) + img2(i, j), 255);
        subtracted_img(i, j) = max(img1(i, j) + img2(i, j), 0);
    end
end

figure(1);

subplot(2, 2, 1);
imshow(img1);
title('Image 1');

subplot(2, 2, 2);
imshow(img2);
title('Image 2');

subplot(2, 2, 3);
imshow(added_img);
title('Added Image');

subplot(2, 2, 4);
imshow(subtracted_img);
title('Subtracted Image');