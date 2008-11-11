module Main where

import Base
import SemBase
import Logic
import PGF

main :: IO ()
main = do
  gr <- file2grammar "Base.pgf"
  loop gr

loop :: PGF -> IO ()
loop gr = do
  s <- getLine
  let t:_ = parse gr "BaseEng" "S" s
  putStrLn $ showTree t
  let p = iS $ fg t
  putStrLn $ show p
  let v = valProp exModel [] p
  putStrLn $ show v
  loop gr

