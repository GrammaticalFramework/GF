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
import GF.Data.Zipper

import GF.Grammar.Abstract
import GF.Compile.Refresh
import GF.Grammar.LookAbs
import qualified GF.Grammar.Lookup as Lookup ---
import GF.Grammar.Unify ---

import GF.Compile.TC

import Control.Monad (foldM, liftM, liftM2)
import Data.List (nub) ---

-- | invariant way of creating TCEnv from context
initTCEnv gamma = 
  (length gamma,[(x,VGen i x) | ((x,_),i) <- zip gamma [0..]], gamma) 

-- interface to TC type checker

type2val :: Type -> Val
type2val = VClos []

aexp2tree :: (AExp,[(Val,Val)]) -> Err Tree
aexp2tree (aexp,cs) = do
  (bi,at,vt,ts) <- treeForm aexp
  ts' <- mapM aexp2tree [(t,[]) | t <- ts]
  return $ Tr (N (bi,at,vt,(cs,[]),False),ts')
 where
  treeForm a = case a of
     AAbs x v b  -> do
       (bi, at, vt, args) <- treeForm b
       v' <- whnf v ---- should not be needed...
       return ((x,v') : bi, at, vt, args)
     AApp c a v -> do
       (_,at,_,args) <- treeForm c
       v' <- whnf v ---- 
       return ([],at,v',args ++ [a]) 
     AVr x v -> do
       v' <- whnf v ---- 
       return ([],AtV x,v',[])
     ACn c v -> do
       v' <- whnf v ---- 
       return ([],AtC c,v',[])
     AInt i -> do
       return ([],AtI i,valAbsInt,[])
     AFloat i -> do
       return ([],AtF i,valAbsFloat,[])
     AStr s -> do
       return ([],AtL s,valAbsString,[])
     AMeta m v -> do
       v' <- whnf v ---- 
       return ([],AtM m,v',[])
     _ -> Bad "illegal tree" -- AProd

cont2exp :: Context -> Exp
cont2exp c = mkProd (c, eType, []) -- to check a context

cont2val :: Context -> Val
cont2val = type2val . cont2exp

-- some top-level batch-mode checkers for the compiler

justTypeCheck :: Grammar -> Exp -> Val -> Err Constraints
justTypeCheck gr e v = do
  (_,constrs0) <- checkExp (grammar2theory gr) (initTCEnv []) e v
  return $ filter notJustMeta constrs0
----  return $ fst $ splitConstraintsSrc gr constrs0
---- this change was to force proper tc of abstract modules. 
---- May not be quite right. AR 13/9/2005 

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

checkEquation :: Grammar -> Fun -> Trm -> [String]
checkEquation gr (m,fun) def = err singleton id $ do
  typ  <- lookupFunType gr m fun
  cs   <- justTypeCheck gr def (vClos typ)
  let cs1 = filter notJustMeta cs
  return $ ifNull [] (singleton . prConstraints) cs1

checkConstrs :: Grammar -> Cat -> [Ident] -> [String]
checkConstrs gr cat _ = [] ---- check constructors!
