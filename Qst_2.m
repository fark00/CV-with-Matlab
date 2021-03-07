clc; clear; close all;
img = im2double(imread('Test_00.ppm'));
% img = rgb2gray(img);

Red = img(:, :, 1);
Green = img(:, :, 2);
Blue = img(:, :, 3);

Gray = Red * 0.2989 + Green * 0.5870 + Blue * 0.1140;
% imshow(Gray, [])
img(:, :, 1) = Gray;
img(:, :, 2) = Gray;
img(:, :, 3) = Gray;
R = 200;
for i = 1 : size(img, 1)
    for j = 1 : size(img, 2)
        if round(sqrt((i-size(img,1)/2)^2 + (j-size(img, 2)/2)^2)) <= R
            img(i, j, 1) = 1;
            img(i, j, 2) = 0;
            img(i, j, 3) = 0;
        end
    end
end

imshow(img,[]);

imwrite(img, 'Result.jpg')