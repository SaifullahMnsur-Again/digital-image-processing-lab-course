clc;
clear;
close all;

img = double(imread('images/image4.jpg'));
[h, w, ch] = size(img);

m = zeros(3);
for i = 1:h
    for j = 1:w
        for k = 1:ch
            if img(i, j, k) > m(k)
                m(k) = img(i, j, k);
            end
        end
    end
end

c = zeros(ch);
for i = 1:ch
    c(i) = 255 / log(m(i) + 1);
end

transformed = zeros(h, w, ch, 'double');

for i = 1:h
    for j = 1:w
        for k = 1:ch
            transformed(i, j, k) = c(k) * log(img(i, j, k) + 1);
        end
    end
    
end



figure(1);

subplot(1, 2, 1);
imshow(uint8(img));
title('Original Image');

subplot(1, 2, 2);
imshow(uint8(transformed));
title('Log Transformed Image');
