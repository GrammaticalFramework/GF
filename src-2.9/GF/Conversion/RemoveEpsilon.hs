----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 08:11:32 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
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
convertGrammar grammar = trace2 "RemoveEpsilon: initialEmpties" (prt initialEmpties) $
			 trace2 "RemoveEpsilon: emptyCats" (prt emptyCats) $
			 grammar 
    where initialEmpties  = nubsort [ (cat, lbl)  | 
				      Rule (Abs cat _ _) (Cnc _ _ lins) <- grammar,
				      Lin lbl [] <- lins ]
	  emptyCats       = limitEmpties initialEmpties
	  limitEmpties es = if es==es' then es else limitEmpties es'
	      where es'   = nubsort [ (cat, lbl) | Rule (Abs cat _ _) (Cnc _ _ lins) <- grammar, 
				      Lin lbl rhs <- lins,
				      all (symbol (\(c,l,n) -> (c,l) `elem` es) (const False)) rhs ]



