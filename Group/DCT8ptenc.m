function Yq = DCT8ptenc(X,N,stp,rise)

% form transform matrix
C = dctmat(N);

% apply transform
Y = colxfm(colxfm(X,C)',C)';

%quantise 
Yq = quantise(Y,stp,rise);

%[m,p] = size(Yq);
%M = m/N;
%P = p/N;

%for k = 1 : P,
%    for l = 1 : M,
%        for i = 1 : N,
%           for j = (N-i+1) : N,
%            Yq(i + (k-1)*N,j + (l-1)*N) = 0;
%           end
%        end
%    end
%end
%draw(regroup(Yq,N)/N);