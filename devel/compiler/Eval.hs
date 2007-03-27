module Eval where

import AbsSrc
import AbsTgt
import SMacros
import TMacros

import ComposOp
import STM
import Env

eval :: Exp -> STM Env Val
eval e = case e of
  EAbs x b -> do
    addVar x ---- adds new VArg i
    eval b
  EApp _ _ -> do
    let (f,xs) = apps e
    xs' <- mapM eval xs
    case f of
      ECon c -> checks [
        do
        v <- lookEnv values c
        return $ appVal v xs'  
       ,
        do
        e <- lookEnv opers c
        v <- eval e
        return $ appVal v xs'
        ]
  ECon c -> lookEnv values c
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

  ETab cs -> do
    vs <- mapM eval [e | Cas _ e <- cs] ---- expand and pattern match
    return $ VRec vs
   

  ESel t v -> do
    t' <- eval t
    v' <- eval v
    ---- pattern match first
    return $ compVal [] $ VPro t' v' ---- []

  EPro t v -> do
    t' <- eval t
    ---- project first
    return $ VPro t' (VPar 666) ---- lookup label

