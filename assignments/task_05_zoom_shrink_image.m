clc;
clear;
close all;

img = double(imread('images/image4.jpg'));


[h, w, ch] = size(img);
factor = input('Enter resizing factor: ');

new_h = round(h * factor);
new_w = round(w * factor);

resized_img = zeros(new_h, new_w, ch, 'uint8');

for i = 1:new_h
    for j = 1:new_w
        for k = 1:ch
            org_i = round(i / factor);
            org_j = round(j / factor);
            
            if org_i < 1
                org_i = 1;
            elseif org_i > h
                org_i = h;
            end
            
            if org_j < 1
                org_j = 1;
            elseif org_j > w
                org_j = w;
            end
            
            resized_img(i, j, k) = img(org_i, org_j, k);
        end
    end
end

figure(1);

subplot(1, 2, 1);
imshow(uint8(img));
title(['Original Image ', mat2str(size(img))]);

subplot(1, 2, 2);
imshow(uint8(resized_img));
title(['Reized Image ', mat2str(size(resized_img))]);

imwrite(uint8(resized_img), 'images/image4_resized.jpg');