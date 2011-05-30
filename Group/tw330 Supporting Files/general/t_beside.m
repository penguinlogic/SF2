function y=t_beside(Xe)

% function y=beside(x1,x2)
% Put x1 beside x2, padding with zeros, and separating with a blank column.

[M1,N2] = size(Xe);

for i = 1:N2
   [m(i),n(i)] = size(Xe{i}); 
end

M = max(m);

y = zeros(M,sum(n) + N2 - 1);

for i = 1:N2
    %y((M-m(i))/2+[1:m(i)],[1:n(i)])=Xe{i};
    y((M-m(i))/2+[1:m(i)], (i - 1) + sum(n(1:(i-1))) + [1:n(i)])=Xe{i};
end

return
