----------------------------------------------------------------------
-- |
-- Module      : GeneralChart
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:53 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Simple implementation of deductive chart parsing
-----------------------------------------------------------------------------


module GF.OldParsing.GeneralChart
    (-- * Type definition
     Chart,
     -- * Main functions
     chartLookup,
     buildChart,
     -- * Probably not needed
     emptyChart,
     chartMember,
     chartInsert,
     chartList,
     addToChart
    ) where

-- import Trace 

import GF.Data.RedBlackSet

-- main functions

chartLookup :: (Ord item, Ord key) => Chart item key -> key -> [item]
buildChart  :: (Ord item, Ord key) => (item -> key) -> 
	       [Chart item key -> item -> [item]] -> [item] -> [item]

buildChart keyof rules axioms     = chartList (addItems axioms emptyChart)
    where addItems []             = id
	  addItems (item:items)   = addItems items . addItem item

          -- addItem item | trace ("+ "++show item++"\n") False = undefined
          addItem item            = addToChart item (keyof item) 
				    (\chart -> foldr (consequence item) chart rules)

          consequence item rule chart = addItems (rule chart item) chart

-- probably not needed

emptyChart  :: (Ord item, Ord key) => Chart item key
chartMember :: (Ord item, Ord key) => Chart item key -> item -> key -> Bool
chartInsert :: (Ord item, Ord key) => Chart item key -> item -> key -> Maybe (Chart item key)
chartList   :: (Ord item, Ord key) => Chart item key -> [item]
addToChart  :: (Ord item, Ord key) => item -> key -> (Chart item key -> Chart item key) -> Chart item key -> Chart item key

addToChart item key after chart = maybe chart after (chartInsert chart item key)


--------------------------------------------------------------------------------
-- key charts as red/black trees

newtype Chart         item key = KC (RedBlackMap key item)
    deriving Show

emptyChart                     = KC rbmEmpty
chartMember (KC tree) item key = rbmElem key item tree
chartInsert (KC tree) item key = fmap KC (rbmInsert key item tree)
chartLookup (KC tree)      key = rbmLookup key tree
chartList   (KC tree)          = concatMap snd (rbmList tree)
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

