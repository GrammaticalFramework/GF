----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module ExtendedArabic where

mkArabic0600 :: String -> String
mkArabic0600 = digraphWordToUnicode . aarnesToDigraphWord

aarnesToDigraphWord :: String -> [(Char, Char)]
aarnesToDigraphWord str = case str of
  [] -> []
  '<' : cs -> ('\\', '<') : spoolMarkup2 cs

  'v' : cs -> ('T', 'H') : aarnesToDigraphWord cs
  'a' : cs -> (' ', 'A') : aarnesToDigraphWord cs
  'o' : cs -> (' ', '3') : aarnesToDigraphWord cs
  'O' : cs -> ('\'', 'i') : aarnesToDigraphWord cs

  'u' : cs -> ('\'', 'A') : aarnesToDigraphWord cs
  'C' : cs -> (' ', 'X') : aarnesToDigraphWord cs

  'U' : cs -> ('~', 'A') : aarnesToDigraphWord cs
  'A' : cs -> ('"', 't') : aarnesToDigraphWord cs
  'c' : cs -> ('s', 'h') : aarnesToDigraphWord cs
  c : cs -> (' ', c) : aarnesToDigraphWord cs

mkExtendedArabic :: String -> String
mkExtendedArabic = digraphWordToUnicode . adHocToDigraphWord

adHocToDigraphWord :: String -> [(Char, Char)]
adHocToDigraphWord str = case str of
  [] -> []
  '<' : cs -> ('\\', '<') : spoolMarkup cs
  -- Sorani 
  'W' : cs -> (':', 'w') : adHocToDigraphWord cs -- ?? Will do
  'E' : cs -> (' ', 'i') : adHocToDigraphWord cs -- ?? Letter missing!
  'j' : cs -> ('d', 'j') : adHocToDigraphWord cs
  'O' : cs -> ('v', 'w') : adHocToDigraphWord cs
  'F' : cs -> (' ', 'v') : adHocToDigraphWord cs
  'Z' : cs -> ('z', 'h') : adHocToDigraphWord cs
  'I' : cs -> (' ', 'i') : adHocToDigraphWord cs -- ?? Letter missing!
  'C' : cs -> ('c', 'h') : adHocToDigraphWord cs
  -- Pashto
  'e' : cs -> (':', 'y') : adHocToDigraphWord cs 
  '$' : cs -> ('3', 'H') : adHocToDigraphWord cs 
  'X' : cs -> ('s', '.') : adHocToDigraphWord cs
  'G' : cs -> ('z', '.') : adHocToDigraphWord cs
  'a' : cs -> (' ', 'A') : adHocToDigraphWord cs
  'P' : cs -> ('\'', 'H') : adHocToDigraphWord cs
  'R' : cs -> ('o', 'r') : adHocToDigraphWord cs 
   -- Shared
  'A' : cs -> (' ', 'h') : adHocToDigraphWord cs -- ?? Maybe to "t or 0x06d5
  'c' : cs -> ('s', 'h') : adHocToDigraphWord cs
  c : cs -> (' ', c) : adHocToDigraphWord cs


-- Beginning 0x621 up and including 0x06d1
digraphedExtendedArabic = " '~A'A'w,A'i A b\"t tTHdj H X dDH r z ssh S D T Z 3GH__________ - f q k l m n h w i y&a&w&i/a/w/i/W/o/~/'/,/|/6/v_____________#0#1#2#3#4#5#6#7#8#9#%#,#'#*>b>q$|> A2'2,3'A'w'w&y'Tb:b:BoT3b p4b4B'H:H2H\"H3Hch4HTdod.dTD:d:D3d3D4dTrvror.rvRz.:rzh4zs.+s*S:S3S3T33>ff.f: v4f.q3q-k~kok.k3k3K gog:g:G3Gvl.l3l3L:n>nTnon3n?h4H't>Y\"Yow-wvwww|w^w:w3w>y/yvy.w:y3y____ -ae"  

digraphWordToUnicode = map digraphToUnicode

digraphToUnicode :: (Char, Char) -> Char
digraphToUnicode (c1, c2) = case lookup (c1, c2) cc of Just c' -> c' ; _ -> c2  
 where 
   cc = zip allExtendedArabicCodes allExtendedArabic

allExtendedArabicCodes :: [(Char, Char)]
allExtendedArabicCodes = mkPairs digraphedExtendedArabic

allExtendedArabic :: String
allExtendedArabic = (map toEnum [0x0621 .. 0x06d1]) 

mkPairs :: String -> [(Char, Char)]
mkPairs str = case str of
  [] -> []
  c1 : c2 : cs -> (c1, c2) : mkPairs cs

spoolMarkup :: String -> [(Char, Char)]
spoolMarkup s = case s of
   [] -> [] -- Shouldn't happen
   '>' : cs -> ('\\', '>') : adHocToDigraphWord cs
   c1 : cs -> ('\\', c1) : spoolMarkup cs

spoolMarkup2 :: String -> [(Char, Char)]
spoolMarkup2 s = case s of
   [] -> [] -- Shouldn't happen
   '>' : cs -> ('\\', '>') : aarnesToDigraphWord cs
   c1 : cs -> ('\\', c1) : spoolMarkup2 cs