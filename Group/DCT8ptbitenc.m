function Yquant1=DCT8ptbitenc(X,N,stp,rise)
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
Yquant1=Yq;
sy=size(Yq);

% Generate zig-zag scan of AC coefs.
scan = [];
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
disp('Generating huffcode and ehuf using default tables.')
[bits, huffval] = huffdflt(1);  % Default tables.
[huffcode, ehuf] = huffgen(bits, huffval);

% Generate run/ampl values and code them into vlc(:,1:2).
% Also generate a histogram of code symbols.
disp('Coding rows')
t = 1:N;
huffhist = zeros(16*16,1);
vlc = [];
for r=0:N:(sy(1)-N),
  fprintf(1,' %d',r)
  vlc1 = [];
  for c=0:N:(sy(2)-N),
    yq = Yq(r+t,c+t);
    % Adjust the range (+/- 127) and no of bits (8) in the following line
    % of code if your quantised dc coefs are bigger or smaller than this.
    if ((yq(1)<-127) | (yq(1)>128))
      disp('DC coefficients too high');
    end
    dccoef = [min(127,max(-127,yq(1)))+128  8];%
    ra1 = runampl(yq(scan));
    vlc1 = [vlc1; dccoef; huffenc(ra1)]; % huffenc() uses ehuf and updates huffhist.
  end
  vlc = [vlc; vlc1];
end
disp('Coding done')

fprintf(1,'No. of bits for coded image with default tables = %d\n', sum(vlc(:,2)))

% Plot histogram of use of huffman codes.
%figure(1)
%bar(0:length(huffhist)-1, huffhist)
%title('Histogram of huffman code usage')
%drawnow

save compress vlc bits huffval stp rise sy N scan

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
t = 1:N;
huffhist = zeros(16*16,1);
vlc = [];
for r=0:N:(sy(1)-N),
  fprintf(1,' %d',r)
  vlc1 = [];
  for c=0:N:(sy(2)-N),
    yq = Yq(r+t,c+t);
    % Adjust the range (+/- 127) and no of bits (8) in the following line
    % of code if your quantised dc coefs are bigger or smaller than this.
    if ((yq(1)<-127) | (yq(1)>128))
      disp('DC coefficients too high');
    end
    dccoef = [min(127,max(-127,yq(1)))+128  8];% 
    ra1 = runampl(yq(scan));
    vlc1 = [vlc1; dccoef; huffenc(ra1)]; % huffenc() uses ehuf and updates huffhist.
  end
  vlc = [vlc; vlc1];
end
disp('Coding done')

fprintf(1,'No. of bits for coded image with custom tables = %d\n', sum(vlc(:,2)))

save compress vlc bits huffval stp rise sy N scan

