----------------------------------------------------------------------
-- |
-- Module      : RedBlackSet
-- Maintainer  : Peter Ljunglöf
-- Stability   : Stable
-- Portability : Haskell 98
--
-- > CVS $Date: 2005/03/21 14:17:39 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Modified version of Okasaki's red-black trees
-- incorporating sets and set-valued maps
----------------------------------------------------------------------

module GF.Data.RedBlackSet ( -- * Red-black sets
		     RedBlackSet,
		     rbEmpty,
		     rbList,
		     rbElem,
		     rbLookup,
		     rbInsert,
		     rbMap,
		     rbOrdMap,
		     -- * Red-black finite maps
		     RedBlackMap,
		     rbmEmpty,
		     rbmList,
		     rbmElem,
		     rbmLookup,
		     rbmInsert,
		     rbmOrdMap
		   ) where

--------------------------------------------------------------------------------
-- sets

data Color = R | B   deriving (Eq, Show)
data RedBlackSet a = E | T Color (RedBlackSet a) a (RedBlackSet a)
		     deriving (Eq, Show)

rbBalance B (T R (T R a x b) y c) z d = T R (T B a x b) y (T B c z d)
rbBalance B (T R a x (T R b y c)) z d = T R (T B a x b) y (T B c z d)
rbBalance B a x (T R (T R b y c) z d) = T R (T B a x b) y (T B c z d)
rbBalance B a x (T R b y (T R c z d)) = T R (T B a x b) y (T B c z d)
rbBalance color a x b = T color a x b

rbBlack (T _ a x b) = T B a x b

-- | the empty set
rbEmpty :: RedBlackSet a
rbEmpty = E

-- | the elements of a set as a sorted list
rbList :: RedBlackSet a -> [a]
rbList tree = rbl tree []
  where rbl E = id
	rbl (T _ left a right) = rbl right . (a:) . rbl left

-- | checking for containment
rbElem :: Ord a => a -> RedBlackSet a -> Bool
rbElem _ E = False
rbElem a (T _ left a' right)
    = case compare a a' of
        LT -> rbElem a left
	GT -> rbElem a right
	EQ -> True

-- | looking up a key in a set of keys and values
rbLookup :: Ord k => k -> RedBlackSet (k, a) -> Maybe a
rbLookup _ E = Nothing
rbLookup a (T _ left (a',b) right)
    = case compare a a' of
        LT -> rbLookup a left
	GT -> rbLookup a right
	EQ -> Just b

-- | inserting a new element.
-- returns 'Nothing' if the element is already contained
rbInsert :: Ord a => a -> RedBlackSet a -> Maybe (RedBlackSet a)
rbInsert value tree = fmap rbBlack (rbins tree)
  where rbins E = Just (T R E value E)
	rbins (T color left value' right)
	    = case compare value value' of
                LT -> do left' <- rbins left
			 return (rbBalance color left' value' right)
		GT -> do right' <- rbins right
			 return (rbBalance color left value' right')
		EQ -> Nothing

-- | mapping each value of a key-value set 
rbMap :: (a -> b) -> RedBlackSet (k, a) -> RedBlackSet (k, b)
rbMap f E = E
rbMap f (T color left (key, value) right) 
    = T color (rbMap f left) (key, f value) (rbMap f right)

-- | mapping each element to another type.
-- /observe/ that the mapping function needs to preserve 
-- the order between objects
rbOrdMap :: (a -> b) -> RedBlackSet a -> RedBlackSet b
rbOrdMap f E = E
rbOrdMap f (T color left value right) 
    = T color (rbOrdMap f left) (f value) (rbOrdMap f right)

----------------------------------------------------------------------
-- finite maps

type RedBlackMap k a = RedBlackSet (k, RedBlackSet a)

-- | the empty map
rbmEmpty :: RedBlackMap k a
rbmEmpty = E

-- | converting a map to a key-value list, sorted on the keys,
-- and for each key, a sorted list of values
rbmList :: RedBlackMap k a -> [(k, [a])]
rbmList tree = [ (k, rbList sub) | (k, sub) <- rbList tree ]

-- | checking whether a key-value pair is contained in the map
rbmElem :: (Ord k, Ord a) => k -> a -> RedBlackMap k a -> Bool
rbmElem key value = maybe False (rbElem value) . rbLookup key 

-- | looking up a key, returning a (sorted) list of all matching values
rbmLookup :: Ord k => k -> RedBlackMap k a -> [a]
rbmLookup key = maybe [] rbList . rbLookup key 

-- | inserting a key-value pair.
-- returns 'Nothing' if the pair is already contained in the map
rbmInsert :: (Ord k, Ord a) => k -> a -> RedBlackMap k a -> Maybe (RedBlackMap k a)
rbmInsert key value tree = fmap rbBlack (rbins tree)
  where rbins E = Just (T R E (key, T B E value E) E)
	rbins (T color left item@(key', vtree) right)
	    = case compare key key' of
                LT -> do left' <- rbins left
			 return (rbBalance color left' item right)
		GT -> do right' <- rbins right
			 return (rbBalance color left item right')
		EQ -> do vtree' <- rbInsert value vtree
			 return (T color left (key', vtree') right)

-- | mapping each value to another type.
-- /observe/ that the mapping function needs to preserve
-- order between objects
rbmOrdMap :: (a -> b) -> RedBlackMap k a -> RedBlackMap k b
rbmOrdMap f E = E
rbmOrdMap f (T color left (key, tree) right) 
    = T color (rbmOrdMap f left) (key, rbOrdMap f tree) (rbmOrdMap f right)



