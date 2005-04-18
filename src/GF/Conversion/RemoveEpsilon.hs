----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/18 14:57:29 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Removing epsilon linearizations from MCF grammars
-----------------------------------------------------------------------------


module GF.Conversion.RemoveEpsilon where
--    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import Monad
import List (mapAccumL)
import Maybe (mapMaybe)
import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Conversion.Types
import GF.Data.Assoc
import GF.Data.SortedList
import GF.NewParsing.GeneralChart

convertGrammar :: EGrammar -> EGrammar
convertGrammar grammar = undefined



