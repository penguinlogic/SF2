function std_yd = DWT_impulse_lowpass(level)

m = 256/(2^(level+1));

Y = zeros(256,256);
Y(m,m) = 100;

%std_y = std(Y(:))

Yd = IDWT_iter(Y,level);

%draw(Yd);

std_yd = sqrt(3) * std(Yd(:));

end