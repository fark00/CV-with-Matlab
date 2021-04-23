close all; 
clear, clc;


for i = 1:9
%     
%     load('Q_4/lena.mat');
%     I = lena;
    I = (imread('Q_4/House.tif'));

    J = imnoise(I, 'salt & pepper', i/10);
    O = NAMF(J, 2, 20, 0.8);
    M = medfilt2(J);
    M = double(M)/255;
    I = double(I)/255;
    O = double(O)/255;
    MY_PSNR(I, O)
    MY_PSNR(I, M)
    imshow([I O M],[])
    
end