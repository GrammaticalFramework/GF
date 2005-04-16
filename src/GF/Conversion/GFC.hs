----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 05:40:49 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- All conversions from GFC 
-----------------------------------------------------------------------------

module GF.Conversion.GFC
    (module GF.Conversion.GFC,
     SGrammar, MGrammar, CGrammar) where

import Option
import GFC (CanonGrammar)
import Ident (Ident)
import GF.Conversion.Types (CGrammar, MGrammar, NGrammar, SGrammar)

import qualified GF.Conversion.GFCtoSimple as G2S
import qualified GF.Conversion.SimpleToFinite as S2Fin
import qualified GF.Conversion.RemoveSingletons as RemSing
import qualified GF.Conversion.RemoveErasing as RemEra
import qualified GF.Conversion.SimpleToMCFG as S2M
import qualified GF.Conversion.MCFGtoCFG as M2C

----------------------------------------------------------------------
-- * GFC -> MCFG & CFG, using options to decide which conversion is used

gfc2mcfg2cfg :: Options -> (CanonGrammar, Ident) -> (MGrammar, CGrammar)
gfc2mcfg2cfg opts = \g -> let m = g2m g in (m, m2c m)
    where m2c = mcfg2cfg
	  g2m = case getOptVal opts gfcConversion of
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

simple2mcfg_nondet :: SGrammar -> MGrammar
simple2mcfg_nondet = S2M.convertGrammarNondet

simple2mcfg_strict :: SGrammar -> MGrammar
simple2mcfg_strict = S2M.convertGrammarStrict

mcfg2cfg :: MGrammar -> CGrammar
mcfg2cfg = M2C.convertGrammar

removeErasing :: MGrammar -> NGrammar
removeErasing = RemEra.convertGrammar

-- | this function is unnecessary, because of the following equivalence:
--
-- >    mcfg2cfg == ne_mcfg2cfg . removeErasing
--
ne_mcfg2cfg :: NGrammar -> CGrammar
ne_mcfg2cfg = M2C.convertNEGrammar



