----------------------------------------------------------------------
-- |
-- Module      : Transfer
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:53 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.5 $
--
-- linearize, parse, etc, by transfer. AR 9\/10\/2003
-----------------------------------------------------------------------------

module GF.UseGrammar.Transfer where

import GF.Grammar.Grammar
import GF.Grammar.Values
import GF.Grammar.AbsCompute
import qualified GF.Canon.GFC as GFC
import GF.Grammar.LookAbs
import GF.Grammar.MMacros
import GF.Grammar.TypeCheck

import GF.Infra.Ident
import GF.Data.Operations

import Control.Monad

-- linearize, parse, etc, by transfer. AR 9/10/2003

doTransfer :: GFC.CanonGrammar -> Ident -> Tree -> Err Tree
doTransfer gr tra t = do
  cat <- liftM snd $ val2cat $ valTree t
  f   <- lookupTransfer gr tra cat
  e   <- compute gr $ App f $ tree2exp t
  annotate gr e

useByTransfer :: (Tree -> Err a) -> GFC.CanonGrammar -> Ident -> (Tree -> Err a)
useByTransfer lin gr tra t = doTransfer gr tra t >>= lin

mkByTransfer :: (a -> Err [Tree]) -> GFC.CanonGrammar -> Ident -> (a -> Err [Tree])
mkByTransfer parse gr tra s = parse s >>= mapM (doTransfer gr tra)
