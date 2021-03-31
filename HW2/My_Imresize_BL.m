function out = My_Imresize_BL(Input_Image, Resizing_Factor)
  [rows, collumns, ~] = size(Input_Image);
    out = zeros(rows*Resizing_Factor, collumns*Resizing_Factor);
    for i = 1: size(out, 1)
        for j = 1: size(out, 2)
           x = i/Resizing_Factor - floor(i/Resizing_Factor);
           y = j/Resizing_Factor - floor(j/Resizing_Factor);
           
           i_temp = ceil(i/Resizing_Factor);
           j_temp = ceil(j/Resizing_Factor);

           if(i_temp == 1 && j_temp == 1)
               a = Input_Image(1, 1);
           elseif(i_temp == 1)
               a = Input_Image(1, j_temp-1);
           elseif(j_temp==1)
               a = Input_Image(i_temp,1);
           elseif(i_temp ~= 1 && j_temp ~=1)
               a = Input_Image(i_temp-1, j_temp-1);
           end
           if(i_temp == 1)
               b = Input_Image(1, j_temp);
           else
               b = Input_Image(i_temp-1, j_temp);
           end
           if(j_temp == 1)
               c = Input_Image(i_temp, 1);
           else
               c = Input_Image(i_temp, j_temp-1);
           end
           d = Input_Image(i_temp, j_temp);

           e = a*(1-x)*(1-y)+b*x*(1-y)+c*(1-x)*y+d*x*y;
           out(i, j) = e;
        end
    end
end