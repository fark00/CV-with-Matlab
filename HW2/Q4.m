clc; clear; close all;

I = rgb2gray(im2double(imread('LR_House.png')));
I2 = rgb2gray(im2double(imread('House.png')));
out1 = My_Imresize_BL(I,2);
out2 = MY_Imresize_NN(I,2);

MY_PSNR(out1, I2)
MY_PSNR(out2, I2)
