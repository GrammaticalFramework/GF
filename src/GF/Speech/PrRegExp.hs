----------------------------------------------------------------------
-- |
-- Module      : PrSLF
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- This module prints a grammar as a regular expression.
-----------------------------------------------------------------------------

module GF.Speech.PrRegExp (regexpPrinter,multiRegexpPrinter) where

import GF.Conversion.Types
import GF.Formalism.Utilities
import GF.Infra.Ident
import GF.Infra.Option (Options)
import GF.Speech.CFGToFiniteState
import GF.Speech.RegExp
import GF.Compile.ShellState (StateGrammar)


regexpPrinter :: Options -> StateGrammar -> String
regexpPrinter opts s = prRE $ dfa2re $ cfgToFA opts s

multiRegexpPrinter :: Options -> StateGrammar -> String
multiRegexpPrinter opts s = prREs $ mfa2res $ cfgToMFA opts s

prREs :: [(String,RE (MFALabel String))] -> String
prREs res = unlines [l ++ " = " ++ prRE (mapRE showLabel re) | (l,re) <- res]
  where showLabel = symbol (\l -> "<" ++ l ++ ">") id

mfa2res :: MFA String -> [(String,RE (MFALabel String))]
mfa2res (MFA _ dfas) = [(l, minimizeRE (dfa2re dfa)) | (l,dfa) <- dfas]
