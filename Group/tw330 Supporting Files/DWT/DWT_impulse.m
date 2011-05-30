function std_yd = DWT_impulse(level)

m = 256/(2^(level+1));

Y = zeros(256,256);
Y(3*m,m) = 100;
Y(3*m,3*m) = 100;
Y(m,3*m) = 100;


Yd = IDWT_iter(Y,level);


contourf(Yd,10)



std_yd = std(Yd(:));

end