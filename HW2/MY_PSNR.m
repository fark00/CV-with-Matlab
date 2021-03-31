function out = MY_PSNR(I, J)
    out = 10 * log10(1/MY_MSE(I,J));
end