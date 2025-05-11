clc;
clear;
close all;

img = uint8(imread('images/image3_gray.jpg'));
[h, w] = size(img);


subplot(2, 5, 1);
imshow(img);
title('Original Image');

bit_planes = zeros(h, w, 8);

for bit_plane = 0:7
    for i = 1:h
        for j = 1:w
            bit_planes(i, j, bit_plane+1) = bitget(img(i,j), bit_plane+1);
        end
    end
    
    subplot(2, 5, bit_plane+2);
    imshow(bit_planes(:, :, bit_plane+1)) ;
    title([num2str(bit_plane), 'th bit plane']);
end

% Step 5: Reconstruct the image from the bit planes
reconstructed_img = zeros(h, w);

for bit_plane = 0:7
    % Shift the bit plane to its original position and add it to the reconstructed image
    reconstructed_img = reconstructed_img + bit_planes(:, :, bit_plane + 1) * 2^bit_plane;
end

subplot(2, 5, 10);
imshow(uint8(reconstructed_img));
title('Reconstructed Image');

diff = uint8(uint8(img) - uint8(reconstructed_img));
maxx = max(diff(:));
disp(maxx);