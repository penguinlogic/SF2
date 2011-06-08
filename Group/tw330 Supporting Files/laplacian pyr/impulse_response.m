function sqrt_energy = impulse_response(layer,h)

Xi = zeros(256,256);


if layer==1
    Xi(128,128) = 100;
else
    Xj = pyrenc(Xi,h,layer);

    [m,n] = size(Xj{layer});

    Xj{layer}(m/2,n/2) = 100;

    Xi = pyrdec(Xj,h);
end

sqrt_energy = std(Xi(:));

end