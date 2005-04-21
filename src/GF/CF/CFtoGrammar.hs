----------------------------------------------------------------------
-- |
-- Module      : CFtoGrammar
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:09 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.7 $
--
-- 26\/1\/2000 -- 18\/4 -- 24\/3\/2004
-----------------------------------------------------------------------------

module GF.CF.CFtoGrammar (cf2grammar) where

import GF.Infra.Ident
import GF.Grammar.Grammar
import qualified GF.Source.AbsGF as A
import qualified GF.Source.GrammarToSource as S
import GF.Grammar.Macros

import GF.CF.CF
import GF.CF.CFIdent
import GF.CF.PPrCF

import GF.Data.Operations

import Data.List (nub)
import Data.Char (isSpace)

cf2grammar :: CF -> [A.TopDef]
cf2grammar cf = concatMap S.trAnyDef (abs ++ conc) where
  rules = rulesOfCF cf
  abs   = cats ++ funs
  conc  = lintypes ++ lins
  cats  = [(cat, AbsCat (yes []) (yes [])) | 
             cat <- nub (concat (map cf2cat rules))] ----notPredef cat
  lintypes = [(cat, CncCat (yes defLinType) nope nope) | (cat,AbsCat _ _) <- cats]
  (funs,lins) = unzip (map cf2rule rules)

cf2cat :: CFRule -> [Ident]
cf2cat (_,(cat, items)) = map cfCat2Ident $ cat : [c | CFNonterm c <- items]

cf2rule :: CFRule -> ((Ident,Info),(Ident,Info))
cf2rule (fun, (cat, items)) = (def,ldef) where
 f     = cfFun2Ident fun
 def   = (f, AbsFun (yes (mkProd (args', Cn (cfCat2Ident cat), []))) nope)
 args0 = zip (map (mkIdent "x") [0..]) items
 args  = [(v, Cn (cfCat2Ident c)) | (v, CFNonterm c) <- args0]
 args' = [(zIdent "_", Cn (cfCat2Ident c)) | (_, CFNonterm c) <- args0]
 ldef  = (f, CncFun 
               Nothing 
               (yes (mkAbs (map fst args) 
                      (mkRecord (const theLinLabel) [foldconcat (map mkIt args0)])))
               nope)
 mkIt (v, CFNonterm _) = P (Vr v) theLinLabel
 mkIt (_, CFTerm (RegAlts [a])) = K a
 mkIt _ = K "" --- regexp not recognized in input CF ; use EBNF for this
 foldconcat [] = K ""
 foldconcat tt = foldr1 C tt

