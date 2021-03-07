clc; clear; close all;
I = (im2double(imread("Test_00.ppm")));

diameter = sqrt(size(I, 1)^2 + size(I, 2)^2);
Temp = zeros(ceil(diameter) + 2, ceil(diameter) + 2, 3);
rowdif = ceil(diameter) - size(I, 1);
coldif = ceil(diameter) - size(I, 2);
Temp(ceil(rowdif/2):size(I, 1) + ceil(rowdif/2) - 1, ceil(coldif/2):size(I, 2) + ceil(coldif/2) - 1, :) = I;

Xcenter = ceil(size(Temp, 1)/2);
Ycenter = ceil(size(Temp, 2)/2);

Result = zeros(ceil(diameter) + 2, ceil(diameter) + 2, 3);
prompt = '';
input = input(prompt);
hermitage = input / 180;
for i = 1: 1: size(Result,1)
    for j = 1: 1: size(Result,2)
        newX = ceil(cos(hermitage*pi)*(i - Xcenter) + sin(hermitage*pi)*(j - Ycenter) + Xcenter);
        newY = ceil(-1*sin(hermitage*pi)*(i - Xcenter) + cos(hermitage*pi)*(j - Ycenter) + Ycenter);
        
        if(newX>=1 && newY>=1 && newX<=size(Temp,2) && newY<=size(Temp, 1))
            Result(i, j,:) = Temp(newX, newY,:);
        end
    end
end
r = imrotate(I, input);
subplot(1,2,1)
imshow(r, [])
title('Rotate the image with the "imrotate" function')

subplot(1,2,2)
imshow(Result, [])
title('My Result')