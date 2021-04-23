function J = MY_negative(I)

    [a, b, c] = size(I);
    
    if(c == 1)
        J = 255 - I;
        imshow(J);
    else
        J(:,:,1) = 255 - I(:,:,1);
        J(:,:,2) = 255 - I(:,:,2);
        J(:,:,3) = 255 - I(:,:,3);
        imshow(J);
    end
end