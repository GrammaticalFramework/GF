----------------------------------------------------------------------
-- |
-- Module      : Assoc
-- Maintainer  : Peter Ljunglöf
-- Stability   : Stable
-- Portability : Haskell 98
--
-- > CVS $Date: 2005/03/29 11:17:54 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Association lists, or finite maps,
-- including sets as maps with result type @()@.
-- function names stolen from module @Array@.
-- /O(log n)/ key lookup
-----------------------------------------------------------------------------

module GF.Data.Assoc ( Assoc,
		       Set,
		       emptyAssoc,
		       emptySet,
		       listAssoc,
		       listSet,
		       accumAssoc,
		       aAssocs,
		       aElems,
		       assocMap,
		       lookupAssoc,
		       lookupWith,
		       (?),
		       (?=)
		     ) where

import GF.Data.SortedList 

infixl 9 ?, ?=

-- | a set is a finite map with empty values
type Set a = Assoc a ()

emptyAssoc :: Ord a => Assoc a b
emptySet   :: Ord a => Set a

-- | creating a finite map from a sorted key-value list 
listAssoc   :: Ord a => SList (a, b) -> Assoc a b

-- | creating a set from a sorted list
listSet     :: Ord a => SList a -> Set a

-- | building a finite map from a list of keys and 'b's, 
-- and a function that combines a sorted list of 'b's into a value
accumAssoc :: (Ord a, Ord c) => (SList c -> b) -> [(a, c)] -> Assoc a b

-- | all key-value pairs from an association list
aAssocs :: Ord a => Assoc a b -> SList (a, b)

-- | all keys from an association list
aElems  :: Ord a => Assoc a b -> SList a

-- fmap :: Ord a => (b -> b') -> Assoc a b -> Assoc a b'

-- | mapping values to other values.
-- the mapping function can take the key as information
assocMap :: Ord a => (a -> b -> b') -> Assoc a b -> Assoc a b'

-- | monadic lookup function,
-- returning failure if the key does not exist
lookupAssoc :: (Ord a, Monad m) => Assoc a b -> a -> m b

-- | if the key does not exist, 
-- the first argument is returned
lookupWith :: Ord a => b -> Assoc a b -> a -> b

-- | if the values are monadic, we can return the value type
(?) :: (Ord a, Monad m) => Assoc a (m b) -> a -> m b

-- | checking wheter the map contains a given key 
(?=) :: Ord a => Assoc a b -> a -> Bool


------------------------------------------------------------

data Assoc a b = ANil | ANode (Assoc a b) a b (Assoc a b)
		 deriving (Eq, Show)

emptyAssoc = ANil
emptySet   = emptyAssoc

listAssoc as = assoc
  where (assoc, [])     = sl2bst (length as) as
	sl2bst 0 xs     = (ANil, xs)
	sl2bst 1 (x:xs) = (ANode ANil (fst x) (snd x) ANil, xs)
	sl2bst n xs     = (ANode left (fst x) (snd x) right, zs)
          where llen    = (n-1) `div` 2
                rlen    = n - 1 - llen
                (left, x:ys) = sl2bst llen xs
                (right, zs)  = sl2bst rlen ys

listSet as = listAssoc (zip as (repeat ()))

accumAssoc join = listAssoc . map (mapSnd join) . groupPairs . nubsort
    where mapSnd f (a, b) = (a, f b)

aAssocs as = prs as []
    where prs ANil = id
	  prs (ANode left a b right) = prs left . ((a,b) :) . prs right

aElems = map fst . aAssocs


instance Ord a => Functor (Assoc a) where
    fmap f = assocMap (const f)

assocMap f ANil = ANil
assocMap f (ANode left a b right) = ANode (assocMap f left) a (f a b) (assocMap f right)


lookupAssoc ANil _ = fail "key not found"
lookupAssoc (ANode left a b right) a' = case compare a a' of
					  GT -> lookupAssoc left  a'
					  LT -> lookupAssoc right a'
					  EQ -> return b

lookupWith z ANil _ = z
lookupWith z (ANode left a b right) a' = case compare a a' of
					   GT -> lookupWith z left  a'
					   LT -> lookupWith z right a'
					   EQ -> b

(?) = lookupWith (fail "key not found")

(?=) = \assoc -> maybe False (const True) . lookupAssoc assoc 







