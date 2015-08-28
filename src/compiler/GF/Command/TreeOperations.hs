module GF.Command.TreeOperations (
  treeOp,
  allTreeOps,
  treeChunks
  ) where

import PGF(PGF,CId,compute,unApp,paraphrase)
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
   ("paraphrase",("paraphrase by using semantic definitions (def)",
      Left  $ nub . concatMap (paraphrase pgf))),
   ("largest",("sort trees from largest to smallest, in number of nodes",
      Left  $ largest)),
   ("nub",("remove duplicate trees",
      Left  $ nub)),
   ("smallest",("sort trees from smallest to largest, in number of nodes",
      Left  $ smallest)),
   ("subtrees",("return all fully applied subtrees (stopping at abstractions), by default sorted from the largest",
      Left  $ concatMap subtrees)),
   ("funs",("return all fun functions appearing in the tree, with duplications",
      Left  $ concatMap funNodes))
---   ("chunks",("return all chunks, i.e. maximal subtrees where the top node is not a metavariable",
---      Left  $ concatMap treeChunks)) --- a tree with ? head does not type check anyway AR 5/11/2013
  ]

largest :: [Expr] -> [Expr]
largest = reverse . smallest

smallest :: [Expr] -> [Expr]
smallest = sortBy (\t u -> compare (size t) (size u)) where
  size t = case t of
    EAbs _ _ e -> size e + 1
    EApp e1 e2 -> size e1 + size e2 + 1
    _ -> 1

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

funNodes :: Expr -> [Expr]
funNodes t = case t of
   EAbs _ _ e -> funNodes e
   EApp e1 e2 -> funNodes e1 ++ funNodes e2
   EFun _ -> [t]
   _ -> []  -- not literals, metas, etc

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

