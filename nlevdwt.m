function Y = nlevdwt (numlevels, X, h1, h2)

m = size(X);
Y = X;

if nargin < 4,
    if numlevels > 0,
        for i = numlevels : -1 : 1,
            t = 1:m;
            Y(t,t) = dwt(Y(t,t));
            m = m/2;
        end
    end
end

if nargin > 3,
    if numlevels > 0,
        for i = numlevels : -1 : 1,
            t = 1:m;
            Y(t,t) = dwt(Y(t,t), h1, h2);
            m = m/2;
        end
    end
end