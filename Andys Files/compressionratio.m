function r = compressionratio(delta, k, levels, X, Y0, Y1, Y2, Y3, Xn)

Y1bits = 0;
Y2bits = 0;
Y3bits = 0;

Xbits = entropy(X, 17)*256^2;
Xnbits = entropy(Xn, (k^4)*delta*0.131)*(16*(2^(4-levels)))^2;
Y0bits = entropy(Y0, delta)*256^2;
if levels > 1
    Y1bits = entropy(Y1, k*delta*0.914)*128^2;
    if levels > 2
        Y2bits = entropy(Y2, (k^2)*delta*0.507)*64^2;
        if levels > 3
            Y3bits = entropy(Y3, (k^3)*delta*0.259)*32^2;
        end
    end
end



r = Xbits/(Y0bits+Y1bits+Y2bits+Y3bits+Xnbits);
