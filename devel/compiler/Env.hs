module Env where

import AbsSrc
import AbsTgt

import STM
import qualified Data.Map as M

data Env = Env {
  values   :: M.Map Ident Val,
  types    :: M.Map Ident Type,
  opers    :: M.Map Ident Exp,
  typedefs :: M.Map Ident Type,
  partypes :: M.Map Type  [Exp],
  parvals  :: M.Map Exp   Val,
  vars     :: M.Map Ident Val
---  constrs  :: M.Map Ident ([Int] -> Int)
  }

emptyEnv = Env M.empty M.empty M.empty M.empty M.empty M.empty M.empty

lookEnv :: (Show i, Ord i) => (Env -> M.Map i a) -> i -> STM Env a
lookEnv field c = do
  s <- readSTM 
  maybe (raise $ "unknown " ++ show c) return $ M.lookup c $ field s

addVal :: Ident -> Val -> STM Env ()
addVal c v = updateSTM (\env -> (env{values = M.insert c v (values env)}))

addType :: Ident -> Type -> STM Env ()
addType c v = updateSTM (\env -> (env{types = M.insert c v (types env)}))

addOper :: Ident -> Exp -> STM Env ()
addOper c v = updateSTM (\env -> (env{opers = M.insert c v (opers env)}))

addTypedef :: Ident -> Type -> STM Env ()
addTypedef c v = updateSTM (\env -> (env{typedefs = M.insert c v (typedefs env)}))

addPartype :: Type -> [Exp] -> STM Env ()
addPartype c v = updateSTM (\env -> (env{partypes = M.insert c v (partypes env)}))

addParVal :: Exp -> Val -> STM Env ()
addParVal c v = updateSTM (\env -> (env{parvals = M.insert c v (parvals env)}))

---addEnv :: (Env -> M.Map Ident a) -> Ident -> a -> STM Env ()
---addEnv field c v = updateSTM (\env -> (env{field = M.insert c v (field env)},()))

addVar :: Ident -> STM Env ()
addVar x = do
  s <- readSTM
  let i = M.size $ vars s
  updateSTM (\env -> (env{vars = M.insert x (VArg $ toInteger i) (vars env)}))
