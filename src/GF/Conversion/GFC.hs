----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/17 13:38:46 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.11 $
--
-- All conversions from GFC 
-----------------------------------------------------------------------------

module GF.Conversion.GFC
    (module GF.Conversion.GFC,
     SGrammar, MGrammar, CGrammar) where

import GF.Infra.Option
import GF.Canon.GFC (CanonGrammar)
import GF.Infra.Ident (Ident, identC)

import GF.Formalism.GCFG (Rule(..), Abstract(..))
import GF.Formalism.SimpleGFC (decl2cat)
import GF.Formalism.CFG (CFRule(..))
import GF.Formalism.Utilities (symbol, name2fun)
import GF.Conversion.Types

import qualified GF.Conversion.GFCtoSimple as G2S
import qualified GF.Conversion.SimpleToFinite as S2Fin
import qualified GF.Conversion.RemoveSingletons as RemSing
import qualified GF.Conversion.RemoveErasing as RemEra
import qualified GF.Conversion.SimpleToMCFG as S2M
import qualified GF.Conversion.MCFGtoCFG as M2C

import GF.Infra.Print

import GF.System.Tracing

----------------------------------------------------------------------
-- * GFC -> MCFG & CFG, using options to decide which conversion is used

gfc2mcfg2cfg :: Options -> (CanonGrammar, Ident) -> (MGrammar, CGrammar)
gfc2mcfg2cfg opts = \g -> let e = g2e g in trace2 "Options" (show opts) (e2m e, e2c e)
    where e2c = mcfg2cfg
	  e2m = case getOptVal opts firstCat of
		  Just cat -> flip removeErasing [identC cat]
		  Nothing  -> flip removeErasing []
	  g2e = case getOptVal opts gfcConversion of
		  Just "strict"            -> simple2mcfg_strict .                                    gfc2simple
		  Just "finite"            -> simple2mcfg_nondet .                    simple2finite . gfc2simple
		  Just "singletons"        -> simple2mcfg_nondet . removeSingletons .                 gfc2simple
		  Just "finite-singletons" -> simple2mcfg_nondet . removeSingletons . simple2finite . gfc2simple
		  Just "finite-strict"     -> simple2mcfg_strict .                    simple2finite . gfc2simple
		  _                        -> simple2mcfg_nondet .                                    gfc2simple

gfc2mcfg :: Options -> (CanonGrammar, Ident) -> MGrammar
gfc2mcfg opts = fst . gfc2mcfg2cfg opts

gfc2cfg :: Options -> (CanonGrammar, Ident) -> CGrammar
gfc2cfg opts = snd . gfc2mcfg2cfg opts

----------------------------------------------------------------------
-- * single step conversions

gfc2simple :: (CanonGrammar, Ident) -> SGrammar
gfc2simple = G2S.convertGrammar

simple2finite :: SGrammar -> SGrammar
simple2finite = S2Fin.convertGrammar

removeSingletons :: SGrammar -> SGrammar
removeSingletons = RemSing.convertGrammar

simple2mcfg_nondet :: SGrammar -> EGrammar
simple2mcfg_nondet = S2M.convertGrammarNondet

simple2mcfg_strict :: SGrammar -> EGrammar
simple2mcfg_strict = S2M.convertGrammarStrict

mcfg2cfg :: EGrammar -> CGrammar
mcfg2cfg = M2C.convertGrammar

removeErasing :: EGrammar -> [SCat] -> MGrammar
removeErasing = RemEra.convertGrammar 

----------------------------------------------------------------------
-- * converting to some obscure formats

gfc2abstract :: (CanonGrammar, Ident) -> [Abstract SCat Fun]
gfc2abstract gr = [ Abs (decl2cat decl) (map decl2cat decls) (name2fun name) |
		    Rule (Abs decl decls name) _ <- gfc2simple gr ]

abstract2prolog :: [Abstract SCat Fun] -> String
abstract2prolog gr = skvatt_hdr ++ concatMap abs2pl gr
    where abs2pl (Abs cat [] fun) = prtQuoted cat ++ " ---> " ++ 
				    "\"" ++ prt fun ++ "\".\n"
	  abs2pl (Abs cat cats fun) =
	      prtQuoted cat ++ " ---> " ++
	      "\"(" ++ prt fun ++ "\"" ++
	      prtBefore ", \" \", " (map prtQuoted cats) ++ ", \")\".\n"

cfg2prolog :: CGrammar -> String
cfg2prolog gr = skvatt_hdr ++ concatMap cfg2pl gr
    where cfg2pl (CFRule cat syms _name) =
	      prtQuoted cat ++ " ---> " ++
	      if null syms then "\"\".\n" else
	      prtSep ", " (map (symbol prtQuoted prTok) syms) ++ ".\n"
	  prTok tok = "\"" ++ tok ++ " \""

skvatt_hdr = ":- use_module(library(skvatt)).\n" ++ 
	     ":- use_module(library(utils), [repeat/1]).\n" ++
	     "corpus(File, StartCat, Depth, Size) :- \n" ++
	     "        set_flag(gendepth, Depth),\n" ++ 
	     "        tell(File), repeat(Size),\n" ++
	     "        generate_words(StartCat, String), format('~s~n~n', [String]),\n" ++
	     "        write(user_error, '.'),\n" ++ 
	     "        fail ; told.\n\n"

prtQuoted :: Print a => a -> String
prtQuoted a = "'" ++ prt a ++ "'"




