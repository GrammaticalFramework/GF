module PGF.Expr where

import PGF.CId
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP

data Expr

instance Eq   Expr
instance Ord  Expr
instance Show Expr

pFactor :: RP.ReadP Expr

ppExpr :: Int -> [CId] -> Expr -> PP.Doc

freshName :: CId -> [CId] -> CId