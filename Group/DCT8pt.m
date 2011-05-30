function Z = DCT8pt(X)

% set transform size and quantisation step size
N = 8;
stp = 23;
rise = 1*stp;

% form transform matrix
C = dctmat(N);

% apply transform
Y = colxfm(colxfm(X,C)',C)';

%quantise 
Yq = quantise(Y,stp,rise);

[m,p] = size(Yq);
M = m/N;
P = p/N;


% uncomment for removing some sub-images from DCT
%for k = 1 : P,
%    for l = 1 : M,
%        for i = 1 : N,
%           for j = (N-i+1) : N,
%            Yq(i + (k-1)*N,j + (l-1)*N) = 0;
%           end
%        end
%    end
%end



% reconstruct the image to return
Z = colxfm(colxfm(Yq',C')',C');

% uncomment to output info about entropy, bit rates and CR
DCTentropy(Yq,N,stp,rise);

% uncomment to give some info about rms error
err = std(Z(:)-X(:))

end