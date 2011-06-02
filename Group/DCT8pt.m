function Z = DCT8pt(X)

% set transform size and quantisation step size
N = 8;
stp = 23;
rise = 1*stp;

% encode X
Yq = DCT8ptenc(X,N,stp,rise);


% decode X
Z = DCT8ptdec(Yq,N);

% uncomment to output info about entropy, bit rates and CR
DCTentropy(Yq,N,stp,rise);

% uncomment to give some info about rms error
err = std(Z(:)-X(:))

end
