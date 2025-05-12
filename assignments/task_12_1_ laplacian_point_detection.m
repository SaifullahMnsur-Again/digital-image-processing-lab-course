clc;
clear;
close all;

% Load image and convert to grayscale
img = double(imread('images/image3_gray.jpg'));
[h, w] = size(img);

% Define Laplacian kernel
laplacian = [0 -1 0;
            -1 4 -1; 
             0 -1 0];

% Initialize output
point_filtered = zeros(h, w);

% Manual convolution
for i = 2: h - 1
    for j = 2: w - 1
        region = img(i-1:i+1, j-1:j+1);
        point_filtered(i, j) = sum(sum(region .* laplacian));
    end
end

% Take absolute value and normalize
point_filtered = abs(point_filtered);
normalized = uint8(255 * mat2gray(point_filtered));  % normalize to [0, 255]

% Thresholding to highlight points
threshold = 30;  % adjust as needed
points = normalized > threshold;

% Show results
figure;

subplot(1, 2, 1);
imshow(uint8(img));
title('Original Image');

subplot(1, 2, 2);
imshow(points);
title('Laplacian Point Detected Image');
