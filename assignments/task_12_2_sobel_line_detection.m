clc;
clear;
close all;

% Load image and convert to grayscale
img = double(rgb2gray(imread('images/image8.jpg')));
[h, w] = size(img);

% Define Sobel kernels for edge detection (line detection)
sobel_x = [-1 0 1;
           -2 0 2;
           -1 0 1];

sobel_y = [-1 -2 -1;
            0  0  0;
            1  2  1];

% Initialize the output for horizontal and vertical gradients
gradient_x = zeros(h, w);
gradient_y = zeros(h, w);

% Manual convolution with Sobel kernels
for i = 2:h-1
    for j = 2:w-1
        region = img(i-1:i+1, j-1:j+1);
        gradient_x(i, j) = sum(sum(region .* sobel_x));  % Apply Sobel X filter
        gradient_y(i, j) = sum(sum(region .* sobel_y));  % Apply Sobel Y filter
    end
end

% Compute the gradient magnitude (to combine the x and y gradients)
gradient_magnitude = sqrt(gradient_x.^2 + gradient_y.^2);

% Normalize the gradient magnitude and gradients
normalized_gradient_magnitude = uint8(255 * mat2gray(gradient_magnitude));  % Normalize to [0, 255]
normalized_gradient_x = uint8(255 * mat2gray(gradient_x));  % Normalize Sobel X gradient
normalized_gradient_y = uint8(255 * mat2gray(gradient_y));  % Normalize Sobel Y gradient

% Thresholding to highlight strong edges (lines)
threshold = 50;  % Adjust as needed
lines = normalized_gradient_magnitude > threshold;

% Show results
figure;

subplot(2, 2, 1);
imshow(uint8(img));
title('Original Image');

subplot(2, 2, 2);
imshow(lines);
title('Sobel Line Detected Image');

subplot(2, 2, 3);
imshow(normalized_gradient_x);
title('Sobel Gradient X Detected Image');

subplot(2, 2, 4);
imshow(normalized_gradient_y);
title('Sobel Gradient Y Detected Image');
