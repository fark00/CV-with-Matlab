function J = MY_Imresize_DCCI(I)

    I = I(:, :, 1);
    J = zeros(size(I,1)*2, size(I,2)*2);

    % Copy the original pixels to the output image, with gaps between the pixels.
    for i = 1: size(J, 1)-1
        for j = 1: size(J, 2)-1
            if(mod(i, 2) == 1 && mod(j, 2) == 1)
                J(i, j) = I(ceil(i/2), ceil(j/2));
            end
        end
    end

    % figure,imshow(J,[])
    % Calculate the pixels for the diagonal gaps.
    for i=1: size(J,1)
        for j=1: size(J,2)
            if(mod(i, 2) == 0 && mod(j, 2) == 0 && i>2 && j>2 && i < size(J,1)-2 && j < size(J,2)-2)
                m = (i/2)-1;
                n = (j/2)-1;
                % d1: the sum of edges in the up-right direction.
                d1 = 0;
                for x = ((i/2)-1)+1: ((i/2)-1)+3    %x = 1: 3
                    for y = (j/2)-1: ((j/2)-1)+2    %y = 0: 2
                        d1 = d1 + abs(I(x, y) - I(x - 1, y + 1));
                    end
                end

                % d2: the sum of edges in the down-right direction.
                d2 = 0;
                for x = (i/2)-1: ((i/2)-1)+2    %x = 0: 2
                    for y = (j/2)-1: ((j/2)-1)+2    %y = 0: 2
                        d2 = d2 + abs(I(x, y) - I(x + 1, y + 1));
                    end
                end
                if(100*(1+d1)>115*(1+d2))
                    % there is an edge in the up-right direction.
                    out = (-1 * I(m, n) + 9 * I(m+1, n+1) + 9 * I(m+2, n+2) - 1 * I(m+3, n+3))/16;
                elseif(100*(1+d2)>115*(1+d1))
                    % there is an edge in the down-right direction.
                    out = (-1 * I(m+3, n) + 9 * I(m+2, n+1) + 9 * I(m+1, n+2) - 1 * I(m, n+3))/16;
                else
                    % there is in a smooth area.
                    w1 = 1/(1 + d1^5);
                    w2 = 1/(1 + d2^5);
                    weight1 = w1 / (w1 + w2);
                    weight2 = w2 / (w1 + w2);
                    DownRightPixel = (-1 * I(m, n) + 9 * I(m+1, n+1) + 9 * I(m+2, n+2) - 1 * I(m+3, n+3))/16;
                    UpRightPixel = (-1 * I(m+3, n) + 9 * I(m+2, n+1) + 9 * I(m+1, n+2) - 1 * I(m, n+3))/16;
                    out = DownRightPixel * weight1 + UpRightPixel*weight2;
                end
                J(i,j)=out;
            end

        end
    end
    % figure,imshow(J,[])

    % Calculating horizontal/vertical edge strength
    for i=1: size(J,1)
        for j=1: size(J,2)
            if(((mod(i, 2) == 0 && mod(j, 2) == 1) || (mod(i, 2) == 1 && mod(j, 2) == 0)) && i>3 && j>3 && i < size(J,1)-2 && j < size(J,2)-2)

                % d1: the sum of edges in the horizontal direction.
                d1 = abs(J(i+1,j-2)-J(i-1,j-2))+abs(J(i+2,j-1)-J(i,j-1))+abs(J(i,j-1)-J(i-2,j-1))+abs(J(i+3,j)-J(i+1,j))+abs(J(i+1,j)-J(i-1,j))+abs(J(i-1,j)-J(i-3,j))+abs(J(i+2,j+1)-J(i,j+1))+abs(J(i,j+1)-J(i-2,j+1))+abs(J(i+1,j+2)-J(i-1,j+2));

                % d2: the sum of edges in the vertical direction.
                d2 = abs(J(i-2, j+1)-J(i-2,j-1))+abs(J(i-1,j+2)-J(i-1,j))+abs(J(i-1,j)-J(i-1,j-2))+abs(J(i,j+3)-J(i,j+1))+abs(J(i,j+1)-J(i,j-1))+abs(J(i,j-1)-J(i,j-3))+abs(J(i+1,j+2)-J(i+1,j))+abs(J(i+1,j)-J(i+1,j-2))+abs(J(i+2,y+1)-J(i+2,j-1));

                if(100*(1+d1)>115*(1+d2))
                    % one has an edge in the horizontal direction
                    out = (-1*J(i,j-3)+9*J(i,j-1)+9*J(i,j+1)-1*J(i,j+3))/16;
                elseif(100*(1+d2)>115*(1+d1))
                    % one has an edge in the vertical direction
                    out = (-1*J(i-3,j)+9*J(i-1,j)+9*J(i+1,j)-1*J(i+3,j))/16;
                else
                    % there is in a smooth area.
                    w1 = 1/(1 + d1^5);
                    w2 = 1/(1 + d2^5);
                    weight1 = w1 / (w1 + w2);
                    weight2 = w2 / (w1 + w2);
                    HorizontalPixel = (-1*J(i-3,j)+9*J(i-1,j)+9*J(i+1,j)-1*J(i+3,j))/16;
                    VerticalPixel = (-1*J(i,j-3)+9*J(i,j-1)+9*J(i,j+1)-1*J(i,j+3))/16;
                    out = VerticalPixel*weight1 + HorizontalPixel*weight2;
                end
                J(i,j)=out;
            end

        end
    end

    % Calculate Boundaries
    j = 1;
    for i = 2:2: size(J,1)-1
        J(i, j)= J(i-1,j)/2 + J(i+1,j)/2;
    end
    i = 1;
    for j = 2:2: size(J,2)-1
        J(i, j)= J(i,j-1)/2 + J(i,j+1)/2;
    end
    j = 3;
    for i = 6:2: size(J,1)-2
        J(i, j)= J(i-1,j)/3 + J(i+1,j)/3 + J(i,j+1)/3;
    end
    for i = 5:1:size(J,1)-1
        J(i,2) = J(i,3)/2+J(i,1)/2;
    end
    i=3;
    for j=2:2:size(J,2)-2
        J(i,j) = J(i,j-1)/2 + J(i,j+1)/2;
    end
    i=2;
    for j=1:1:size(J,1)-2
        J(i,j) = J(i-1,j)/2 + J(i+1,j)/2;
    end
    j=size(J,2)-1;
    for i=2:2:size(J,1)-2
        J(i,j) = J(i-1,j)/2+J(i+1,j)/2;
    end
    j = size(J,2)-2;
    for i =4:size(J,1)-3
        J(i,j) = J(i,j-1)/2+J(i,j+1)/2;
    end
    i = size(J,1)-1;
    for j=4:2:size(J,2)-2
        J(i,j) = J(i,j-1)/2+J(i,j+1)/2;
    end
    i = size(J,1)-2;
    for j=4:size(J,2)-2
        J(i,j) = J(i+1,j)/2+J(i-1,j)/2;
    end
    j=size(J,2);
    for i=1:size(J,1)-1
        J(i,j) = J(i,j-1);
    end
    i=size(J,1);
    for j=1:size(J,2)
        J(i,j) = J(i-1,j);
    end
    J(4,3)=J(3,3)/3+J(5,3)/3+J(4,4)/3;
    J(4,2)=J(4,1)/4+J(3,2)/4+J(4,3)/4+J(5,2)/4;

end
