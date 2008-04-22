module GF.Command.Importing (importGrammar) where

import GF.Compile.API
import GF.GFCC.DataGFCC
import GF.GFCC.API

import GF.Devel.UseIO
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
        Bad msg  -> do print msg
                       return mgr0
    ".gfcc" -> do
      gfcc2 <- mapM file2gfcc files >>= return . foldl1 unionGFCC
      let gfcc3 = unionGFCC (gfcc mgr0) gfcc2
      return $ MultiGrammar gfcc3