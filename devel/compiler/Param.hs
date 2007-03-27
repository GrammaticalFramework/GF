module Param where

import AbsSrc
import SMacros

import Env
import STM

sizeParType :: [Constr] -> STM Env (Int,Int)
sizeParType cs = do
  scs <- mapM sizeC cs
  return (sum scs, length cs)
 where
  sizeC (Con c ts) = do
    ats <- mapM lookParTypeSize ts
    return $ product ats

lookParTypeSize :: Type -> STM Env Int
lookParTypeSize ty = case ty of
  TBas c -> do
    ty' <- lookEnv typedefs c
    lookParTypeSize ty'
  TVal i -> return $ fromInteger i

allParVals :: [Constr] -> STM Env [Exp]
allParVals cs = do
  ess <- mapM alls cs
  return $ concat ess
 where
  alls (Con c []) = do
    return [constr c []]
  alls (Con c ts) = do
    ess <- mapM (lookEnv partypes) ts
    return [constr c es | es <- sequence ess]
