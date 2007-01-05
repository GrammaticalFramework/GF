----------------------------------------------------------------------
-- |
-- Module      : PrSLF
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- This module prints a grammar as a regular expression.
-----------------------------------------------------------------------------

module GF.Speech.PrRegExp (regexpPrinter) where

import GF.Conversion.Types
import GF.Infra.Ident
import GF.Speech.CFGToFiniteState
import GF.Speech.RegExp
import GF.Compile.ShellState (StateGrammar)


regexpPrinter :: Ident -- ^ Grammar name
	      -> String -> StateGrammar -> String
regexpPrinter name start = prRE . dfa2re . cfgToFA start
