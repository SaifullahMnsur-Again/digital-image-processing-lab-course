clc;
clear;
close all;

h = 200;
w = 200;

r = 0;
g = 0;
b = 0;

img = zeros(h, w, 3, 'uint8');
for i = 1:h
    for j = 1:w
        img(i, j, :) = [r, g, b];
    end
end

imshow(img);
title('Genrated image');
imwrite(img, 'images/image2.jpg');