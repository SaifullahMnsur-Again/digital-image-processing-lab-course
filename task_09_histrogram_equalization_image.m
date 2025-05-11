clc;
clear;
close all;

gray_img = uint8(imread('images/image5_gray.jpg'));
[h, w] = size(gray_img);

histogram = zeros(256, 1, 'double');
for i = 1:h
    for j = 1:w
        histogram(gray_img(i,j) + 1) = histogram(gray_img(i,j) + 1) + 1;
    end
end

pdf = zeros(256, 1, 'double');
for i = 1:256
    pdf(i) = histogram(i) / (h * w);
end

cdf = zeros(256, 1, 'double');
for i = 1:256
    if i == 1
        cdf(i) = pdf(i);
    else
        cdf(i) = cdf(i-1) + pdf(i);
    end
end

cdf_norm = zeros(256, 1, 'uint8');
for i = 1:256
    cdf_norm(i) = round(cdf(i) * 255);
end

equalized_img = zeros(h, w, 'uint8');
for i = 1:h
    for j = 1:w
        equalized_img(i, j) = cdf_norm(gray_img(i, j) + 1);
    end
end

figure(1);

subplot(2, 2, 1);
imshow(gray_img);
title('Original Image');

subplot(2, 2, 2);
plot(1:256, histogram);
title('Histogram');

subplot(2, 2, 3);
plot(1:256, cdf_norm);
title('Normalized CDF');

subplot(2, 2, 4);
imshow(equalized_img);
title('Equalized Image');