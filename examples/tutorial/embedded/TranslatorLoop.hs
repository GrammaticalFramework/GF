module Main where

import GF.Embed.EmbedAPI
import System (getArgs)

main :: IO () 
main = do
  file:_ <- getArgs
  gr <- file2grammar file
  loop (translate gr)

loop :: (String -> String) -> IO ()
loop trans = do 
  s <- getLine
  if s == "quit" then putStrLn "bye" else do  
    putStrLn $ trans s
    loop trans

translate :: MultiGrammar -> String -> String
translate gr = unlines . map transLine . lines where
  transLine s = case parseAllLang gr (startCat gr) s of
    (lg,t:_):_ -> unlines [linearize gr l t | l <- languages gr, l /= lg]
    _ -> "NO PARSE"
