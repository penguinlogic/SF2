function Z = IDWT_iter(Yq,levels)

m = 256 / (2^(levels-1));
Z = Yq;

for i = 1:levels
    t = 1:m;
    Z(t,t) = idwt(Z(t,t));
    m = m*2;
end

end