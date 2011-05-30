function err = DCTerror(X,N,stp)

C = dctmat(N);
Y = colxfm(colxfm(X,C)',C)';
Yq = quantise(Y,stp);
Yr = regroup(Yq,N)/N;

[H W] = size(X);

Z = colxfm(colxfm(Yq',C')',C');

err = std(Z(:)-X(:));

end