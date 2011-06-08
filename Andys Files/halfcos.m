function h = halfcos(N)

% function h = halfcos(N)
% Generate a half-cosine impulse response of length N samples.
% h is a column vector.
% The amplitude of h gives unit gain at zero frequency.
% Nick Kingsbury, Dec 94

h = cos(([1:N]'/(N+1) - 0.5) * pi);
h = h / sum(h);

return


