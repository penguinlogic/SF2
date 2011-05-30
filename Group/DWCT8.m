function Z = DWCT8(X)

% set the parameters
k = 0.8; delta = 4.5;
N = 4;

% DCT stuff
stepDCT = 13;
riseDCT = 1*stepDCT;

% DWT stuff
%steps = DWT_steps(1,k)*delta;
%riseDWT = steps*2;

% perform the iterative DWT
Y = DWT_iter(X,1);


% form transform matrix
C = dctmat(N);

% apply transform
Y(1:128,1:128) = colxfm(colxfm(Y(1:128,1:128),C)',C)';

Yq = quantise(Y,stepDCT,riseDCT);

Yq(1:128,1:128) = colxfm(colxfm(Yq(1:128,1:128)',C')',C');

Z = IDWT_iter(Yq, 1);


% uncomment to output entropy and bit rate information
%compression_ratio = 2.2812e5 / total_bits

% uncomment to output rms error
%error = std(X(:) - Z(:))

end