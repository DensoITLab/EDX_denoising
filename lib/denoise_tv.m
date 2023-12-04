function W = denoise_tv(W_tilde,mu_tv_tilde)

fy = [1;-1];
otfFy = psf2otf(fy,size(W_tilde));

denominator = 1+mu_tv_tilde*(abs(otfFy).^4);

numerator = fft2(W_tilde);
W = real(ifft2(numerator./denominator));

end

