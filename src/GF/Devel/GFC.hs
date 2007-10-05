module Main where

import GF.Devel.Compile
import GF.Devel.GrammarToGFCC
import GF.GFCC.OptimizeGFCC
import GF.GFCC.CheckGFCC
import GF.GFCC.DataGFCC
import GF.Devel.UseIO
import GF.Infra.Option

import System

main = do
  xx <- getArgs
  let (opts,fs) = getOptions "-" xx
  case opts of
    _ | oElem (iOpt "help") opts -> putStrLn "usage: gfc (--make) FILES"
    _ | oElem (iOpt "-make") opts -> do
      gr <- batchCompile opts fs
      let name = justModuleName (last fs)
      let (abs,gc0) = mkCanon2gfcc opts name gr
      gc1 <- check gc0
      let gc = if oElem (iOpt "noopt") opts then gc1 else optGFCC gc1
      let target = abs ++ ".gfcc"
      writeFile target (printGFCC gc)
      putStrLn $ "wrote file " ++ target
    _ -> do
      mapM_ (batchCompile opts) (map return fs)
      putStrLn "Done."

check gfcc = do
  (gc,b) <- checkGFCC gfcc
  putStrLn $ if b then "OK" else "Corrupted GFCC"
  return gc

