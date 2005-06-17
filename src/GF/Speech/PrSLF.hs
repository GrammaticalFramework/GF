----------------------------------------------------------------------
-- |
-- Module      : PrSLF
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/17 12:46:05 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- This module converts a CFG to an SLF finite-state network
-- for use with the ATK recognizer. The SLF format is described
-- in the HTK manual, and an example for use in ATK is shown
-- in the ATK manual.
--
-- FIXME: remove \/ warn \/ fail if there are int \/ string literal
-- categories in the grammar
-----------------------------------------------------------------------------

module GF.Speech.PrSLF (slfPrinter) where

import GF.Speech.SRG
import GF.Speech.TransformCFG
import GF.Infra.Ident

import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..))
import GF.Conversion.Types
import GF.Infra.Print
import GF.Infra.Option

import Data.Char (toUpper,toLower)

data SLF = SLF [SLFNode] [SLFEdge]

data SLFNode = SLFNode Int SLFWord

type SLFWord = Maybe String

data SLFEdge = SLFEdge Int Int Int


slfPrinter :: Ident -- ^ Grammar name
	   -> Options -> CGrammar -> String
slfPrinter name opts cfg = prSLF slf ""
    where gr = makeNice cfg
	  gr' = makeRegular gr
	  srg = makeSRG name opts gr'
	  slf = srg2slf srg

srg2slf :: SRG -> SLF
srg2slf = undefined

prSLF :: SLF -> ShowS
prSLF (SLF ns es) = header . unlinesS (map prNode ns) . unlinesS (map prEdge es)
    where
    header = showString "VERSION=1.0" . nl 
	     . prFields [("N",show (length ns)),("L", show (length es))] . nl
    prNode (SLFNode i w) = prFields [("I",show i),("W",showWord w)]
    prEdge (SLFEdge i s e) = prFields [("J",show i),("S",show s),("E",show e)]


showWord :: SLFWord -> String
showWord Nothing = "!NULL"
showWord (Just w) = w -- FIXME: convert words to upper case

prFields :: [(String,String)] -> ShowS
prFields fs = unwordsS [ showString l . showChar '=' . showString v | (l,v) <- fs ]
