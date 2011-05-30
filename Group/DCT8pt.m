function Z = DCT8pt(X)

% set transform size and quantisation step size
N = 8;
stp = 16;
rise = 1*stp;

% form transform matrix
C = dctmat(N);

% apply transform
Y = colxfm(colxfm(X,C)',C)';

%quantise 
Yq = quantise(Y,stp,rise);

% reconstruct the image to return
Z = colxfm(colxfm(Yq',C')',C');

% uncomment to output info about entropy, bit rates and CR
DCTentropy(X,N,stp,rise);

% uncomment to give some info about rms error
error = DCTerror(X,N,stp,rise)

end