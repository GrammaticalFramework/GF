module PGF.Type ( readType, showType, pType, ppType ) where

import PGF.CId
import PGF.Data
import PGF.Expr
import Data.Char
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP
import Control.Monad
import Debug.Trace

-- | parses 'String' as an expression
readType :: String -> Maybe Type
readType s = case [x | (x,cs) <- RP.readP_to_S pType s, all isSpace cs] of
               [x] -> Just x
               _   -> Nothing

-- | renders type as 'String'
showType :: Type -> String
showType = PP.render . ppType 0

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
                     v <- pIdent
                     RP.skipSpaces
                     RP.string ":"
                     return (mkCId v)
         ty <- pType
         return (Hyp var ty))

    pAtom = do
      cat <- pIdent
      RP.skipSpaces
      args <- RP.sepBy pFactor RP.skipSpaces
      return (mkCId cat, args)


ppType d (DTyp ctxt cat args)
  | null ctxt = ppRes cat args
  | otherwise = ppParens (d > 0) (foldr ppCtxt (ppRes cat args) ctxt)
  where
    ppCtxt (Hyp x typ) doc
      | x == wildCId = ppType 1 typ PP.<+> PP.text "->" PP.<+> doc
      | otherwise    = PP.parens (PP.text (prCId x) PP.<+> PP.char ':' PP.<+> ppType 0 typ) PP.<+> PP.text "->" PP.<+> doc

    ppRes cat es = PP.text (prCId cat) PP.<+> PP.hsep (map (ppExpr 2) es)

ppParens True  = PP.parens
ppParens False = id
