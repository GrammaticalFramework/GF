----------------------------------------------------------------------
-- |
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/20 12:49:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Simple implementation of deductive chart parsing
-----------------------------------------------------------------------------

module GF.NewParsing.GeneralChart 
    (-- * Type definition
     ParseChart,
     -- * Main functions
     chartLookup,
     buildChart, buildChartM,
     -- * Probably not needed
     emptyChart,
     chartMember,
     chartInsert, chartInsertM,
     chartList, chartKeys,
     addToChart, addToChartM
    ) where

-- import Trace 

import GF.Data.RedBlackSet
import Monad (foldM)

----------------------------------------------------------------------
-- main functions

chartLookup :: (Ord item, Ord key) => ParseChart item key -> key -> [item]
chartList   :: (Ord item, Ord key) => ParseChart item key -> [item]
chartKeys   :: (Ord item, Ord key) => ParseChart item key -> [key]
buildChart  :: (Ord item, Ord key) => 
	       (item -> key)                           -- ^ key lookup function
	    -> [ParseChart item key -> item -> [item]] -- ^ list of inference rules as functions 
						       -- from triggering items to lists of items
	    -> [item]                                  -- ^ initial chart
	    -> ParseChart item key                     -- ^ final chart
buildChartM :: (Ord item, Ord key) => 
	       (item -> [key])                         -- ^ many-valued key lookup function
	    -> [ParseChart item key -> item -> [item]] -- ^ list of inference rules as functions 
						       -- from triggering items to lists of items
	    -> [item]                                  -- ^ initial chart
	    -> ParseChart item key                     -- ^ final chart

buildChart keyof rules axioms     = addItems axioms emptyChart
    where addItems []             = id
	  addItems (item:items)   = addItems items . addItem item
          -- addItem item | trace ("+ "++show item++"\n") False = undefined
          addItem item            = addToChart item (keyof item) 
				    (\chart -> foldr (consequence item) chart rules)
          consequence item rule chart = addItems (rule chart item) chart

buildChartM keysof rules axioms   = addItems axioms emptyChart
    where addItems []             = id
	  addItems (item:items)   = addItems items . addItem item
          -- addItem item | trace ("+ "++show item++"\n") False = undefined
          addItem item            = addToChartM item (keysof item) 
				    (\chart -> foldr (consequence item) chart rules)
          consequence item rule chart = addItems (rule chart item) chart

-- probably not needed

emptyChart   :: (Ord item, Ord key) => ParseChart item key
chartMember  :: (Ord item, Ord key) => ParseChart item key
	     -> item -> key -> Bool
chartInsert  :: (Ord item, Ord key) => ParseChart item key
	     -> item -> key -> Maybe (ParseChart item key)
chartInsertM :: (Ord item, Ord key) => ParseChart item key
	     -> item -> [key] -> Maybe (ParseChart item key)

addToChart  :: (Ord item, Ord key) => item -> key 
	    -> (ParseChart item key -> ParseChart item key) 
	    ->  ParseChart item key -> ParseChart item key
addToChart item keys after chart = maybe chart after (chartInsert chart item keys)

addToChartM :: (Ord item, Ord key) => item -> [key] 
	    -> (ParseChart item key -> ParseChart item key) 
	    ->  ParseChart item key -> ParseChart item key
addToChartM item keys after chart = maybe chart after (chartInsertM chart item keys)


--------------------------------------------------------------------------------
-- key charts as red/black trees

newtype ParseChart    item key = KC (RedBlackMap key item)
    deriving Show

emptyChart                     = KC rbmEmpty
chartMember (KC tree) item key = rbmElem key item tree
chartLookup (KC tree)      key = rbmLookup key tree
chartList   (KC tree)          = concatMap snd (rbmList tree)
chartKeys   (KC tree)          = map fst (rbmList tree)
chartInsert (KC tree) item key = fmap KC (rbmInsert key item tree)

chartInsertM (KC tree) item keys = fmap KC (foldM insertItem tree keys)
    where insertItem tree key    = rbmInsert key item tree

--------------------------------------------------------------------------------}


{--------------------------------------------------------------------------------
-- key charts as unsorted association lists -- OBSOLETE!

newtype Chart          item key = SC [(key, item)]

emptyChart = SC []
chartMember (SC chart) item key = (key,item) `elem` chart
chartInsert (SC chart) item key = if (key,item) `elem` chart then Nothing else Just (SC ((key,item):chart))
chartLookup (SC chart)      key = [ item | (key',item) <- chart, key == key' ]
chartList   (SC chart)          = map snd chart
--------------------------------------------------------------------------------}

