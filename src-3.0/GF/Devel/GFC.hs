module GF.Devel.GFC (mainGFC) where
-- module Main where

import GF.Compile
import GF.Devel.PrintGFCC
import GF.GFCC.CId
import GF.GFCC.DataGFCC
import GF.GFCC.Raw.ParGFCCRaw
import GF.GFCC.Raw.ConvertGFCC
import GF.Devel.UseIO
import GF.Infra.Option
import GF.GFCC.API
import GF.Data.ErrM

import System.FilePath

mainGFC :: [String] -> IO ()
mainGFC xx = do
  let (opts,fs) = getOptions "-" xx
  case opts of
    _ | oElem (iOpt "help") opts -> putStrLn usageMsg
    _ | oElem (iOpt "-make") opts -> do
      gfcc <- appIOE (compileToGFCC opts fs) >>= err fail return
      let gfccFile = targetNameGFCC opts (absname gfcc)
      outputFile gfccFile (printGFCC gfcc)
      mapM_ (alsoPrint opts gfcc) printOptions

    -- gfc -o target.gfcc source_1.gfcc ... source_n.gfcc
    _ | all ((==".gfcc") . takeExtensions) fs -> do
      gfccs <- mapM file2gfcc fs
      let gfcc = foldl1 unionGFCC gfccs
      let gfccFile = targetNameGFCC opts (absname gfcc)
      outputFile gfccFile (printGFCC gfcc)
      mapM_ (alsoPrint opts gfcc) printOptions
      
    _ -> do
      appIOE (mapM_ (batchCompile opts) (map return fs)) >>= err fail return
      putStrLn "Done."

targetName :: Options -> CId -> String
targetName opts abs = case getOptVal opts (aOpt "target") of
  Just n -> n
  _ -> prCId abs

targetNameGFCC :: Options -> CId -> FilePath
targetNameGFCC opts abs = targetName opts abs ++ ".gfcc"

---- TODO: nicer and richer print options

alsoPrint opts gr (opt,name) = do
  if oElem (iOpt opt) opts 
    then outputFile name (prGFCC opt gr)
    else return ()

outputFile :: FilePath -> String -> IO ()
outputFile outfile output = 
      do writeFile outfile output
         putStrLn $ "wrote file " ++ outfile

printOptions = [
  ("haskell","GSyntax.hs"),
  ("haskell_gadt","GSyntax.hs"),
  ("js","grammar.js")
  ]

usageMsg = 
  "usage: gfc (-h | --make (-noopt) (-noparse) (-target=PREFIX) (-js | -haskell | -haskell_gadt)) (-src) FILES"
