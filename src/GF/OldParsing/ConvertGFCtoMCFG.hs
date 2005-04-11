----------------------------------------------------------------------
-- |
-- Module      : ConvertGFCtoMCFG
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:52 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- All different conversions from GFC to MCFG
-----------------------------------------------------------------------------


module GF.OldParsing.ConvertGFCtoMCFG
    (convertGrammar) where

import GFC (CanonGrammar)
import GF.OldParsing.GrammarTypes
import Ident (Ident(..))
import Option
import GF.System.Tracing

import qualified GF.OldParsing.ConvertGFCtoMCFG.Old as Old
import qualified GF.OldParsing.ConvertGFCtoMCFG.Nondet as Nondet
import qualified GF.OldParsing.ConvertGFCtoMCFG.Strict as Strict
import qualified GF.OldParsing.ConvertGFCtoMCFG.Coercions as Coerce

convertGrammar :: String -> (CanonGrammar, Ident) -> MCFGrammar
convertGrammar "nondet" = Coerce.addCoercions . Nondet.convertGrammar
convertGrammar "strict" = Strict.convertGrammar
convertGrammar "old" = Old.convertGrammar

