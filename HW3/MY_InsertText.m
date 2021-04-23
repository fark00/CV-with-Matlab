function I = MY_InsertText(I, num)
    flag = 0;
    if(num < 0)
        flag = 1;
        num = num * -1;
    end
    Div = floor(num/10);
    Rem = rem(num, 10);
    
    i = 762;
    j = 70;
    
    while(Div ~= 0)
        number = imresize(imread("numbers/" + Rem + ".png"), 1.5, 'bilinear');
        for m = 1 : size(number, 1)
            for n = 1 : size(number, 2)
                I(i + m, j + n, 1) = number(m, n, 1);
                I(i + m, j + n, 2) = number(m, n, 2);
                I(i + m, j + n, 3) = number(m, n, 3);
            end
        end
        
        
        
        num = Div;
        Div = floor(num/10);
        Rem = rem(num, 10);
    
    end
    
    number = imresize(imread("numbers/" + Rem + ".png"), 1.5, 'bilinear');
    i = 762;
    j = j - size(number, 2) - 5;
    for m = 1 : size(number, 1)
        for n = 1 : size(number, 2)
            I(i + m, j + n, 1) = number(m, n, 1);
            I(i + m, j + n, 2) = number(m, n, 2);
            I(i + m, j + n, 3) = number(m, n, 3);
        end
    end
    
    i = 775;
    j = j - 20;
        
    if (flag == 1)
        sign = imresize(imread("numbers/sign.png"), 1.5, 'bilinear');
        for m = 1 : size(sign, 1)
            for n = 1 : size(sign, 2)
                I(i + m, j + n, 1) = sign(m, n, 1);
                I(i + m, j + n, 2) = sign(m, n, 2);
                I(i + m, j + n, 3) = sign(m, n, 3);
            end
        end
    end
end