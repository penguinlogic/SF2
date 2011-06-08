function [Xf] = low_pass(X,h)

Xf = filter_rows(filter_rows(X,h)',h)';

end