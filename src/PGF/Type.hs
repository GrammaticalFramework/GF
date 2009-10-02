module PGF.Type ( Type(..), Hypo,
                  readType, showType,
                  pType, ppType, ppHypo ) where

import PGF.CId
import {-# SOURCE #-} PGF.Expr
import Data.Char
import Data.List
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP
import Control.Monad

-- | To read a type from a 'String', use 'read' or 'readType'.
data Type =
   DTyp [Hypo] CId [Expr]
  deriving (Eq,Ord,Show)

-- | 'Hypo' represents a hypothesis in a type i.e. in the type A -> B, A is the hypothesis
type Hypo = (BindType,CId,Type)

-- | Reads a 'Type' from a 'String'.
readType :: String -> Maybe Type
readType s = case [x | (x,cs) <- RP.readP_to_S pType s, all isSpace cs] of
               [x] -> Just x
               _   -> Nothing

-- | renders type as 'String'. The list
-- of identifiers is the list of all free variables
-- in the expression in order reverse to the order
-- of binding.
showType :: [CId] -> Type -> String
showType vars = PP.render . ppType 0 vars

pType :: RP.ReadP Type
pType = do
  RP.skipSpaces
  hyps <- RP.sepBy (pHypo >>= \h -> RP.skipSpaces >> RP.string "->" >> return h) RP.skipSpaces
  RP.skipSpaces
  (cat,args) <- pAtom
  return (DTyp (concat hyps) cat args)
  where
    pHypo =
      do (cat,args) <- pAtom
         return [(Explicit,wildCId,DTyp [] cat args)]
      RP.<++
      (RP.between (RP.char '(') (RP.char ')') $ do
         xs <- RP.option [(Explicit,wildCId)] $ do
                     xs <- pBinds
                     RP.skipSpaces
                     RP.char ':'
                     return xs
         ty <- pType
         return [(b,v,ty) | (b,v) <- xs])
      RP.<++
      (RP.between (RP.char '{') (RP.char '}') $ do
         vs <- RP.sepBy1 (RP.skipSpaces >> pCId) (RP.skipSpaces >> RP.char ',')
         RP.skipSpaces
         RP.char ':'
         ty <- pType
         return [(Implicit,v,ty) | v <- vs])

    pAtom = do
      cat <- pCId
      RP.skipSpaces
      args <- RP.sepBy pArg RP.skipSpaces
      return (cat, args)

ppType :: Int -> [CId] -> Type -> PP.Doc
ppType d scope (DTyp hyps cat args)
  | null hyps = ppRes scope cat args
  | otherwise = let (scope',hdocs) = mapAccumL ppHypo scope hyps
                in ppParens (d > 0) (foldr (\hdoc doc -> hdoc PP.<+> PP.text "->" PP.<+> doc) (ppRes scope' cat args) hdocs)
  where
    ppRes scope cat es = ppCId cat PP.<+> PP.hsep (map (ppExpr 4 scope) es)

ppHypo scope (Explicit,x,typ) = if x == wildCId
                                  then (scope,ppType 1 scope typ)
                                  else let y = freshName x scope
                                       in (y:scope,PP.parens (ppCId y PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))
ppHypo scope (Implicit,x,typ) = if x == wildCId
                                  then (scope,PP.parens (PP.braces (ppCId x) PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))
                                  else let y = freshName x scope
                                       in (y:scope,PP.parens (PP.braces (ppCId y) PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))
