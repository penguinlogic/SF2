function [Yq, entropy_array, total_bits] = DWTgrpenc(X,levels,steps,rise)

% perform the iterative DWT
Y = DWT_iter(X,levels);

%Y(9:16,9:16) = 0;
%Y(17:32,17:32) = 0;
%Y(33:64,33:64) = 0;
%Y(65:128,65:128) = 0;
%Y(129:256,129:256) = 0;
%draw(Y);

% quantise the image (Yq) and get entropy and bit rate information
[Yq , entropy_array, total_bits] = DWT_quant1(Y,levels,steps,rise);
[Yq , entropy_array, total_bits] = DWT_quant2(Yq,levels,steps,rise);

%[Yq , entropy_array, total_bits] = DWT_quantise(Y,levels,steps,rise);