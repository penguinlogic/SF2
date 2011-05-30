function Y = rowdec(X, h)

% function Y = rowdec(X, h)
% Filter the rows of image X using h, and decimate them by 2.
% If length(h) is odd, each output sample is aligned with the first of
% each pair of input samples.
% If length(h) is even, each output sample is aligned with the mid point
% of each pair of input samples.

[r,c] = size(X);
m = length(h);
m2 = fix(m/2);

if rem(m,2) > 0,
% Odd h: symmetrically extend indices without repeating end samples.
  xe = [(m2+1:-1:2)  (1:c)  (c-(1:m2))];
else
% Even h: symmetrically extend with repeat of end samples.
  xe = [(m2-1:-1:1)  (1:c)  (c+1-(1:m2-1))];
end  

t = 0:2:(c-1);

Y = zeros(r,length(t));
% Loop for each term in h.
for i=1:m,
  Y = Y + h(i) * X(:,xe(t+i));
end

return