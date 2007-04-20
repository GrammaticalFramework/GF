module Eval where

import AbsSrc
import AbsTgt
import SMacros
import TMacros
import Match
import Env

import STM


eval :: Exp -> STM Env Val
eval e = case e of
  EAbs x b -> do
    addVar x ---- adds new VArg i
    eval b
  EApp _ _ -> do
    let (f,xs) = apps e
    xs' <- mapM eval xs
    case f of
      ECon c -> do
        v <- lookEnv values c
        return $ appVal v xs'  
      EOpr c -> do
        e <- lookEnv opers c
        v <- eval e           ---- not possible in general
        return $ appVal v xs'
  ECon c -> lookEnv values c
  EOpr c -> lookEnv opers c >>= eval ---- not possible in general
  EVar x -> lookEnv vars x
  ECst _ _ -> lookEnv parvals e
  EStr s -> return $ VTok s
  ECat x y -> do
    x' <- eval x
    y' <- eval y
    return $ VCat x' y'
  ERec fs -> do
    vs <- mapM eval [e | FExp _ e <- fs]
    return $ VRec vs

  ETab ty cs -> do
--    sz <- lookEnv parsizes ty
--    let ps = map (VPar . toInteger) [0..sz-1]
    ps <- lookEnv partypes ty
    vs <- mapM (\p -> match cs p >>= eval) ps
    return $ VRec vs
   
  ESel t v -> do
    t' <- eval t
    v' <- eval v
    ---- pattern match first
    return $ compVal [] $ VPro t' v' ---- []

  EPro t v@(Lab _ i) -> do
    t' <- eval t
    return $ compVal [] $ VPro t' (VPar i)
