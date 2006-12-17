----------------------------------------------------------------------
-- |
-- Module      : Relation
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/26 17:13:13 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- A simple module for relations.
-----------------------------------------------------------------------------

module GF.Speech.Relation (Rel, mkRel, mkRel'
                           , allRelated , isRelatedTo
                           , transitiveClosure
                           , reflexiveClosure, reflexiveClosure_
                           , symmetricClosure
                           , symmetricSubrelation, reflexiveSubrelation
                           , reflexiveElements
                           , equivalenceClasses
                           , isTransitive, isReflexive, isSymmetric
                           , isEquivalence
                           , isSubRelationOf) where

import Data.List
import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

import GF.Data.Utilities

type Rel a = Map a (Set a)

-- | Creates a relation from a list of related pairs.
mkRel :: Ord a => [(a,a)] -> Rel a
mkRel ps = relates ps Map.empty

-- | Creates a relation from a list pairs of elements and the elements
--   related to them.
mkRel' :: Ord a => [(a,[a])] -> Rel a
mkRel' xs = Map.fromListWith Set.union [(x,Set.fromList ys) | (x,ys) <- xs]

relToList :: Rel a -> [(a,a)]
relToList r = [ (x,y) | (x,ys) <- Map.toList r, y <- Set.toList ys ]

-- | Add a pair to the relation.
relate :: Ord a => a -> a -> Rel a -> Rel a
relate x y r = Map.insertWith Set.union x (Set.singleton y) r

-- | Add a list of pairs to the relation.
relates :: Ord a => [(a,a)] -> Rel a -> Rel a
relates ps r = foldl (\r' (x,y) -> relate x y r') r ps

-- | Checks if an element is related to another.
isRelatedTo :: Ord a => Rel a -> a  -> a -> Bool
isRelatedTo r x y = maybe False (y `Set.member`) (Map.lookup x r)

-- | Get the set of elements to which a given element is related.
allRelated :: Ord a => Rel a -> a -> Set a
allRelated r x = fromMaybe Set.empty (Map.lookup x r)

-- | Get all elements in the relation.
domain :: Ord a => Rel a -> Set a
domain r = foldl Set.union (Map.keysSet r) (Map.elems r)

-- | Keep only pairs for which both elements are in the given set.
intersectSetRel :: Ord a => Set a -> Rel a -> Rel a
intersectSetRel s = filterRel (\x y -> x `Set.member` s && y `Set.member` s)

transitiveClosure :: Ord a => Rel a -> Rel a
transitiveClosure r = fix (Map.map growSet) r
  where growSet ys = foldl Set.union ys (map (allRelated r) $ Set.toList ys)

reflexiveClosure_ :: Ord a => [a] -- ^ The set over which the relation is defined.
		 -> Rel a -> Rel a
reflexiveClosure_ u r = relates [(x,x) | x <- u] r

-- | Uses 'domain'
reflexiveClosure :: Ord a => Rel a -> Rel a
reflexiveClosure r = reflexiveClosure_ (Set.toList $ domain r) r

symmetricClosure :: Ord a => Rel a -> Rel a
symmetricClosure r = relates [ (y,x) | (x,y) <- relToList r ] r

symmetricSubrelation :: Ord a => Rel a -> Rel a
symmetricSubrelation r = filterRel (flip $ isRelatedTo r) r

reflexiveSubrelation :: Ord a => Rel a -> Rel a
reflexiveSubrelation r = intersectSetRel (reflexiveElements r) r

-- | Get the set of elements which are related to themselves.
reflexiveElements :: Ord a => Rel a -> Set a
reflexiveElements r = Set.fromList [ x | (x,ys) <- Map.toList r, x `Set.member` ys ]

-- | Keep the related pairs for which the predicate is true.
filterRel :: Ord a => (a -> a -> Bool) -> Rel a -> Rel a 
filterRel p = purgeEmpty . Map.mapWithKey (Set.filter . p)

-- | Remove keys that map to no elements.
purgeEmpty :: Ord a => Rel a -> Rel a
purgeEmpty r = Map.filter (not . Set.null) r


-- | Get the equivalence classes from an equivalence relation. 
equivalenceClasses :: Ord a => Rel a -> [Set a]
equivalenceClasses r = equivalenceClasses_ (Map.keys r) r
 where equivalenceClasses_ [] _ = []
       equivalenceClasses_ (x:xs) r = ys:equivalenceClasses_ zs r
	   where ys = allRelated r x
                 zs = [x' | x' <- xs, not (x' `Set.member` ys)]

isTransitive :: Ord a => Rel a -> Bool
isTransitive r = and [z `Set.member` ys | (x,ys) <- Map.toList r, 
                      y <- Set.toList ys, z <- Set.toList (allRelated r y)]

isReflexive :: Ord a => Rel a -> Bool
isReflexive r = all (\ (x,ys) -> x `Set.member` ys) (Map.toList r)

isSymmetric :: Ord a => Rel a -> Bool
isSymmetric r = and [isRelatedTo r y x | (x,y) <- relToList r]

isEquivalence :: Ord a => Rel a -> Bool
isEquivalence r = isReflexive r && isSymmetric r && isTransitive r

isSubRelationOf :: Ord a => Rel a -> Rel a -> Bool
isSubRelationOf r1 r2 = all (uncurry (isRelatedTo r2)) (relToList r1)