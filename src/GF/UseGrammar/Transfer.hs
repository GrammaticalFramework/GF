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
import GF.Grammar.Macros
import GF.Grammar.PrGrammar
import GF.Grammar.TypeCheck

import GF.Infra.Ident
import GF.Data.Operations

import qualified Transfer.Core.Abs as T

import Control.Monad


-- transfer is done in T.Exp - we only need these conversions.

exp2core :: Ident -> Exp -> T.Exp
exp2core f = T.EApp (T.EVar (var f)) . exp2c where
 exp2c e = case e of
  App f a -> T.EApp (exp2c f) (exp2c a)
  Abs x b -> T.EAbs (T.PVVar (var x)) (exp2c b) ---- should be syntactic abstr
  Q  _ c  -> T.EVar (var c)
  QC _ c  -> T.EVar (var c)
  K s     -> T.EStr s
  EInt i  -> T.EInteger $ toInteger i
  Meta m  -> T.EMeta (T.TMeta (prt m))   ---- which meta symbol?
  Vr x    -> T.EVar (var x)              ---- should be syntactic var

 var x = T.CIdent $ prt x

core2exp :: T.Exp -> Exp
core2exp e = case e of
  T.EApp f a -> App (core2exp f) (core2exp a)
  T.EAbs (T.PVVar x) b -> Abs (var x) (core2exp b) ---- only from syntactic abstr
  T.EVar c   -> Vr (var c)               -- GF annotates to Q or QC
  T.EStr s   -> K s
  T.EInteger i -> EInt $ fromInteger i
  T.EMeta _  -> uExp  -- meta symbol 0, refreshed by GF
 where
   var (T.CIdent x) = zIdent x



-- The following are now obsolete (30/11/2005)
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
