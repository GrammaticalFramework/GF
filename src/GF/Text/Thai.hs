----------------------------------------------------------------------
-- |
-- Module      : Thai
-- Maintainer  : (Maintainer)
-- Stability   : (experimental)
-- Portability : (portable)
--
--
-- Thai transliteration and other alphabet information.
-----------------------------------------------------------------------------

-- AR 27/12/2006. Execute test2 to see the transliteration table.

module GF.Text.Thai (mkThai) where

import qualified Data.Map as Map
import Data.Char

-- for testing
import GF.Text.UTF8 
import Data.List


mkThai :: String -> String
mkThai = concat . map mkThaiWord . words

type ThaiChar = Char

mkThaiWord :: String -> [ThaiChar]
mkThaiWord = map (toEnum . mkThaiChar) . unchar

mkThaiChar :: String -> Int
mkThaiChar c = maybe 0 id $ Map.lookup c thaiMap

thaiMap :: Map.Map String Int
thaiMap = Map.fromList $ zip allThaiTrans allThaiCodes

-- convert all string literals in a text

thaiStrings :: String -> String
thaiStrings s = case s of
  '"':cs -> let (t,_:r) = span (/='"') cs in
            '"':mkThai t ++ "\"" ++ thaiStrings r
  c:cs -> c:thaiStrings cs
  _ -> s


-- each character is either [letter] or [letter+nonletter]

unchar :: String -> [String]
unchar s = case s of
  c:d:cs 
   | isAlpha d -> [c]   : unchar (d:cs)
   | d == '?'  ->         unchar cs -- use "o?" to represent implicit 'o'
   | otherwise -> [c,d] : unchar cs
  [_]          -> [s]
  _            -> []

allThaiTrans :: [String]
allThaiTrans = words $
  "-  k  k1 -  k2 -  k3 g  c  c1 c2 s  c3 y  d  t  " ++
  "t1 t2 t3 n  d' t' t4 t5 t6 n  b  p  p1 f  p2 f' " ++
  "p3 m  y' r  -  l  -  w  s' r' s- h  l' O  h' -  " ++
  "a  a. a: a+ i  i: v  v: u  u: -  -  -  -  -  -  " ++
  "e  e: o: a% a& L  R  M  E  T  -  -  -  -  -  -  " ++
  "N0 N1 N2 N3 N4 N5 N6 N7 N8 N9 -  -  -  -  -  -  "


allThaiCodes :: [Int]
allThaiCodes = [0x0e00 .. 0x0e7f]


-- to test

test1 = testThai "k2wa:mrak"
test2 = putStrLn $ thaiTable
test3 = do
  writeFile  "thai.html" "<html><body><pre>"
  appendFile "thai.html" thaiTable
  appendFile "thai.html" "</pre></body></html>"


testThai :: String -> IO ()
testThai s = do
  putStrLn $ encodeUTF8 $ mkThai s
  putStrLn $ unwords $ map mkThaiPron $ words s

thaiFile :: FilePath -> Maybe FilePath -> IO ()
thaiFile f mo = do
  s <- readFile f
  let put = maybe putStr writeFile mo
  put $ encodeUTF8 $ thaiStrings s

mkThaiPron = concat . render . unchar where
  render s = case s of
    [c]  -> maybe c return (Map.lookup c thaiFinalMap): []
    c:cs -> pronThai c : render cs
    _ -> []

thaiFinalMap = Map.fromList $ zip allThaiTrans finals


thaiTable :: String
thaiTable = unlines [
  "\t" ++ 
  hex c ++ "\t" ++ 
  encodeUTF8 (showThai s) ++ "\t" ++ 
  s ++ "\t" ++ 
  pronThai s ++ "\t" ++
  [f] ++ "\t" ++
  [q] ++ "\t"
    |
      (c,q,f,s) <- zip4 allThaiCodes heights finals allThaiTrans
  ]

showThai s = case s of
  "-" -> "-"
---  v:_ | elem v "ivu" -> map (toEnum . mkThaiChar) ["O",s] 
  _   -> [toEnum $ mkThaiChar s]

pronThai s = case s of
  [c,p]
    | isUpper c && isDigit p -> [p]
    | isDigit p   -> c:"h"
    | p==':'      -> c:[c]
    | elem p "%&" -> c:"y"
    | p=='+'      -> c:"m"
    | otherwise   -> [c]
  [c] | isUpper c -> "" --- O
  _ -> s

hex = map hx . reverse . digs where
  digs 0 = [0]
  digs n = n `mod` 16 : digs (n `div` 16)
  hx d = "0123456789ABCDEF" !! d

heights :: String
finals  :: String
heights = 
  " MHHLLLLMHLLLLMMHLLLMMHLLLMMHHLLLLLL-L-LHHHHLML" ++ replicate 99 ' '
finals  = 
  " kkkkkkgt-tt-ntttttntttttnpp--pppmyn-n-wttt-n--" ++ replicate 99 ' '
