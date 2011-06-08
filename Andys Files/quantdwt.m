function [Yq, ent, bitrate] = quantdwt (numlevels, stp, Y)

[~, n] = size(stp);
[o, p] = size(Y);

ent = zeros(3, (numlevels + 1));

if numlevels == n - 1,
    t = 1 : (o/(2^numlevels));
    ent(1,numlevels + 1) = entropy(Y(t,t), stp(numlevels + 1));
    bitrate = ent(1,numlevels + 1)*(o/(2^numlevels))^2;
    Yq(t,t) = quantise(Y(t,t), stp(numlevels + 1));
    
    for i = numlevels : -1 : 1,
        t = 1 : (o/(2^i));
        
        ent(1, i) = entropy(Y(t,(t + o/(2^i))), stp(i));
        bitrate = bitrate + ent(1, i)*(o/(2^i))^2;
        Yq(t,(t + o/(2^i))) = quantise(Y(t,(t + o/(2^i))), stp(i));
        
        ent(2, i) = entropy(Y((t + o/(2^i)),t), stp(i));
        bitrate = bitrate + ent(2, i)*(o/(2^i))^2;
        Yq((t + o/(2^i)),t) = quantise(Y((t + o/(2^i)),t), stp(i));
        
        ent(3, i) = entropy(Y((t + o/(2^i)),(t + o/(2^i))), stp(i));
        bitrate = bitrate + ent(3, i)*(o/(2^i))^2;
        Yq((t + o/(2^i)),(t + o/(2^i))) = quantise(Y((t + o/(2^i)),(t + o/(2^i))), stp(i));        
    end
    
end