function Y = convse(X, h)

% function Y = convse(X, h)
% Filter the rows of image X using h, with symmetric extension of X.
% Nick Kingsbury, Nov 94.

[r,c] = size(X);
m = length(h);
m2 = fix((m)/2);

if rem(m,2) > 0,
  xe = [((m2+1):-1:2)  (1:c)  (c-(1:m2))];
else
  xe = [(m2:-1:1) (1:c) (c+1-(1:m2))];
end
t = 0:(c-1);

Y = zeros(r,length(t));
% Loop for each term in h.
for i=1:m,
  Y = Y + h(i) * X(:,xe(t+i));
end

return