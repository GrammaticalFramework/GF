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

import Debug.Trace


mkThai :: String -> String
mkThai = concat . map mkThaiWord . words
mkThaiPron = unwords . map mkPronSyllable . words


type ThaiChar = Char

mkThaiWord :: String -> [ThaiChar]
mkThaiWord = map (toEnum . mkThaiChar) . unchar . snd . pronAndOrth

mkThaiChar :: String -> Int
mkThaiChar c = maybe 0 id $ Map.lookup c thaiMap

thaiMap :: Map.Map String Int
thaiMap = Map.fromList $ zip allThaiTrans allThaiCodes

-- convert all string literals in a text

thaiStrings :: String -> String
thaiStrings = convStrings mkThai

thaiPronStrings :: String -> String
thaiPronStrings = convStrings mkThaiPron

convStrings conv s = case s of
  '"':cs -> let (t,_:r) = span (/='"') cs in
            '"': conv t ++ "\"" ++ convStrings conv r
  c:cs -> c : convStrings conv cs
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
  "-  k  k1 -  k2 -  k3 g  c  c1 c2 s' c3 y' d' t' " ++
  "t1 t2 t3 n' d  t  t4 t5 t6 n  b  p  p1 f  p2 f' " ++
  "p3 m  y  r  -  l  -  w  s- r' s  h  l' O  h' -  " ++
  "a  a. a: a+ i  i: v  v: u  u: -  -  -  -  -  -  " ++
  "e  e' o: a% a& L  R  S  T1 T2 T3 T4 K  -  -  -  " ++
  "N0 N1 N2 N3 N4 N5 N6 N7 N8 N9 -  -  -  -  -  -  "

allThaiCodes :: [Int]
allThaiCodes = [0x0e00 .. 0x0e7f]


---------------------
-- heuristic pronunciation of codes
---------------------

-- this works for one syllable

mkPronSyllable s = pronSyllable $ getSyllable $ map mkThaiChar $ unchar s

data Syllable = Syll {
  initv   :: [Int],
  initc   :: [Int],
  midv    :: [Int],
  finalc  :: [Int],
  finalv  :: [Int],
  tone    :: [Int],
  shorten :: Bool,
  kill    :: Bool
  }
   deriving Show

data Tone = TMid | TLow | THigh | TRise | TFall
  deriving Show

data CClass = CLow | CMid | CHigh
  deriving Show

pronSyllable :: Syllable -> String
pronSyllable s = 
  initCons ++ tonem ++ vowel ++ finalCons
 where

  vowel = case (initv s, midv s, finalv s, shorten s, tone s) of
    ([0x0e40],[0x0e30,0x0e2d],_,_,_) -> "ö" -- eOa
    ([0x0e40],[0x0e30,0x0e32],_,_,_) -> "o" -- ea:a 
    (i,m,f,_,_) -> concatMap pronThaiChar (reverse $ f ++ m ++ i) ----

  initCons = concatMap pronThaiChar $ case (reverse $ initc s) of
    0x0e2b:cs@(_:_) -> cs -- high h
    0x0e2d:cs@(_:_) -> cs -- O
    cs -> cs

  finalCons =
    let (c,cs) = splitAt 1 $ finalc s
    in
    case c of
      [] -> []
      [k] -> concatMap pronThaiChar (reverse cs) ++ finalThai k

  iclass = case take 1 (reverse $ initc s) of
    [c] -> classThai c
    []  -> CMid -- O

  isLong = not (shorten s) && case vowel of
    _:_:_ -> True ----
    _ -> False

  isLive = case finalCons of
    c | elem c ["n","m","g"] -> True
    "" -> isLong
    _ -> False

  tonem = case (iclass,isLive,isLong,tone s) of
    (_,_,_,   [0x0e4a])    -> tHigh
    (_,_,_,   [0x0e4b])    -> tRise
    (CLow,_,_,[0x0e49])    -> tRise
    (_,_,_,   [0x0e49])    -> tFall
    (CLow,_,_,[0x0e48])    -> tFall
    (_,   _,_,[0x0e48])    -> tLow
    (CHigh,True,_,_)       -> tRise
    (_,    True,_,_)       -> tMid
    (CLow,False,False,_)   -> tHigh
    (CLow,False,_,_)       -> tFall
    _                      -> tLow

(tMid,tHigh,tLow,tRise,tFall) = ("-","'","`","~","^")

isVowel c = 0x0e30 <= c && c <= 0x0e44 ----
isCons c  = 0x0e01 <= c && c <= 0x0e2f ----
isTone c  = 0x0e48 <= c && c <= 0x0e4b

getSyllable :: [Int] -> Syllable
getSyllable = foldl get (Syll [] [] [] [] [] [] False False) where
  get syll c = case c of
    0x0e47 -> syll {shorten = True}
    0x0e4c -> syll {kill = True, finalc = tail (finalc syll)} --- always last
    0x0e2d 
      | null (initc syll) -> syll {initc = [c]}  -- "O"
      | otherwise -> syll {midv = c : midv syll}
    _ 
      | isVowel c -> if null (initc syll) 
                       then syll {initv = c : initv syll}
                       else syll {midv  = c : midv syll}
      | isCons c  -> if null (midv syll) 
                       then syll {initc  = c : initc syll}
                       else syll {finalc = c : finalc syll}
      | isTone c  -> syll {tone = [c]}
    _ -> syll ---- check this


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
  putStrLn $ unwords $ map mkPronSyllable $ words s

testSyllable s =
  let y = getSyllable $ map mkThaiChar $ unchar s 
  in
  putStrLn $ pronSyllable $ trace (show y) y

thaiFile :: FilePath -> Maybe FilePath -> IO ()
thaiFile f mo = do
  s <- readFile f
  let put = maybe putStr writeFile mo
  put $ encodeUTF8 $ thaiStrings s

thaiPronFile :: FilePath -> Maybe FilePath -> IO ()
thaiPronFile f mo = do
  s <- readFile f
  let put = maybe putStr writeFile mo
  put $ encodeUTF8 $ thaiPronStrings s

finalThai c = maybe "" return (Map.lookup c thaiFinalMap)
thaiFinalMap = Map.fromList $ zip allThaiCodes finals

classThai c = maybe CLow readClass (Map.lookup c thaiClassMap)
thaiClassMap = Map.fromList $ zip allThaiCodes heights

readClass s = case s of
  'L' -> CLow
  'M' -> CMid
  'H' -> CHigh


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
  "O"             -> "O"
  [c] | isUpper c -> "" 
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
