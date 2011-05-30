
%%
Xs = quantise (X,17);
std(Xs(:) - X(:))
ans =
    4.8612

%%

err = pyrerror(X,h,11.3,4)
err =
    4.6962

    
    
    
%%

err = DCTerror(X,8,24)
err =
    4.9084

entropy(Xs,17)
ans =
    3.4808    
    
ents = DCTentropy(X,8,24);
mean_ent =
    0.1524
simple_ent =
    0.2386
%%

