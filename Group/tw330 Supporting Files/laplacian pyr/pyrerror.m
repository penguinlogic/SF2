function err = pyrerror(X,h,stp,N)

if(N>1)
    Xe = pyrenc(X,h,N); 
    Xq = quantise_cells(Xe,stp);
    Xs = pyrdec(Xq,h);
end

if (N == 1)
       Xs = quantise(X,stp);       
end

draw(Xs);

err = std(X(:) - Xs(:));

end