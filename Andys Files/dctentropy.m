function dctentropy(N, step)

load lighthouse

C = dctmat(N);
Y = colxfm(colxfm(X,C)',C)';
Yq = quantise(Y, step);
Yr = regroup(Yq,N);%/N;
Xq = quantise(X, 17);

[H, W] = size(Yr);
H = H/N;
W = W/N;

E = zeros(N,N);

for i = 1 : N,
    for j = 1 : N,
        E(i,j) = entropy(Yr(((i-1)*W)+1:i*W,((j-1)*H)+1:j*H), step);
    end
end

meanentropy = 0;

for i = 1 : (N*N),
    meanentropy = meanentropy +E(i);
end

meanentropy = meanentropy/(N*N)
meanbitrate = meanentropy*256^2
meanCR = 228786/meanbitrate

simpleentropy = entropy(Yr,step)
simplebitrate = simpleentropy*256^2
simpleCR = 228786/simplebitrate

Z = colxfm(colxfm(Yq',C')',C');

E;

stdXq = std(Xq(:)-X(:))
stdZ = std(Z(:)-X(:))

draw(Z)