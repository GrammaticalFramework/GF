----------------------------------------------------------------------
-- |
-- Module      : Hiragana
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:38 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.5 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Text.Hiragana (mkJapanese) where

-- long vowel romaaji must be ei, ou not ee, oo  

mkJapanese :: String -> String
mkJapanese = digraphWordToUnicode . romaajiToDigraphWord

romaajiToDigraphWord :: String -> [(Char, Char)]
romaajiToDigraphWord str = case str of
  [] -> []
  '<' : cs -> ('\\', '<') : spoolMarkup cs 
  ' ' : cs -> ('\\', ' ') : romaajiToDigraphWord cs
  
  c1 : cs | isVowel c1 -> (' ', cap c1) : romaajiToDigraphWord cs

  -- The combinations
  c1 : 'y' : c2 : cs -> (c1, 'i') : ('y', cap c2) : romaajiToDigraphWord cs 

  's' : 'h' : 'a' : cs -> ('S', 'i') : ('y', 'A') : romaajiToDigraphWord cs
  'c' : 'h' : 'a' : cs -> ('C', 'i') : ('y', 'A') : romaajiToDigraphWord cs
  'j' : 'a' : cs -> ('j', 'i') : ('y', 'A') : romaajiToDigraphWord cs

  's' : 'h' : 'u' : cs -> ('S', 'i') : ('y', 'U') : romaajiToDigraphWord cs
  'c' : 'h' : 'u' : cs -> ('C', 'i') : ('y', 'U') : romaajiToDigraphWord cs
  'j' : 'u' : cs -> ('j', 'i') : ('y', 'U') : romaajiToDigraphWord cs

  's' : 'h' : 'o' : cs -> ('S', 'i') : ('y', 'O') : romaajiToDigraphWord cs
  'c' : 'h' : 'o' : cs -> ('C', 'i') : ('y', 'O') : romaajiToDigraphWord cs
  'j' : 'o' : cs -> ('j', 'i') : ('y', 'O') : romaajiToDigraphWord cs

  'd' : 'z' : c3 : cs -> ('D', c3) : romaajiToDigraphWord cs
  't' : 's' : c3 : cs -> ('T', c3) : romaajiToDigraphWord cs
  'c' : 'h' : c3 : cs -> ('C', c3) : romaajiToDigraphWord cs
  's' : 'h' : c3 : cs -> ('S', c3) : romaajiToDigraphWord cs
  'z' : 'h' : c3 : cs -> ('Z', c3) : romaajiToDigraphWord cs

  c1 : ' ' : cs -> (' ', c1) : ('\\', ' ') : romaajiToDigraphWord cs -- n
  c1 : [] -> [(' ', c1)] -- n
   
  c1 : c2 : cs | isVowel c2 -> (c1, c2) : romaajiToDigraphWord cs
  c1 : c2 : cs | c1 == c2 -> ('T', 'U') : romaajiToDigraphWord (c2 : cs) -- double cons
  c1 : cs -> (' ', c1) : romaajiToDigraphWord cs -- n
  
isVowel x = elem x "aeiou"
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
  '>' : cs -> ('\\', '>') : romaajiToDigraphWord cs  
  c1 : cs -> ('\\', c1) : spoolMarkup cs

digraphWordToUnicode :: [(Char, Char)] -> String
digraphWordToUnicode = map digraphToUnicode

digraphToUnicode :: (Char, Char) -> Char
digraphToUnicode (c1, c2) = case lookup (c1, c2) cc of Just c' -> c' ; _ -> c2 
 where 
   cc = zip allHiraganaCodes allHiragana

allHiraganaCodes :: [(Char, Char)]
allHiraganaCodes = mkPairs digraphedHiragana

allHiragana :: String
allHiragana = (map toEnum [0x3041 .. 0x309f]) 

mkPairs :: String -> [(Char, Char)]
mkPairs str = case str of
  [] -> []
  c1 : c2 : cs -> (c1, c2) : mkPairs cs

digraphedHiragana = " a A i I u U e E o OkagakigikugukegekogosazaSiZisuzusezesozotadaCijiTUTuDutedetodonaninunenohabapahibipihubupuhebepehobopomamimumemoyAyayUyuyOyorarirurerowaWawiwewo nvukAkE____<< o>>o  >'> b"


