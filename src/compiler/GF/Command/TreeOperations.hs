module GF.Command.TreeOperations (
  treeOp,
  allTreeOps,
  treeChunks
  ) where

import PGF(PGF,CId,compute,unApp,mkApp,exprSize,exprFunctions)
import PGF.Internal(Expr(..),unAppForm)
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
   ("largest",("sort trees from largest to smallest, in number of nodes",
      Left  $ largest)),
   ("nub",("remove duplicate trees",
      Left  $ nub)),
   ("smallest",("sort trees from smallest to largest, in number of nodes",
      Left  $ smallest)),
   ("subtrees",("return all fully applied subtrees (stopping at abstractions), by default sorted from the largest",
      Left  $ concatMap subtrees)),
   ("funs",("return all fun functions appearing in the tree, with duplications",
      Left  $ \es -> [mkApp f [] | e <- es, f <- exprFunctions e]))
  ]

largest :: [Expr] -> [Expr]
largest = reverse . smallest

smallest :: [Expr] -> [Expr]
smallest = sortBy (\t u -> compare (exprSize t) (exprSize u))

treeChunks :: Expr -> [Expr]
treeChunks = snd . cks where
  cks t = case unAppForm t of
    (EFun f, ts) -> case unzip (map cks ts) of 
       (bs,_) | and bs      -> (True, [t])
       (_,cts)              -> (False,concat cts)
    (EMeta _, ts)           -> (False,concatMap (snd . cks) ts)
    _                       -> (True, [t])

subtrees :: Expr -> [Expr]
subtrees t = t : case unApp t of
  Just (f,ts) -> concatMap subtrees ts
  _ -> []  -- don't go under abstractions

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

