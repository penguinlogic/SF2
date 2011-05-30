function ents = DCTentropy(X,N,stp,rise)

C = dctmat(N);
Y = colxfm(colxfm(X,C)',C)';
Yq = quantise(Y,stp,rise);
Yr = regroup(Yq,N);

mean_ent = 0;
[H W] = size(X);
H = H/N;
W = W/N;


%k = 7; l = 7;
%(Yr((H*(k-1) + 1):(H*k),(W*(l-1) + 1):(W*l)))
%draw((Yr((H*(k-1) + 1):(H*k),(W*(l-1) + 1):(W*l)))*50)


for i = 1:N
   for j = 1:N
       sub_y = Yr((H*(i-1) + 1):(H*i),(W*(j-1) + 1):(W*j));
       ents(i,j) = entropy2(sub_y,stp,rise);
       
       mean_ent = mean_ent + ents(i,j);
   end
end



mean_ent = mean_ent / N / N;
%simple_ent = entropy(Yr,stp);
total_bits = mean_ent *H*N*W*N;
compression_ratio = 2.2812e5 / total_bits
end