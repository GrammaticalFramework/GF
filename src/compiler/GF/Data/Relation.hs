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

module GF.Data.Relation (Rel, mkRel, mkRel'
                           , allRelated , isRelatedTo
                           , transitiveClosure
                           , reflexiveClosure, reflexiveClosure_
                           , symmetricClosure
                           , symmetricSubrelation, reflexiveSubrelation
                           , reflexiveElements
                           , equivalenceClasses
                           , isTransitive, isReflexive, isSymmetric
                           , isEquivalence
                           , isSubRelationOf
                           , topologicalSort) where

import Data.Foldable (toList)
import Data.List
import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Sequence (Seq)
import qualified Data.Sequence as Seq
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

relToList :: Ord a => Rel a -> [(a,a)]
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

reverseRel :: Ord a => Rel a -> Rel a
reverseRel r = mkRel [(y,x) | (x,y) <- relToList r]

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
filterRel p = fst . purgeEmpty . Map.mapWithKey (Set.filter . p)

-- | Remove keys that map to no elements.
purgeEmpty :: Ord a => Rel a -> (Rel a, Set a)
purgeEmpty r = let (r',r'') = Map.partition (not . Set.null) r
                in (r', Map.keysSet r'')

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

-- | Returns 'Left' if there are cycles, and 'Right' if there are cycles.
topologicalSort :: Ord a => Rel a -> Either [a] [[a]]
topologicalSort r = tsort r' noIncoming Seq.empty
  where r' = relToRel' r
        noIncoming = Seq.fromList [x | (x,(is,_)) <- Map.toList r', Set.null is]

tsort :: Ord a => Rel' a -> Seq a -> Seq a -> Either [a] [[a]]
tsort r xs l = case Seq.viewl xs of
                 Seq.EmptyL | isEmpty' r -> Left (toList l)
                            | otherwise  -> Right (findCycles (rel'ToRel r))
                 x Seq.:< xs -> tsort r' (xs Seq.>< Seq.fromList new) (l Seq.|> x)
                     where (r',_,os) = remove x r
                           new = [o | o <- Set.toList os, Set.null (incoming o r')]

findCycles :: Ord a => Rel a -> [[a]]
findCycles = map Set.toList . equivalenceClasses . reflexiveSubrelation . symmetricSubrelation . transitiveClosure

--
-- * Alternative representation that keeps both incoming and outgoing edges
--

-- | Keeps both incoming and outgoing edges.
type Rel' a = Map a (Set a, Set a)

isEmpty' :: Ord a => Rel' a -> Bool
isEmpty' = Map.null

relToRel' :: Ord a => Rel a -> Rel' a
relToRel' r = Map.unionWith (\ (i,_) (_,o) -> (i,o)) ir or
  where ir = Map.map (\s -> (s,Set.empty)) $ reverseRel r
        or = Map.map (\s -> (Set.empty,s)) $ r

rel'ToRel :: Ord a => Rel' a -> Rel a
rel'ToRel = Map.map snd

-- | Removes an element from a relation.
-- Returns the new relation, and the set of incoming and outgoing edges
-- of the removed element.
remove :: Ord a => a -> Rel' a -> (Rel' a, Set a, Set a)
remove x r = let (mss,r') = Map.updateLookupWithKey (\_ _ -> Nothing) x r
              in case mss of
                   -- element was not in the relation
                   Nothing      -> (r', Set.empty, Set.empty)
                   -- remove element from all incoming and outgoing sets
                   -- of other elements
                   Just (is,os) -> 
                       let r''  = foldr (\i -> Map.adjust (\ (is',os') -> (is', Set.delete x os')) i) r'  $ Set.toList is
                           r''' = foldr (\o -> Map.adjust (\ (is',os') -> (Set.delete x is', os')) o) r'' $ Set.toList os
                        in (r''', is, os)

incoming :: Ord a => a -> Rel' a -> Set a
incoming x r = maybe Set.empty fst $ Map.lookup x r

outgoing :: Ord a => a -> Rel' a -> Set a
outgoing x r = maybe Set.empty snd $ Map.lookup x r