clc; clear; close all;

I = im2double(imread('test.ppm'));
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
J = R/3 + G/3 + B/3;
J = cat(3,J,J,J);


psnr = 10 * log10(1/MY_immse(I, J))