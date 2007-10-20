module Main where

import GSyntax
import AnswerBase
import GF.GFCC.API

main :: IO ()
main = do
  gr <- file2grammar "base.gfcc"
  loop gr

loop :: MultiGrammar -> IO ()
loop gr = do
  s <- getLine
  case parse gr "BaseEng" "Question" s of
    [] -> putStrLn "no parse"
    ts -> mapM_ answer ts
  loop gr
 where
   answer t = putStrLn $ linearize gr "BaseEng" $ gf $ question2answer $ fg t

