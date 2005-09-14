----------------------------------------------------------------------
-- |
-- Module      : PrSLF
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/14 16:08:35 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.10 $
--
-- This module converts a CFG to an SLF finite-state network
-- for use with the ATK recognizer. The SLF format is described
-- in the HTK manual, and an example for use in ATK is shown
-- in the ATK manual.
--
-- FIXME: remove \/ warn \/ fail if there are int \/ string literal
-- categories in the grammar
-----------------------------------------------------------------------------

module GF.Speech.PrSLF (slfPrinter,slfGraphvizPrinter,
                        faGraphvizPrinter,regularPrinter) where

import GF.Data.Utilities
import GF.Conversion.Types
import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..),symbol)
import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.Print
import GF.Speech.CFGToFiniteState
import GF.Speech.FiniteState
import GF.Speech.SRG
import GF.Speech.TransformCFG

import Data.Char (toUpper,toLower)
import Data.List
import Data.Maybe (fromMaybe)

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
    prFAGraphviz (mapStates (fromMaybe "") $ mapTransitions (const "") $ moveLabelsToNodes $ cfgToFA name opts cfg)

faGraphvizPrinter :: Ident -- ^ Grammar name
		   -> Options -> CGrammar -> String
faGraphvizPrinter name opts cfg = 
    prFAGraphviz (mapStates (const "") $ mapTransitions (fromMaybe "") $ cfgToFA name opts cfg)


-- | Convert the grammar to a regular grammar and print it in BNF
regularPrinter :: CGrammar -> String
regularPrinter = prCFRules . makeSimpleRegular
  where
  prCFRules :: CFRules -> String
  prCFRules g = unlines [ c ++ " ::= " ++ join " | " (map (showRhs . ruleRhs) rs) | (c,rs) <- g]
  join g = concat . intersperse g
  showRhs = unwords . map (symbol id show)

automatonToSLF :: FA State (Maybe String) () -> SLF
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

