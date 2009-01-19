----------------------------------------------------------------------
-- |
-- Module      : LookAbs
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/28 16:42:48 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.14 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Grammar.LookAbs (
		lookupFunType,
		lookupCatContext
	       ) where

import GF.Data.Operations
import GF.Grammar.Abstract
import GF.Infra.Ident

import GF.Infra.Modules

import Data.List (nub)
import Control.Monad

-- | this is needed at compile time
lookupFunType :: Grammar -> Ident -> Ident -> Err Type
lookupFunType gr m c = do
  mo <- lookupModule gr m
  info <- lookupIdentInfo mo c
  case info of
    AbsFun (Yes t) _  -> return t
    AnyInd _ n  -> lookupFunType gr n c
    _ -> prtBad "cannot find type of" c

-- | this is needed at compile time
lookupCatContext :: Grammar -> Ident -> Ident -> Err Context
lookupCatContext gr m c = do
  mo <- lookupModule gr m
  info <- lookupIdentInfo mo c
  case info of
    AbsCat (Yes co) _ -> return co
    AnyInd _ n        -> lookupCatContext gr n c
    _                 -> prtBad "unknown category" c
