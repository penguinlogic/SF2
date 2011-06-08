function Xe = pyrenc(X,h,N)
% Form cell array for laplacian pyramid

Xlow{1} = rcdec(X,h);
for i = 2:N
    Xlow{i} = rcdec(Xlow{i-1},h);
end

Xhigh{1} = X - rcint(Xlow{1},h);
for j = 2:N
    Xhigh{j} = Xlow{j-1} - rcint(Xlow{j},h);
end


Xe = Xhigh;
Xe{N} = Xlow{N-1};



end