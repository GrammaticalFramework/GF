module PGF.Type ( Type(..), Hypo(..),
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
data Hypo =
    Hyp      Type      -- ^ hypothesis without bound variable like in A -> B
  | HypV CId Type      -- ^ hypothesis with bound variable like in (x : A) -> B x
  | HypI CId Type      -- ^ hypothesis with bound implicit variable like in {x : A} -> B x
  deriving (Eq,Ord,Show)

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
         return [Hyp (DTyp [] cat args)]
      RP.<++
      (RP.between (RP.char '(') (RP.char ')') $ do
         hyp <- RP.option (\ty -> [Hyp ty]) $ do
                     vs <- RP.sepBy (RP.skipSpaces >> pCId) (RP.skipSpaces >> RP.char ',')
                     RP.skipSpaces
                     RP.char ':'
                     return (\ty -> [HypV v ty | v <- vs])
         ty <- pType
         return (hyp ty))
      RP.<++
      (RP.between (RP.char '{') (RP.char '}') $ do
         vs <- RP.sepBy1 (RP.skipSpaces >> pCId) (RP.skipSpaces >> RP.char ',')
         RP.skipSpaces
         RP.char ':'
         ty <- pType
         return [HypI v ty | v <- vs])

    pAtom = do
      cat <- pCId
      RP.skipSpaces
      args <- RP.sepBy pFactor RP.skipSpaces
      return (cat, args)

ppType :: Int -> [CId] -> Type -> PP.Doc
ppType d scope (DTyp hyps cat args)
  | null hyps = ppRes scope cat args
  | otherwise = let (scope',hdocs) = mapAccumL ppHypo scope hyps
                in ppParens (d > 0) (foldr (\hdoc doc -> hdoc PP.<+> PP.text "->" PP.<+> doc) (ppRes scope' cat args) hdocs)
  where
    ppRes scope cat es = PP.text (prCId cat) PP.<+> PP.hsep (map (ppExpr 4 scope) es)

ppHypo scope (Hyp    typ) = (  scope,ppType 1 scope typ)
ppHypo scope (HypV x typ) = let y = freshName x scope
                            in (y:scope,PP.parens (PP.text (prCId y) PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))
ppHypo scope (HypI x typ) = let y = freshName x scope
                            in (y:scope,PP.braces (PP.text (prCId y) PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))

ppParens :: Bool -> PP.Doc -> PP.Doc
ppParens True  = PP.parens
ppParens False = id
