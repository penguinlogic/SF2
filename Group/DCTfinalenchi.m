function [vlc, bits, huffval, ehuf, huffhist, scan, sy, bitcount]=DCTfinalenchi(Yq,N)

% These global variables are needed by function HUFFENC 
% because it is difficult to pass pointers in Matlab, and
% huffhist just needs some elements to be incremented in 
% each call to HUFFENC.
global ehuf      % Huffman code table.
global huffhist  % Histogram of usage of huffman codewords.

sy=size(Yq);

% Generate zig-zag scan of AC coefs.
scan = [];
scan(1,1) = 1; % include DC coeff
% scanning direction, (1 for up, 0 for down)
dir = 0;
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
    
% On the first pass use default huffman tables.
[bits, huffval] = huffdflt(1);  % Default tables.
[huffcode, ehuf] = huffgen(bits, huffval);

% Generate run/ampl values and code them into vlc(:,1:2).
% Also generate a histogram of code symbols.
t = 1:N;
huffhist = zeros(16*16,1);
vlc = [];
for r=0:N:(sy(1)-N),
  %fprintf(1,' %d',r)
  vlc1 = [];
  for c=0:N:(sy(2)-N),
    yq = Yq(r+t,c+t);
    % Adjust the range (+/- 127) and no of bits (8) in the following line
    % of code if your quantised dc coefs are bigger or smaller than this.
    %if ((yq(1)<-127) | (yq(1)>128))
    %  disp('DC coefficients too high');
    %end
    %dccoef = [min(127,max(-127,yq(1)))+128  8];%
    ra1 = runampl(yq(scan));
    %vlc1 = [vlc1; dccoef; huffenc(ra1)]; % huffenc() uses ehuf and updates huffhist.
    vlc1 = [vlc1; huffenc(ra1)]; % huffenc() uses ehuf and updates huffhist.
  end
  vlc = [vlc; vlc1];
end

% Design custom huffman tables.
%disp('Generating huffcode and ehuf using custom tables.')
[bits, huffval] = huffdes(huffhist);
[huffcode, ehuf] = huffgen(bits, huffval);

% Generate run/ampl values and code them into vlc(:,1:2).
% Also generate a histogram of code symbols.
t = 1:N;
huffhist = zeros(16*16,1);
vlc = [];
for r=0:N:(sy(1)-N),
%  fprintf(1,' %d',r)
  vlc1 = [];
  for c=0:N:(sy(2)-N),
    yq = Yq(r+t,c+t);

    % Adjust the range (+/- 127) and no of bits (8) in the following line
    % of code if your quantised dc coefs are bigger or smaller than this.
    %if ((yq(1)<-127) | (yq(1)>128))
    %  disp('DC coefficients too high');
    %end
    %dccoef = [min(127,max(-127,yq(1)))+128  8];% 
    ra1 = runampl(yq(scan));
    %vlc1 = [vlc1; dccoef; huffenc(ra1)]; % huffenc() uses ehuf and updates huffhist.
    vlc1 = [vlc1; huffenc(ra1)]; % huffenc() uses ehuf and updates huffhist.
  end
  vlc = [vlc; vlc1];
end

bitcount = sum(vlc(:,2)) + 1424;

%fprintf(1,'No. of bits for coded DCT image with custom tables = %d\n', sum(vlc(:,2)))

