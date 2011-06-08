%1 startup
clear; load lighthouse; X = X - 128;

%2 low pass filter and draw
h = halfcos(7); Xf = t4(X,h); draw(Xf);

%3 laplacian pyr unequal steps
step = form_quantise_stp(4,h,k);            
step = 11.6;
err = pyrerror_varied(X,h,step*delta,4)
Xe = pyrenc(X,h,4);
entropy_cells(Xe,step*delta)

%4 beside drawing
draw(beside(Xe{1},beside(Xe{2},beside(Xe{3},Xe{4}))))

%5 error calcs
err = max(abs(X1(:)-X2(:)));

%6 laplacian pyramid do
clear; load lighthouse; X = X - 128;
h = [0.25 0.5 0.25]';
Xe = pyrenc(X,h,6); draw(t_beside(Xe)); % encode
Xd = pyrdec(Xe,h); draw(Xd);            % decode
err = max(abs(Xs(:)-X(:)));

%7 row or col first difference
X1 = low_pass(low_pass(X,h)',h)';
X2 = low_pass(low_pass(X',h)',h);
err = max(abs(X1(:)-X2(:)));

%8 DCT first bits
C8 = dctmat(8);
Y = colxfm(colxfm(X,C8)',C8)';
N = 8;
draw(regroup(Y,N)/N + 128)
Z = colxfm(colxfm(Y',C8')',C8');
bases = [zeros(1,8);C8';zeros(1,8)]
err = max(abs(Z(:)-X(:)))
Yq = quantise(Y,17);

%9 DCT compare to direct quantisation
clear; load lighthouse; X = X - 128;
Z = DCTfull(X,8,24); draw(Z)
Xs = quantise (X,17);
draw(beside(X,beside(Xs,Z)));

%10 DWT first bits
h1 = [-1 2 6 2 -1]/8;
h2 = [-1 2 -1]/4;
U = rowdec(X,h1);
V = rowdec2(X,h2);
draw([U V])
UU = rowdec(U',h1)';
UV = rowdec2(U',h2)';
VU = rowdec(V',h1)';
VV = rowdec2(V',h2)';
draw([UU VU ; UV VV]);
g1 = [1 2 1]/2;
g2 = [-1 -2 6 -2 -1]/4;
Ur = rowint(UU',g1)' + rowint2(UV',g2)';
Vr = rowint(VU',g1)' + rowint2(VV',g2)';
draw([Ur Vr])
max(abs(Ur(:)-U(:)))
max(abs(Vr(:)-V(:)))
Xr = rowint(Ur,g1) + rowint2(Vr,g2);
max(abs(Xr(:)-X(:)))

%11 DWT proper
step = [15 15 15 15 15];
Y = DWT_iter(X,4);
[Yq ent bits] = DWT_quantise(Y,4,step);
Z = IDWT_iter(Yq, 4);
draw(Z)

%12 DWT bits required
step = [15 15 15 15 15 15 15 15 15 15 15];
for n = 1:7    
    %n = 5;
    Y = DWT_iter(X,n);
    n
    [Yq ent] = DWT_quantise(Y,n,step); 
end

%13 DWT full do
layers = 5; k = 1; delta = 25;
DWT_full(X,layers,DWT_steps(layers,k)*delta);

%14 Centre clipped linear quantiser
x = -100:100 ;
y = quantise(x,20,20); plot(x,y), grid







