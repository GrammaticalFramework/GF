----------------------------------------------------------------------
-- |
-- Module      : TypeCheck
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/15 16:22:02 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.16 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Compile.TypeCheck (-- * top-level type checking functions; TC should not be called directly.
		  checkContext,
		  checkTyp,
		  checkEquation,
		  checkConstrs,
		 ) where

import GF.Data.Operations

import GF.Grammar.Abstract
import GF.Grammar.Lookup
import GF.Grammar.Unify
import GF.Grammar.Printer
import GF.Compile.Refresh
import GF.Compile.AbsCompute
import GF.Compile.TC

import Control.Monad (foldM, liftM, liftM2)

-- | invariant way of creating TCEnv from context
initTCEnv gamma = 
  (length gamma,[(x,VGen i x) | ((x,_),i) <- zip gamma [0..]], gamma) 

-- interface to TC type checker

type2val :: Type -> Val
type2val = VClos []

cont2exp :: Context -> Exp
cont2exp c = mkProd (c, eType, []) -- to check a context

cont2val :: Context -> Val
cont2val = type2val . cont2exp

-- some top-level batch-mode checkers for the compiler

justTypeCheck :: Grammar -> Exp -> Val -> Err Constraints
justTypeCheck gr e v = do
  (_,constrs0) <- checkExp (grammar2theory gr) (initTCEnv []) e v
  (constrs1,_) <- unifyVal constrs0
  return $ filter notJustMeta constrs1

notJustMeta (c,k) = case (c,k) of
    (VClos g1 (Meta m1), VClos g2 (Meta m2)) -> False
    _ -> True

grammar2theory :: Grammar -> Theory
grammar2theory gr (m,f) = case lookupFunType gr m f of
  Ok t -> return $ type2val t
  Bad s -> case lookupCatContext gr m f of
    Ok cont -> return $ cont2val cont
    _ -> Bad s

checkContext :: Grammar -> Context -> [String]
checkContext st = checkTyp st . cont2exp

checkTyp :: Grammar -> Type -> [String]
checkTyp gr typ = err singleton prConstrs $ justTypeCheck gr typ vType

checkEquation :: Grammar -> Fun -> Term -> [String]
checkEquation gr (m,fun) def = err singleton prConstrs $ do
  typ  <- lookupFunType gr m fun
  cs   <- justTypeCheck gr def (vClos typ)
  return $ filter notJustMeta cs

checkConstrs :: Grammar -> Cat -> [Ident] -> [String]
checkConstrs gr cat _ = [] ---- check constructors!
