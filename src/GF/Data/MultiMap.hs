module GF.Data.MultiMap where

import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set
import Prelude hiding (map)
import qualified Prelude

type MultiMap k a = Map k (Set a)

empty :: MultiMap k a
empty = Map.empty

keys :: MultiMap k a -> [k]
keys = Map.keys

elems :: MultiMap k a -> [a]
elems = concatMap Set.toList . Map.elems

(!) :: Ord k => MultiMap k a -> k -> [a]
m ! k = Set.toList $ Map.findWithDefault Set.empty k m

member :: (Ord k, Ord a) => k -> a -> MultiMap k a -> Bool
member k x m = x `Set.member` Map.findWithDefault Set.empty k m

insert :: (Ord k, Ord a) => k -> a -> MultiMap k a -> MultiMap k a
insert k x m = Map.insertWith Set.union k (Set.singleton x) m

insert' :: (Ord k, Ord a) => k -> a -> MultiMap k a -> Maybe (MultiMap k a)
insert' k x m | member k x m = Nothing -- FIXME: inefficient
              | otherwise = Just (insert k x m)

union :: (Ord k, Ord a) => MultiMap k a -> MultiMap k a -> MultiMap k a
union = Map.unionWith Set.union

size :: MultiMap k a -> Int
size = sum . Prelude.map Set.size . Map.elems

map :: (Ord a, Ord b) => (a -> b) -> MultiMap k a -> MultiMap k b
map f = Map.map (Set.map f)

fromList :: (Ord k, Ord a) => [(k,a)] -> MultiMap k a
fromList xs = Map.fromListWith Set.union [(k, Set.singleton x) | (k,x) <- xs]

toList :: MultiMap k a -> [(k,a)]
toList m = [(k,x) | (k,s) <- Map.toList m, x <- Set.toList s]