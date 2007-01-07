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
mkThaiWord = map (toEnum . mkThaiChar) . unchar . snd . pronAndOrth

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

-- you can prefix transliteration by irregular phonology in []

pronAndOrth :: String -> (Maybe String, String)
pronAndOrth s = case s of
  '[':cs -> case span (/=']') cs of
    (p,_:o) -> (Just p,o)
    _ -> (Nothing,s)
  _ -> (Nothing,s)

allThaiTrans :: [String]
allThaiTrans = words $
  "-  k  k1 -  k2 -  k3 g  c  c1 c2 s  c3 y  d  t  " ++
  "t1 t2 t3 n  d' t' t4 t5 t6 n  b  p  p1 f  p2 f' " ++
  "p3 m  y' r  -  l  -  w  s' r' s- h  l' O  h' -  " ++
  "a  a. a: a+ i  i: v  v: u  u: -  -  -  -  -  -  " ++
  "e  e' o: a% a& L  R  M  T1 T2 T3 T4 -  -  -  -  " ++
  "N0 N1 N2 N3 N4 N5 N6 N7 N8 N9 -  -  -  -  -  -  "


allThaiCodes :: [Int]
allThaiCodes = [0x0e00 .. 0x0e7f]


-- derive the pronunciation of a syllable

pronSyll :: [Int] -> String
pronSyll s = cons1 ++ voc ++ cons2 where
  voc = toned tone $ pronThaiChar vo

  cons1 = concatMap pronThaiChar co1 ----
  cons2 = mkThaiPron $ unwords $ map recodeThai co2 -- takes care of final ----

  (vo,cc@(co1,co2)) = case s of
    c:cs    | initVowel c -> (c,getCons cs)
    c1:c:c2 | internVowel c -> (c,([c1],getFinal c2))
    c1:0x0e2d:c2 -> (0x0e42,([c1],getFinal c2))
    c0:c1:c:c2 | cluster c0 c1 && internVowel c -> (c,([c0,c1],getFinal c2))
    c0:c1:0x0e2d:c2 | cluster c0 c1 -> (0x0e42,([c0,c1],getFinal c2))
    _ -> (0x0e42,getCons s) ---- "o"

  getCons cs = case cs of
    c0:c1:c2 | cluster c1 c1 -> ([c0,c1],getFinal c2)
    c:c2 -> ([c],getFinal c2)

  getFinal = snd . getToneFinal
  toneMark = fst . getToneFinal

  getToneFinal c = case c of
    [  _,0x0e4c] -> ([], []) -- killer
    [t,_,0x0e4c] -> ([t],[]) -- killer
    _ -> splitAt (length c - 1) c

  initVowel   c = 0x0e40 <= c && c <= 0x0e44
  internVowel c = 0x0e30 <= c && c <= 0x0e39

  cluster c0 c1 = 
       c0 == 0x0e2b -- h
    || c1 == 0x0e23 -- r
    || c1 == 0x0e25 -- l
    || c1 == 0x0e27 -- w

  classC = case co1 of
    _ -> "L" ----

  lengthV = case vo of
    _ -> False ----

  liveness = case co2 of
    _ -> False ----

  tone = case (classC,lengthV,liveness,toneMark) of
    _ -> ""

  toned t v = t ++ v ----

-- [0x0e00 .. 0x0e7f]


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

mkThaiPron s = case fst $ pronAndOrth s of
  Just p -> p
  _ -> concat $ render $ unchar s 
 where
  render s = case s of
    [c]  -> finalThai c : []
    c:cs -> pronThai c : render cs
    _ -> []

finalThai c = maybe c return (Map.lookup c thaiFinalMap)
thaiFinalMap = Map.fromList $ zip allThaiTrans finals

classThai c = maybe c return (Map.lookup c thaiClassMap)
thaiClassMap = Map.fromList $ zip allThaiTrans heights


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


pronThaiChar = pronThai . recodeThai
  
recodeThai c = allThaiTrans !! (c - 0x0e00)

pronThai s = case s of
  [c,p]
    | c == 'N' && isDigit p -> [p]
    | c == 'T' && isDigit p -> ['\'',p]
    | isDigit p   -> c:"h"
    | p==':'      -> c:[c]
    | elem p "%&" -> c:"y"
    | p=='+'      -> c:"m"
    | s == "e'"   -> "ä"
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
