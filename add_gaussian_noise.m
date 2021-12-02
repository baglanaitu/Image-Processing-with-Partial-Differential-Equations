function out = add_gaussian_noise(I,s)
%Add Gaussian noise of standard deviation s to an image I
[m,n]=size(I);
%creation and addition of gaussian noise
out=I+s*randn(m,n);
end

