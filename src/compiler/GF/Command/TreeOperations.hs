module GF.Command.TreeOperations (
  treeOp,
  allTreeOps
  ) where

import PGF
import PGF.Data
import Data.List

type TreeOp = [Expr] -> [Expr]

treeOp :: PGF -> String -> Maybe (Either TreeOp (CId -> TreeOp))
treeOp pgf f = fmap snd $ lookup f $ allTreeOps pgf

allTreeOps :: PGF -> [(String,(String,Either TreeOp (CId -> TreeOp)))]
allTreeOps pgf = [
   ("compute",("compute by using semantic definitions (def)",
      Left  $ map (compute pgf))),
   ("transfer",("syntactic transfer by applying function, recursively in subtrees",
      Right $ \f -> map (transfer pgf f))),
   ("paraphrase",("paraphrase by using semantic definitions (def)",
      Left  $ nub . concatMap (paraphrase pgf))),
   ("smallest",("sort trees from smallest to largest, in number of nodes",
      Left  $ smallest))
  ]

smallest :: [Expr] -> [Expr]
smallest = sortBy (\t u -> compare (size t) (size u)) where
  size t = case t of
    EAbs _ _ e -> size e + 1
    EApp e1 e2 -> size e1 + size e2 + 1
    _ -> 1


--- simple-minded transfer; should use PGF.Expr.match

transfer :: PGF -> CId -> Expr -> Expr
transfer pgf f e = case transf e of
  v | v /= appf e -> v
  _ -> case e of
    EApp g a -> EApp (transfer pgf f g) (transfer pgf f a)
    _ -> e
 where
  appf = EApp (EFun f)
  transf = compute pgf . appf

