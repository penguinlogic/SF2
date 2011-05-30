function b=entropy(x,step)

% function b=entropy(x,step)
% Calculate the entropy in bits per element for the matrix x, assuming that x
% is quantised into bins.
% If step is a scalar, the bins are  step  wide, and cover the
% range min(x) to max(x) with bins centred on integer multiples
% of  step.
% If step is a vector, the bins are centred on each element of the
% vector between min(x) and max(x).

% The entropy represents the number of bits per element to encode x
% assuming an ideal first-order entropy code.

if (max(step) <= 0),
  b = 0;
  return
end

minx = min(min(x));
maxx = max(max(x));

if length(step) == 1,
  bins = [floor(minx/step):ceil(maxx/step)] * step;
else
% For speed, ignore steps that are outside the range of x.
  bins = step(find(step >= minx & step <= maxx));
end

% Calculate histogram of x in bins defined by  bins.
if bins==0 
   h=[]; s=[];
else
  [h,s] = hist(x(:),bins);
end

% bar(s,h)
% figure(gcf)

% Convert bin counts to probabilities, and remove zeros.
p = h / sum(h);
p = p(find(p > 0));

% Calculate the entropy of the histogram using base 2 logs.
b = -sum(p .* log(p)) / log(2);

return
