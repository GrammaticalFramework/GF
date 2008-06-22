----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.PrRegExp
--
-- This module prints a grammar as a regular expression.
-----------------------------------------------------------------------------

module GF.Speech.PrRegExp (regexpPrinter,multiRegexpPrinter) where

import GF.Speech.CFG
import GF.Speech.CFGToFA
import GF.Speech.PGFToCFG
import GF.Speech.RegExp
import PGF

regexpPrinter :: PGF -> CId -> String
regexpPrinter pgf cnc = (++"\n") $ prRE $ dfa2re $ cfgToFA $ pgfToCFG pgf cnc

multiRegexpPrinter :: PGF -> CId -> String
multiRegexpPrinter pgf cnc = prREs $ mfa2res $ cfgToMFA $ pgfToCFG pgf cnc

prREs :: [(String,RE CFSymbol)] -> String
prREs res = unlines [l ++ " = " ++ prRE (mapRE showLabel re) | (l,re) <- res]
  where showLabel = symbol (\l -> "<" ++ l ++ ">") id

mfa2res :: MFA -> [(String,RE CFSymbol)]
mfa2res (MFA _ dfas) = [(l, minimizeRE (dfa2re dfa)) | (l,dfa) <- dfas]
