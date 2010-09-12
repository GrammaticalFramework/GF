module PGF.Type ( Type(..), Hypo,
                  readType, showType,
                  mkType, mkHypo, mkDepHypo, mkImplHypo,
                  unType,
                  pType, ppType, ppHypo ) where

import PGF.CId
import {-# SOURCE #-} PGF.Expr
import Data.Char
import Data.List
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP
import Control.Monad

-- | To read a type from a 'String', use 'readType'.
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

-- | creates a type from list of hypothesises, category and 
-- list of arguments for the category. The operation 
-- @mkType [h_1,...,h_n] C [e_1,...,e_m]@ will create 
-- @h_1 -> ... -> h_n -> C e_1 ... e_m@
mkType :: [Hypo] -> CId -> [Expr] -> Type
mkType hyps cat args = DTyp hyps cat args

-- | creates hypothesis for non-dependent type i.e. A
mkHypo :: Type -> Hypo
mkHypo ty = (Explicit,wildCId,ty)

-- | creates hypothesis for dependent type i.e. (x : A)
mkDepHypo :: CId -> Type -> Hypo
mkDepHypo x ty = (Explicit,x,ty)

-- | creates hypothesis for dependent type with implicit argument i.e. ({x} : A)
mkImplHypo :: CId -> Type -> Hypo
mkImplHypo x ty = (Implicit,x,ty)

unType :: Type -> ([Hypo], CId, [Expr])
unType (DTyp hyps cat es) = (hyps, cat, es)

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
      do RP.between (RP.char '(') (RP.char ')') pHypoBinds

pHypoBinds = do
   xs <- RP.option [(Explicit,wildCId)] $ do
               xs <- pBinds
               RP.skipSpaces
               RP.char ':'
               return xs
   ty <- pType
   return [(b,v,ty) | (b,v) <- xs]

    pAtom = do
      cat <- pCId
      RP.skipSpaces
      args <- RP.sepBy pArg RP.skipSpaces
      return (cat, args)

ppType :: Int -> [CId] -> Type -> PP.Doc
ppType d scope (DTyp hyps cat args)
  | null hyps = ppRes scope cat args
  | otherwise = let (scope',hdocs) = mapAccumL (ppHypo 1) scope hyps
                in ppParens (d > 0) (foldr (\hdoc doc -> hdoc PP.<+> PP.text "->" PP.<+> doc) (ppRes scope' cat args) hdocs)
  where
    ppRes scope cat es
      | null es   = ppCId cat
      | otherwise = ppParens (d > 3) (ppCId cat PP.<+> PP.hsep (map (ppExpr 4 scope) es))

ppHypo :: Int -> [CId] -> (BindType,CId,Type) -> ([CId],PP.Doc)
ppHypo d scope (Explicit,x,typ) = if x == wildCId
                                    then (scope,ppType d scope typ)
                                    else let y = freshName x scope
                                         in (y:scope,PP.parens (ppCId y PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))
ppHypo d scope (Implicit,x,typ) = if x == wildCId
                                    then (scope,PP.parens (PP.braces (ppCId x) PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))
                                    else let y = freshName x scope
                                         in (y:scope,PP.parens (PP.braces (ppCId y) PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))
