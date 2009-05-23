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
      map tree2expr . nub . concatMap (paraphrase pgf . expr2tree))),
   ("smallest",("sort trees from smallest to largest, in number of nodes",
      smallest)),
   ("typecheck",("type check and solve metavariables; reject if incorrect",
      concatMap (typecheck pgf)))
  ]

smallest :: [Expr] -> [Expr]
smallest = sortBy (\t u -> compare (size t) (size u)) where
  size t = case t of
    EAbs _ e -> size e + 1
    EApp e1 e2 -> size e1 + size e2 + 1
    _ -> 1

{-
toTree :: G.Term -> Tree
toTree t = case M.termForm t of
  Ok (xx,f,aa) -> Abs xx (Fun f (map toTree aa))

fromTree :: Tree -> G.Term
fromTree t = case t of
  Abs xx b -> M.mkAbs xx (fromTree b)
  Var x    -> M.vr x
  Fun f ts -> M.mkApp f (map fromTree ts)
-}

{-
data Tree = 
   Abs [CId] Tree                   -- ^ lambda abstraction. The list of variables is non-empty
 | Var CId                          -- ^ variable
 | Fun CId [Tree]                   -- ^ function application
 | Lit Literal                      -- ^ literal
 | Meta Int                         -- ^ meta variable

data Literal = 
   LStr String                      -- ^ string constant
 | LInt Integer                     -- ^ integer constant
 | LFlt Double                      -- ^ floating point constant

mkType :: A.Type -> C.Type
mkType t = case GM.typeForm t of
  Ok (hyps,(_,cat),args) -> C.DTyp (mkContext hyps) (i2i cat) (map mkExp args)

mkExp :: A.Term -> C.Expr
-}
