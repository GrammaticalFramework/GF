module GF.Command.TreeOperations (
  treeOp,
  allTreeOps
  --typeCheck,
  --compute
  ) where

import GF.Compile.TypeCheck
import GF.Compile.AbsCompute

-- for conversions
import PGF.Data
--import GF.Compile.GrammarToGFCC (mkType,mkExp)
import GF.Grammar.Grammar


type TreeOp = [Tree] -> [Tree]

treeOp :: String -> Maybe TreeOp
treeOp f = fmap snd $ lookup f allTreeOps

allTreeOps :: [(String,(String,TreeOp))]
allTreeOps = [
   ("compute",("compute by using semantic definitions (def)",
      id)),
   ("smallest",("sort trees from smallest to largest, in number of nodes",
      id)),
   ("typecheck",("type check and solve metavariables; reject if incorrect",
      id))
  ]

typeCheck :: PGF -> Tree -> (Tree,(Bool,[String]))
typeCheck pgf t = (t,(True,[]))

compute :: PGF -> Tree -> Tree
compute pgf t = t



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
