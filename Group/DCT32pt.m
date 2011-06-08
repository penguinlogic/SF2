function Z = DCT32pt(X)

% set transform size and quantisation step size
N = 32;
stp = 9;
rise = stp*1.5;

% encode X
Yq = DCT32ptenc(X,N,stp,rise);

% decode Yq
Z = DCT32ptdec(Yq,N);

% uncomment to output info about entropy and bit rates
ent = DCTentropy(Yq,N,stp,rise);

% uncomment to give some info about rms error
err = std(Z(:)-X(:))

end