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
		  checkDef,
		  checkConstrs,
		 ) where

import GF.Data.Operations

import GF.Infra.CheckM
import GF.Grammar.Abstract
import GF.Grammar.Lookup
import GF.Grammar.Unify
import GF.Grammar.Printer
import GF.Compile.Refresh
import GF.Compile.AbsCompute
import GF.Compile.TC

import Text.PrettyPrint
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

checkContext :: Grammar -> Context -> [Message]
checkContext st = checkTyp st . cont2exp

checkTyp :: Grammar -> Type -> [Message]
checkTyp gr typ = err (\x -> [text x]) ppConstrs $ justTypeCheck gr typ vType

checkDef :: Grammar -> Fun -> Type -> [Equation] -> [Message]
checkDef gr (m,fun) typ eqs = err (\x -> [text x]) ppConstrs $ do
  bcs <- mapM (\b -> checkBranch (grammar2theory gr) (initTCEnv []) b (type2val typ)) eqs
  let (bs,css) = unzip bcs
  (constrs,_) <- unifyVal (concat css)
  return $ filter notJustMeta constrs

checkConstrs :: Grammar -> Cat -> [Ident] -> [String]
checkConstrs gr cat _ = [] ---- check constructors!
