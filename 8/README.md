https://adventofcode.com/2021/day/8 - Seven Segment Search

Working;

2 digits = 1 
3 digits = 7
4 digits = 4
5 digits = 2,3,5
6 digits = 0,6,9
7 digits = 8

Example puzzle;

dbc gfecab afcdg dfebcag bd dgbe bcaeg dcefab ecgadb agcbd | acdgb gbcda gdecfba bacge

Whichever character is in the three signal code (dbc) but not the two digit code (bd)
is aa. The other two digits are either cc or ff
dbc (7) - bd (1) = c,  thus c = aa and b = cc OR ff and d = cc OR ff

  aa       c
b    c       b/d
b    c       b/d
  dd
e    f       b/d
e    f       b/d
  gg

Whichever two characters are in the four signal code (dgbe) but not the two digit code (bd)
are either bb or dd.
dgbe (4) - bd (1) = ge, thus g = bb OR dd and e = bb OR dd

  aa          c
b    c   g/e     b/d
b    c   g/e     b/d
  dd         g/e
e    f           b/d
e    f           b/d
  gg

Whichever of b or d in the 6 digit codes (0,6,9) is in two out of the three = cc
Whichever of b or d in the 6 digit codes (0,6,9) is in three out of three = ff

gfecab       b
dcefab       bd
ecgadb       bd 

  aa          c
b    c   g/e     d
b    c   g/e     d
  dd         g/e
e    f           b
e    f           b
  gg

Now we know three signals

of the 5 signal codes (2,3,5) we identify 2 by the code that contains d but not b
From 2, whichever of g or e that exists = dd , therefore the other = bb

afcdg   -- This is 2, g exists, so g = dd and e = bb
bcaeg
agcbd

   aa         c
bb    cc   e     d
bb    cc   e     d
   dd         g
ee    ff         b
ee    ff         b
   gg

Now we know 5 signals

5 digits = 2,3,5
6 digits = 0,6,9

Whichever of the 6 digit codes has all of the signals we know and one more signal, 
that code is 9. 

gfecab
dcefab
ecgadb -- We know b,c,d,e,g, so this is 9

The signal we don't know is a, so a = gg.
There's now only one signal left, ee, so f must = ee

   aa         c
bb    cc   e     d
bb    cc   e     d
   dd         g
ee    ff   f     b
ee    ff   f     b
   gg         a
