function [y] = quantise(x, step, rise1)

% function [y] = quantise(x, step, rise1)
% Quantise the matrix x using steps of width  step.
% If rise1 is defined, the first step rises at rise1, otherwise
% it rises at step/2 to give a uniform quantiser with a step
% centred on zero.
% In any case the quantiser is symmetrical about zero.
% Nick Kingsbury, Nov 94.

if step <= 0, y = x; return, end

if nargin <= 2, rise1 = step/2; end

% Quantise abs(x) to integer values.
q = max(0,ceil((abs(x) - rise1)/step));

% Reconstruct quantised values and incorporate sign(x).
y = (q * step + (q > 0) * (rise1 - step/2)) .* sign(x);

