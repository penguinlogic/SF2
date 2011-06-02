function Z = DWTgrp(X,levels)

% set the parameters
k = 0.8; delta = 4.5;

% form the equal MSE step sizes
steps = DWT_steps(levels,k)*delta;

% set first rise for quantisation
rise = steps*2;

% perform the iterative DWT
Y = DWT_iter(X,levels);

%Y(9:16,9:16) = 0;
%Y(17:32,17:32) = 0;
%Y(33:64,33:64) = 0;
%Y(65:128,65:128) = 0;
%Y(129:256,129:256) = 0;
%draw(Y);

% quantise the image (Yq) and get entropy and bit rate information
[Yq entropy_array total_bits] = DWT_quantise(Y,levels,steps,rise);

% reform the image to return
Z = IDWT_iter(Yq, levels);



% uncomment to output entropy and bit rate information
%%total_bits
%%entropy_array
%%avg_entropy = total_bits / 256 / 256
compression_ratio = 2.2812e5 / total_bits

% uncomment to output rms error
error = std(X(:) - Z(:))

end