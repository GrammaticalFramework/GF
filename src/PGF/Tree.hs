module PGF.Tree 
         ( Tree(..),
           readTree, showTree, pTree, ppTree,
           tree2expr, expr2tree
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
   Abs [CId] Tree                   -- ^ lambda abstraction. The list of variables is non-empty
 | Var CId                          -- ^ variable
 | Fun CId [Tree]                   -- ^ function application
 | Lit Literal                      -- ^ literal
 | Meta {-# UNPACK #-} !MetaId      -- ^ meta variable
  deriving (Eq, Ord)

-- | parses 'String' as an expression
readTree :: String -> Maybe Tree
readTree s = case [x | (x,cs) <- RP.readP_to_S (pTree False) s, all isSpace cs] of
               [x] -> Just x
               _   -> Nothing

-- | renders expression as 'String'
showTree :: Tree -> String
showTree = PP.render . ppTree 0

instance Show Tree where
    showsPrec i x = showString (PP.render (ppTree i x))

instance Read Tree where
    readsPrec _ = RP.readP_to_S (pTree False)

pTrees :: RP.ReadP [Tree]
pTrees = liftM2 (:) (pTree True) pTrees RP.<++ (RP.skipSpaces >> return [])

pTree :: Bool -> RP.ReadP Tree
pTree isNested = RP.skipSpaces >> (pParen RP.<++ pAbs RP.<++ pApp RP.<++ fmap Lit pLit RP.<++ fmap Meta pMeta)
  where 
        pParen = RP.between (RP.char '(') (RP.char ')') (pTree False)
        pAbs = do xs <- RP.between (RP.char '\\') (RP.skipSpaces >> RP.string "->") (RP.sepBy1 (RP.skipSpaces >> pCId) (RP.skipSpaces >> RP.char ','))
                  t  <- pTree False
                  return (Abs xs t)
        pApp = do f  <- pCId
                  ts <- (if isNested then return [] else pTrees)
                  return (Fun f ts)

ppTree d (Abs xs t) = ppParens (d > 0) (PP.char '\\' PP.<>
                                        PP.hsep (PP.punctuate PP.comma (List.map ppCId xs)) PP.<+>
                                        PP.text "->" PP.<+>
                                        ppTree 0 t)
ppTree d (Fun f []) = ppCId f
ppTree d (Fun f ts) = ppParens (d > 0) (ppCId f PP.<+> PP.hsep (List.map (ppTree 1) ts))
ppTree d (Lit l)    = ppLit l
ppTree d (Meta n)   = ppMeta n
ppTree d (Var id)   = ppCId id


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
    tree2expr ys (Abs xs t) = foldr EAbs (tree2expr (reverse xs++ys) t) xs
    tree2expr ys (Var x)    = case List.lookup x (zip ys [0..]) of
                                Just i  -> EVar i
                                Nothing -> error "unknown variable"

-- | Converts an expression to tree. The conversion is only partial.
-- Variables and meta variables of function type and beta redexes are not allowed.
expr2tree :: Expr -> Tree
expr2tree e = abs [] [] e
  where
    abs ys xs (EAbs x e)      = abs ys (x:xs) e
    abs ys xs (ETyped e _)    = abs ys xs e
    abs ys xs e               = case xs of
                                  [] -> app ys [] e
                                  xs -> Abs (reverse xs) (app (xs++ys) [] e)

    app xs as (EApp e1 e2)    = app xs ((abs xs [] e2) : as) e1
    app xs as (ELit l)
               | List.null as = Lit l
               | otherwise    = error "literal of function type encountered"
    app xs as (EMeta n)
               | List.null as = Meta n
               | otherwise    = error "meta variables of function type are not allowed in trees"
    app xs as (EAbs x e)      = error "beta redexes are not allowed in trees"
    app xs as (EVar i)        = Var (xs !! i)
    app xs as (EFun f)        = Fun f as
    app xs as (ETyped e _)    = app xs as e
