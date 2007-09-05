module Main where

import GF.Embed.EmbedAPI
import TransferDef (transfer)

main :: IO () 
main = do
  gr <- file2grammar "math.gfcm"
  loop (translate transfer gr)

loop :: (String -> String) -> IO ()
loop trans = do 
  s <- getLine
  if s == "quit" then putStrLn "bye" else do  
    putStrLn $ trans s
    loop trans

translate :: (Tree -> Tree) -> MultiGrammar -> String -> String
translate tr gr = unlines . map transLine . lines where
  transLine s = case parseAllLang gr (startCat gr) s of
    (lg,t:_):_ -> linearize gr lg (tr t)
    _ -> "NO PARSE"

