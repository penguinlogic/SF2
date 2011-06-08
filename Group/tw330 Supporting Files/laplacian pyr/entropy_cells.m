function entropy_cells(Xe,stp)

[N1,N2] = size(Xe);
pix = 0;
min_bits = 0;

sz = size(stp);


if (sz(2) > 1)
    for i = 1:N2
        [m(i),n(i)] = size(Xe{i});
        pix = pix + m(i)*n(i);
        min_bits = min_bits + m(i) * n(i) * entropy(Xe{i},stp(i));
    end
end
if (sz(2) == 1)
    for i = 1:N2
        [m(i),n(i)] = size(Xe{i});
        pix = pix + m(i)*n(i);
        min_bits = min_bits + m(i) * n(i) * entropy(Xe{i},stp);
    end
end


min_bits
%entr_per_bit = min_bits / pix
%entr_per_original_bit = min_bits / (n(1)*m(1))


end