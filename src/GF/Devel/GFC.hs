module Main where

import GF.Devel.Compile
import GF.Devel.GrammarToGFCC
import GF.Devel.GFCCtoJS
import GF.GFCC.OptimizeGFCC
import GF.GFCC.CheckGFCC
import GF.GFCC.DataGFCC
import GF.GFCC.ParGFCC
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
      if oElem (iOpt "js") opts 
        then do
          let js = abs ++ ".js"
          writeFile js (gfcc2js gc)
          putStrLn $ "wrote file " ++ js
        else return ()

    -- gfc -o target.gfcc source_1.gfcc ... source_n.gfcc
    _ | all ((=="gfcc") . fileSuffix) fs && oElem (iOpt "o") opts -> do
      let target:sources = fs
      gfccs <- mapM file2gfcc sources
      let gfcc = foldl1 unionGFCC gfccs
      writeFile target (printGFCC gfcc)
      
    _ -> do
      mapM_ (batchCompile opts) (map return fs)
      putStrLn "Done."

check gfcc = do
  (gc,b) <- checkGFCC gfcc
  putStrLn $ if b then "OK" else "Corrupted GFCC"
  return gc

file2gfcc f =
  readFileIf f >>= err (error) (return . mkGFCC) . pGrammar . myLexer
