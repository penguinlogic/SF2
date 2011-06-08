function [huffcode, ehuf] = huffgen(bits, huffval)

% function [huffcode, ehuf] = huffgen(bits, huffval)
% From the specifications, bits and huffval, generate the
% Huffman code table, huffcode, and the encoder matrix ehuf.
% huffcode lists the valid codes in ascending order, and huffsize lists
% their lengths.
% ehuf lists the codes and their lengths in the order of the values 
% defined in huffval.
% Nick Kingsbury, Dec 94

% Generate huffman size table (JPEG fig C1, p78):
nb=length(bits);
k=1;
j=1;
ncodes=sum(bits);
huffsize=zeros(ncodes,1);
for i=1:nb,
  while j<=bits(i), huffsize(k)=i; k=k+1; j=j+1; end	
  j=1;
end

% Generate huffman code table (JPEG fig C2, p79):
huffcode=zeros(ncodes,1);
code=0;
si=huffsize(1);
for k=1:ncodes,
  while huffsize(k)>si,
    code=code*2;
    si=si+1;
  end
  huffcode(k)=code;
  code=code+1;
end

% Reorder the code tables according to the data in huffval
% to yield the encoder look-up tables.
ehuf=zeros(256,2);
ehuf(huffval+1,:)=[huffcode huffsize];

return
