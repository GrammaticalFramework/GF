----------------------------------------------------------------------
-- |
-- Module      : GFC
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/08 15:51:17 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.10 $
--
-- canonical GF. AR 10\/9\/2002 -- 9\/5\/2003 -- 21\/9
-----------------------------------------------------------------------------

module GFC (Context,
	    CanonGrammar,
	    CanonModInfo,
	    CanonModule,
	    CanonAbs,
	    Info(..),
	    Printname,
	    mapInfoTerms,
	    setFlag
	   ) where

import AbsGFC
import PrintGFC
import qualified Abstract as A

import Ident
import Option
import Zipper
import Operations
import qualified Modules as M

import Char
import Control.Arrow (first)

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
 | ResOper CType Term     -- ^ global constant
 | CncCat  CType Term Printname
 | CncFun  CIdent [ArgVar] Term Printname
 | AnyInd Bool Ident
  deriving (Show)

type Printname = Term
	      
mapInfoTerms :: (Term -> Term) -> Info -> Info
mapInfoTerms f i = case i of 
         ResOper x a -> ResOper x (f a)
	 CncCat  x a y -> CncCat x (f a) y
	 CncFun  x y a z -> CncFun x y (f a) z
	 _ -> i

setFlag :: String -> String -> [Flag] -> [Flag]
setFlag n v fs = Flg (IC n) (IC v):[f | f@(Flg (IC n') _) <- fs, n' /= n]
