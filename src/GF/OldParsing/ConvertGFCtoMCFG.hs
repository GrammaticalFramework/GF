----------------------------------------------------------------------
-- |
-- Module      : ConvertGFCtoMCFG
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:44 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- All different conversions from GFC to MCFG
-----------------------------------------------------------------------------


module GF.OldParsing.ConvertGFCtoMCFG
    (convertGrammar) where

import GF.Canon.GFC (CanonGrammar)
import GF.OldParsing.GrammarTypes
import GF.Infra.Ident (Ident(..))
import GF.Infra.Option
import GF.System.Tracing

import qualified GF.OldParsing.ConvertGFCtoMCFG.Old as Old
import qualified GF.OldParsing.ConvertGFCtoMCFG.Nondet as Nondet
import qualified GF.OldParsing.ConvertGFCtoMCFG.Strict as Strict
import qualified GF.OldParsing.ConvertGFCtoMCFG.Coercions as Coerce

convertGrammar :: String -> (CanonGrammar, Ident) -> MCFGrammar
convertGrammar "nondet" = Coerce.addCoercions . Nondet.convertGrammar
convertGrammar "strict" = Strict.convertGrammar
convertGrammar "old" = Old.convertGrammar

