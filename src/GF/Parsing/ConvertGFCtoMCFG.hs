----------------------------------------------------------------------
-- |
-- Module      : ConvertGFCtoMCFG
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/29 11:17:54 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- All different conversions from GFC to MCFG
-----------------------------------------------------------------------------


module GF.Parsing.ConvertGFCtoMCFG
    (convertGrammar) where

import GFC (CanonGrammar)
import GF.Parsing.GrammarTypes
import Ident (Ident(..))
import Option
import GF.System.Tracing

import qualified GF.Parsing.ConvertGFCtoMCFG.Old as Old
import qualified GF.Parsing.ConvertGFCtoMCFG.Nondet as Nondet
import qualified GF.Parsing.ConvertGFCtoMCFG.Strict as Strict
import qualified GF.Parsing.ConvertGFCtoMCFG.Coercions as Coerce

convertGrammar :: String -> (CanonGrammar, Ident) -> MCFGrammar
convertGrammar "nondet" = Coerce.addCoercions . Nondet.convertGrammar
convertGrammar "strict" = Strict.convertGrammar
convertGrammar "old" = Old.convertGrammar

