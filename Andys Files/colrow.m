function Xcolrow = colrow(X,h)

Xcolrow = convse(X',h)';
Xcolrow = convse(Xcolrow,h);