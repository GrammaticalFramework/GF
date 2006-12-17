----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.SISR
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- Abstract syntax and pretty printer for SISR,
-- (Semantic Interpretation for Speech Recognition)
--
-----------------------------------------------------------------------------

module GF.Speech.SISR (SISRFormat(..), SISRExpr(..), prSISR, 
                       profileInitSISR, catSISR) where

import Data.List

import GF.Conversion.Types
import GF.Data.Utilities
import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..), NameProfile(..), Profile(..), forestName)
import GF.Infra.Ident
import GF.Speech.SRG


infixl 8 :.
infixr 1 :=

data SISRFormat = 
    -- SISR Working draft 1 April 2003
    -- http://www.w3.org/TR/2003/WD-semantic-interpretation-20030401/
    SISROld
 deriving Show

data SISRExpr = SISRExpr := SISRExpr
              | EThis 
              | SISRExpr :. String 
              | ERef String
              | EStr String
              | EApp SISRExpr [SISRExpr]
              | ENew String [SISRExpr]
  deriving Show

prSISR :: SISRFormat -> [SISRExpr] -> String
prSISR fmt = join "; " . map f
  where
   f e = 
    case e of
      x := y -> f x ++ "=" ++ f y
      EThis -> "$" 
      x :. y -> f x ++ "." ++ y
      ERef y -> "$" ++ y
      EStr s -> show s
      EApp x ys -> f x ++ "(" ++ concat (intersperse "," (map f ys)) ++ ")"
      ENew n ys -> "new " ++ n ++ "(" ++ concat (intersperse "," (map f ys)) ++ ")"

profileInitSISR :: Name -> [SISRExpr]
profileInitSISR (Name f prs) =
    [(EThis :. "name") := (EStr (prIdent f))] ++
    [(EThis :. ("arg" ++ show n)) := (EStr (argInit (prs!!n))) 
                  | n <- [0..length prs-1]]
  where argInit (Unify _) = "?"
        argInit (Constant f) = maybe "?" prIdent (forestName f)

catSISR :: SRGNT -> [SISRExpr]
catSISR (c,slots) = [(EThis :. ("arg" ++ show s)) := (ERef c) | s <- slots]
