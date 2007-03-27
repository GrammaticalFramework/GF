module Compile where

import AbsSrc
import AbsTgt
import SMacros
import TMacros

import Eval
import Param

import STM
import Env

import qualified Data.Map as M

compile :: Grammar -> Env
compile (Gr defs) = err error snd $ appSTM (mapM_ compDef defs) emptyEnv

compDef :: Def -> STM Env ()
compDef d = case d of
  DLin f ty exp -> do
    val <- eval exp
    addType f ty
    addVal f val
  DOper f ty exp -> do
    addType f ty
    addOper f exp
  DPar  p cs -> do
    v <- sizeParType cs
    addTypedef p $ TVal $ toInteger $ fst v
    vals <- allParVals cs
    addPartype (TBas p) vals
    mapM_ (uncurry addParVal) (zip vals (map VPar [0..])) 
  DOpty a ty -> do
    addTypedef a ty
