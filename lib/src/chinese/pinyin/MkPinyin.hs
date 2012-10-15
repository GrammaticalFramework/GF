import qualified Data.Map as Map
import Pinyin (c2pMap, useMapGF, mkList)

main = do
  s <- readFile pinyinFile
  let m = c2pMap (mkList (words s))
  mapM_ (mkPinyin m) ["Lexicon", "Numeral", "Res", "Structural"]
  return ()

pinyinFile = "../pinyin.txt"

mkPinyin ma mo = do
  s <- readFile (mo ++ "Chi.gf")
  writeFile (mo ++ "Cmn.gf") (useMapGF ma s)

