clc; clear; close all;

arr = zeros(1,37);

I = imread('Q_3/Image_39_1.png');
J = I;
for i = 1: size(I, 1)
    for j = 1:size(I, 2)
        if((I(i, j, 1) == 0 && I(i, j, 2) == 0 && I(i, j, 3) == 0) || (I(i, j, 1) == 255 && I(i, j, 2) == 255 && I(i, j, 3) == 255))
            I(i, j, 1) = 255;
            I(i, j, 2) = 255;
            I(i, j, 3) = 255;
            
        end
    end
end

for i = 2: size(I, 1)-1
    for j = 2:size(I, 2)-1
        if((I(i-1,j,1) > 0 && I(i+1,j,1)>0 && I(i+1,j,2) == 0 && I(i+1,j,3)==0 && I(i-1,j,2)==0 && I(i-1,j,3)==0) || (I(i,j-1,1) > 0 && I(i,j+1,1)>0 && I(i,j+1,2) == 0 && I(i,j+1,3)==0 && I(i,j-1,2)==0 && I(i,j-1,3)==0) || (I(i-1,j-1,1) > 0 && I(i+1,j+1,1)>0 && I(i+1,j+1,2) == 0 && I(i+1,j+1,3)==0 && I(i-1,j-1,2)==0 && I(i-1,j-1,3)==0) || (I(i+1,j-1,1) > 0 && I(i-1,j+1,1)>0 && I(i+1,j-1,2) == 0 && I(i+1,j-1,3)==0 && I(i-1,j+1,2)==0 && I(i-1,j+1,3)==0))
            I(i, j, 1) = 255;
            I(i, j, 2) = 0;
            I(i, j, 3) = 0;
        elseif((I(i-1,j,3) > 0 && I(i+1,j,3)>0 && I(i+1,j,2) == 0 && I(i+1,j,1)==0 && I(i-1,j,2)==0 && I(i-1,j,1)==0) || (I(i,j-1,3) > 0 && I(i,j+1,3)>0 && I(i,j+1,2) == 0 && I(i,j+1,1)==0 && I(i,j-1,2)==0 && I(i,j-1,1)==0) || (I(i-1,j-1,3) > 0 && I(i+1,j+1,3)>0 && I(i+1,j+1,2) == 0 && I(i+1,j+1,1)==0 && I(i-1,j-1,2)==0 && I(i-1,j-1,1)==0) || (I(i+1,j-1,3) > 0 && I(i-1,j+1,3)>0 && I(i+1,j-1,2) == 0 && I(i+1,j-1,1)==0 && I(i-1,j+1,2)==0 && I(i-1,j+1,1)==0))
            I(i, j, 1) = 0;
            I(i, j, 2) = 0;
            I(i, j, 3) = 255;
        end
    end
end

% templatesR = zeros(73,45,34,'double');
% templatesG = zeros(73,45,34,'double');
% templatesB = zeros(73,45,34,'double');
templates = zeros(73,45,34,'double');
counter = 1;
for m = 1 : 9
    for n = 1 : 4
        str = "Q_3_template2/" + m + "_" + n + "_" + ".png";
        J = im2double(imread(str));
%             templatesR(counter,:,:) = J(:,:,1);
%             templatesG(counter,:,:) = J(:,:,2);
%             templatesB(counter,:,:) = J(:,:,3);
        templates(counter,:,:) = rgb2gray(J);
%         templates(templates < 0.5) = 0;
%         templates(templates >= 0.5) = 1;

        counter = counter + 1;
    end
end
str = "Q_3_template2/" + 0 + "_" + 0 + "_" + 0 + ".png";
J = im2double(imread(str));
% templatesR(counter,:,:) = J(:,:,1);
% templatesG(counter,:,:) = J(:,:,2);
% templatesB(counter,:,:) = J(:,:,3);
templates(counter,:,:) = rgb2gray(J);
num = 0;
minn = 1000;
I = im2double((I));

I = rgb2gray(I);

summation = 0;
for i = 23 : size(I, 1) - 22
    for j = 17 : size(I, 2) - 17
%         if(sum(sum(I(i-22:i+22,j-16:j+17,1))) == 1530 && sum(sum(I(i-22:i+22,j-16:j+16,2))) == 1530 && sum(sum(I(i-22:i+22,j-16:j+17,3))) == 1530)
        if(sum(sum(I(i-22:i+22,j-16:j+17))) == 45*34)  
            continue;
        end
        counter = 1;
        
        for m = 1 :37
%             temp = 0;
%             temp = temp + sum(sum(abs(reshape(templatesR(counter,:,:),45,34) - I(i-22 : i + 22, j - 16: j + 17, 1))));
%             temp = temp + sum(sum(abs(reshape(templatesG(counter,:,:),45,34) - I(i-22 : i + 22, j - 16: j + 17, 2))));
%             temp = temp + sum(sum(abs(reshape(templatesB(counter,:,:),45,34) - I(i-22 : i + 22, j - 16: j + 17, 3))));
            temp = psnr(reshape(templates(counter,:,:),45,34),I(i:45+i-1,j:34+j-1));
%             temp = sum(sum(abs(reshape(templates(counter,:,:),45,34) - I(i-22 : i + 22, j - 16: j + 17))));
            arr(1, counter) = temp/3;
            counter = counter + 1;
        end
        
        [val, idx] = max(arr);

        if(val > 11  && idx ~= 37)
            I(i-22 : i + 22, j - 16: j + 17) = 1;
%             I(i-22 : i + 22, j - 16: j + 17, 1) = 1;
%             I(i-22 : i + 22, j - 16: j + 17, 2) = 1;
%             I(i-22 : i + 22, j - 16: j + 17, 3) = 1;
            num = num + 1;
            remm = rem(idx, 4);
            devv = round(idx/4);
            if(remm == 0)
                numm = devv;
            else
                numm = devv + 1;
            end
            numm
            
%             remm = rem(idx, 2);
%             if(remm == 0)
%                 coe = 1;
%             else
%                 coe = -1;
%             end
%             coe = 1;
%             summation = summation + numm * coe;
        end
    end
end