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

module Tamil where

mkTamil :: String -> String
mkTamil = digraphWordToUnicode . adHocToDigraphWord

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
  c1 : c2 : c3 : cs | c2 == c3 && isVowel c2 -> (' ', c1) : (c2, ':') : adHocToDigraphWord cs
  c1 : c2 : c3 : cs | isVowel c2 && isVowel c3 -> (' ', c1) : (c2, c3) : adHocToDigraphWord cs
  c1 : 'a' : cs -> (' ', c1) : adHocToDigraphWord cs -- a inherent
  c1 : c2 : cs | isVowel c2 -> (' ', c1) : (' ', c2) : adHocToDigraphWord cs  

  c1 : cs -> (' ', c1) : (' ', '.') : adHocToDigraphWord cs -- vowelless  

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
   cc = zip allTamilCodes allTamil

mkPairs :: String -> [(Char, Char)]
mkPairs str = case str of
  [] -> []
  c1 : c2 : cs -> (c1, c2) : mkPairs cs

allTamilCodes :: [(Char, Char)]
allTamilCodes = mkPairs digraphedTamil

allTamil :: String
allTamil = (map toEnum [0x0b85 .. 0x0bfa]) 

digraphedTamil = " AA: II: UU:______ EE:AI__ OO:AU k______ G c__ j__ ñ T______ N t______ V n p______ m y r l L M v__ s S h________a: ii: uu:______ ee:ai__ oo:au .__________________ :______________________________#1#2#3#4#5#6#7#8#9^1^2^3=d=m=y=d=c==ru##"

