function Zi = DWTbitdec()

%Decodes a DWT encoded image

% Input data is in vlc(:,1:2).
load compress

% Define starting addresses of each new code length in huffcode.
huffstart=cumsum([1; bits(1:15)]);

% Set up huffman coding arrays.
[huffcode, ehuf] = huffgen(bits, huffval);

% Define array of powers of 2 from 1 to 2^16.
k=[1; cumprod(2*ones(16,1))];

% For each block in the image:

% Decode the dc coef (a fixed-length 8-bit word)
% Look for any 15/0 code words.
% Choose alternate code words to be decoded (excluding 15/0 ones).
% and mark these with vector t until the next 0/0 EOB code is found.
% Decode all the t huffman codes, and the t+1 amplitude codes.

eob = ehuf(1,:);
run16 = ehuf(15*16+1,:);
i = 1;
Zq = zeros(sy);
t=1:N;

disp('Decoding rows of blocks of VL coefs:')
for r=0:N:(sy(1)-N),
  fprintf(1,'\n%d',r)
  for c=0:N:(sy(2)-N),
    fprintf(1,'.')
    yq = zeros(N,N);

% Decode DC coef.
% Adjust the following 6 lines of code if the no of bits for
% the dc coef in JPEGENC was altered.
    if vlc(i,2) ~= 11, 
      fprintf(1,'Error: DC wordlength = %d at i = %d\n', vlc(1,2), i);
    end
    cf = 1;
    yq(cf) = vlc(i,1) - 2048;
    i = i + 1;

% Loop for each non-zero AC coef.
    while any(vlc(i,:) ~= eob),
      run = 0;

% Decode any runs of 16 zeros first.
      while all(vlc(i,:) == run16), run = run + 16; i = i + 1; end

% Decode run and size (in bits) of AC coef.
      start = huffstart(vlc(i,2));
      res = huffval(start + vlc(i,1) - huffcode(start));
      run = run + fix(res/16);
      cf = cf + run + 1;  % Pointer to new coef.
      si = rem(res,16);
      i = i + 1;

% Decode amplitude of AC coef.
      if vlc(i,2) ~= si,
        fprintf(1, 'Error: size of AC coef %d should be %d bits\n', i, si);
        return
      end
      ampl = vlc(i,1);

% Adjust ampl for negative coef (i.e. MSB = 0).
      thr = k(si);
      yq(scan(cf-1)) = ampl - (ampl < thr) * (2 * thr - 1);

      i = i + 1;      
    end

% End-of-block detected, save block.
    i = i + 1;

    Zq(r+t,c+t) = yq;
  end
end

disp('Decoding done')

disp('Inverse regrouping'); Zir=dwtgroup(Zq,levels*(-1));

disp('Inverse quantising'); Ziq=DWT_quant2(Zir,levels,steps,steps);

disp('Inverse DWT'); Zi = DWTgrpdec(Ziq,levels);

draw(Zi)
