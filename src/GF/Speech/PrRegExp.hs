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
  where showLabel (MFASym s) = s
        showLabel (MFASub l) = "<" ++ l ++ ">"

mfa2res :: MFA String -> [(String,RE (MFALabel String))]
mfa2res (MFA start dfas) = 
    [("START",f start)] ++ [(l,f dfa) | (l,dfa) <- dfas]
  where f = minimizeRE . dfa2re