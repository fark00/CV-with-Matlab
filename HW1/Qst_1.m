clc; clear;
F = fopen('Test_00.ppm');
File_Content = fread(F,'uint8');
fclose(F);
img = File_Content(17:end);

counter = 1;
temp = zeros(852, 1282, 3);
for i = 1 : 852
    for j = 1 :  1282
        for k = 1 : 3
            temp(i,j,k) = img(counter);
            counter = counter + 1;
        end
    end
end
temp = uint8(temp);

% out = reshape(img,[3 1282 852]);
% out = permute(out, [3 2 1]);
% out = uint8(out);
% figure, imshow(out);

I = imread('Test_00.ppm');

subplot(1,2,1)
imshow(temp, [])
title('Read the image with the "fopen" function')

subplot(1,2,2)
imshow(I, [])
title('Read the image with the "imread" function')