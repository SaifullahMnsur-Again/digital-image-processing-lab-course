clc;
clear;
close all;

img = uint8(imread('images/image3_resized.jpg'));
[h, w, ch] = size(img);

figure(1);
subplot(2, (ch+1)/2, 1);
imshow(img);
title('Original Image');

for k = 1:ch
    histogram = zeros(256);
    for i = 1:h
        for j = 1:w
            histogram(img(i,j, k) + 1) = histogram(img(i,j, k) + 1) + 1;
        end
    end
    
    subplot(2, (ch+1)/2, k + 1);
    stem(0:255, histogram);
    title(['Color ', num2str(k)]);
end