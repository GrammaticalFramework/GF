module Main where

import GF.Devel.Compile
import GF.Devel.GrammarToGFCC
import GF.Canon.GFCC.CheckGFCC
import GF.Canon.GFCC.PrintGFCC
import GF.Canon.GFCC.DataGFCC
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
      let (abs,gc) = mkCanon2gfcc opts name gr

      if oElem (iOpt "check") opts then (check gc) else return ()

      let target = abs ++ ".gfcc"
      writeFile target (printTree gc)
      putStrLn $ "wrote file " ++ target
    _ -> do
      mapM_ (batchCompile opts) (map return fs)
      putStrLn "Done."

check gc = do
  let gfcc = mkGFCC gc
  b <- checkGFCC gfcc
  putStrLn $ if b then "OK" else "Corrupted GFCC"

