function J = MY_imadjust(I, adjust_param)
    K = imhist(I);
    
    sum_begin = 0;
    for i = 1 : size(K, 1)
        sum_begin = sum_begin + K(i);
        if(sum_begin >= round(numel(I) * adjust_param))
            break;
        end
    end

    sum_end = 0;
    for j = 256 : -1 : 1
        sum_end = sum_end + K(j);
        if(sum_end >= round(numel(I) * adjust_param))
            break;
        end
    end

    J = zeros(size(I, 1), size(I, 2),'double');

    for m = 1 : size(I, 1)
        for n = 1 : size(I, 2)
            if(I(m, n) <= i)
                J(m, n) = 0;
            elseif(I(m, n) >= j)
                J(m, n) = 255;
            else
                J(m, n) = ceil(255/(j - i)*(I(m, n) - i));
            end
        end
    end

    K = imadjust(I);

    imshow([I J K]);
end