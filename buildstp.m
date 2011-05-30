function stp = buildstp (N, delta, k)

stp = zeros (N + 1);

stp(1) = 1 * delta;

stp(2) = 0.690 * delta * k;

stp(3) = 0.383 * delta * k^2;

if N == 3,
    stp(4) = 0.460 * delta * k^3;
end

if N == 4,
    stp(4) = 0.20 * delta * k^3;
    stp(5) = 0.233 * delta * k^4;
end

if N == 5,
    stp(4) = 0.20 * delta * k^3;
    stp(5) = 0.099 * delta * k^4;
    stp(6) = 0.118 * delta * k^5;
end