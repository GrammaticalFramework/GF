module GF.Command.TreeOperations (
  treeOp,
  allTreeOps
  ) where

import GF.Compile.TypeCheck
import PGF

import Data.List

type TreeOp = [Expr] -> [Expr]

treeOp :: PGF -> String -> Maybe TreeOp
treeOp pgf f = fmap snd $ lookup f $ allTreeOps pgf

allTreeOps :: PGF -> [(String,(String,TreeOp))]
allTreeOps pgf = [
   ("compute",("compute by using semantic definitions (def)",
      map (compute pgf))),
   ("paraphrase",("paraphrase by using semantic definitions (def)",
      nub . concatMap (paraphrase pgf))),
   ("smallest",("sort trees from smallest to largest, in number of nodes",
      smallest))
  ]

smallest :: [Expr] -> [Expr]
smallest = sortBy (\t u -> compare (size t) (size u)) where
  size t = case t of
    EAbs _ e -> size e + 1
    EApp e1 e2 -> size e1 + size e2 + 1
    _ -> 1
