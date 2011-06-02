function Z = DCT8pt(X)

% set transform size and quantisation step size
N = 8;
stp = 16;
rise = 1*stp;

% encode X
Xe = DCT8ptenc(X,N,stp,rise);

% decode X
Z = DCT8ptdec(Xe,N);

% uncomment to output info about entropy, bit rates and CR
DCTentropy(X,N,stp,rise);

% uncomment to give some info about rms error
error = DCTerror(X,N,stp,rise)

end