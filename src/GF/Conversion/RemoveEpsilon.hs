----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:52 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Removing epsilon linearizations from MCF grammars
-----------------------------------------------------------------------------


module GF.Conversion.RemoveEpsilon where
--    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import Control.Monad
import Data.List (mapAccumL)
import Data.Maybe (mapMaybe)
import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Conversion.Types
import GF.Data.Assoc
import GF.Data.SortedList
import GF.Data.GeneralDeduction

convertGrammar :: EGrammar -> EGrammar
convertGrammar grammar = undefined



