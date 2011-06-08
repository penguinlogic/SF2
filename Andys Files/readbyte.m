function X = readbyte(filename, rows, cols)
% function X = readbyte(filename, rows, cols)
% Reads an image row by row into X, where each pel is represented by
% 1 byte in 'filename'.

fid=fopen(filename,'r');
X=zeros(rows,cols);
for r=1:rows,
  X(r,:)=fscanf(fid,'%c',cols); 
end
X=X+0; % Convert X from text to numeric.
fclose(fid);
return
