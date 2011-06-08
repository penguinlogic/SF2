function Yq = DCT32ptenc(X,N,stp,rise)

% form transform matrix
C = dctmat(N);

% apply transform
Y = colxfm(colxfm(X,C)',C)';

%quantise 
Yq = quantise(Y,stp,rise);
