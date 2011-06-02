function Z = DWCT8(X,stepDWT,stepDCT,cut_start_row)

% DWT stuff
%stepDWT = 3.5;
riseDWT = 2*stepDWT;

% DCT stuff
%stepDCT = 7;
riseDCT = 1*stepDCT;
N = 8;
%cut_start_row = 4;

% DWT stuff
%steps = DWT_steps(1,k)*delta;
%riseDWT = steps*2;

% perform a single level DWT
Y = DWT_iter(X,1);

% form transform matrix
C = dctmat(N);

% apply transform
Y(1:128,1:128) = colxfm(colxfm(Y(1:128,1:128),C)',C)';

% quantise each section with different step sizes
Yq = quantise(Y,stepDWT,riseDWT);
Yq(1:128,1:128) = quantise(Y(1:128,1:128),stepDCT,riseDCT);

% suppress bottom right DWT component
Yq(129:256,129:256) = 0;

%suppress some components of the DCT
[m,p] = size(Yq(1:128,1:128));
M = m/N;
P = p/N;

for k = 1 : P,
    for l = 1 : M,
        for i = cut_start_row : N,
           for j = (N-i+cut_start_row) : N,
            Yq(i + (k-1)*N,j + (l-1)*N) = 0;
           end
        end
    end
end

%Yq(1:128,1:128) = regroup(Yq(1:128,1:128)/N,N); draw(Yq(1:128,1:128));


% decode the DCT part
Z = Yq;
Z(1:128,1:128) = colxfm(colxfm(Z(1:128,1:128)',C')',C');

% decode the DWT part
Z = IDWT_iter(Z, 1);

% calculate compression ratio and errors
% DCT bit
total_bits = 0;
Yr = regroup(Yq(1:128,1:128),N);
mean_ent = 0;
[H W] = size(Yr);
H = H/N;
W = W/N;

for i = 1:N
   for j = 1:N
       sub_y = Yr((H*(i-1) + 1):(H*i),(W*(j-1) + 1):(W*j));
       mean_ent = mean_ent + entropy2(sub_y,stepDCT,riseDCT);
   end
end
mean_ent = mean_ent / N / N;
total_bits = total_bits + mean_ent*H*N*W*N;


% DWT bit
total_bits = total_bits + 128*128*entropy2(Yq(1:128,129:256),stepDWT,riseDWT);

total_bits = total_bits + 128*128*entropy2(Yq(129:256,1:128),stepDWT,riseDWT);


% display bits required and compression ratio
total_bits
compression_ratio = 2.2812e5 / total_bits

% display rms error
error = std(X(:) - Z(:))

% draw the reconstructed image
draw(Z);
end