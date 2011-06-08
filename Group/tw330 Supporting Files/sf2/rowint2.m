function Y = rowint2(X, h)

% function Y = rowint2(X, h)
% Interpolate the rows of image X by 2, using filter h.
% If length(h) is odd, each input sample is aligned with the second of
% each pair of output samples.
% If length(h) is even, each input sample is aligned with the mid point
% of each pair of output samples.

[r,c] = size(X);
m = length(h);
m2 = fix(m/2);
c2 = 2 * c;

if rem(m,2) > 0,
  xe = [((m2+1):-1:2)  (1:c2)  (c2-(1:m2))];
else
  xe = [(m2:-1:2)  (1:c2)  c2-1  (c2+2-(2:m2))];
end  
t = 0:(c2-1);

% Generate X2 as X interleaved with columns of zeros.
X2 = zeros(r,c2);
X2(:,2:2:c2) = X;

Y = zeros(r,2*c);
% Loop for each term in h.
for i=1:m,
  Y = Y + h(i) * X2(:,xe(t+i));
end

return