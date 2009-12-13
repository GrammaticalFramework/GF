module PGF.Tree 
         ( Tree(..),
           tree2expr, expr2tree,
           prTree
         ) where

import PGF.CId
import PGF.Expr hiding (Tree)

import Data.Char
import Data.List as List
import Control.Monad
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP

-- | The tree is an evaluated expression in the abstract syntax
-- of the grammar. The type is especially restricted to not
-- allow unapplied lambda abstractions. The tree is used directly 
-- from the linearizer and is produced directly from the parser.
data Tree = 
   Abs [(BindType,CId)] Tree        -- ^ lambda abstraction. The list of variables is non-empty
 | Var CId                          -- ^ variable
 | Fun CId [Tree]                   -- ^ function application
 | Lit Literal                      -- ^ literal
 | Meta {-# UNPACK #-} !MetaId      -- ^ meta variable
  deriving (Eq, Ord)

-----------------------------------------------------
-- Conversion Expr <-> Tree
-----------------------------------------------------

-- | Converts a tree to expression. The conversion
-- is always total, every tree is a valid expression.
tree2expr :: Tree -> Expr
tree2expr = tree2expr []
  where
    tree2expr ys (Fun x ts) = foldl EApp (EFun x) (List.map (tree2expr ys) ts) 
    tree2expr ys (Lit l)    = ELit l
    tree2expr ys (Meta n)   = EMeta n
    tree2expr ys (Abs xs t) = foldr (\(b,x) e -> EAbs b x e) (tree2expr (List.map snd (reverse xs)++ys) t) xs
    tree2expr ys (Var x)    = case List.lookup x (zip ys [0..]) of
                                Just i  -> EVar i
                                Nothing -> error "unknown variable"

-- | Converts an expression to tree. The conversion is only partial.
-- Variables and meta variables of function type and beta redexes are not allowed.
expr2tree :: Expr -> Tree
expr2tree e = abs [] [] e
  where
    abs ys xs (EAbs b x e)    = abs ys ((b,x):xs) e
    abs ys xs (ETyped e _)    = abs ys xs e
    abs ys xs e               = case xs of
                                  [] -> app ys [] e
                                  xs -> Abs (reverse xs) (app (map snd xs++ys) [] e)

    app xs as (EApp e1 e2)    = app xs ((abs xs [] e2) : as) e1
    app xs as (ELit l)
               | List.null as = Lit l
               | otherwise    = error "literal of function type encountered"
    app xs as (EMeta n)
               | List.null as = Meta n
               | otherwise    = error "meta variables of function type are not allowed in trees"
    app xs as (EAbs _ x e)    = error "beta redexes are not allowed in trees"
    app xs as (EVar i)        = Var (xs !! i)
    app xs as (EFun f)        = Fun f as
    app xs as (ETyped e _)    = app xs as e


prTree :: Tree -> String
prTree = showExpr [] . tree2expr

