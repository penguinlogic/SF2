function [Yq ent bits] = DWT_quant1(Y,levels,step,rise)

m = 256;
Yq = Y;
bits = 0;

for i = 1:levels
    m = m/2; 
    t = 1:m;
    
    Yq(t,m+t) = quant1(Yq(t,m+t),step(i),rise(i));            % top right
    ent(1,i) = entropy2(Yq(t,m+t),step(i),rise(i));
    
    Yq(m+t,t) = quant1(Yq(m+t,t),step(i),rise(i));            % bottom left
    ent(2,i) = entropy2(Yq(m+t,t),step(i),rise(i));
    
    Yq(m+t,m+t) = quant1(Yq(m+t,m+t),step(i),rise(i));        % bottom right
    ent(3,i) = entropy2(Yq(m+t,m+t),step(i),rise(i));
    
    bits = bits + m*m*(ent(1,i)+ent(2,i)+ent(3,i));
end

t = 1:m;
Yq(t,t) = quant1(Yq(t,t),step(levels+1),rise(levels+1));             % low pass bit
ent(1,levels+1) = entropy2(Yq(t,t),step(levels+1),rise(levels+1));

bits = bits + m*m*(ent(1,levels+1));

