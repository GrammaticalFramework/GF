----------------------------------------------------------------------
-- |
-- Module      : IncrementalChart
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 14:17:42 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Implementation of /incremental/ deductive parsing,
-- i.e. parsing one word at the time.
-----------------------------------------------------------------------------


module GF.Parsing.IncrementalChart (-- * Type definitions
			 IncrementalChart,
			 -- * Functions
			 buildChart,
			 chartList
			) where

import Array
import GF.Data.SortedList
import GF.Data.Assoc

buildChart :: (Ord item, Ord key) => (item -> key) -> 
	      (Int -> item -> SList item) -> 
	      (Int ->         SList item) -> 
	      (Int, Int) -> IncrementalChart item key

chartList :: (Ord item, Ord key) => (Int -> item -> edge) -> IncrementalChart item key -> [edge]

type IncrementalChart item key = Array Int (Assoc key (SList item))

----------

buildChart keyof rules axioms bounds = finalChartArray
    where buildState k     = limit (rules k) $ axioms k
	  finalChartList   = map buildState [fst bounds .. snd bounds]
	  finalChartArray  = listArray bounds $ map stateAssoc finalChartList
	  stateAssoc state = accumAssoc id [ (keyof item, item) | item <- state ]

chartList combine chart = [ combine k item | 
			    (k, state) <- assocs chart, 
			    item <- concatMap snd $ aAssocs state ]


