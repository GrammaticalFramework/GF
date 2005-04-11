----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:53 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- All different conversions from SimpleGFC to MCFG
-----------------------------------------------------------------------------


module GF.OldParsing.ConvertSimpleToMCFG
    (convertGrammar) where

import qualified GF.OldParsing.SimpleGFC as S
--import GF.OldParsing.GrammarTypes

import qualified GF.OldParsing.ConvertFiniteSimple as Fin
import qualified GF.OldParsing.ConvertSimpleToMCFG.Nondet as Nondet
--import qualified GF.OldParsing.ConvertSimpleToMCFG.Strict as Strict
import qualified GF.OldParsing.ConvertSimpleToMCFG.Coercions as Coerce

--convertGrammar :: String -> S.Grammar -> MCFGrammar
convertGrammar ('f':'i':'n':'-':cnv) = convertGrammar cnv . Fin.convertGrammar
convertGrammar "nondet" = Coerce.addCoercions . Nondet.convertGrammar
--convertGrammar "strict" = Strict.convertGrammar

