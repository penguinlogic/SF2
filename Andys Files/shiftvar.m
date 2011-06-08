% SHIFTVAR.M
% Investigate the shift variance of subband energy for a variety of
% common wavelets.
%
% Nick Kingsbury, Cambridge University, June 1996.

printon=2

% Generate a series of n steps with 1-bit shifts, extended by ex samples.
n = 16;
% ex = 64;
% x = cumsum([zeros(ex,n); diag(ones(n,1)); zeros(ex,n)]);

% Now do the Antonini wavelets.
% This polynomial makes even terms of P(z) zero when other factors 
% are (1+z)^8.
r2 = roots([5 -40 131 -208 131 -40 5]);

% Antonini 7,9-tap wavelets (FBI standard).
% 4 roots at z=-1 and the 4 complex roots from r2.
h0ant = real(poly([-1; -1; -1; -1; r2(2:5)])');
% 4 roots at z=-1 and the 2 real roots from r2.
g0ant = real(poly([-1; -1; -1; -1; r2([1 6])])');

% Antonini 6,10-tap wavelets.
% 5 roots at z=-1 and the 4 complex roots from r2.
% h0ant = real(poly([-1; -1; -1; -1; -1; r2(2:5)])');
% 3 roots at z=-1 and the 2 real roots from r2.
% g0ant = real(poly([-1; -1; -1; r2([1 6])])');

h0ant = h0ant/sum(h0ant);  % unit DC gain.
g0ant = g0ant/sum(g0ant);

% Generate hi-band filters as quadrature mirrors of lo-band filters.
h1ant = g0ant .* cumprod(-ones(size(g0ant)));
g1ant = -h0ant .* cumprod(-ones(size(h0ant)));

h = wav4(g0ant,g1ant);

% Step function matrix, extended to 160 samples.
hs=cumsum([h;zeros(160-size(h,1),5)]);

setfig(1)
t1=-48:48;
t2=-48:16:48;
t3=-40:16:40;
plot(t1/16,hs(t1+54,4),'-r',t2/16,hs(t2+54,4),'xg',t3/16,hs(t3+54,4),'oc')
grid
title('Step response of level-4 Antonini wavelet');
xlabel('output sample number');

% Energy matrix.
es = hs .* hs;

% Derive the energy fluctuations at each level.
dt = 15;
t1 = [0:2:111] + dt;
t2 = [1:4:111] + dt;
t3 = [3:8:111] + dt;
t4 = [7:16:111] + dt;
for i=1:16,
  efl(i,:) = [sum(es(t1+i,1)) sum(es(t2+i,2)) sum(es(t3+i,3)) sum(es(t4+i,4))]; 
end

setfig(2)
% cplot([efl; efl],0.2);
plotsep2([efl; efl],0.2);
hold on
plot([0 16]-0.5,efl(16,4)-0.6*[1 1],'xg');
plot([0 16]-8.5,efl(8,4)-0.6*[1 1],'oc');
hold off
% grid
axis([-20 20 -0.7 0.2])
title('Shift variance of Antonini wavelet output energy at levels 1 to 4');
xlabel('Position of input step');
text(-17.5,0.15,'Level','horiz','center','vert','mid');
text(-17.5,0.05,'1','horiz','center','vert','mid');
text(-17.5,-0.15,'2','horiz','center','vert','mid');
text(-17.5,-0.35,'3','horiz','center','vert','mid');
text(-17.5,-0.55,'4','horiz','center','vert','mid');

% Now do the complex filters.

h0c = [1-j 4-j 4+j 1+j].'/10; 
h1c = [-1-2*j 5+2*j -5+2*j 1-2*j].'/14;
h1c = real(h1c) + j*imag(h1c)*4/3;

% Calculate the top-level filter which gives correct scalability.
[f,lambda] = topfilt(h0c);

h = wav4(h0c,h1c);

% Convolve the top filter with all the others.
hf = [];
for i = 1:size(h,2),
  hf(:,i) = conv(f,h(:,i));
end

% Step function matrix, extended to 160 samples.
hs=cumsum([zeros(25,5);hf;zeros(135-size(hf,1),5)]);
setfig(3)
t1=-48:48;
t2=-48:16:48;
t3=-40:16:40;
plot(t1/16,real(hs(t1+49,4)),'-r');
hold on
plot(t1/16,imag(hs(t1+49,4)),'-b');
plot(t1/16,abs(hs(t1+49,4)),'-g');
plot(t2/16,abs(hs(t2+49,4)),'xg',t3/16,abs(hs(t3+49,4)),'oc')
hold off
grid
title('Step response of level-4 complex wavelet');
xlabel('output sample number');

% Energy matrix.
es = real(hs .* conj(hs));

% Derive the energy fluctuations at each level.
dt = 15;
t1 = [0:2:111] + dt;
t2 = [1:4:111] + dt;
t3 = [3:8:111] + dt;
t4 = [7:16:111] + dt;
for i=1:16,
  efl(i,:) = [sum(es(t1+i,1)) sum(es(t2+i,2)) sum(es(t3+i,3)) sum(es(t4+i,4))]; 
end

setfig(4)
% cplot([efl; efl],0.2);
plotsep2([efl; efl],0.2);
hold on
plot([0 16]-0.5,efl(16,4)-0.6*[1 1],'xg');
plot([0 16]-8.5,efl(8,4)-0.6*[1 1],'oc');
hold off
% grid
axis([-20 20 -0.7 0.2])
title('Shift variance of complex wavelet output energy at levels 1 to 4');
xlabel('Position of input step');
text(-17.5,0.15,'Level','horiz','center','vert','mid');
text(-17.5,0.05,'1','horiz','center','vert','mid');
text(-17.5,-0.15,'2','horiz','center','vert','mid');
text(-17.5,-0.35,'3','horiz','center','vert','mid');
text(-17.5,-0.55,'4','horiz','center','vert','mid');

if printon==2,
  figure(1)
  print -deps shift1.eps
  figure(2)
  print -deps shift2.eps
  figure(3)
  print -deps shift3.eps
  figure(4)
  print -deps shift4.eps
elseif printon==1,
  figure(1)
  print -dpsc shift1.ps
  figure(2)
  print -dpsc shift2.ps
  figure(3)
  print -dpsc shift3.ps
  figure(4)
  print -dpsc shift4.ps
end

