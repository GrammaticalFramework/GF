module Main where

import Numeric
import qualified Data.Map as Map
import System

-- AR 3/10/2012
-- Chinese unicode - character - pinyin conversions
-- character data from http://www.linguanaut.com/chinese_alphabet2.htm

main = do
  xs <- getArgs
  s <- readFile "pinyin.txt"
  let ws = mkList (words s)
  case xs of
    "c2p":_    -> interact (useMap (c2pMap ws))    -- Chinese char to Pinyin (all results)
    "p2c":_    -> interact (useMap (p2cMap ws))    -- Pinyin to Chinese char (all results)
    "c2u":_    -> interact (useMap (c2uMap ws))    -- Chinese char to Unicode hex
    "u2c":_    -> interact (useMap (u2cMap ws))    -- Unicode hex to Chinese char
    "c2pGF":_  -> interact (useMapGF (c2pMap ws))  -- char to pinyin (first result) in string literals (e.g. in GF files)
    "p2cTry":_ -> interact (tryUseMap (p2cMap ws)) -- pinyin to char, trying syllable with all tone marks

    _ -> mapM_ (putStrLn . printOne) ws

mkList ws = case ws of
  c:w:ws -> (head (map (flip Numeric.showHex "" . fromEnum) c), (c, chop w)) : mkList ws
  _ -> []

printOne (u,(c,ws)) = u ++ "\t" ++ c ++ "\t" ++ unwords ws

chop = words . map unslash
 where
  unslash '/' = ' '
  unslash c = c

useMap :: Map.Map String String -> String -> String
useMap = useMapWith words unwords (const "NONE")

tryUseMap :: Map.Map String String -> String -> String
tryUseMap m = unlines . map try . words where
  try w = unwords [c ++ " (" ++ w2 ++ ")" | w2 <- alts w, Just c <- [Map.lookup w2 m]]
  alts w = w : [w ++ show i | i <- [1 .. 4]]

useMapWith :: (String -> [String]) -> ([String] -> String) -> (String -> String) -> Map.Map String String -> String -> String
useMapWith ws uws deft m = uws . map (\w -> maybe (deft w) id (Map.lookup w m)) . ws

useMapGF m s = case s of
---  'C':'h':'i':'n':cs -> "Chin" ++ useMapGF m cs  -- don't change Chinese, China
---  'C':'h':'i'    :cs -> "Cmn"  ++ useMapGF m cs  -- to change language code Chi to Cmn
  '"':cs -> '"':convert cs
  c  :cs -> c  :useMapGF m cs
  _ -> s
 where
  convert cs = case cs of
    '"':s -> '"' : useMapGF m s
    c  :s -> maybe [c] (head . words) (Map.lookup [c] m) ++ convert s
    _ -> cs 

c2pMap ws = Map.fromList [(c,unwords ps) | (_,(c,ps)) <- ws]
p2cMap ws = Map.fromListWith (++) [(p,c) | (_,(c,ps)) <- ws, p <- ps] -- store all chars with the same pinyin
c2uMap ws = Map.fromList [(c,u)          | (u,(c,_))  <- ws]
u2cMap ws = Map.fromList [(u,c)          | (u,(c,_))  <- ws]


