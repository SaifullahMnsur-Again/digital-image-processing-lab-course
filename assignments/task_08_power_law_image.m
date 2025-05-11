clc;
clear;
close all;

img = double(imread('images/image4.jpg'));
[h, w, ch] = size(img);

m = zeros(1, ch);
for i = 1:h
    for j = 1:w
        for k = 1:ch
            if img(i, j, k) > m(k)
                m(k) = img(i, j, k);
            end
        end
    end
end

gamma = 0.3;

c = zeros(1, ch);
for i = 1:ch
    c(i) = 255 / m(i)^gamma;
end

power_law = zeros(h, w, ch, 'double');

for i = 1:h
    for j = 1:w
        for k = 1:ch
            power_law(i, j, k) = c(k) * img(i, j, k)^gamma;
        end
    end
    
end



figure(1);

subplot(1, 2, 1);
imshow(uint8(img));
title('Original Image');

subplot(1, 2, 2);
imshow(uint8(power_law));
title('Power Law Image');
