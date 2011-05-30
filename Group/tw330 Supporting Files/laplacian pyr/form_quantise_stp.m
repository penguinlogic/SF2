function steps = form_quantise_stp(layers,h,k)
% unfinished

for i = 1:layers
   steps(i) = (k^(i-1)) / impulse_response(i,h); 
end

steps = steps / steps(1);

end