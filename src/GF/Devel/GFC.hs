module GF.Devel.GFC (mainGFC) where
-- module Main where

import GF.Devel.Compile
import GF.Devel.PrintGFCC
import GF.Devel.GrammarToGFCC
import GF.GFCC.OptimizeGFCC
import GF.GFCC.CheckGFCC
import GF.GFCC.DataGFCC
import GF.GFCC.Raw.ParGFCCRaw
import GF.GFCC.Raw.ConvertGFCC
import GF.Devel.UseIO
import GF.Infra.Option
import GF.GFCC.API
import GF.Data.ErrM

mainGFC :: [String] -> IO ()
mainGFC xx = do
  let (opts,fs) = getOptions "-" xx
  case opts of
    _ | oElem (iOpt "help") opts -> putStrLn usageMsg
    _ | oElem (iOpt "-make") opts -> do
      gr <- batchCompile opts fs
      let name = justModuleName (last fs)
      let (abs,gc0) = mkCanon2gfcc opts name gr
      gc1 <- checkGFCCio gc0
      let gc = addParsers $ if oElem (iOpt "noopt") opts then gc1 else optGFCC gc1
      let target = targetName opts abs
      let gfccFile =  target ++ ".gfcc"
      writeFile gfccFile (printGFCC gc)
      putStrLn $ "wrote file " ++ gfccFile
      mapM_ (alsoPrint opts target gc) printOptions

    -- gfc -o target.gfcc source_1.gfcc ... source_n.gfcc
    _ | all ((=="gfcc") . fileSuffix) fs -> do
      gfccs <- mapM file2gfcc fs
      let gfcc = foldl1 unionGFCC gfccs
      let abs = printCId $ absname gfcc
      let target = targetName opts abs
      let gfccFile =  target ++ ".gfcc"
      writeFile gfccFile (printGFCC gfcc)
      putStrLn $ "wrote file " ++ gfccFile
      mapM_ (alsoPrint opts target gfcc) printOptions
      
    _ -> do
      mapM_ (batchCompile opts) (map return fs)
      putStrLn "Done."

targetName opts abs = case getOptVal opts (aOpt "target") of
  Just n -> n
  _ -> abs

---- TODO: nicer and richer print options

alsoPrint opts abs gr (opt,name) = do
  if oElem (iOpt opt) opts 
    then do
      let outfile = name
      let output = prGFCC opt gr
      writeFile outfile output
      putStrLn $ "wrote file " ++ outfile
    else return ()

printOptions = [
  ("haskell","GSyntax.hs"),
  ("haskell_gadt","GSyntax.hs"),
  ("js","grammar.js"),
  ("jsref","grammarReference.js")
  ]

usageMsg = 
  "usage: gfc (-h | --make (-noopt) (-target=PREFIX) (-js | -jsref | -haskell | -haskell_gadt)) (-src) FILES"
