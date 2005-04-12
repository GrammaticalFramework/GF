----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/12 10:49:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- All different conversions from SimpleGFC to MCFG
-----------------------------------------------------------------------------

module GF.Conversion.SimpleToMCFG where

import GF.Formalism.SimpleGFC 
import GF.Conversion.Types

import qualified GF.Conversion.SimpleToMCFG.Strict as Strict
import qualified GF.Conversion.SimpleToMCFG.Nondet as Nondet
import qualified GF.Conversion.SimpleToMCFG.Coercions as Coerce

convertGrammarNondet, convertGrammarStrict :: SGrammar -> MGrammar
convertGrammarNondet = Coerce.addCoercions . Nondet.convertGrammar
convertGrammarStrict = Strict.convertGrammar

