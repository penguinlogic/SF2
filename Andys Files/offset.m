function c = offset(x,n)

% function c = offset(x,n)
% Generate a matrix of size(x), whose elements are all
% 128 except the top left size(x)/n corner block which are zero.
% This may be used to offset the bandpass subimages for
% display of an image transform.

c = 128 * ones(size(x));
s = size(x)/n;
c(1:s(1),1:s(2)) = zeros(s);
return
