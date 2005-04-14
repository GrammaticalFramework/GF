----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/14 11:42:05 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- All conversions from GFC 
-----------------------------------------------------------------------------

module GF.Conversion.GFC
    (module GF.Conversion.GFC,
     SGrammar, MGrammar, CGrammar) where

import GFC (CanonGrammar)
import Ident (Ident)
import GF.Conversion.Types (CGrammar, MGrammar, SGrammar)

import qualified GF.Conversion.GFCtoSimple as G2S
import qualified GF.Conversion.SimpleToFinite as S2Fin
import qualified GF.Conversion.RemoveSingletons as RemSing
import qualified GF.Conversion.SimpleToMCFG as S2M
import qualified GF.Conversion.MCFGtoCFG as M2C

gfc2simple :: (CanonGrammar, Ident) -> SGrammar
gfc2simple = G2S.convertGrammar

simple2finite :: SGrammar -> SGrammar
simple2finite = S2Fin.convertGrammar

removeSingletons :: SGrammar -> SGrammar
removeSingletons = RemSing.convertGrammar

simple2mcfg_nondet :: SGrammar -> MGrammar
simple2mcfg_nondet = S2M.convertGrammarNondet

simple2mcfg_strict :: SGrammar -> MGrammar
simple2mcfg_strict = S2M.convertGrammarStrict

mcfg2cfg :: MGrammar -> CGrammar
mcfg2cfg = M2C.convertGrammar


