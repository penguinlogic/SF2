function Xrowcol = rowcol(X,h)

Xrowcol = convse(X,h);
Xrowcol = convse(Xrowcol',h)';