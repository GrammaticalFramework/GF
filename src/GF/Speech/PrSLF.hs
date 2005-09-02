----------------------------------------------------------------------
-- |
-- Module      : PrSLF
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/02 15:47:46 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
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

data SLF = SLF { slfNodes :: [SLFNode], slfEdges :: [SLFEdge] }

data SLFNode = SLFNode { nId :: Int, nWord :: SLFWord }

-- | An SLF word is a word, or the empty string.
type SLFWord = String

data SLFEdge = SLFEdge { eId :: Int, eStart :: Int, eEnd :: Int }


slfPrinter :: Ident -- ^ Grammar name
	   -> Options -> CGrammar -> String
slfPrinter name opts cfg = prSLF slf ""
    where slf = srg2slf $ makeSRG name opts $ makeRegular $ makeNice cfg

srg2slf :: SRG -> SLF
srg2slf = undefined -- should use TransformCFG.compileAutomaton

prSLF :: SLF -> ShowS
prSLF (SLF { slfNodes = ns, slfEdges = es}) = header . unlinesS (map prNode ns) . unlinesS (map prEdge es)
    where
    header = showString "VERSION=1.0" . nl 
	     . prFields [("N",show (length ns)),("L", show (length es))] . nl
    prNode n = prFields [("I",show (nId n)),("W",showWord (nWord n))]
    prEdge e = prFields [("J",show (eId e)),("S",show (eStart e)),("E",show (eEnd e))]


showWord :: SLFWord -> String
showWord "" = "!NULL"
showWord w = w -- FIXME: convert words to upper case

prFields :: [(String,String)] -> ShowS
prFields fs = unwordsS [ showString l . showChar '=' . showString v | (l,v) <- fs ]
