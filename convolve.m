function convolve(h,X,N);

for n = 1 : 1 : N,
    Xf(n,:) = conv(h,X(n,:));
end

return