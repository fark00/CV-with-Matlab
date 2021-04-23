function summation = MY_TemplateMatching(I)
    a = 0;
    a = a + sum(sum(I(1:80, 670:750,1)));
    a = a + sum(sum(I(1:80, 670:750,2)));
    a = a + sum(sum(I(1:80, 670:750,3)));

    if(a > 3660000)
        threshold = 0.85;
    else
        threshold = 0.78;
    end
    
    I(:,:,1) = medfilt2(I(:,:,1));
    I(:,:,2) = medfilt2(I(:,:,2));
    I(:,:,3) = medfilt2(I(:,:,3));
    
    I(:,:,1) = medfilt2(I(:,:,1));
    I(:,:,2) = medfilt2(I(:,:,2));
    I(:,:,3) = medfilt2(I(:,:,3));
    
    rgbImage = I;
    

    summation = 0;
    for x = 1 : 1 : 9
        for y = 1 : 1 : 4
            for z = 0 : 1 : 1
                str = "temp/" + x + "_" + y + "_" + z + ".png";
                J = imread(str);
                smallSubImage = J;
                templateHeight = size(J, 1);
                templateWidth = size(J, 2);
                flag = 1;
                while(flag == 1)
                    if(z == 1)
                        channelToCorrelate = 1;  
                    else
                        channelToCorrelate = 3;
                    end
                    try
                        correlationOutput = normxcorr2(smallSubImage(:,:,channelToCorrelate), rgbImage(:,:, channelToCorrelate));
                    catch
                        correlationOutput = 0;
                    end
                    if(correlationOutput == 0)
                        flag = 0;
                        continue;
                    end
                    [maxCorrValue, maxIndex] = max(abs(correlationOutput(:)));
                    if(maxCorrValue < threshold)
                        flag = 0;
                        continue;
                    end
                    [yPeak, xPeak] = ind2sub(size(correlationOutput),maxIndex(1));
                    corr_offset = [(xPeak-size(smallSubImage,2)) (yPeak-size(smallSubImage,1))];
                    rgbImage(corr_offset(2):corr_offset(2) + templateHeight, corr_offset(1):corr_offset(1) + templateWidth, 1) = 255;
                    rgbImage(corr_offset(2):corr_offset(2) + templateHeight, corr_offset(1):corr_offset(1) + templateWidth, 2) = 255;
                    rgbImage(corr_offset(2):corr_offset(2) + templateHeight, corr_offset(1):corr_offset(1) + templateWidth, 3) = 255;
                    if(z == 0)
                        coe = 1;
                    else
                        coe = -1;
                    end
                    summation = summation + coe * x;
                end
            end
        end
    end
end