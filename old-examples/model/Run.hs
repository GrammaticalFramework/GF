module Main where

import GSyntax
import GF.Embed.EmbedAPI

main :: IO () 
main = do
  gr <- file2grammar "math.gfcm"
  loop gr

loop :: MultiGrammar -> IO ()
loop gr = do
  s <- getLine
  interpret gr s
  loop gr

interpret :: MultiGrammar -> String -> IO ()
interpret gr s = do
  let tss = parseAll gr "Prop" s
  case (concat tss) of
    [] ->  putStrLn "no parse"
    t:_ -> print $ answer $ fg t

answer :: GProp -> Bool
answer p = case p of
  (GOdd x1) -> odd (value x1)
  (GEven x1) -> even (value x1)
  (GAnd x1 x2) -> answer x1 && answer x2

value :: GElem -> Int
value e = case e of
  GZero -> 0

