module GF.Compile.API (batchCompile, compileToGFCC) where

import GF.Devel.Compile
import GF.Devel.GrammarToGFCC
import GF.GFCC.OptimizeGFCC
import GF.GFCC.CheckGFCC
import GF.GFCC.DataGFCC
import GF.Infra.Option
import GF.Devel.UseIO

-- | Compiles a number of source files and builds a 'GFCC' structure for them.
compileToGFCC :: Options -> [FilePath] -> IO GFCC
compileToGFCC opts fs = 
    do gr <- batchCompile opts fs
       let name = justModuleName (last fs)
       let (abs,gc0) = mkCanon2gfcc opts name gr
       gc1 <- checkGFCCio gc0
       let opt = if oElem (iOpt "noopt") opts then id else optGFCC
           par = if oElem (iOpt "noparse") opts then id else addParsers
       return (par (opt gc1))
