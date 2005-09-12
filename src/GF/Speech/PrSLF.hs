----------------------------------------------------------------------
-- |
-- Module      : PrSLF
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/12 15:46:44 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.4 $
--
-- This module converts a CFG to an SLF finite-state network
-- for use with the ATK recognizer. The SLF format is described
-- in the HTK manual, and an example for use in ATK is shown
-- in the ATK manual.
--
-- FIXME: remove \/ warn \/ fail if there are int \/ string literal
-- categories in the grammar
-----------------------------------------------------------------------------

module GF.Speech.PrSLF (slfPrinter,slfGraphvizPrinter,faGraphvizPrinter) where

import GF.Speech.SRG
import GF.Speech.TransformCFG
import GF.Speech.CFGToFiniteState
import GF.Speech.FiniteState
import GF.Infra.Ident

import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..))
import GF.Conversion.Types
import GF.Infra.Print
import GF.Infra.Option

import Data.Char (toUpper,toLower)
import Data.Maybe (fromMaybe)

import Data.Graph.Inductive (emap,nmap)
import Data.Graph.Inductive.Graphviz

data SLF = SLF { slfNodes :: [SLFNode], slfEdges :: [SLFEdge] }

data SLFNode = SLFNode { nId :: Int, nWord :: SLFWord }

-- | An SLF word is a word, or the empty string.
type SLFWord = Maybe String

data SLFEdge = SLFEdge { eId :: Int, eStart :: Int, eEnd :: Int }


slfPrinter :: Ident -- ^ Grammar name
	   -> Options -> CGrammar -> String
slfPrinter name opts cfg = prSLF (automatonToSLF $ moveLabelsToNodes $ cfgToFA name opts cfg) ""

slfGraphvizPrinter :: Ident -- ^ Grammar name
		   -> Options -> CGrammar -> String
slfGraphvizPrinter name opts cfg = 
    graphviz (nmap (fromMaybe "") $ asGraph $ moveLabelsToNodes $ cfgToFA name opts cfg) (prIdent name) (8.5,11.0) (1,1) Landscape

faGraphvizPrinter :: Ident -- ^ Grammar name
		   -> Options -> CGrammar -> String
faGraphvizPrinter name opts cfg = 
    graphviz (nmap (const "") $ emap (fromMaybe "") $ asGraph $ cfgToFA name opts cfg) (prIdent name) (8.5,11.0) (1,1) Landscape

automatonToSLF :: FA (Maybe String) () -> SLF
automatonToSLF fa = 
    SLF { slfNodes = map mkSLFNode (states fa), 
	  slfEdges = zipWith mkSLFEdge [0..] (transitions fa) }
    where mkSLFNode (i,w) = SLFNode { nId = i, nWord = w }
	  mkSLFEdge i (f,t,()) = SLFEdge { eId = i, eStart = f, eEnd = t }


prSLF :: SLF -> ShowS
prSLF (SLF { slfNodes = ns, slfEdges = es}) 
    = header . unlinesS (map prNode ns) . nl . unlinesS (map prEdge es) . nl
    where
    header = showString "VERSION=1.0" . nl 
	     . prFields [("N",show (length ns)),("L", show (length es))] . nl
    prNode n = prFields [("I",show (nId n)),("W",showWord (nWord n))]
    prEdge e = prFields [("J",show (eId e)),("S",show (eStart e)),("E",show (eEnd e))]

showWord :: SLFWord -> String
showWord Nothing = "!NULL"
showWord (Just w) = w -- FIXME: convert words to upper case
		      -- FIXME: could this be the empty string? if so, print as !NULL

prFields :: [(String,String)] -> ShowS
prFields fs = unwordsS [ showString l . showChar '=' . showString v | (l,v) <- fs ]

