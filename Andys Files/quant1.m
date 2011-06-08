function q = quant1(x, step, rise1)

% function q = quant1(x, step, rise1)
% Quantise the matrix x using steps of width  step; stage 1.
% The result is the quantised integers.
% If rise1 is defined, the first step rises at rise1, otherwise
% it rises at step/2 to give a uniform quantiser with a step
% centred on zero.
% In any case the quantiser is symmetrical about zero.
% Nick Kingsbury, Nov 94.

if step <= 0, q = x; return, end

if nargin <= 2, rise1 = step/2; end

% Quantise abs(x) to integer values, and incorporate sign(x)..
q = max(0,ceil((abs(x) - rise1)/step)) .* sign(x);


