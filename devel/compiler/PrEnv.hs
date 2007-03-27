module PrEnv where

import Env

import AbsSrc
import AbsTgt

import qualified PrintSrc as S
import qualified PrintTgt as T

import qualified Data.Map as M

prEnv :: Env -> IO ()
prEnv env = do
  putStrLn "--# types"
  mapM_ putStrLn 
    [prs c ++ " : " ++ prs val | (c,val) <- M.toList $ types env]
  putStrLn "--# typedefs"
  mapM_ putStrLn 
    [prs c ++ " = " ++ prs val | (c,val) <- M.toList $ typedefs env]
  putStrLn "--# partypes"
  mapM_ putStrLn 
    [prs c ++ " = " ++ unwords (map prs val) | (c,val) <- M.toList $ partypes env]
  putStrLn "--# parvals"
  mapM_ putStrLn 
    [prs c ++ " = " ++ prt val | (c,val) <- M.toList $ parvals env]
  putStrLn "--# values"
  mapM_ putStrLn 
    [prs c ++ " = " ++ prt val | (c,val) <- M.toList $ values env]


prs :: (S.Print a) => a -> String
prs = S.printTree

prt :: (T.Print a) => a -> String
prt = T.printTree

{-
data Env = Env {
  values   :: M.Map Ident Val,
  types    :: M.Map Ident Type,
  opers    :: M.Map Ident Exp,
  typedefs :: M.Map Ident Type,
  partypes :: M.Map Type  [Exp],
  parvals  :: M.Map Exp   Val,
  vars     :: M.Map Ident Val
  }
-}
