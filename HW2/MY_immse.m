function out = MY_immse(I, J)
    out = sum(sum(MY_MSE(I, J)));
end