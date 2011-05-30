function [X4q, Y0q, Y1q, Y2q, Y3q] = quantisemany(delta, k, X4, Y0, Y1, Y2, Y3)

%X1q = quantise(X1, delta);
%X2q = quantise(X2, delta);
%X3q = quantise(X3, delta);
Y0q = quantise(Y0, delta);
Y1q = quantise(Y1, k*delta*0.914);
Y2q = quantise(Y2, (k^2)*delta*0.507);
Y3q = quantise(Y3, (k^3)*delta*0.259);
X4q = quantise(X4, (k^4)*delta*0.131);