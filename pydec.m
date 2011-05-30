function [Z0, Z1, Z2, Z3] = pydec(N, h, lo, hi0, hi1, hi2, hi3)

inlevel = cell(1, 4);
inlevel{1} = hi0;
inlevel{2} = hi1;
inlevel{3} = hi2;
inlevel{4} = hi3;

outlevel = cell(1, 5);
outlevel{N+1} = lo;

for i = N : -1 : 1
    outlevel{i} = rowint(rowint(outlevel{i+1},2*h)',2*h)' + inlevel{i};
end

Z0 = outlevel{1};
Z1 = outlevel{2};
Z2 = outlevel{3};
Z3 = outlevel{4};