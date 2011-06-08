function vlc = huffenc(rsa)

% function vlc = huffenc(rsa)
% Perform huffman encoding on the run/ampl coded rows
% of rsa, as produced by RUNAMPL.M.
% The codewords are variable length integers in vlc(:,1)
% whose lengths are in vlc(:,2).
% The global matrix ehuf contains the huffman codes and their lengths.

% These global variables are needed  
% because it is difficult to pass pointers in Matlab, and
% huffhist just needs some elements to be incremented in 
% each call to HUFFENC.
% It is also inefficient to pass all of ehuf with each call.
global ehuf
global huffhist

[r,c] = size(rsa);

vlc = [];
for i=1:r,
  run = rsa(i,1);

% If run > 15, use repeated codes for 16 zeros.
  while run > 15,
    code = 15*16 + 1;
    huffhist(code) = huffhist(code) + 1;
    vlc = [vlc; ehuf(code,:)];
    run = run - 16;
  end

% Code the run and size.
  code = run*16 + rsa(i,2) + 1;
  huffhist(code) = huffhist(code) + 1;
  vlc = [vlc; ehuf(code,:)];

% If size > 0, code the remainder.
  if rsa(i,2) > 0,
    vlc = [vlc; rsa(i,[3 2])];
  end
end
return 