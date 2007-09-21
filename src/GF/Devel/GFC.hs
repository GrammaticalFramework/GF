module Main where

import GF.Devel.Compile
import GF.Devel.GrammarToGFCC
import GF.Devel.UseIO
import GF.Infra.Option
---import GF.Devel.PrGrammar ---

import System


main = do
  xx <- getArgs
  let (opts,fs) = getOptions "-" xx
  case opts of
    _ | oElem (iOpt "help") opts -> putStrLn "usage: gfc (--make) FILES"
    _ | oElem (iOpt "-make") opts -> do
      gr <- batchCompile opts fs
      let name = justModuleName (last fs)
      let (abs,gc) = prGrammar2gfcc name gr
      let target = abs ++ ".gfcc"
      writeFile target gc
      putStrLn $ "wrote file " ++ target
    _ -> do
      mapM_ (batchCompile opts) (map return fs)
      putStrLn "Done."
