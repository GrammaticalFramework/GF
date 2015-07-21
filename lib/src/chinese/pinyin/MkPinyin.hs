import qualified Data.Map as Map
import Numeric
import System.Environment

main = do
  xx <- getArgs
  s <- readFile pinyinFile
  let m = c2pMap (mkList (words s))
  mapM_ (mkPinyin m) xx
  putStrLn $ unwords xx
  return ()

pinyinFile = "pinyin.txt"

resModules = [mo | mo <- 
                ["Extra","Lexicon", "Numeral", "Paradigms","Res", "Structural","Symbol", "Construction"]
             ]

mkPinyin ma mo = do
  s <- readFile ("../" ++ mo ++ "Chi.gf")
  writeFile ("tmp/" ++ mo ++ "Chi.gf") (useMapGF ma s)


--import Pinyin (c2pMap, useMapGF, mkList)


-- AR 3/10/2012
-- Chinese unicode - character - pinyin conversions
-- character data from http://www.linguanaut.com/chinese_alphabet2.htm


mkList ws = case ws of
  c:w:ws -> (head (map (flip Numeric.showHex "" . fromEnum) c), (c, chop w)) : mkList ws
  _ -> []

chop = words . map unslash
 where
  unslash '/' = ' '
  unslash c = c

useMapGF m s = case s of
---  'C':'h':'i':'n':cs -> "Chin" ++ useMapGF m cs  -- don't change Chinese, China
---  'C':'h':'i'    :cs -> "Cmn"  ++ useMapGF m cs  -- to change language code Chi to Cmn
  '"':cs -> '"':convert cs
  c  :cs -> c  :useMapGF m cs
  _ -> s
 where
  convert cs = case cs of
    '"':s -> '"' : useMapGF m s
    c  :s -> maybe [c] (tone2tone . head . words) (Map.lookup [c] m) ++ convert s
    _ -> cs 

c2pMap ws = Map.fromList [(c,unwords ps) | (_,(c,ps)) <- ws]

-- from numeric tones to diacritics
tone2tone :: String -> String
tone2tone = combine . change . analyse where
  analyse :: String -> [String] -- four parts: ch,a,ng,1
  analyse s = case reverse s of
    i:'r':    v:x | elem i "1234" -> [reverse x,[v],"r", [i]]
    i:'n':    v:x | elem i "1234" -> [reverse x,[v],"n", [i]]
    i:'g':'n':v:x | elem i "1234" -> [reverse x,[v],"ng",[i]]
    i:        v:x | elem i "1234" -> [reverse x,[v],"",  [i]]
    'r':      v:x                 -> [reverse x,[v],"r", []]
    'n':      v:x                 -> [reverse x,[v],"n", []]
    'g':'n':  v:x                 -> [reverse x,[v],"ng",[]]
    v          :x                 -> [reverse x,[v],"",  []]
    _                             -> error $ "illegal pinyin: " ++ s

  change ss@[x,[v],ng,i] = case i of
    [] -> ss
    _  -> [x,[accent v !! (read i - 1)],ng]

  combine = concat

  accent v = case v of
    'a' -> "āáǎà"
    'e' -> "ēéěè"
    'i' -> "īíǐì" 
    'o' -> "ōóǒò"
    'u' -> "ūúǔù"
    'ü' -> "ǖǘǚǜ"
    'v' -> "ǖǘǚǜ"
    _ -> error $ "no accents for " ++ [v]
