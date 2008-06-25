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
  let ltss = parseAllLang gr "Question" s
  case ltss of
    [] ->  putStrLn "no parse"
    (l,t:_):_ -> putStrLn $ linearize gr l $ gf $ answer $ fg t

answer :: GQuestion -> GAnswer
answer p = case p of
  GOdd x   -> test odd x
  GEven x  -> test even x
  GPrime x -> test prime x

value :: GObject -> Int
value e = case e of
  GNumber (GInt i) -> fromInteger i

test :: (Int -> Bool) -> GObject -> GAnswer
test f x = if f (value x) then GYes else GNo

prime :: Int -> Bool
prime = (< 8) ----
