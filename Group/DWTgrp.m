function Z = DWTgrp(X,levels)

% set the parameters
k = 0.8; delta = 4.5;

% form the equal MSE step sizes
steps = DWT_steps(levels,k)*delta;

% set first rise for quantisation
rise = steps*2;

% encode X
[Yq, entropy_array, total_bits] = DWTgrpenc(X,levels,steps,rise);

% decode Yq
Z = DWTgrpdec(Yq,levels);

% uncomment to output entropy and bit rate information
%%total_bits
%%entropy_array
%%avg_entropy = total_bits / 256 / 256
compression_ratio = 2.2812e5 / total_bits

% uncomment to output rms error
error = std(X(:) - Z(:))

end