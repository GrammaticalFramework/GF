module Eval where

import AbsSrc
import AbsTgt

import qualified Data.Map as M

eval :: Env -> Exp -> Val
eval env e = case e of
  ECon c -> look c
  EStr s -> VTok s
  ECat x y -> VCat (ev x) (ev y)
 where 
   look = lookCons env
   ev = eval env

data Env = Env {
  constants :: M.Map Ident Val
  }

lookCons :: Env -> Ident -> Val
lookCons env c = maybe undefined id $ M.lookup c $ constants env
