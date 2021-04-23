clc; clear; close all; imtool close all;

tic
dataset = ('Q_3/');
directory = dir(dataset);
accuracy = 0.0;

for i = 2 : 1 : numel(directory)
    if directory(i).isdir == 0
        I = imread([dataset directory(i).name]);
        result = MY_TemplateMatching(I);
        answer = sscanf(directory(i).name, "Image_%d_%d.png");
        if(answer(2) == result)
            accuracy = accuracy + 1;
        end
        I = MY_InsertText(I, result);
        imwrite(I, ['Q_3_Results/' directory(i).name]);
    end
    
end

accuracy
toc