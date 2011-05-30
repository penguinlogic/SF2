function Y = DWT_iter(X,levels)

m = 256;
Y = dwt(X);

for i = 2:levels
    m = m/2;
    t = 1:m;
    Y(t,t) = dwt(Y(t,t));
end

end