module Ethiopic where

-- Ascii-Unicode decoding for Ethiopian
-- Copyright (c) Harald Hammarström 2003 under Gnu General Public License

mkEthiopic :: String -> String
mkEthiopic = digraphWordToUnicode . adHocToDigraphWord

-- mkEthiopic :: String -> String
-- mkEthiopic = reverse . unwords . (map (digraphWordToUnicode . adHocToDigraphWord)) . words
--- reverse : assumes everything's on same line

adHocToDigraphWord :: String -> [(Char, Int)]
adHocToDigraphWord str = case str of
  [] -> []
  '<' : cs -> ('<', -1) : spoolMarkup cs
  c1 : cs | isVowel c1 -> (')', vowelOrder c1) : adHocToDigraphWord cs
  -- c1 isn't a vowel
  c1 : cs | not (elem c1 allEthiopicCodes) -> (c1, -1) : adHocToDigraphWord cs
  c1 : c2 : cs | isVowel c2 -> (c1, vowelOrder c2) : adHocToDigraphWord cs
  c1 : cs -> (c1, 5) : adHocToDigraphWord cs 
  
spoolMarkup :: String -> [(Char, Int)]
spoolMarkup s = case s of
  -- [] -> [] -- Shouldn't happen
  '>' : cs -> ('>', -1) : adHocToDigraphWord cs  
  c1 : cs -> (c1, -1) : spoolMarkup cs
    
isVowel x = elem x "AäuiïaeoI"

vowelOrder :: Char -> Int
vowelOrder x = case x of 
  'A' -> 0
  'ä' -> 0
  'u' -> 1
  'i' -> 2
  'a' -> 3
  'e' -> 4
  'I' -> 5
  'ï' -> 5
  'o' -> 6
  c   -> 5 -- vowelless 

digraphWordToUnicode = map digraphToUnicode

digraphToUnicode :: (Char, Int) -> Char
-- digraphToUnicode (c1, c2) = c1
 
digraphToUnicode (c1, -1) = c1 
digraphToUnicode (c1, c2) = toEnum (0x1200 + c2 + 8*case lookup c1 cc of Just c' -> c') 
    where 
      cc = zip allEthiopicCodes allEthiopic

allEthiopic :: [Int]
allEthiopic = [0 .. 44] -- x 8

allEthiopicCodes = "hlHmLrs$KQ__bBtcxXnN)kW__w(zZyd_jgG_TCPSLfp"

-- Q = kW, X = xW, W = kW, G = gW  

