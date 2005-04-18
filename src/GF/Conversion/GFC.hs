----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/18 14:55:32 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.6 $
--
-- All conversions from GFC 
-----------------------------------------------------------------------------

module GF.Conversion.GFC 
    (module GF.Conversion.GFC,
     SGrammar, MGrammar, CGrammar) where

import Option
import GFC (CanonGrammar)
import Ident (Ident)
import GF.Conversion.Types (CGrammar, MGrammar, EGrammar, SGrammar)

import qualified GF.Conversion.GFCtoSimple as G2S
import qualified GF.Conversion.SimpleToFinite as S2Fin
import qualified GF.Conversion.RemoveSingletons as RemSing
import qualified GF.Conversion.RemoveErasing as RemEra
import qualified GF.Conversion.SimpleToMCFG as S2M
import qualified GF.Conversion.MCFGtoCFG as M2C

----------------------------------------------------------------------
-- * GFC -> MCFG & CFG, using options to decide which conversion is used

gfc2mcfg2cfg :: Options -> (CanonGrammar, Ident) -> (MGrammar, CGrammar)
gfc2mcfg2cfg opts = \g -> let e = g2e g in (e2m e, e2c e)
    where e2c = mcfg2cfg
	  e2m = removeErasing
	  g2e = case getOptVal opts gfcConversion of
		  Just "strict" -> simple2mcfg_strict . gfc2simple
		  Just "finite" -> simple2mcfg_nondet . gfc2finite
		  Just "finite-strict" -> simple2mcfg_strict . gfc2finite
		  _ -> simple2mcfg_nondet . gfc2simple

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

gfc2finite :: (CanonGrammar, Ident) -> SGrammar
gfc2finite = removeSingletons . simple2finite . gfc2simple

simple2mcfg_nondet :: SGrammar -> EGrammar
simple2mcfg_nondet = S2M.convertGrammarNondet

simple2mcfg_strict :: SGrammar -> EGrammar
simple2mcfg_strict = S2M.convertGrammarStrict

mcfg2cfg :: EGrammar -> CGrammar
mcfg2cfg = M2C.convertGrammar

removeErasing :: EGrammar -> MGrammar
removeErasing = RemEra.convertGrammar




