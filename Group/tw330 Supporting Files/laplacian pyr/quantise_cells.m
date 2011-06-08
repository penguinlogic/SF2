function Xq = quantise_cells(Xe,stps)

[N1,N2] = size(Xe);
sz = size(stps);


if (sz(2) > 1)
    for i = 1:N2
        Xq{i} = quantise(Xe{i},stps(i));
    end
end
if (sz(2) == 1)
    for i = 1:N2
        Xq{i} = quantise(Xe{i},stps);
    end 
end


end