module GF.Canon.CanonToGFCC where

import GF.Devel.GrammarToGFCC
import GF.Devel.PrintGFCC
import GF.GFCC.CheckGFCC (checkGFCCmaybe)
import GF.GFCC.OptimizeGFCC
import GF.Canon.AbsGFC
import GF.Canon.GFC
import GF.Canon.CanonToGrammar
import GF.Canon.Subexpressions
import GF.Devel.PrintGFCC
import GF.Grammar.PrGrammar

import qualified GF.Infra.Modules as M
import GF.Infra.Option

import GF.Data.Operations
import GF.Text.UTF8

canon2gfccPr opts = printGFCC . canon2gfcc opts
canon2gfcc opts = source2gfcc opts . canon2source ----
canon2source = err error id . canon2sourceGrammar . unSubelimCanon

source2gfcc opts gf = 
  let 
    (abs,gfcc) = mkCanon2gfcc opts (gfcabs gf) gf
    gfcc1 = maybe undefined id $ checkGFCCmaybe gfcc
  in addParsers $ if oElem (iOpt "noopt") opts then gfcc1 else optGFCC gfcc1

gfcabs gfc = 
  prt $ head $ M.allConcretes gfc $ maybe (error "no abstract") id $ 
   M.greatestAbstract gfc

{-
-- this variant makes utf8 conversion; used in back ends
mkCanon2gfcc :: CanonGrammar -> D.GFCC
mkCanon2gfcc = 
-- canon2gfcc . reorder abs . utf8Conv . canon2canon abs
  optGFCC . canon2gfcc . reorder . utf8Conv . canon2canon . normalize

-- this variant makes no utf8 conversion; used in ShellState
mkCanon2gfccNoUTF8 :: CanonGrammar -> D.GFCC
mkCanon2gfccNoUTF8 = optGFCC . canon2gfcc . reorder . canon2canon . normalize
-}

