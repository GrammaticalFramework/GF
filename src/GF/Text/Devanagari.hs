----------------------------------------------------------------------
-- |
-- Module      : Devanagari
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:14 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.4 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Devanagari (mkDevanagari) where

mkDevanagari :: String -> String
mkDevanagari = digraphWordToUnicode . adHocToDigraphWord

adHocToDigraphWord :: String -> [(Char, Char)]
adHocToDigraphWord str = case str of
  [] -> []
  '<' : cs -> ('\\', '<') : spoolMarkup cs 
  ' ' : cs -> ('\\', ' ') : adHocToDigraphWord cs -- skip space

-- if c1 is a vowel
  -- Two of the same vowel => lengthening 
  c1 : c2 : cs | c1 == c2 && isVowel c1 -> (cap c1, ':') : adHocToDigraphWord cs
  -- digraphed or long vowel
  c1 : c2 : cs | isVowel c1 && isVowel c2 -> (cap c1, cap c2) : adHocToDigraphWord cs
  c1 : cs | isVowel c1 -> (' ', cap c1) : adHocToDigraphWord cs

-- c1 isn't a vowel
  -- c1 : 'a' : [] -> [(' ', c1)] -- a inherent
  -- c1 : c2 : [] | isVowel c2 -> (' ', c1) : [(' ', c2)]

  -- c1 is aspirated
  c1 : 'H' : c2 : c3 : cs | c2 == c3 && isVowel c2 -> 
    (c1, 'H') : (c2, ':') : adHocToDigraphWord cs
  c1 : 'H' : c2 : c3 : cs | isVowel c2 && isVowel c3 -> 
    (c1, 'H') : (c2, c3) : adHocToDigraphWord cs
  c1 : 'H' : 'a' : cs -> (c1, 'H') : adHocToDigraphWord cs -- a inherent
  c1 : 'H' : c2 : cs | isVowel c2 -> (c1, 'H') : (' ', c2) : adHocToDigraphWord cs  
  -- not vowelless at EOW
  c1 : 'H' : ' ' : cs -> (c1, 'H') : ('\\', ' ')  : adHocToDigraphWord cs
  c1 : 'H' : [] -> [(c1, 'H')]
  c1 : 'H' : cs -> (c1, 'H') : (' ', '^') : adHocToDigraphWord cs -- vowelless

  -- c1 unasp.
  c1 : c2 : c3 : cs | c2 == c3 && isVowel c2 -> (' ', c1) : (c2, ':') : adHocToDigraphWord cs
  c1 : c2 : c3 : cs | isVowel c2 && isVowel c3 -> (' ', c1) : (c2, c3) : adHocToDigraphWord cs
  c1 : 'a' : cs -> (' ', c1) : adHocToDigraphWord cs -- a inherent
  c1 : c2 : cs | isVowel c2 -> (' ', c1) : (' ', c2) : adHocToDigraphWord cs  
  -- not vowelless at EOW
  c1 : ' ' : cs -> (' ', c1) : ('\\', ' '): adHocToDigraphWord cs
  c1 : [] -> [(' ', c1)]
  'M' : cs -> (' ', 'M') : adHocToDigraphWord cs -- vowelless but no vowelless sign for anusvara
  c1 : cs -> (' ', c1) : (' ', '^') : adHocToDigraphWord cs -- vowelless  

isVowel x = elem x "aeiou:"
cap :: Char -> Char
cap x = case x of 
  'a' -> 'A'
  'e' -> 'E'
  'i' -> 'I'
  'o' -> 'O'
  'u' -> 'U'
  c   -> c 

spoolMarkup :: String -> [(Char, Char)]
spoolMarkup s = case s of
  -- [] -> [] -- Shouldn't happen
  '>' : cs -> ('\\', '>') : adHocToDigraphWord cs  
  c1 : cs -> ('\\', c1) : spoolMarkup cs


digraphWordToUnicode :: [(Char, Char)] -> String
digraphWordToUnicode = map digraphToUnicode

digraphToUnicode :: (Char, Char) -> Char
digraphToUnicode (c1, c2) = case lookup (c1, c2) cc of Just c' -> c' ; _ -> c2 
 where 
   cc = zip allDevanagariCodes allDevanagari

digraphedDevanagari = " ~ M ;__ AA: II: UU:RoLoEvE~ EE:AvA~ OAU kkH ggHNG ccH jjH ñ TTH DDH N ttH ddH nn. ppH bbH m y rr. l LL. v ç S s h____ .-Sa: ii: uu:ror:eve~ eaiava~ oau ^____OM | -dddu______ Q X G zD.RH fy.R:L:mrmR#I#d#0#1#2#3#4#5#6#7#8#9#o" 

allDevanagariCodes :: [(Char, Char)]
allDevanagariCodes = mkPairs digraphedDevanagari

allDevanagari :: String
allDevanagari = (map toEnum [0x0901 .. 0x0970]) 

mkPairs :: String -> [(Char, Char)]
mkPairs str = case str of
  [] -> []
  c1 : c2 : cs -> (c1, c2) : mkPairs cs

