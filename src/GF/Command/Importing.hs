module GF.Command.Importing (importGrammar) where

import GF.Devel.Compile
import GF.Devel.GrammarToGFCC
import GF.GFCC.OptimizeGFCC
import GF.GFCC.CheckGFCC
import GF.GFCC.DataGFCC
import GF.GFCC.ParGFCC
import GF.GFCC.API
import qualified GF.Command.AbsGFShell as C

import GF.Devel.UseIO
import GF.Infra.Option

import Data.List (nubBy)

-- import a grammar in an environment where it extends an existing grammar
importGrammar :: MultiGrammar -> Options -> [FilePath] -> IO MultiGrammar
importGrammar mgr0 opts files = do
  gfcc2 <- case fileSuffix (last files) of
    s | elem s ["gf","gfo"] -> do
      gr <- batchCompile opts files
      let name = justModuleName (last files)
      let (abs,gfcc0) = mkCanon2gfcc opts name gr
      gfcc1 <- checkGFCCio gfcc0
      return $ if oElem (iOpt "noopt") opts then gfcc1 else optGFCC gfcc1
    "gfcc" -> 
      mapM file2gfcc files >>= return . foldl1 unionGFCC
  let gfcc3 = unionGFCC (gfcc mgr0) gfcc2
  return $ MultiGrammar gfcc3 
     (nubBy (\ (x,_) (y,_) -> x == y) (gfcc2parsers gfcc3 ++ parsers mgr0)) 
     -- later coming parsers override
