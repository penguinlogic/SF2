function Z = DCTfull(X,N,stp)

C = dctmat(N);
Y = colxfm(colxfm(X,C)',C)';
Yq = quantise(Y,stp);
Z = colxfm(colxfm(Yq',C')',C');

ent = DCTentropy(X,N,stp);

error = DCTerror(X,N,stp)

end