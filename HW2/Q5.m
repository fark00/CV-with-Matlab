clc; clear; close all;

I = im2double(imread('LR_Boat.png'));
I = I(:,:,1);

tic
J = MY_Imresize_DCCI(I);
toc

J1=im2double(imread('Boat.png'));
J1=J1(:, :, 1);
J2=imresize(I,2,'nearest');
J3=imresize(I,2,'bilinear');
% J4=imresize(I,2,'bicubic');
% J5 = imresize(I,2,'lanczos2');
% J6 = imresize(I,2,'lanczos3');

psnr(J1,J)
psnr(J1,J2)
psnr(J1,J3)
% psnr(J1,J4)
% psnr(J1,J5)
% psnr(J1,J6)

% figure,imshow(J,[])

