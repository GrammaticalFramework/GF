module PGF.Type ( Type(..), Hypo(..),
                  readType, showType,
                  pType, ppType, ppHypo ) where

import PGF.CId
import {-# SOURCE #-} PGF.Expr
import Data.Char
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP
import Control.Monad
import Debug.Trace

-- | To read a type from a 'String', use 'read' or 'readType'.
data Type =
   DTyp [Hypo] CId [Expr]
  deriving (Eq,Ord)

data Hypo =
   Hyp CId Type
  deriving (Eq,Ord,Show)

-- | Reads a 'Type' from a 'String'.
readType :: String -> Maybe Type
readType s = case [x | (x,cs) <- RP.readP_to_S pType s, all isSpace cs] of
               [x] -> Just x
               _   -> Nothing

instance Show Type where
    showsPrec i x = showString (PP.render (ppType i x))

instance Read Type where
    readsPrec _ = RP.readP_to_S pType

-- | renders type as 'String'
showType :: Type -> String
showType = PP.render . ppType 0

pType :: RP.ReadP Type
pType = do
  RP.skipSpaces
  hyps <- RP.sepBy (pHypo >>= \h -> RP.string "->" >> return h) RP.skipSpaces
  RP.skipSpaces
  (cat,args) <- pAtom
  return (DTyp hyps cat args)
  where
    pHypo =
      do (cat,args) <- pAtom
         return (Hyp wildCId (DTyp [] cat args))
      RP.<++
      (RP.between (RP.char '(') (RP.char ')') $ do
         var <- RP.option wildCId $ do
                     v <- pCId
                     RP.skipSpaces
                     RP.string ":"
                     return v
         ty <- pType
         return (Hyp var ty))

    pAtom = do
      cat <- pCId
      RP.skipSpaces
      args <- RP.sepBy pFactor RP.skipSpaces
      return (cat, args)

ppType :: Int -> Type -> PP.Doc
ppType d (DTyp ctxt cat args)
  | null ctxt = ppRes cat args
  | otherwise = ppParens (d > 0) (foldr ppCtxt (ppRes cat args) ctxt)
  where
    ppCtxt hyp doc = ppHypo hyp PP.<+> PP.text "->" PP.<+> doc
    ppRes cat es = PP.text (prCId cat) PP.<+> PP.hsep (map (ppExpr 2) es)

ppHypo (Hyp x typ)
  | x == wildCId = ppType 1 typ
  | otherwise    = PP.parens (PP.text (prCId x) PP.<+> PP.char ':' PP.<+> ppType 0 typ)

ppParens :: Bool -> PP.Doc -> PP.Doc
ppParens True  = PP.parens
ppParens False = id
