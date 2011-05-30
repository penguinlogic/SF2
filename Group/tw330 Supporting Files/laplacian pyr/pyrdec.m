function Xs = pyrdec(Xe,h)
% Form original from laplacian pyramid

[N1,N2] = size(Xe);

Xlow{N2} = Xe{N2};
for i = (N2-1):-1:1
    Xlow{i} = Xe{i} + rcint(Xlow{i+1},h);
end


Xs = Xlow{1};

end