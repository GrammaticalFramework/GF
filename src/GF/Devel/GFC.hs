module Main where

import GF.Devel.Compile
import GF.Devel.GrammarToGFCC
---import GF.Devel.PrGrammar ---

import System


main = do
  xx <- getArgs
  case xx of
    "-help":[] -> putStrLn "usage: gfc (--make) FILES"
    "--make":fs -> do
      gr <- batchCompile fs
      --- putStrLn $ prGrammar gr
      writeFile "a.gfcc" $ prGrammar2gfcc gr
      putStrLn "Wrote file a.gfcc."
    _ -> do
      mapM_ batchCompile (map return xx)
      putStrLn "Done."
