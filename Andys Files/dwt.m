function Y = dwt(X,h1,h2)

% function Y = dwt(X,h1,h2)
% 1-level 2-D discrete wavelet transform on X.
% If filters h1,h2 are given, then they are used,
% otherwise the LeGall filter pair are used.

if nargin < 3,
  h1=[-1 2 6 2 -1]/8;
  h2=[-1 2 -1]/4;
end

[m,n] = size(X);
Y = zeros(m,n);

n2 = n/2;
t = 1:n2;
Y(:,t) = rowdec(X,h1);
Y(:,t+n2) = rowdec2(X,h2);
X = Y';
m2 = m/2;
t = 1:m2;
Y(t,:) = rowdec(X,h1)';
Y(t+m2,:) = rowdec2(X,h2)';

