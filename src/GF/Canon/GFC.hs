module GFC where

import AbsGFC
import PrintGFC
import qualified Abstract as A

import Ident
import Option
import Zipper
import Operations
import qualified Modules as M

import Char

-- canonical GF. AR 10/9/2002 -- 9/5/2003 -- 21/9

type Context = [(Ident,Exp)]

type CanonGrammar = M.MGrammar Ident Flag Info

type CanonModInfo = M.ModInfo Ident Flag Info

type CanonModule = (Ident, CanonModInfo)

type CanonAbs = M.Module Ident Option Info

data Info = 
   AbsCat  A.Context [A.Fun]
 | AbsFun  A.Type A.Term
 | AbsTrans A.Term

 | ResPar  [ParDef]
 | ResOper CType Term     -- global constant
 | CncCat  CType Term Printname
 | CncFun  CIdent [ArgVar] Term Printname
 | AnyInd Bool Ident
  deriving (Show)

type Printname = Term

-- some printing ----

{-
prCanonModInfo :: (Ident,CanonModInfo) -> String
prCanonModInfo = printTree . info2mod

prGrammar :: CanonGrammar -> String
prGrammar = printTree . grammar2canon
-}
