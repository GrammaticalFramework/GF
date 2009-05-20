module PGF.Expr where

import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP

data Expr

instance Eq  Expr
instance Ord Expr

pFactor :: RP.ReadP Expr

ppExpr :: Int -> Expr -> PP.Doc
