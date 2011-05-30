function Z = DCT32pt(X)

% set transform size and quantisation step size
N = 32;
stp = 24;

% form transform matrix
C = dctmat(N);

% apply transform
Y = colxfm(colxfm(X,C)',C)';

%quantise 
Yq = quantise(Y,stp,0.5*stp);

% reconstruct the image to return
Z = colxfm(colxfm(Yq',C')',C');

% uncomment to output info about entropy and bit rates
%%ent = DCTentropy(X,N,stp)

% uncomment to give some info about rms error
%%error = DCTerror(X,N,stp)

end