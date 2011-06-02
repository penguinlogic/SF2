function DWTbitenc(X,levels,steps,rise)

% DWTbitenc.m

% These global variables are needed by function HUFFENC 
% because it is difficult to pass pointers in Matlab, and
% huffhist just needs some elements to be incremented in 
% each call to HUFFENC.
global ehuf      % Huffman code table.
global huffhist  % Histogram of usage of huffman codewords.

% DCT on input image X.
 %N = 8; % N now given as arg
 %C8=dctmat(N); % not needed for DWT
 disp('Doing DWT'); Y = DWT_iter(X,levels);

% Quantise to integers.
%qstep = input('Quantiser step size = '); %steps recieved as arg
%disp(['Quantising to step size = ' sprintf('%d',qstep)]); 
%Yq=quant1(Y,steps,rise); %standard fn used for DCT
Yq = DWT_quantise(Y,levels,steps,rise);

sy=size(Yq);

% Generate zig-zag scan of AC coefs.
%if N==8,
%  scan=[9 2 3 10 17 25 18 11 4 5 12 19 26 33 41 34 27 20 13 6];
%  scan=[scan 7 14 21 28 35 42 49 57 50 43 36 29 22 15 8];
%  scan=[scan 16 23 30 37 44 51 58 59 52 45 38 31 24];
%  scan=[scan 32 39 46 53 60 61 54 47 40 48 55 62 63 56 64];
%end

% On the first pass use default huffman tables.
disp('Generating huffcode and ehuf using default tables.')
[bits, huffval] = huffdflt(1);  % Default tables.
[huffcode, ehuf] = huffgen(bits, huffval);

% Generate zig-zag scan of AC coefs.
scan = [];
% scanning direction, (1 for up, 0 for down)
dir = 0;

N = 2^levels;
for k = 2:2*N
    dir = 1-dir;
        
    if dir == 1
       for row = k:-1:1
           col = ((k+1)-row);
           if row <= N && col <= N,
             scan = [scan ((row-1)*N+col)];  
           end
       end
    else
        for col = k:-1:1
           row = ((k+1)-col);
           if row <= N && col <= N,
             scan = [scan ((row-1)*N+col)];
           end
        end
    end
end

disp('Coding rows')
t = 1:N;
huffhist = zeros(16*16,1);
% find number of pixels in each direction of smallest (DC) coeff set
Yr = dwtgroup(Yq, levels);
vlc = [];
for i = 0: N : sy(1)-N,
    vlc1 = [];
    for j = 0: N : sy(2)-N, % iterate over each pixel in DC coeff set
        yr = Yr(i+t,j+t);
        % Adjust the range (+/- 127) and no of bits (8) in the following line
        % of code if your quantised dc coefs are bigger or smaller than this.
        if ((yr(1)<-127) | (yr(1)>128)),
            disp('DC coefficients too high');
        end
        dccoef = [min(127,max(-127,yr(1)))+128  8]; 
        ra1 = runampl(yr(scan));
        vlc1 = [vlc1; dccoef; huffenc(ra1)]; % huffenc() uses ehuf and updates huffhist.
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

save compress vlc bits huffval steps sy N scan

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
% find number of pixels in each direction of smallest (DC) coeff set
vlc = [];
for i = 0: N : sy(1)-N,
    vlc1 = [];
    for j = 0: N : sy(2)-N, % iterate over each pixel in DC coeff set
        yr = Yr(i+t,j+t);
        % Adjust the range (+/- 127) and no of bits (8) in the following line
        % of code if your quantised dc coefs are bigger or smaller than this.
        if ((yr(1)<-127) | (yr(1)>128)),
            disp('DC coefficients too high');
        end
        dccoef = [min(127,max(-127,yr(1)))+128  8]; 
        ra1 = runampl(yr(scan));
        vlc1 = [vlc1; dccoef; huffenc(ra1)]; % huffenc() uses ehuf and updates huffhist.
    end
    vlc = [vlc; vlc1];
end
disp('Coding done')

fprintf(1,'No. of bits for coded image with custom tables = %d\n', sum(vlc(:,2)))

save compress vlc bits huffval steps sy N scan

