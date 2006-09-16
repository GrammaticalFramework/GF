----------------------------------------------------------------------
-- |
-- Module      : GFC
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:22 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.12 $
--
-- canonical GF. AR 10\/9\/2002 -- 9\/5\/2003 -- 21\/9
-----------------------------------------------------------------------------

module GF.Canon.GFC (Context,
	    CanonGrammar,
	    CanonModInfo,
	    CanonModule,
	    CanonAbs,
	    Info(..),
	    Printname,
            prPrintnamesGrammar,
	    mapInfoTerms,
	    setFlag,
            flagIncomplete,
            isIncompleteCanon,
            hasFlagCanon,
            flagCanon
	   ) where

import GF.Canon.AbsGFC
import GF.Canon.PrintGFC
import qualified GF.Grammar.Abstract as A

import GF.Infra.Ident
import GF.Infra.Option
import GF.Data.Zipper
import GF.Data.Operations
import qualified GF.Infra.Modules as M

import Data.Char
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
setFlag n v fs = flagCanon n v : [f | f@(Flg (IC n') _) <- fs, n' /= n]

flagIncomplete :: Flag
flagIncomplete = flagCanon "incomplete" "true"

isIncompleteCanon :: CanonModule -> Bool
isIncompleteCanon = hasFlagCanon flagIncomplete

hasFlagCanon :: Flag -> CanonModule -> Bool
hasFlagCanon f (_,M.ModMod mo) = elem f $ M.flags mo
hasFlagCanon f _ = True ---- safe, useless 

flagCanon :: String -> String -> Flag
flagCanon f v = Flg (identC f) (identC v)

-- for Ha-Jo 20/2/2005

prPrintnamesGrammar :: CanonGrammar -> String
prPrintnamesGrammar gr = unlines $ filter (not . null) [prPrint j | 
  (_,M.ModMod m) <- M.modules gr,  
  M.isModCnc m,
  j <- tree2list $ M.jments m
  ]
  where
    prPrint j = case j of
      (c,CncCat _   _ p) -> "printname cat" +++ A.prt_ c +++ "=" +++ A.prt_ p
      (c,CncFun _ _ _ p) -> "printname fun" +++ A.prt_ c +++ "=" +++ A.prt_ p
      _ -> []
