----------------------------------------------------------------------
-- |
-- Module      : Refresh
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:27 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- make variable names unique by adding an integer index to each
-----------------------------------------------------------------------------

module GF.Devel.Compile.Refresh (
  refreshModule,
  refreshTerm, 
  refreshTermN
  ) where

import GF.Devel.Grammar.Grammar
import GF.Devel.Grammar.Construct
import GF.Devel.Grammar.Macros
import GF.Infra.Ident

import GF.Data.Operations

import Control.Monad


-- for concrete and resource in grammar, before optimizing

refreshModule :: Int -> SourceModule -> Err (SourceModule,Int)
refreshModule k (m,mo) = do
  (mo',(_,k')) <- appSTM (termOpModule refresh mo) (initIdStateN k)
  return ((m,mo'),k')


refreshTerm :: Term -> Err Term
refreshTerm = refreshTermN 0

refreshTermN :: Int -> Term -> Err Term
refreshTermN i e = liftM snd $ refreshTermKN i e

refreshTermKN :: Int -> Term -> Err (Int,Term)
refreshTermKN i e = liftM (\ (t,(_,i)) -> (i,t)) $ 
                    appSTM (refresh e) (initIdStateN i)

refresh :: Term -> STM IdState Term
refresh e = case e of

  Vr x    -> liftM  Vr  (lookVar x)
  Abs x b -> liftM2 Abs (refVarPlus x)  (refresh b)

  Prod x a b -> do
    a'  <- refresh a
    x'  <- refVarPlus x
    b'  <- refresh b
    return $ Prod x' a' b'

  Let (x,(mt,a)) b -> do
    a'  <- refresh a
    mt' <- case mt of
             Just t -> refresh t >>= (return . Just) 
             _ -> return mt
    x'  <- refVar x
    b'  <- refresh b
    return (Let (x',(mt',a')) b')

  R r  -> liftM R $ refreshRecord r

  ExtR r s -> liftM2 ExtR (refresh r)  (refresh s)
  
  T i cc -> liftM2 T (refreshTInfo i) (mapM refreshCase cc)

  _ -> composOp refresh e

refreshCase :: (Patt,Term) -> STM IdState (Patt,Term)
refreshCase (p,t) = liftM2 (,) (refreshPatt p) (refresh t)

refreshPatt p = case p of
  PV x    -> liftM PV     (refVarPlus x)
  PC c ps -> liftM (PC c) (mapM refreshPatt ps)
  PP q c ps -> liftM (PP q c) (mapM refreshPatt ps)
  PR r    -> liftM PR     (mapPairsM refreshPatt r)
  PT t p' -> liftM2 PT    (refresh t) (refreshPatt p')

  PAs x p'   -> liftM2 PAs     (refVar x) (refreshPatt p')

  PSeq p' q' -> liftM2 PSeq    (refreshPatt p') (refreshPatt q')
  PAlt p' q' -> liftM2 PAlt    (refreshPatt p') (refreshPatt q')
  PRep p'    -> liftM  PRep    (refreshPatt p')
  PNeg p'    -> liftM  PNeg    (refreshPatt p')

  _ -> return p

refreshRecord r = case r of
  [] -> return r
  (x,(mt,a)):b -> do
    a'  <- refresh a
    mt' <- case mt of
             Just t -> refresh t >>= (return . Just) 
             _ -> return mt
    b'  <- refreshRecord b
    return $ (x,(mt',a')) : b'

refreshTInfo i = case i of
  TTyped t -> liftM TTyped $ refresh t
  TComp t -> liftM TComp $ refresh t
  TWild t -> liftM TWild $ refresh t
  _ -> return i

-- for abstract syntax

refreshEquation :: Equation -> Err ([Patt],Term)
refreshEquation pst = err Bad (return . fst) (appSTM (refr pst) initIdState) where
  refr (ps,t) = liftM2 (,) (mapM refreshPatt ps) (refresh t)

