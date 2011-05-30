function err = pyrerror_varied(X,h,stps,layers)

%stps = form_quantise_stp(layers,h,k,delta)

if(layers>1)
    Xe = pyrenc(X,h,layers); 
    Xq = quantise_cells(Xe,stps);
    Xs = pyrdec(Xq,h);
end

if (layers == 1)
       Xs = quantise(X,stp);       
end

err = std(X(:) - Xs(:));
%diff = err - pyrerror(X,h,stps,layers);
draw(Xs);

end