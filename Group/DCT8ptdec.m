function Z = DCT8ptdec(Xe,N)

% form transform matrix
C = dctmat(N);

% reconstruct the image to return
Z = colxfm(colxfm(Xe',C')',C');