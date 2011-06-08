function y = quant2(q, step, rise1)

% function y = quant2(q, step, rise1)
% Quantiser, stage 2:
% Reconstruct the matrix y from integers q using steps of width  step.
% The result is the reconstructed values.
% If rise1 is defined, the first step rises at rise1, otherwise
% it rises at step/2 to give a uniform quantiser with a step
% centred on zero.
% In any case the quantiser is symmetrical about zero.
% Nick Kingsbury, Nov 94.

if step <= 0, y = q; return, end

if nargin <= 2, rise1 = step/2; end

% Reconstruct quantised values and incorporate sign(q).
y = q * step + sign(q) * (rise1 - step/2);


