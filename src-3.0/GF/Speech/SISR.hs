----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.SISR
--
-- Abstract syntax and pretty printer for SISR,
-- (Semantic Interpretation for Speech Recognition)
----------------------------------------------------------------------
module GF.Speech.SISR (SISRFormat(..), SISRTag, prSISR, 
                       topCatSISR, profileInitSISR, catSISR, profileFinalSISR) where

import Data.List

import GF.Data.Utilities
import GF.Infra.Ident
import GF.Speech.CFG
import GF.Speech.SRG (SRGNT)
import PGF.CId

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
    | null (usedArgs t) = []
    | otherwise = [JS.Decl [JS.DInit args (JS.EArray [])]]

usedArgs :: CFTerm -> [Int]
usedArgs (CFObj _ ts) = foldr union [] (map usedArgs ts)
usedArgs (CFAbs _ x) = usedArgs x
usedArgs (CFApp x y) = usedArgs x `union` usedArgs y
usedArgs (CFRes i) = [i]
usedArgs _ = []

catSISR :: CFTerm -> SRGNT -> SISRFormat -> SISRTag
catSISR t (c,i) fmt
        | i `elem` usedArgs t = map JS.DExpr 
            [JS.EIndex (JS.EVar args) (JS.EInt (fromIntegral i)) `ass` fmtRef fmt c]
        | otherwise = []

profileFinalSISR :: CFTerm -> SISRFormat -> SISRTag
profileFinalSISR term fmt = [JS.DExpr $ fmtOut fmt `ass` f term]
  where 
        f (CFObj n ts) = tree (prCId n) (map f ts)
        f (CFAbs v x) = JS.EFun [var v] [JS.SReturn (f x)]
        f (CFApp x y) = JS.ECall (f x) [f y]
        f (CFRes i) = JS.EIndex (JS.EVar args) (JS.EInt (fromIntegral i))
        f (CFVar v) = JS.EVar (var v)
        f (CFMeta typ) = obj [("name",JS.EStr "?"), ("type",JS.EStr (prCId typ))]

fmtOut SISROld = JS.EVar (JS.Ident "$")

fmtRef SISROld c = JS.EVar (JS.Ident ("$" ++ c))

args = JS.Ident "a"

var v = JS.Ident ("x" ++ show v)

field x y = JS.EMember x (JS.Ident y)

ass = JS.EAssign

tree n xs = obj [("name", JS.EStr n), ("args", JS.EArray xs)]

obj ps = JS.EObj [JS.Prop (JS.StringPropName x) y | (x,y) <- ps]

