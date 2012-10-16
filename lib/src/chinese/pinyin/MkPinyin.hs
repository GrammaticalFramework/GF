import qualified Data.Map as Map
import Numeric

main = do
  s <- readFile pinyinFile
  let m = c2pMap (mkList (words s))
  mapM_ (mkPinyin m) ["Lexicon", "Numeral", "Res", "Structural"]
  return ()

pinyinFile = "pinyin.txt"

mkPinyin ma mo = do
  s <- readFile ("../" ++ runghc MkPinyin.hsmo ++ "Chi.gf")
  writeFile (mo ++ "Cmn.gf") (useMapGF ma s)


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
  'C':'h':'i':'n':cs -> "Chin" ++ useMapGF m cs  -- don't change Chinese, China
  'C':'h':'i'    :cs -> "Cmn"  ++ useMapGF m cs  -- to change language code Chi to Cmn
  '"':cs -> '"':convert cs
  c  :cs -> c  :useMapGF m cs
  _ -> s
 where
  convert cs = case cs of
    '"':s -> '"' : useMapGF m s
    c  :s -> maybe [c] (head . words) (Map.lookup [c] m) ++ convert s
    _ -> cs 

c2pMap ws = Map.fromList [(c,unwords ps) | (_,(c,ps)) <- ws]
