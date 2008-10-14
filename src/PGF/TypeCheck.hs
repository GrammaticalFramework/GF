----------------------------------------------------------------------
-- |
-- Module      : TypeCheck
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- type checking in abstract syntax with dependent types.
--
-- modified from src GF TC
-----------------------------------------------------------------------------

module PGF.TypeCheck (
		   typecheck
		  ) where

import PGF.Data
import PGF.Macros (lookDef,isData)
import PGF.Expr
import PGF.AbsCompute
import PGF.CId

import GF.Data.ErrM
import qualified Data.Map as Map
import Control.Monad (liftM2)
import Data.List (partition,sort,groupBy)

import Debug.Trace

typecheck :: PGF -> Tree -> [Tree]
typecheck pgf t = case inferExpr pgf (tree2expr t) of
  Ok t  -> [expr2tree t]
  Bad s -> trace s []

inferExpr :: PGF -> Expr -> Err Expr
inferExpr pgf e = case infer pgf emptyTCEnv e of
  Ok (e,_,cs) -> let (ms,cs2) = splitConstraints cs in case cs2 of
    [] -> Ok (metaSubst ms e)
    _  -> Bad ("Error: " ++ prConstraints cs2)
  Bad s -> Bad s

infer :: PGF -> TCEnv -> Expr -> Err (Expr, Value, [(Value,Value)])
infer pgf tenv@(k,rho,gamma) e = case e of
   EVar x -> do
     ty <- lookupEVar pgf tenv x
     return (e,ty,[])

--   EInt i -> return (AInt i, valAbsInt, [])
--   EFloat i -> return (AFloat i, valAbsFloat, [])
--   K i -> return (AStr i, valAbsString, [])

   EApp f t -> do
    (f',w,csf) <- infer pgf tenv f 
    typ <- whnf w
    case typ of
      VClosure env (EPi x a b) -> do
        (a',csa) <- checkExp pgf tenv t (VClosure env a)
	b' <- whnf $ VClosure (eins x (VClosure rho t) env) b
	return $ (EApp f' a', b', csf ++ csa)
      _ -> Bad ("function type expected for function " ++ show f)
   _ -> Bad ("cannot infer type of expression" ++ show e)


checkExp :: PGF -> TCEnv -> Expr -> Value -> Err (Expr, [(Value,Value)])
checkExp pgf tenv@(k,rho,gamma) e ty = do
  typ <- whnf ty
  let v = VGen k
  case e of
    EMeta m -> return $ (e,[])
    EAbs x t -> case typ of
      VClosure env (EPi y a b) -> do
	a' <- whnf $ VClosure env a
	(t',cs) <- checkExp pgf (k+1,eins x v rho, eins x a' gamma) t 
                            (VClosure (eins y v env) b)
	return (EAbs x t', cs)
      _ -> Bad ("function type expected for " ++ show e)
    _ -> checkInferExp pgf tenv e typ

checkInferExp :: PGF -> TCEnv -> Expr -> Value -> Err (Expr, [(Value,Value)])
checkInferExp pgf tenv@(k,_,_) e typ = do
  (e',w,cs1) <- infer pgf tenv e
  cs2 <- eqValue k w typ
  return (e',cs1 ++ cs2)
      
lookupEVar :: PGF -> TCEnv -> CId -> Err Value
lookupEVar pgf (_,g,_) x = case Map.lookup x g of
  Just v -> return v
  _ -> maybe (Bad "var not found") (return . VClosure eempty . type2expr . fst) $ 
         Map.lookup x (funs (abstract pgf))

type2expr :: Type -> Expr
type2expr (DTyp hyps cat es) = 
  foldr (uncurry EPi) (foldl EApp (EVar cat) es) [(x, type2expr t) | Hyp x t <- hyps]

type TCEnv = (Int,Env,Env)

eempty = Map.empty
eins = Map.insert

emptyTCEnv :: TCEnv
emptyTCEnv = (0,eempty,eempty)

whnf :: Value -> Err Value
whnf v = case v of
  VApp u w -> do
    u' <- whnf u 
    w' <- whnf w
    return $ apply u' w'
  VClosure env e -> return $ eval env e
  _ -> return v

eqValue :: Int -> Value -> Value -> Err [(Value,Value)]
eqValue k u1 u2 = do
  w1 <- whnf u1
  w2 <- whnf u2 
  let v = VGen k
  case (w1,w2) of
    (VApp f1 a1, VApp f2 a2) -> liftM2 (++) (eqValue k f1 f2) (eqValue k a1 a2)
    (VClosure env1 (EAbs x1 e1), VClosure env2 (EAbs x2 e2)) ->
      eqValue (k+1) (VClosure (eins x1 v env1) e1) (VClosure (eins x2 v env2) e2)
    (VClosure env1 (EPi x1 a1 b1), VClosure env2 (EPi x2 a2 b2)) ->
      liftM2 (++) 
        (eqValue k     (VClosure env1 a1) (VClosure env2 a2))
        (eqValue (k+1) (VClosure (eins x1 v env1) b1) (VClosure (eins x2 v env2) b2))
    (VGen i, VGen j) -> return [(w1,w2) | i /= j]
    (VVar i, VVar j) -> return [(w1,w2) | i /= j] 
    _ -> return [(w1,w2) | w1 /= w2]
-- invariant: constraints are in whnf


-- this is not given in Expr
prValue = showExpr . value2expr

value2expr v = case v of
  VApp v u -> EApp (value2expr v) (value2expr u)
  VVar x -> EVar x
  VMeta i -> EMeta i
  VClosure g e -> e ----
  VLit l -> ELit l

prConstraints :: [(Value,Value)] -> String
prConstraints cs = unwords 
  ["(" ++ prValue v ++ " <> " ++ prValue w ++ ")" | (v,w) <- cs]

-- work more on this: unification, compute,...

splitConstraints :: [(Value,Value)] -> ([(Int,Expr)],[(Value,Value)])
splitConstraints = mkSplit . partition isSubst . regroup . map reorder where
  reorder (v,w) = case w of
    VMeta _ -> (w,v)
    _ -> (v,w)

  regroup = groupBy (\x y -> fst x == fst y) . sort

  isSubst cs@((v,u):_) = case v of
    VMeta _ -> all ((==u) . snd) cs
    _ -> False
  mkSplit (ms,cs) = ([(i,value2expr v) | (VMeta i,v):_ <- ms], concat cs)

metaSubst :: [(Int,Expr)] -> Expr -> Expr
metaSubst vs exp = case exp of
  EApp u v  -> EApp (subst u) (subst v)
  EMeta i   -> maybe exp id $ lookup i vs
  EPi x a b -> EPi x (subst a) (subst b)
  EAbs x b  -> EAbs x (subst b)
  _ -> exp
 where
  subst = metaSubst vs

