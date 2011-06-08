function steps = DWT_steps(layers,k)

for i = 1:layers
   steps(i) = (k^(i-1)) / DWT_impulse(i); 
end

steps(layers+1) = (k^layers) / DWT_impulse_lowpass(layers);

steps = steps / steps(1);

end