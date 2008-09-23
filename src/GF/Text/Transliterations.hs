module GF.Text.Transliterations (transliterate,transliteration,characterTable) where

import GF.Text.UTF8

import Data.Char
import Numeric
import qualified Data.Map as Map

-- transliterations between ASCII and a Unicode character set

-- current transliterations: devanagari, thai

-- to add a new one: define the Unicode range and the corresponding ASCII strings,
-- which may be one or two characters long

-- conventions to be followed: 
--   each character is either [letter] or [letter+nonletter]
--   when using a sparse range of unicodes, mark missing codes as "-" in transliterations
--   characters can be invisible: ignored in translation to unicode

transliterate :: String -> Maybe (String -> String)
transliterate s = case s of
  'f':'r':'o':'m':'_':t -> fmap appTransFromUnicode $ transliteration t
  't':'o':'_':t -> fmap appTransToUnicode $ transliteration t
  _ -> Nothing

transliteration :: String -> Maybe Transliteration
transliteration s = case s of
  "arabic" -> Just transArabic
  "devanagari" -> Just transDevanagari
  "telugu" -> Just transTelugu
  "thai" -> Just transThai
----  "urdu" -> Just transUrdu
  _ -> Nothing

characterTable :: Transliteration -> String
characterTable = unlines . map prOne . Map.assocs . trans_from_unicode where
  prOne (i,s) = unwords ["|", showHex i "", "|", [toEnum i], "|", s, "|"]

data Transliteration = Trans {
  trans_to_unicode   :: Map.Map String Int,
  trans_from_unicode :: Map.Map Int String,
  invisible_chars    :: [String]
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
  map (maybe "?" id . 
       flip Map.lookup (trans_from_unicode trans)
      ) . 
  map fromEnum


mkTransliteration :: [String] -> [Int] -> Transliteration
mkTransliteration ts us = Trans (Map.fromList (tzip ts us)) (Map.fromList (uzip us ts)) []
  where
    tzip ts us = [(t,u) | (t,u) <- zip ts us, t /= "-"]
    uzip us ts = [(u,t) | (u,t) <- zip us ts, t /= "-"]


unchar :: String -> [String]
unchar s = case s of
  c:d:cs 
   | isAlpha d -> [c]    : unchar (d:cs)
   | isSpace d -> [c]:[d]: unchar cs
   | otherwise -> [c,d]  : unchar cs
  [_]          -> [s]
  _            -> []

transThai :: Transliteration
transThai = mkTransliteration allTrans allCodes where
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
  (mkTransliteration allTransUrduHindi allCodes){invisible_chars = ["a"]} where
    allCodes = [0x0901 .. 0x094c]

allTransUrduHindi = words $
    "M  N  -  - " ++
    "a- A- i- I- u- U- R- -  -  -  e- E- -  -  o- O- " ++
    "k  K  g  G  N: c  C  j  J  n: t. T. d. D. n. t  " ++
    "T  d  D  n  -  p  P  b  B  m  y  r  -  l  -  -  v  " ++
    "S  s. s  h  -  -  r. -  A  i  I  u  U  R  -  -  " ++
    "-  e  E  o  O "

transUrdu :: Transliteration
transUrdu = 
  (mkTransliteration allTransUrduHindi allCodes){invisible_chars = ["a"]} where
    allCodes = [0x0901 .. 0x094c] ---- TODO: this is devanagari

transArabic :: Transliteration
transArabic = mkTransliteration allTrans allCodes where
  allTrans = words $
    "   V  A: A? w? A- y? A  b  t. t  v  g  H  K  d " ++  -- 0621 - 062f
    "W  r  z  s  C S  D  T  Z  c  G "                ++  -- 0630 - 063a
    "   f  q  k  l  m  n  h  w  y. y a. u. i. a  u " ++  -- 0641 - 064f
    "i  v2 o  a: V+ V- i: a+"                             -- 0650 - 0657 
  allCodes = [0x0621..0x062f] ++ [0x0630..0x063a] ++ 
             [0x0641..0x064f] ++ [0x0650..0x0657]

transTelugu :: Transliteration
transTelugu = mkTransliteration allTrans allCodes where
  allTrans = words $
    "-  c1 c2 c3 -  A  A: I  I: U  U: R_ L_ -  E  E: " ++
    "A' -  O  O: A_ k  k. g  g. n. c  c. j  j. n' T  " ++
    "T. d  d. N  t  t. d  d. n  -  p  p. b  b. m  y  " ++
    "r  R  l  L  -  v  s' S  s  h  -  -  -  c5 a: i  " ++
    "i: u  u: r_ r. -  e  e: a' -  o  o: a_ c6 -  -  " ++
    "-  -  -  -  -  c7 c8 z  Z  -  -  -  -  -  -  -  " ++
    "R+ L+ l+ l* -  -  n0 n1 n2 n3 n4 n5 n6 n7 n8 n9 "
  allCodes = [0x0c00 .. 0x0c7f]

