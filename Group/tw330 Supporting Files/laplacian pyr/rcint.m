function X1 = rcint(X,h)

X1 = rowint(rowint(X,2*h)',2*h)';


end