----------------------------------------------------------------------
-- |
-- Module      : SortedList
-- Maintainer  : Peter Ljunglöf
-- Stability   : stable
-- Portability : portable
--
-- > CVS $Date: 2005/03/21 14:17:39 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Sets as sorted lists
--
--    * /O(n)/   union, difference and intersection 
--
--    * /O(n log n)/ creating a set from a list (=sorting)
--
--    * /O(n^2)/ fixed point iteration
-----------------------------------------------------------------------------

module GF.Data.SortedList ( SList, 
		    nubsort, union, 
		    (<++>), (<\\>), (<**>), 
		    limit,
		    hasCommonElements, subset, 
		    groupPairs, groupUnion
		  ) where

import List (groupBy)

-- | The list must be sorted and contain no duplicates.
type SList a = [a]

-- | Group a set of key-value pairs into
-- a set of unique keys with sets of values
groupPairs :: Ord a => SList (a, b) -> SList (a, SList b)
groupPairs = map mapFst . groupBy eqFst
    where mapFst as = (fst (head as), map snd as)
	  eqFst a b = fst a == fst b

-- | Group a set of key-(sets-of-values) pairs into
-- a set of unique keys with sets of values
groupUnion :: (Ord a, Ord b) => SList (a, SList b) -> SList (a, SList b)
groupUnion = map unionSnd . groupPairs
    where unionSnd (a, bs) = (a, union bs)

-- | True is the two sets has common elements
hasCommonElements :: Ord a => SList a -> SList a -> Bool
hasCommonElements as bs = not (null (as <**> bs))

-- | True if the first argument is a subset of the second argument
subset :: Ord a => SList a -> SList a -> Bool
xs `subset` ys = null (xs <\\> ys)

-- | Create a set from any list.
-- This function can also be used as an alternative to @nub@ in @List.hs@
nubsort :: Ord a => [a] -> SList a
nubsort = union . map return

-- | The union of a list of sets
union :: Ord a => [SList a] -> SList a
union []   = []
union [as] = as
union abs  = let (as, bs) = split abs in union as <++> union bs
	      where split (a:b:abs) = let (as, bs) = split abs in (a:as, b:bs)
		    split as        = (as, [])

-- | The union of two sets
(<++>) :: Ord a => SList a -> SList a -> SList a 
[] <++> bs = bs
as <++> [] = as
as@(a:as') <++> bs@(b:bs') = case compare a b of
			       LT -> a : (as' <++> bs)
			       GT -> b : (as  <++> bs')
			       EQ -> a : (as' <++> bs')

-- | The difference of two sets
(<\\>) :: Ord a => SList a -> SList a -> SList a 
[] <\\> bs = []
as <\\> [] = as
as@(a:as') <\\> bs@(b:bs') = case compare a b of
			       LT -> a : (as' <\\> bs)
			       GT ->     (as  <\\> bs')
			       EQ ->     (as' <\\> bs')

-- | The intersection of two sets
(<**>) :: Ord a => SList a -> SList a -> SList a
[] <**> bs = []
as <**> [] = []
as@(a:as') <**> bs@(b:bs') = case compare a b of
			       LT ->     (as' <**> bs)
			       GT ->     (as  <**> bs')
			       EQ -> a : (as' <**> bs')

-- | A fixed point iteration 
limit :: Ord a => (a -> SList a)  -- ^ The iterator function
      -> SList a                  -- ^ The initial set
      -> SList a                  -- ^ The result of the iteration
limit more start = limit' start start
    where limit' chart agenda | null new' = chart
			      | otherwise = limit' (chart <++> new') new'
	      where new = union (map more agenda)
		    new'= new <\\> chart





