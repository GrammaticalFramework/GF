----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/01 09:53:18 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.14 $
--
-- All conversions from GFC 
-----------------------------------------------------------------------------

module GF.Conversion.GFC
    (module GF.Conversion.GFC,
     SGrammar, EGrammar, MGrammar, FGrammar, CGrammar) where

import GF.Infra.Option
import GF.Canon.GFC (CanonGrammar)
import GF.Infra.Ident (Ident, identC)
import qualified GF.Infra.Modules as M

import GF.Formalism.GCFG (Rule(..), Abstract(..))
import GF.Formalism.SimpleGFC (decl2cat)
import GF.Formalism.CFG (CFRule(..))
import GF.Formalism.Utilities (symbol, name2fun)
import GF.Conversion.Types

import qualified GF.Conversion.GFCtoSimple as G2S
import qualified GF.Conversion.SimpleToFinite as S2Fin
import qualified GF.Conversion.RemoveSingletons as RemSing
import qualified GF.Conversion.RemoveErasing as RemEra
import qualified GF.Conversion.RemoveEpsilon as RemEps
import qualified GF.Conversion.SimpleToMCFG as S2M
import qualified GF.Conversion.MCFGtoCFG as M2C

import GF.Infra.Print

import GF.System.Tracing
import qualified Debug.Trace as D

----------------------------------------------------------------------
-- * GFC -> MCFG & CFG, using options to decide which conversion is used

convertGFC :: Options -> (CanonGrammar, Ident)
           -> (SGrammar, (EGrammar, (MGrammar, CGrammar)))
convertGFC opts = \g -> let s = g2s g
                            e = s2e s 
                            m = e2m e
                        in D.trace (show ((M.greatestAbstract (fst g),snd g))) $ trace2 "Options" (show opts) (s, (e, (m, e2c e)))
    where e2c = M2C.convertGrammar
	  e2m = case getOptVal opts firstCat of
		  Just cat -> flip erasing [identC cat]
		  Nothing  -> flip erasing []
	  s2e = case getOptVal opts gfcConversion of
		  Just "strict"            -> strict
		  Just "finite-strict"     -> strict
		  Just "epsilon"           -> epsilon . nondet
		  _                        -> nondet
	  g2s = case getOptVal opts gfcConversion of
		  Just "finite"            -> finite . simple
		  Just "finite2"           -> finite . finite . simple
		  Just "finite3"           -> finite . finite . finite . simple
		  Just "singletons"        -> single . simple
		  Just "finite-singletons" -> single . finite . simple
		  Just "finite-strict"     -> finite . simple
		  _                        -> simple

          simple  = G2S.convertGrammar
          strict  = S2M.convertGrammarStrict
          nondet  = S2M.convertGrammarNondet
          epsilon = RemEps.convertGrammar
          finite  = S2Fin.convertGrammar
          single  = RemSing.convertGrammar
          erasing = RemEra.convertGrammar

gfc2simple :: Options -> (CanonGrammar, Ident) -> SGrammar
gfc2simple opts = fst . convertGFC opts 

gfc2mcfg :: Options -> (CanonGrammar, Ident) -> MGrammar
gfc2mcfg opts g = mcfg
  where
    (mcfg, _) = snd (snd (convertGFC opts g))

gfc2cfg :: Options -> (CanonGrammar, Ident) -> CGrammar
gfc2cfg opts g = cfg
  where
    (_, cfg) = snd (snd (convertGFC opts g))


----------------------------------------------------------------------
-- * single step conversions

{-
gfc2simple :: (CanonGrammar, Ident) -> SGrammar
gfc2simple = G2S.convertGrammar

simple2finite :: SGrammar -> SGrammar
simple2finite = S2Fin.convertGrammar

removeSingletons :: SGrammar -> SGrammar
removeSingletons = RemSing.convertGrammar

simple2mcfg_nondet :: SGrammar -> EGrammar
simple2mcfg_nondet = 

simple2mcfg_strict :: SGrammar -> EGrammar
simple2mcfg_strict = S2M.convertGrammarStrict

mcfg2cfg :: EGrammar -> CGrammar
mcfg2cfg = M2C.convertGrammar

removeErasing :: EGrammar -> [SCat] -> MGrammar
removeErasing = RemEra.convertGrammar 

removeEpsilon :: EGrammar -> EGrammar
removeEpsilon = RemEps.convertGrammar 
-}

----------------------------------------------------------------------
-- * converting to some obscure formats

gfc2abstract :: (CanonGrammar, Ident) -> [Abstract SCat Fun]
gfc2abstract gr = [ Abs (decl2cat decl) (map decl2cat decls) (name2fun name) |
		    Rule (Abs decl decls name) _ <- G2S.convertGrammar gr ]

abstract2skvatt :: [Abstract SCat Fun] -> String
abstract2skvatt gr = skvatt_hdr ++ concatMap abs2pl gr
    where abs2pl (Abs cat [] fun) = prtQuoted cat ++ " ---> " ++ 
				    "\"" ++ prt fun ++ "\".\n"
	  abs2pl (Abs cat cats fun) =
	      prtQuoted cat ++ " ---> " ++
	      "\"(" ++ prt fun ++ "\"" ++
	      prtBefore ", \" \", " (map prtQuoted cats) ++ ", \")\".\n"

cfg2skvatt :: CGrammar -> String
cfg2skvatt gr = skvatt_hdr ++ concatMap cfg2pl gr
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




