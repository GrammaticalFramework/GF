----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/09 09:28:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- Implementation of /incremental/ deductive parsing,
-- i.e. parsing one word at the time.
-----------------------------------------------------------------------------

module GF.Data.IncrementalDeduction
    (-- * Type definitions
     IncrementalChart,
     -- * Functions
     chartLookup,
     buildChart,
     chartList, chartKeys
    ) where

import Data.Array
import GF.Data.SortedList
import GF.Data.Assoc

----------------------------------------------------------------------
-- main functions 

chartLookup :: (Ord item, Ord key) =>
	       IncrementalChart item key
	    -> Int -> key -> SList item

buildChart :: (Ord item, Ord key) => 
	      (item -> key)               -- ^ key lookup function
	   -> (Int -> item -> SList item) -- ^ all inference rules for position k, collected
	   -> (Int ->         SList item) -- ^ all axioms for position k, collected
	   -> (Int, Int)                  -- ^ input bounds
	   -> IncrementalChart item key

chartList :: (Ord item, Ord key) => 
	     IncrementalChart item key    -- ^ the final chart
	  -> (Int -> item -> edge)        -- ^ function building an edge from 
					  -- the position and the item
	  -> [edge]

chartKeys :: (Ord item, Ord key) => IncrementalChart item key -> Int -> [key]

type IncrementalChart item key = Array Int (Assoc key (SList item))

----------

chartLookup chart k key = (chart ! k) ? key

buildChart keyof rules axioms bounds = finalChartArray
    where buildState k     = limit (rules k) $ axioms k
	  finalChartList   = map buildState [fst bounds .. snd bounds]
	  finalChartArray  = listArray bounds $ map stateAssoc finalChartList
	  stateAssoc state = accumAssoc id [ (keyof item, item) | item <- state ]

chartList chart combine = [ combine k item | 
			    (k, state) <- assocs chart, 
			    item <- concatMap snd $ aAssocs state ]

chartKeys chart k = aElems (chart ! k)

