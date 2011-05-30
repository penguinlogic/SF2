function Z = DWTgrp(X)

% set the parameters
layers = 5; k = 0.8; delta = 12;

% 
steps = DWT_steps(layers,k)*delta;

Y = DWT_iter(X,levels);
[Yq entropy_array total_bits] = DWT_quantise(Y,levels,steps);
Z = IDWT_iter(Yq, levels);




%%total_bits
%%entropy_array
%%avg_entropy = total_bits / 256 / 256

%%error = std(X(:) - Z(:))


end