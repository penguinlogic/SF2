function Z = DCT32ptdec(Yq,N)

% form transform matrix
C = dctmat(N);

% reconstruct the image to return
Z = colxfm(colxfm(Yq',C')',C');