clc; clear; close all;

I = im2double(imread('Boat.png'));

J = 255 - I;

MY_MSE(I,J)

figure, imshow(I, [])
figure, imshow(J, [])