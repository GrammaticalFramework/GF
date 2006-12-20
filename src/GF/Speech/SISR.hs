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

type SISRTag = [JS.Expr]


prSISR :: SISRTag -> String
prSISR = JS.printTree

topCatSISR :: String -> String -> SISRFormat -> SISRTag
topCatSISR i c fmt = [field (fmtOut fmt) i `ass` fmtRef fmt c]

profileInitSISR :: CFTerm -> SISRFormat -> SISRTag
profileInitSISR t fmt 
    | null (usedChildren t) = []
    | otherwise = [children `ass` JS.ENew (JS.Ident "Array") []]

usedChildren :: CFTerm -> [Int]
usedChildren (CFObj _ ts) = foldr union [] (map usedChildren ts)
usedChildren (CFAbs _ x) = usedChildren x
usedChildren (CFApp x y) = usedChildren x `union` usedChildren y
usedChildren (CFRes i) = [i]
usedChildren _ = []

catSISR :: CFTerm -> SRGNT -> SISRFormat -> SISRTag
catSISR t (c,i) fmt
        | i `elem` usedChildren t = 
            [JS.EIndex children (JS.EInt (fromIntegral i)) `ass` fmtRef fmt c]
        | otherwise = []

profileFinalSISR :: CFTerm -> SISRFormat -> SISRTag
profileFinalSISR term fmt = g term
  where 
        -- optimization for tokens
        g (CFObj n []) = [field (fmtOut fmt) "name" `ass` JS.EStr (prIdent n)] 
        g t = [fmtOut fmt `ass` f t]
        f (CFObj n ts) = 
            JS.ESeq $ [ret `ass` JS.ENew (JS.Ident "Object") [], 
                           field ret "name" `ass` JS.EStr (prIdent n)] 
                  ++ [field ret ("arg"++show i) `ass` f t 
                          | (i,t) <- zip [0..] ts ]
                  ++ [ret]
          where ret = JS.EVar (JS.Ident "ret")
        f (CFAbs v x) = JS.EFun [var v] [JS.SReturn (f x)]
        f (CFApp x y) = JS.ECall (f x) [f y]
        f (CFRes i) = JS.EIndex children (JS.EInt (fromIntegral i))
        f (CFVar v) = JS.EVar (var v)
        f (CFConst s) = JS.EStr s


fmtOut SISROld = JS.EVar (JS.Ident "$")

fmtRef SISROld c = JS.EVar (JS.Ident ("$" ++ c))

children = JS.EVar (JS.Ident "c")

var v = JS.Ident ("x" ++ show v)

field x y = JS.EMember x (JS.Ident y)

ass = JS.EAssign