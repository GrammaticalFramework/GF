module GF.Command.TreeOperations (
  treeOp,
  allTreeOps
  --typeCheck,
  ) where

import GF.Compile.TypeCheck
import PGF (compute,paraphrase)

-- for conversions
import PGF.Data
--import GF.Compile.GrammarToGFCC (mkType,mkExp)
import qualified GF.Grammar.Grammar as G
import qualified GF.Grammar.Macros as M

import Data.List

type TreeOp = [Tree] -> [Tree]

treeOp :: PGF -> String -> Maybe TreeOp
treeOp pgf f = fmap snd $ lookup f $ allTreeOps pgf

allTreeOps :: PGF -> [(String,(String,TreeOp))]
allTreeOps pgf = [
   ("compute",("compute by using semantic definitions (def)",
      map (compute pgf))),
   ("paraphrase",("paraphrase by using semantic definitions (def)",
      concatMap (paraphrase pgf))),
   ("smallest",("sort trees from smallest to largest, in number of nodes",
      smallest)),
   ("typecheck",("type check and solve metavariables; reject if incorrect",
      id))
  ]

typeCheck :: PGF -> Tree -> (Tree,(Bool,[String]))
typeCheck pgf t = (t,(True,[]))

smallest :: [Tree] -> [Tree]
smallest = sortBy (\t u -> compare (size t) (size u)) where
  size t = case t of
    Abs _ b -> size b + 1
    Fun f ts -> sum (map size ts) + 1
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
