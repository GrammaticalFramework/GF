{-
 -- layout for unicode Nepali format, based on
 -- http://mpp.org.np/index.php?option=com_docman&task=cat_view&gid=18&Itemid=63
 -- keys like /, {, }.. are replaced by ([x]:) letters
 -- http://jrgraphix.net/r/Unicode/0900-097F
-}
transNepali :: Transliteration
transNepali = mkTransliteration "Nepali" allTrans allCodes where
  allTrans = words $
    "z+  z= " ++ 
    "-  V  M  h: -  H  A  i: I: f  F  Z  -  -  -  e: " ++
    "E: -  -  O  W  k  K  g  G  n: C  c  j  J  Y  q  " ++
    "Q  x  X  N  t  T  d  D  n  -  p  P  b  B  m  y  " ++
    "r  -  l  L  -  v  S  z  s  h  -  -  ~  `  a  i  " ++
    "I  u  U  R  -  -  -  e  E  -  -  o  w  x: -  -  " ++
    "O: -  _  -  -  -  -  -  -  -  -  -  -  -  -  -  " ++
    "-  -  -  -  .  >  0  1  2  3  4  5  6  7  8  9  " ++
    "-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  "
  allCodes = [0x200c,0x200d] ++ [0x0900 .. 0x097f]

