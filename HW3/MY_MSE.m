function out = MY_MSE(I, J)
    out = sum(sum((I-J).^2))/(numel(I));
end