function DCT8ptbitenc(X,N,stp,rise)
% DCT8ptbitenc.M

% These global variables are needed by function HUFFENC 
% because it is difficult to pass pointers in Matlab, and
% huffhist just needs some elements to be incremented in 
% each call to HUFFENC.
global ehuf      % Huffman code table.
global huffhist  % Histogram of usage of huffman codewords.

% DCT on input image X.
 C = dctmat(N);
 disp('Doing DCT'); Y=colxfm(colxfm(X,C)',C)'; 

% Quantise to integers.
Yq=quant1(Y,stp,rise);

sy=size(Yq);

% Generate zig-zag scan of AC coefs.
%if N==8,
    % added dc component to start of scan
  %scan=[1 9 2 3 10 17 25 18 11 4 5 12 19 26 33 41 34 27 20 13 6];
  %scan=[scan 7 14 21 28 35 42 49 57 50 43 36 29 22 15 8];
  %scan=[scan 16 23 30 37 44 51 58 59 52 45 38 31 24];
  %scan=[scan 32 39 46 53 60 61 54 47 40 48 55 62 63 56 64];
%end

% On the first pass use default huffman tables.
disp('Generating huffcode and ehuf using default tables.')
[bits, huffval] = huffdflt(1);  % Default tables.
[huffcode, ehuf] = huffgen(bits, huffval);

% Generate run/ampl values and code them into vlc(:,1:2).
% Also generate a histogram of code symbols.
disp('Coding rows')

huffhist = zeros(16*16,1);
vlc = [];

%vlc1 = [];
%vlc1 = [
%dccoef = [min(127,max(-127,yq(1)))+128  8];
%for i = 1 : 63,
%  element = [];
%  for r=0:N:(sy(1)-N),
%    for c=0:N:(sy(2)-N),
%        yq = Yq(r+t,c+t);
%        element = [element, yq(scan(i))];        
%    end
%  end
%  ra1 = runampl(element);
  

n = sy(1)/N;
t = 1:n;
Yr = regroup(Yq,N);

for r=0:n:(sy(1)-n),
  fprintf(1,' %d',r)
  vlc1 = [];
  for c=0:n:(sy(2)-n),
    yr = Yr(r+t,c+t);
    % Adjust the range (+/- 127) and no of bits (8) in the following line
    % of code if your quantised dc coefs are bigger or smaller than this.
    if r == 0 && c == 0,        
        if ((yr(1)<-127) | (yr(1)>128))
         disp('DC coefficients too high');
        end
        ra1 = [min(127,max(-127,yr(:)))+128, 8*ones(n^2,1)]; % actually dccoef
        size(ra1)
    else
        ra1 = runampl(yr(:));
        ra1 = huffenc(ra1);
    end
        vlc1 = [vlc1; ra1]; % huffenc() uses ehuf and updates huffhist.
  end
  vlc = [vlc; vlc1];
end
disp('Coding done')

fprintf(1,'No. of bits for coded image with default tables = %d\n', sum(vlc(:,2)))

% Plot histogram of use of huffman codes.
figure(1)
bar(0:length(huffhist)-1, huffhist)
title('Histogram of huffman code usage')
drawnow

save compress vlc bits huffval stp sy N

% Return here if the default tables are sufficient, otherwise repeat the
% encoding process using the custom designed huffman tables.

if all(input('Recode using custom tables (y/n)? ','s') ~= 'y'), return, end

% Design custom huffman tables.
disp('Generating huffcode and ehuf using custom tables.')
[bits, huffval] = huffdes(huffhist);
[huffcode, ehuf] = huffgen(bits, huffval);

% Generate run/ampl values and code them into vlc(:,1:2).
% Also generate a histogram of code symbols.
disp('Coding rows')
huffhist = zeros(16*16,1);
vlc = [];

n = sy(1)/N;
t = 1:n;
Yr = regroup(Yq,N);

for r=0:n:(sy(1)-n),
  fprintf(1,' %d',r)
  vlc1 = [];
  for c=0:n:(sy(2)-n),
    yr = Yr(r+t,c+t);
    if r == 0 && c == 0,        
        if ((yr(1)<-127) | (yr(1)>128))
         disp('DC coefficients too high');
        end
        ra1 = [min(127,max(-127,yr(:)))+128, 8*ones(n^2,1)]; % actually dccoef
        size(ra1)
    else
        ra1 = runampl(yr(:));
        ra1 = huffenc(ra1);
    end
        vlc1 = [vlc1; ra1]; % huffenc() uses ehuf and updates huffhist.
  end
  vlc = [vlc; vlc1];
end

%for r=0:n:(sy(1)-n),
%  fprintf(1,' %d',r)
%  vlc1 = [];
%  for c=0:n:(sy(2)-n),
%    yr = Yr(r+t,c+t);
%    % Adjust the range (+/- 127) and no of bits (8) in the following line
%    % of code if your quantised dc coefs are bigger or smaller than this.
%    %if ((yr(1)<-127) | (yr(1)>128))
%    %  disp('DC coefficients too high');
%    %end
%    %dccoef = [min(127,max(-127,yr(1)))+128  8]; 
%    ra1 = runampl(yr(:));
%    vlc1 = [vlc1; huffenc(ra1)]; % huffenc() uses ehuf and updates huffhist.
%  end
%  vlc = [vlc; vlc1];
%end
disp('Coding done')

fprintf(1,'No. of bits for coded image with custom tables = %d\n', sum(vlc(:,2)))

save compress vlc bits huffval stp sy N

