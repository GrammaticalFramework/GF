----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:48 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- All conversions from GFC 
-----------------------------------------------------------------------------

module GF.Conversion.GFC
    (module GF.Conversion.GFC,
     SimpleGrammar, MGrammar, CGrammar) where

import GFC (CanonGrammar)
import Ident (Ident)
import GF.Formalism.SimpleGFC (SimpleGrammar)
import GF.Conversion.Types (CGrammar, MGrammar)

import qualified GF.Conversion.GFCtoSimple as G2S
import qualified GF.Conversion.SimpleToFinite as S2Fin
import qualified GF.Conversion.SimpleToMCFG as S2M
import qualified GF.Conversion.MCFGtoCFG as M2C

gfc2simple :: (CanonGrammar, Ident) -> SimpleGrammar
gfc2simple = G2S.convertGrammar

simple2finite :: SimpleGrammar -> SimpleGrammar
simple2finite = S2Fin.convertGrammar

simple2mcfg_nondet :: SimpleGrammar -> MGrammar
simple2mcfg_nondet = S2M.convertGrammarNondet

simple2mcfg_strict :: SimpleGrammar -> MGrammar
simple2mcfg_strict = S2M.convertGrammarStrict

mcfg2cfg :: MGrammar -> CGrammar
mcfg2cfg = M2C.convertGrammar


