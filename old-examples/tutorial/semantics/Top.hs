module Main where

import GSyntax
import SemBase
import Logic
import GF.GFCC.API

main :: IO ()
main = do
  gr <- file2grammar "base.gfcc"
  loop gr

loop :: MultiGrammar -> IO ()
loop gr = do
  s <- getLine
  let t:_ = parse gr "BaseEng" "S" s
  putStrLn $ showTree t
  let p = iS $ fg t
  putStrLn $ show p
  let v = valProp exModel [] p
  putStrLn $ show v
  loop gr

