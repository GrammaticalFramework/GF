----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/18 14:55:32 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- All different conversions from SimpleGFC to MCFG
-----------------------------------------------------------------------------

module GF.Conversion.SimpleToMCFG where

import GF.Formalism.SimpleGFC 
import GF.Conversion.Types

import qualified GF.Conversion.SimpleToMCFG.Strict as Strict
import qualified GF.Conversion.SimpleToMCFG.Nondet as Nondet
import qualified GF.Conversion.SimpleToMCFG.Coercions as Coerce

convertGrammarNondet, convertGrammarStrict :: SGrammar -> EGrammar
convertGrammarNondet = Coerce.addCoercions . Nondet.convertGrammar
convertGrammarStrict = Strict.convertGrammar

