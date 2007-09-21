module Main where

import GF.Devel.Compile
import GF.Devel.GrammarToGFCC
import GF.Devel.UseIO
---import GF.Devel.PrGrammar ---

import System


main = do
  xx <- getArgs
  case xx of
    "-help":[] -> putStrLn "usage: gfc (--make) FILES"
    "--make":fs -> do
      gr <- batchCompile fs
      let name = justModuleName (last fs)
      let (abs,gc) = prGrammar2gfcc name gr
      let target = abs ++ ".gfcc"
      writeFile target gc
      putStrLn $ "wrote file " ++ target
    _ -> do
      mapM_ batchCompile (map return xx)
      putStrLn "Done."
