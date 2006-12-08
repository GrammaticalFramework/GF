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

module GF.Speech.SISR (SISRFormat(..), SISRExpr(..), prSISR) where

import Data.List

infixl 8 :.
infixr 1 :=

data SISRFormat = SISROld
 deriving Show

data SISRExpr = SISRExpr := SISRExpr
              | EThis 
              | SISRExpr :. String 
              | ERef String
              | EStr String
              | EApp SISRExpr [SISRExpr]
              | ENew String [SISRExpr]
  deriving Show

prSISR :: SISRFormat -> SISRExpr -> String
prSISR fmt = f
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