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
import PGF.CId

import GF.Data.ErrM
import qualified Data.Map as Map
import Control.Monad (liftM2)
import Data.List (partition,sort,groupBy)

import Debug.Trace

typecheck :: PGF -> Expr -> [Expr]
typecheck pgf e = case inferExpr pgf (newMetas e) of
  Ok e  -> [e]
  Bad s -> trace s []

inferExpr :: PGF -> Expr -> Err Expr
inferExpr pgf e = case infer pgf emptyTCEnv e of
  Ok (e,_,cs) -> let (ms,cs2) = splitConstraints cs in case cs2 of
    [] -> Ok (metaSubst ms e)
    _  -> Bad ("Error in tree " ++ showExpr e ++ " :\n  " ++ prConstraints cs2)
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
    (f',typ,csf) <- infer pgf tenv f 
    case typ of
      VClosure env (EPi x a b) -> do
        (a',csa) <- checkExp pgf tenv t (VClosure env a)
	let b' = eval (getFunEnv (abstract pgf)) (eins x (VClosure rho t) env) b
	return $ (EApp f' a', b', csf ++ csa)
      _ -> Bad ("function type expected for function " ++ show f)
   _ -> Bad ("cannot infer type of expression" ++ show e)


checkExp :: PGF -> TCEnv -> Expr -> Value -> Err (Expr, [(Value,Value)])
checkExp pgf tenv@(k,rho,gamma) e typ = do
  let v = VGen k []
  case e of
    EMeta m -> return $ (e,[])
    EAbs x t -> case typ of
      VClosure env (EPi y a b) -> do
	let a' = eval (getFunEnv (abstract pgf)) env a
	(t',cs) <- checkExp pgf (k+1,eins x v rho, eins x a' gamma) t 
                            (VClosure (eins y v env) b)
	return (EAbs x t', cs)
      _ -> Bad ("function type expected for " ++ show e)
    _ -> checkInferExp pgf tenv e typ

getFunEnv abs = Map.union (funs abs) (Map.map (\hypos -> (DTyp hypos cidType [],0,[])) (cats abs))
  where
    cidType = mkCId "Type"

checkInferExp :: PGF -> TCEnv -> Expr -> Value -> Err (Expr, [(Value,Value)])
checkInferExp pgf tenv@(k,_,_) e typ = do
  (e',w,cs1) <- infer pgf tenv e
  let cs2 = eqValue (getFunEnv (abstract pgf)) k w typ
  return (e',cs1 ++ cs2)
      
lookupEVar :: PGF -> TCEnv -> CId -> Err Value
lookupEVar pgf (_,g,_) x = case Map.lookup x g of
  Just v -> return v
  _ -> maybe (Bad "var not found") (return . VClosure eempty . type2expr . (\(a,b,c) -> a)) $ 
         Map.lookup x (funs (abstract pgf))

type2expr :: Type -> Expr
type2expr (DTyp hyps cat es) = 
  foldr (uncurry EPi) (foldl EApp (EVar cat) es) [(x, type2expr t) | Hyp x t <- hyps]

type TCEnv = (Int,Env,Env)

eempty = Map.empty
eins = Map.insert

emptyTCEnv :: TCEnv
emptyTCEnv = (0,eempty,eempty)


-- this is not given in Expr
prValue = showExpr . value2expr

value2expr v = case v of
  VApp f vs -> foldl EApp (EVar f) (map value2expr vs)
  VMeta i vs -> foldl EApp (EMeta i) (map value2expr vs)
  VClosure g e -> e ----
  VLit l -> ELit l

prConstraints :: [(Value,Value)] -> String
prConstraints cs = unwords 
  ["(" ++ prValue v ++ " <> " ++ prValue w ++ ")" | (v,w) <- cs]

-- work more on this: unification, compute,...

splitConstraints :: [(Value,Value)] -> ([(Int,Expr)],[(Value,Value)])
splitConstraints = mkSplit . partition isSubst . regroup . map reorder where
  reorder (v,w) = case w of
    VMeta _ _ -> (w,v)
    _ -> (v,w)

  regroup = groupBy (\x y -> fst x == fst y) . sort

  isSubst cs@((v,u):_) = case v of
    VMeta _ _ -> all ((==u) . snd) cs
    _ -> False
  mkSplit (ms,cs) = ([(i,value2expr v) | (VMeta i _,v):_ <- ms], concat cs)

metaSubst :: [(Int,Expr)] -> Expr -> Expr
metaSubst vs exp = case exp of
  EApp u v  -> EApp (subst u) (subst v)
  EMeta i   -> maybe exp id $ lookup i vs
  EPi x a b -> EPi x (subst a) (subst b)
  EAbs x b  -> EAbs x (subst b)
  _ -> exp
 where
  subst = metaSubst vs

--- use composOp and state monad...
newMetas :: Expr -> Expr
newMetas = fst . metas 0 where
  metas i exp = case exp of
    EAbs x e -> let (f,j) = metas i e in (EAbs x f, j)
    EApp f a -> let (g,j) = metas i f ; (b,k) = metas j a in (EApp g b,k)
    EMeta _  -> (EMeta i, i+1)
    _        -> (exp,i)
