module GF.Text.Transliterations (
  transliterate,
  transliterateWithFile,
  transliteration,
  characterTable,
  transliterationPrintNames
  ) where

import Data.Char
import Numeric
import qualified Data.Map as Map

-- transliterations between ASCII and a Unicode character set

-- current transliterations: devanagari, thai

-- to add a new one: define the Unicode range and the corresponding ASCII strings,
-- which may be one or more characters long

-- conventions to be followed: 
--   each character is either [letter] or [letter+nonletters]
--   when using a sparse range of unicodes, mark missing codes as "-" in transliterations
--   characters can be invisible: ignored in translation to unicode

transliterate :: String -> Maybe (String -> String)
transliterate s = case s of
  'f':'r':'o':'m':'_':t -> fmap appTransFromUnicode $ transliteration t
  't':'o':'_':t -> fmap appTransToUnicode $ transliteration t
  _ -> Nothing

transliterateWithFile :: String -> String -> Bool -> (String -> String)
transliterateWithFile name src isFrom =
  (if isFrom then appTransFromUnicode else appTransToUnicode) (getTransliterationFile name src)

transliteration :: String -> Maybe Transliteration
transliteration s = Map.lookup s allTransliterations 

allTransliterations = Map.fromList [
  ("amharic",transAmharic),
  ("ancientgreek", transAncientGreek),
  ("arabic", transArabic),
  ("arabic_unvocalized", transArabicUnvoc),
  ("devanagari", transDevanagari),
  ("greek", transGreek),
  ("hebrew", transHebrew),
  ("persian", transPersian),
  ("sanskrit", transSanskrit),
  ("sindhi", transSindhi),
  ("nepali", transNepali),
  ("telugu", transTelugu),
  ("thai", transThai),
  ("urdu", transUrdu)
 ]

-- used in command options and help
transliterationPrintNames = [(t,printname p) | (t,p) <- Map.toList allTransliterations]

characterTable :: Transliteration -> String
characterTable = unlines . map prOne . Map.assocs . trans_from_unicode where
  prOne (i,s) = unwords ["|", showHex i "", "|", [toEnum i], "|", s, "|"]

data Transliteration = Trans {
  trans_to_unicode   :: Map.Map String Int,
  trans_from_unicode :: Map.Map Int String,
  invisible_chars    :: [String],
  printname          :: String
  }

appTransToUnicode :: Transliteration -> String -> String
appTransToUnicode trans = 
  concat .
  map (\c -> maybe c (return . toEnum) $
             Map.lookup c (trans_to_unicode trans)
      ) . 
  filter (flip notElem (invisible_chars trans)) . 
  unchar

appTransFromUnicode :: Transliteration -> String -> String
appTransFromUnicode trans = 
  concat .
  map (\c -> maybe [toEnum c] id $ 
             Map.lookup c (trans_from_unicode trans)
      ) . 
  map fromEnum


mkTransliteration :: String -> [String] -> [Int] -> Transliteration
mkTransliteration name ts us = 
 Trans (Map.fromList (tzip ts us)) (Map.fromList (uzip us ts)) [] name
  where
    tzip ts us = [(t,u) | (t,u) <- zip ts us, t /= "-"]
    uzip us ts = [(u,t) | (u,t) <- zip us ts, t /= "-"]

getTransliterationFile :: String -> String -> Transliteration
getTransliterationFile name = uncurry (mkTransliteration name) . codes
 where
  codes = unzip . map (mkOne . words) . filter (not . all isSpace) . lines
  mkOne ws = case ws of
    [c]:t:_ -> (t,fromEnum c)  -- ä a:
    u:t:_   -> (t,read u)      -- 228 a: OR 0xe4
    _ -> error $ "not a valid transliteration:" ++ unwords ws

unchar :: String -> [String]
unchar s = case s of
  c:d:cs 
   | isAlpha d -> [c]    : unchar (d:cs)
   | isSpace d -> [c]:[d]: unchar cs
   | otherwise -> let (ds,cs2) = break (\x -> isAlpha x || isSpace x) cs in
                  (c:d:ds) : unchar cs2
  [_]          -> [s]
  _            -> []

transThai :: Transliteration
transThai = mkTransliteration "Thai" allTrans allCodes where
  allTrans = words $
    "-  k  k1 -  k2 -  k3 g  c  c1 c2 s' c3 y' d' t' " ++
    "t1 t2 t3 n' d  t  t4 t5 t6 n  b  p  p1 f  p2 f' " ++
    "p3 m  y  r  -  l  -  w  s- s. s  h  l' O  h' -  " ++
    "a. a  a: a+ i  i: v  v: u  u: -  -  -  -  -  -  " ++
    "e  e' o: a% a& L  R  S  T1 T2 T3 T4 K  -  -  -  " ++
    "N0 N1 N2 N3 N4 N5 N6 N7 N8 N9 -  -  -  -  -  -  "
  allCodes = [0x0e00 .. 0x0e7f]

transDevanagari :: Transliteration
transDevanagari = 
  (mkTransliteration "Devanagari" 
    allTransUrduHindi allCodes){invisible_chars = ["a"]} where
      allCodes = [0x0900 .. 0x095f] ++ [0x0966 .. 0x096f]

allTransUrduHindi = words $
    "-  n~ m. h.  -  A A: I I: U U: r.- l.-  -  -  E: " ++
    "E+ -  -  O: O+ k  k'  g  g'  n- c  c'  j  j'  n* T " ++
    "T' D D' N t  t'  d  d'  n  -  p  p'  b  b'  m  y  " ++
    "r  -  l  L  -  v  s*  S  s  h  -  -  X~ -  a:  i  " ++
    "i:  u  u:  r.  l.  -  -  e:  e+  -  -  o:  o+  X,  -  -  " ++
    "-  -  -  -  -  -  -  -  q  x  g.  z  R R'  f  -  " ++
    "N0 N1 N2 N3 N4 N5 N6 N7 N8 N9 "


transUrdu :: Transliteration
transUrdu = 
  (mkTransliteration "Urdu" allTrans allCodes) where
    allCodes = [0x0622 .. 0x062f] ++ [0x0630 .. 0x063a] ++ [0x0641,0x0642] ++ [0x06A9] ++ [0x0644 .. 0x0648] ++ 
               [0x0654,0x0658,0x0679,0x067e,0x0686,0x0688,0x0691,0x0698,0x06af,0x06c1,0x06c3,0x06cc,0x06ba,0x06be,0x06d2] ++
			   [0x06f0 .. 0x06f9] ++ [0x061f,0x06D4]
    allTrans = words $
      "A - w^ - y^ a b - t C j H K d " ++  -- 0622 - 062f
      "Z r z s X S Z- t- z- e G "   ++  -- 0630 - 063a
      "f q k l m n - w "    ++  -- 0641, 0642, 0643 - 0648
      "$ n- T p c D R x g h t: y N h' E " ++  -- 0654,658,679,67e,686,688,698,6af,6c1,6c3,6cc,6ba,6be,6d2
      "N0 N1 N2 N3 N4 N5 N6 N7 N8 N9 " ++ "? ."

transSindhi :: Transliteration
transSindhi = 
  (mkTransliteration "Sindhi" allTrans allCodes) where
    allCodes = [0x062e] ++ [0x0627 .. 0x062f] ++ [0x0630 .. 0x063a] ++ [0x0641 .. 0x0648] ++
               [0x067a,0x067b,0x067d,0x067e,0x067f] ++ [0x0680 .. 0x068f] ++
               [0x0699,0x0918,0x06a6,0x061d,0x06a9,0x06af,0x06b3,0x06bb,0x06be,0x06f6,0x064a,0x06b1, 0x06aa, 0x06fd, 0x06fe] ++
			   [0x06f0 .. 0x06f9] ++ [0x061f,0x06D4]
    allTrans = words $
      "K a b - t C j H - d " ++  -- 0626 - 062f
      "Z r z s X S Z- t- z- e G "   ++  -- 0630 - 063a
      "f q - L m n - W "    ++  -- 0641 - 0648
      "T! B T p T' " ++  -- 067a,067b,067d,067e,067f
      "B' - - Y' J' - c c' - - d! - d' D - D' " ++  -- 0680 - 068f
      "R - F' - k' g G' t' h' e' y c! k A M " ++  -- 0699, 0918, 06a6, 061d, 06a9,06af,06b3,06bb,06be,06f6,06cc,06b1 
      "N0 N1 N2 N3 N4 N5 N6 N7 N8 N9 " ++ "? ."

    

transArabic :: Transliteration
transArabic = mkTransliteration "Arabic" allTrans allCodes where
  allTrans = words $
    "   V  A: A? w? A- y? A  b  t. t  v  g  H  K  d " ++  -- 0621 - 062f
    "W  r  z  s  C S  D  T  Z  c  G "                 ++  -- 0630 - 063a
    "   f  q  k  l  m  n  h  w  y. y a. u. i. a  u "  ++  -- 0641 - 064f
    "i  v2 o  a: V+ V- i: a+ "                        ++  -- 0650 - 0657
    "A*  q?"                                              -- 0671 (used by AED) 
  allCodes = [0x0621..0x062f] ++ [0x0630..0x063a] ++ 
             [0x0641..0x064f] ++ [0x0650..0x0657] ++ [0x0671,0x061f]


transArabicUnvoc :: Transliteration
transArabicUnvoc = transArabic{
  invisible_chars = ["a","u","i","v2","o","V+","V-","a:"],
  printname = "unvocalized Arabic"
  }

transPersian :: Transliteration
transPersian = (mkTransliteration "Persian/Farsi" allTrans allCodes)
    {invisible_chars = ["a","u","i"]} where
  allTrans = words $
    "   V  A: A? w? A- y? A  b  t. t  t-  j  H  K  d " ++  -- 0621 - 062f
    "W  r  z  s  C  S  D  T  Z  c  G "                 ++  -- 0630 - 063a
    "   f  q  -  l  m  n  h  v  -  y. a. u. i. a  u "   ++  -- 0640 - 064f
    "i  v2 o  a: V+ V- i: a+ " ++                          -- 0650 - 0657 
    "p  c^ J  k  g  y q? Z0"
  allCodes = [0x0621..0x062f] ++ [0x0630..0x063a] ++ 
             [0x0641..0x064f] ++ [0x0650..0x0657] ++ 
             [0x067e,0x0686,0x0698,0x06a9,0x06af,0x06cc,0x061f,0x200c]

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


transHebrew :: Transliteration
transHebrew = mkTransliteration "unvocalized Hebrew" allTrans allCodes where
  allTrans = words $
    "A  b  g  d  h  w  z  H  T  y  K  k  l  M  m  N " ++
    "n  S  O  P  p  Z. Z  q  r  s  t  -  -  -  -  - " ++
    "w2 w3 y2 g1 g2"
  allCodes = [0x05d0..0x05f4]

transTelugu :: Transliteration
transTelugu = mkTransliteration "Telugu" allTrans allCodes where
  allTrans = words $
    "-  c1 c2 c3 -  A  A: I  I: U  U: R_ L_ -  E  E: " ++
    "A' -  O  O: A_ k  k. g  g. n. c  c. j  j. n' T  " ++
    "T. d  d. N  t  t. d  d. n  -  p  p. b  b. m  y  " ++
    "r  R  l  L  -  v  s' S  s  h  -  -  -  c5 a: i  " ++
    "i: u  u: r_ r. -  e  e: a' -  o  o: a_ c6 -  -  " ++
    "-  -  -  -  -  c7 c8 z  Z  -  -  -  -  -  -  -  " ++
    "R+ L+ l+ l* -  -  n0 n1 n2 n3 n4 n5 n6 n7 n8 n9 "
  allCodes = [0x0c00 .. 0x0c7f]

transGreek :: Transliteration
transGreek = mkTransliteration "modern Greek" allTrans allCodes where
  allTrans = words $
    "-  -  -  -  -  -  A' -  E' H' I' -  O' -  Y' W' " ++
    "i= A  B  G  D  E  Z  H  V  I  K  L  M  N  X  O  " ++
    "P  R  -  S  T  Y  F  C  Q  W  I- Y- a' e' h' i' " ++
    "y= a  b  g  d  e  z  h  v  i  k  l  m  n  x  o  " ++
    "p  r  s* s  t  y  f  c  q  w  i- y- o' y' w' -  "    
  allCodes = [0x0380 .. 0x03cf]

transAncientGreek :: Transliteration
transAncientGreek = mkTransliteration "ancient Greek" allTrans allCodes where
 allTrans = words $
--   "-  -  -  -  -  -  -  c: -  -  -  -  -  -  -  - " ++  -- standard code point for colon: 00B7
   "-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - " ++
   "i= A  B  G  D  E  Z  H  V  I  K  L  M  N  X  O  " ++
   "P  R  -  S  T  Y  F  C  Q  W  I- Y- -  -  -  -  " ++
   "y= a  b  g  d  e  z  h  v  i  k  l  m  n  x  o  " ++
   "p  r  s* s  t  y  f  c  q  w  i- y- -  -  -  -  " ++
   "a)  a(  a)` a(` a)' a(' a)~ a(~ A)  A(  A)` A(` A)' A(' A)~ A(~ " ++  -- 1f00-1f09,1f0a-1f0f
   "e)  e(  e)` e(` e)' e(' -   -   E)  E(  E)` E(` E)' E(' -   -   " ++
   "h)  h(  h)` h(` h)' h(' h)~ h(~ H)  H(  H)` H(` H)' H(' H)~ H(~ " ++
   "i)  i(  i)` i(` i)' i(' i)~ i(~ I)  I(  I)` I(` I)' I(' I)~ I(~ " ++
   "o)  o(  o)` o(` o)' o(' -   -   O)  O(  O)` O(` O)' O(' -   -   " ++
   "y)  y(  y)` y(` y)' y(' y)~ y(~ -   Y(  -   Y(` -   Y(' -   Y(~ " ++
   "w)  w(  w)` w(` w)' w(' w)~ w(~ W)  W(  W)` W(` W)' W(' W)~ W(~ " ++
   "a`  a'  e`  e'  h`  h'  i`  i'  o`  o'  y`  y'  w`  w'  -   -   " ++
   "a|) a|( a|)` a|(` a|)' a|(' a|)~ a|(~ - - - - - - - - " ++ -- 1f80-  
   "h|) h|( h|)` h|(` h|)' h|(' h|)~ h|(~ - - - - - - - - " ++ -- 1f90-  
   "w|) w|( w|)` w|(` w|)' w|(' w|)~ w|(~ - - - - - - - - " ++ -- 1fa0-  
   "a.  a_  a|` a|  a|'  -  a~ a|~ - - - - - - - - " ++ -- 1fb0-
   "-  -  h|` h|  h|'  -  h~ h|~ - - - - - - - - " ++ -- 1fc0-
   "i. i_ i=` i=' -    -  i~ i=~ - - - - - - - - " ++ -- 1fd0-
   "y. y_ y=` y=' r)   r( y~ y=~ - - - - - - - - " ++ -- 1fe0-   
   "-  -  w|` w|  w|'  -  w~ w|~ - - - - - - - - " ++ -- 1ff0-
   -- HL, Private Use Area Code Points (New Athena Unicode, Cardo, ALPHABETUM, Antioch)
   -- see: http://apagreekkeys.org/technicalDetails.html
   --      GreekKeys Support by Donald Mastronarde
   "- - - - - - - - - e. o. R) Y) Y)` Y)' Y)~ "    ++ -- e1a0-e1af  
   "e~ e)~ e(~ e_ e_' e_` e_) e_( e_)` e_(` e_)' e_(' E)~ E(~ E_ E. " ++ -- e1b0-e1bf
   "o~ o)~ o(~ o_ o_' o_` o_) o_( o_)` o_(` o_)' o_(' O)~ O(~ O_ O. " ++ -- e1c0-e1cf
   "a_` - a_~ a_)` a_(` a_)~ a_(~ - a.` a.) a.)` a.(' a.(` - - - "    ++ -- eaf0-eaff  
   "a_' - - - a_) a_( - a_)' - a_(' a.' a.( a.)' - - - "              ++ -- eb00-eb0f  
   "e_)~ e_(~ - - - - - e_~ - - - - - - - - "                         ++ -- eb20-eb2f
   "- - - - - - i_~ - i_` i_' - - i_) i_)' i_( i_(' "                 ++ -- eb30-eb3f   
   "i.' i.) i.)' i.( i.` i.)` - i.(' i.(` - - - - - - - "             ++ -- eb40-eb4f
   "- - - - i_)` i_(` - i_)~ i_(~ - o_~ o_)~ o_(~ - - - "             ++ -- eb50-eb5f
   "y_` " ++ -- eb6f
   "y_~ y_)` - - - y_(` - y_)~ y_(~ - y_' - - y_) y_( y_)' "  ++         -- eb70-eb7f
   "y_(' y.' y.( y.` y.) y.)' - - y.)` y.(' y.(` - - - - - "             -- eb80-eb8f
 allCodes =  -- [0x00B0 .. 0x00Bf] 
             [0x0380 .. 0x03cf] ++ [0x1f00 .. 0x1fff] 
          ++ [0xe1a0 .. 0xe1af] 
          ++ [0xe1b0 .. 0xe1bf]
          ++ [0xe1c0 .. 0xe1cf]
          ++ [0xeaf0 .. 0xeaff]
          ++ [0xeb00 .. 0xeb0f]
          ++ [0xeb20 .. 0xeb2f]
          ++ [0xeb30 .. 0xeb3f]
          ++ [0xeb40 .. 0xeb4f]
          ++ [0xeb50 .. 0xeb5f] ++ [0xeb6f]
          ++ [0xeb70 .. 0xeb7f]
          ++ [0xeb80 .. 0xeb8f]
 
transAmharic :: Transliteration
transAmharic = mkTransliteration "Amharic" allTrans allCodes where
 
allTrans = words $
    
  	" h.  h-  h'  h(  h)  h  h?  h*  l.  l-  l'  l(  l)  l  l?  l*  "++
	" H.  H-  H'  H(  H)  H  H?  H*  m.  m-  m'  m(  m)  m  m?  m*  "++
	" s.  s-  s'  s(  s)  s  s?  s*  r.  r-  r'  r(  r)  r  r?  r* "++
	" -   -   -   -   -  -   -  -   x.  x-  x'  x(  x)  x  x?   x* "++
	" q.  q-  q'  q(  q)  q  q?  q*  -   -   -   -   -   -  -   - "++
	" -   -   -   -   -   -  -   -   -   -   -   -   -   -  -   - "++
	" b.  b-  b'  b(  b)  b  b?  b*  v.  v-  v'  v(  v)  v  v?  v* "++
	" t.  t-  t'  t(  t)  t  t?  t*  c.  c-  c'  c(  c)  c  c?  c* "++
	" X.  X-  X'  X(  X)  X  X?  -   -   -   -   X*  -   -  -   - "++
	" n.  n-  n'  n(  n)  n  n?  n*  N.  N-  N'  N(  N)  N  N?  N* "++
	" a   u   i   A   E   e  o   e*  k.  k-  k'  k(  k)  k  k?  - "++
	" -   -   -   k*  -   -  -   -   -   -   -   -   -   -  -   - "++
	" -   -   -   -   -   -  -   -   w.  w-  w'  w(  w)  w  w?  w* "++
	" -   -   -   -   -   -  -   -   z.  z-  z'  z(  z)  z  z?  z* "++
	" Z.  Z-  Z'  Z(  Z)  Z  Z?  Z*  y.  y-  y'  y(  y)  y  y?  y* "++
	" d.  d-  d'  d(  d)  d  d?  d*  -   -   -   -   -   -  -   - "++
	" j.  j-  j'  j(  j)  j  j?  j*  g.  g-  g'  g(  g)  g  g?  - "++
	" -   -   -   g*  -   -  -   -   -   -   -   -   -   -  -   - "++
	" T.  T-  T'  T(  T)  T  T?  T*  C.  C-  C'  C(  C)  C  C?  C* "++
	" P.  P-  P'  P(  P)  P  P?  P*  S.  S-  S'  S(  S)  S  S?  S* "++
	" -   -   -   -   -   -  -   -   f.  f-  f'  f(  f)  f  f?  f*"++
	" p.  p-  p'  p(  p)  p  p?  p*" 	
allCodes = [0x1200..0x1357]
 
-- by Prasad 31/5/2013
transSanskrit :: Transliteration
transSanskrit = (mkTransliteration "Sanskrit" allTrans allCodes) {invisible_chars = ["a"]} where
  allTrans = words $
    "-  n~ m. h. - A A: I I: U U: R. L. - - E: " ++
    "E+ - O O: O+ k k' g g' n- c c' j j' n* T " ++
    "T' D D' N t t' d d' n - p p' b b' m y " ++
    "r - l L - v s* S s h - - - v- a: i " ++
    "i: u u: r. r.: - e e: e+ - o o: o+ a_ - - " ++
    "o~  -  -  -  -  - - -  q x G  z  R  R'  f  -  " ++
    "R.: L.: l. l.: p, p.  N0 N1 N2 N3 N4 N5 N6 N7 N8 N9 "
  allCodes = [0x0900 .. 0x097f]
