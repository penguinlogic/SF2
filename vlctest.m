function bits = vlctest(vlc)

% function bits = vlctest(vlc)
% Test the validity of a vlc matrix and return the total number of
% bits to code the vlc data.

% Check that all elements in vlc(:,1) are positive and less than 
% 2.^vlc(:,2) - 1.

neg = find(vlc(:,1) < 0);
if ~isempty(neg),
  disp('Negative entries in vlc(:,1) at rows:');
  [vlc(neg,1) neg]
end

invalid = find((2.^vlc(:,2) - 1) < vlc(:,1));
if ~isempty(invalid),
  disp('Invalid [data,nbits] entries in vlc(:,1:2) at rows:');
  [vlc(invalid,:) invalid]
end

% Calculate total number of bits to code vlc(:,1) entries.
bits = sum(vlc(:,2));
return