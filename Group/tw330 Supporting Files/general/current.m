%layers = 5; k = 1; delta = 25;
%DWT_full(X,layers,DWT_steps(layers,k)*delta);


figure
Z = peaks; surf(Z); 
axis tight
set(gca,'NextPlot','replacechildren');
% Preallocate the struct array for the struct returned by getframe
F(20) = struct('cdata',[],'colormap',[]);
% Record the movie
for j = 1:20 
    surf(.01+sin(2*pi*j/20)*Z,Z)
    F(j) = getframe;
end


movie(F,10)

