module PGF.Expr where

import PGF.CId
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP

data Expr

instance Eq   Expr
instance Ord  Expr
instance Show Expr


data BindType = Explicit | Implicit

instance Eq   BindType
instance Ord  BindType
instance Show BindType


pArg   :: RP.ReadP Expr
pBinds :: RP.ReadP [(BindType,CId)]

ppExpr :: Int -> [CId] -> Expr -> PP.Doc

freshName :: CId -> [CId] -> CId

ppParens :: Bool -> PP.Doc -> PP.Doc
