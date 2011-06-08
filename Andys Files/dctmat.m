function C = dctmat(N)

% function C = dctmat(N)
% Generate the 1-D DCT transform matrix of size N, such that
%   y = C * x   transforms N-vector x into y.

C = ones(N,N) / sqrt(N);
theta = ([1:N] - 0.5) * (pi/N);
g = sqrt(2/N);
for i=2:N,
  C(i,:) = g * cos((i-1) * theta);
end
return
