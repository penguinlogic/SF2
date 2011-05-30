function Z = DWT_full(X,levels,steps)

Y = DWT_iter(X,levels);
[Yq entropy_array total_bits] = DWT_quantise(Y,levels,steps);
Z = IDWT_iter(Yq, levels);

draw(Z)

total_bits
entropy_array
avg_entropy = total_bits / 256 / 256

error = std(X(:) - Z(:))


end