module Main where

import GF.Embed.EmbedAPI
import System (getArgs)

main :: IO () 
main = do
  file:_ <- getArgs
  gr <- file2grammar file
  interact (translate gr)

translate :: MultiGrammar -> String -> String
translate gr = unlines . map transLine . lines where
  transLine s =
    let (lang,tree:_):_ = parseAllLang gr (startCat gr) s
    in unlines [linearize gr lg tree | lg <- languages gr, lg /= lang]      
