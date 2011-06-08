function Y = nlevidwt(numlevels, X, g1, g2)

m = size(X)/2^(numlevels-1);
Y = X;

if nargin < 4,
    if numlevels > 0,
        for i = numlevels : -1 : 1,
            t = 1:m;
            Y(t,t) = idwt(Y(t,t));
            m = 2*m;
        end
    end
end

if nargin > 3,
    if numlevels > 0,
        for i = numlevels : -1 : 1,
            t = 1:m;
            Y(t,t) = idwt(Y(t,t), h1, h2);
            m = 2*m;
        end
    end
end