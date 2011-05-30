function err = DCTerror(X,N,stp,rise)

C = dctmat(N);
Y = colxfm(colxfm(X,C)',C)';
Yq = quantise(Y,stp,rise);
%Yr = regroup(Yq,N)/N;

%[H W] = size(X);

Z = colxfm(colxfm(Yq',C')',C');

err = std(Z(:)-X(:));

end