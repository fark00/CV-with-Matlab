function out = My_Imresize_NN(Input_Image, Resizing_Factor)
  [rows, collumns, ~] = size(Input_Image);
    out = zeros(rows*Resizing_Factor, collumns*Resizing_Factor);
    for i = 1: size(out, 1)
        for j = 1: size(out, 2)
           
           i_temp = ceil(i/Resizing_Factor);
           j_temp = ceil(j/Resizing_Factor);
           
           if(i_temp >= 0.5)
               i_temp = ceil(i_temp);
           else
               i_temp = round(i_temp);
           end
           
           if(j_temp >= 0.5)
               j_temp = ceil(j_temp);
           else
               j_temp = round(j_temp);
           end
           
           out(i, j) = Input_Image(i_temp, j_temp);
        end
    end
end