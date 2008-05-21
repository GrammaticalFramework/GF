----------------------------------------------------------------------
-- |
-- Module      : Statistics
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/04 11:45:38 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.1 $
--
-- statistics on canonical grammar: amounts of generated code
-- AR 4\/9\/2005.
-- uses canonical grammar
-----------------------------------------------------------------------------

module GF.UseGrammar.Statistics (prStatistics) where

import GF.Infra.Modules
import GF.Infra.Option
import GF.Grammar.PrGrammar
import GF.Canon.GFC
import GF.Canon.MkGFC

import GF.Data.Operations

import Data.List (sortBy)

-- | the top level function
prStatistics :: CanonGrammar -> String
prStatistics can = unlines $ [
  show (length mods)  ++ "\t\t modules",
  show chars ++ "\t\t gfc size",
  "",
  "Top 40 definitions"
  ] ++
  [show d ++ "\t\t " ++ f | (d,f) <- tops]
 where
   tops = take 40 $ reverse $ sortBy (\ (i,_) (j,_) -> compare i j) defs
   defs = [(length (prt (info2def j)), name m j) | (m,j) <- infos]
   infos = [(m,j) | (m,ModMod mo) <- mods, j <- tree2list (jments mo)]
   name m (f,_) = prt m ++ "." ++ prt f
   mods = modules can
   chars = length $ prCanon can
