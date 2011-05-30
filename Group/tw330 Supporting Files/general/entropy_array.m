function entropy_array(Xe,stp)

[m,n] = size(Xe);

min_bits = m * n * entropy(Xe,stp)

entr_per_bit = entropy(Xe,stp)


end