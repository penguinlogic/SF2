function [Xr, Yq, Y, Xq, X, ent, bitrate] = fulldwt (numlevels, delta, k, h1, h2, g1, g2)

load lighthouse;
%impulse response section
%X = zeros(256,256);
%Y = zeros(256,256);
%Y(24,24) = 100;
%Y(24,8) = 100;
%Y(8,24) = 100;
%Yq = Y;
% end of impulse response section

%build stp
stp = zeros (numlevels + 1);

stp(1) = 1 * delta;

stp(2) = 0.690 * delta * k;

stp(3) = 0.383 * delta * k^2;

if numlevels == 3,
    stp(4) = 0.460 * delta * k^3;
end

if numlevels == 4,
    stp(4) = 0.20 * delta * k^3;
    stp(5) = 0.233 * delta * k^4;
end

if numlevels == 5,
    stp(4) = 0.20 * delta * k^3;
    stp(5) = 0.099 * delta * k^4;
    stp(6) = 0.118 * delta * k^5;
end
% end of build stp

if nargin < 4,
    Y = nlevdwt(numlevels, X);
else
    Y = nlevdwt(numlevels, X, h1, h2);
end

[Yq, ent, bitrate] = quantdwt (numlevels, stp, Y);

if nargin < 6,
    Xr = nlevidwt(numlevels, Yq);
else
    Xr = nlevidwt(numlevels, Yq, g1, g2);
end

Xq = quantise(X, 17);
stdXq = std(Xq(:) - X(:))
stdXr = std(Xr(:) - X(:))
bitrateXr = bitrate
compratio = (228786)/bitrateXr
figure(1)
draw(Xr)
%figure(2)
%contour(Xr)