function [Xf] = filter_rows(X,h)

N = size(X);

for i = 1:N(1)
    Xf(i,:) = convse(X(i,:),h);
end
    

end
