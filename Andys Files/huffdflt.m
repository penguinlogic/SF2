function [bits,huffval] = huffdflt(type)

% function [bits,huffval] = huffdflt(type)
% Generate JPEG default huffman specification tables, bits
% and huffval, as in JPEG appendix K.3.3.2.
% If type = 1, the default luminance AC coefficient table is generated.
% If type = 2, the default chrominance AC coefficient table is generated.
% Nick Kingsbury, Dec 94

if type == 1,
  bits=hex2vec('0 2 1 3 3 2 4 3 5 5 4 4 0 0 1 7D')';
  huffval = [hex2vec('1 2 3 0 4 11 5 12 21 31 41 6 13 51 61 7')'
    hex2vec('22 71 14 32 81 91 a1 08 23 42 b1 c1 15 52 d1 f0')'
    hex2vec('24 33 62 72 82 09 0a 16 17 18 19 1a 25 26 27 28')'
    hex2vec('29 2a 34 35 36 37 38 39 3a 43 44 45 46 47 48 49')'
    hex2vec('4a 53 54 55 56 57 58 59 5a 63 64 65 66 67 68 69')'
    hex2vec('6a 73 74 75 76 77 78 79 7a 83 84 85 86 87 88 89')'
    hex2vec('8a 92 93 94 95 96 97 98 99 9a a2 a3 a4 a5 a6 a7')'
    hex2vec('a8 a9 aa b2 b3 b4 b5 b6 b7 b8 b9 ba c2 c3 c4 c5')'
    hex2vec('c6 c7 c8 c9 ca d2 d3 d4 d5 d6 d7 d8 d9 da e1 e2')'
    hex2vec('e3 e4 e5 e6 e7 e8 e9 ea f1 f2 f3 f4 f5 f6 f7 f8')'
    hex2vec('f9 fa')'];
else
  bits=hex2vec('0 2 1 2 4 4 3 4 7 5 4 4 0 1 2 77')';
  huffval = [hex2vec('0 1 2 3 11 4 5 21 31 6 12 41 51 7 61 71')'
    hex2vec('13 22 32 81 8 14 42 91 a1 b1 c1 9 23 33 52 f0')'
    hex2vec('15 62 72 d1 0a 16 24 34 e1 25 f1 17 18 19 1a 26')'
    hex2vec('27 28 29 2a 35 36 37 38 39 3a 43 44 45 46 47 48')'
    hex2vec('49 4a 53 54 55 56 57 58 59 5a 63 64 65 66 67 68')'
    hex2vec('69 6a 73 74 75 76 77 78 79 7a 82 83 84 85 86 87')'
    hex2vec('88 89 8a 92 93 94 95 96 97 98 99 9a a2 a3 a4 a5')'
    hex2vec('a6 a7 a8 a9 aa b2 b3 b4 b5 b6 b7 b8 b9 ba c2 c3')'
    hex2vec('c4 c5 c6 c7 c8 c9 ca d2 d3 d4 d5 d6 d7 d8 d9 da')'
    hex2vec('e2 e3 e4 e5 e6 e7 e8 e9 ea f2 f3 f4 f5 f6 f7 f8')'
    hex2vec('f9 fa')'];
end
return
