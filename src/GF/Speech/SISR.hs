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

module GF.Speech.SISR (SISRFormat(..), SISRTag, prSISR, 
                       topCatSISR, profileInitSISR, catSISR, profileFinalSISR) where

import Data.List

import GF.Conversion.Types
import GF.Data.Utilities
import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..), NameProfile(..), Profile(..), forestName)
import GF.Infra.Ident
import GF.Speech.TransformCFG
import GF.Speech.SRG

import qualified GF.JavaScript.AbsJS   as JS
import qualified GF.JavaScript.PrintJS as JS

data SISRFormat = 
    -- SISR Working draft 1 April 2003
    -- http://www.w3.org/TR/2003/WD-semantic-interpretation-20030401/
    SISROld
 deriving Show

type SISRTag = [JS.DeclOrExpr]


prSISR :: SISRTag -> String
prSISR = JS.printTree

topCatSISR :: String -> SISRFormat -> SISRTag
topCatSISR c fmt = map JS.DExpr [fmtOut fmt `ass` fmtRef fmt c]

profileInitSISR :: CFTerm -> SISRFormat -> SISRTag
profileInitSISR t fmt 
    | null (usedChildren t) = []
    | otherwise = [JS.Decl [JS.DInit children (JS.EArray [])]]

usedChildren :: CFTerm -> [Int]
usedChildren (CFObj _ ts) = foldr union [] (map usedChildren ts)
usedChildren (CFAbs _ x) = usedChildren x
usedChildren (CFApp x y) = usedChildren x `union` usedChildren y
usedChildren (CFRes i) = [i]
usedChildren _ = []

catSISR :: CFTerm -> SRGNT -> SISRFormat -> SISRTag
catSISR t (c,i) fmt
        | i `elem` usedChildren t = map JS.DExpr 
            [JS.EIndex (JS.EVar children) (JS.EInt (fromIntegral i)) `ass` fmtRef fmt c]
        | otherwise = []

profileFinalSISR :: CFTerm -> SISRFormat -> SISRTag
profileFinalSISR term fmt = [JS.DExpr $ fmtOut fmt `ass` f term]
  where 
        f (CFObj n ts) = tree (prIdent n) (map f ts)
        f (CFAbs v x) = JS.EFun [var v] [JS.SReturn (f x)]
        f (CFApp x y) = JS.ECall (f x) [f y]
        f (CFRes i) = JS.EIndex (JS.EVar children) (JS.EInt (fromIntegral i))
        f (CFVar v) = JS.EVar (var v)
        f (CFConst s) = JS.EStr s
        f CFMeta = tree "?" []

fmtOut SISROld = JS.EVar (JS.Ident "$")

fmtRef SISROld c = JS.EVar (JS.Ident ("$" ++ c))

children = JS.Ident "c"

var v = JS.Ident ("x" ++ show v)

field x y = JS.EMember x (JS.Ident y)

ass = JS.EAssign

tree n xs = JS.EObj $ [JS.Prop (JS.Ident "name") (JS.EStr n)]
                   ++ [JS.Prop (JS.Ident ("arg"++show i)) x | (i,x) <- zip [0..] xs]