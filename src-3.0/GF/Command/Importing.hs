module GF.Command.Importing (importGrammar, importSource) where

import PGF
import PGF.Data

import GF.Compile
import GF.Grammar.Grammar (SourceGrammar) -- for cc command
import GF.Infra.UseIO
import GF.Infra.Option
import GF.Data.ErrM

import Data.List (nubBy)
import System.FilePath

-- import a grammar in an environment where it extends an existing grammar
importGrammar :: MultiGrammar -> Options -> [FilePath] -> IO MultiGrammar
importGrammar mgr0 opts files =
  case takeExtensions (last files) of
    s | elem s [".gf",".gfo"] -> do
      res <- appIOE $ compileToGFCC opts files
      case res of
        Ok gfcc2 -> do let gfcc3 = unionGFCC (gfcc mgr0) gfcc2
                       return $ MultiGrammar gfcc3
        Bad msg  -> do putStrLn msg
                       return mgr0
    ".gfcc" -> do
      gfcc2 <- mapM file2gfcc files >>= return . foldl1 unionGFCC
      let gfcc3 = unionGFCC (gfcc mgr0) gfcc2
      return $ MultiGrammar gfcc3

importSource :: SourceGrammar -> Options -> [FilePath] -> IO SourceGrammar
importSource src0 opts files = do
  src <- appIOE $ batchCompile opts files
  case src of
    Ok gr -> return gr
    Bad msg -> do 
      putStrLn msg
      return src0
