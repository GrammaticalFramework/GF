module GF.Data.TrieMap
         ( TrieMap

         , empty
         , singleton

         , lookup
         
         , null
         , compose
         , decompose
         
         , insertWith

         , union,  unionWith
         , unions, unionsWith
         
         , elems
         , toList
         ) where

import Prelude hiding (lookup, null)
import qualified Data.Map as Map

data TrieMap k v = Tr (Maybe v) (Map.Map k (TrieMap k v))

empty = Tr Nothing Map.empty

singleton :: [k] -> a -> TrieMap k a
singleton []     v = Tr (Just v) Map.empty
singleton (k:ks) v = Tr Nothing  (Map.singleton k (singleton ks v))

lookup :: Ord k => [k] -> TrieMap k a -> Maybe a
lookup []     (Tr mb_v m) = mb_v
lookup (k:ks) (Tr mb_v m) = Map.lookup k m >>= lookup ks

null :: TrieMap k v -> Bool
null (Tr Nothing m) = Map.null m
null _              = False

compose :: Maybe v -> Map.Map k (TrieMap k v) -> TrieMap k v
compose mb_v m = Tr mb_v m

decompose :: TrieMap k v -> (Maybe v, Map.Map k (TrieMap k v))
decompose (Tr mb_v m) = (mb_v,m)

insertWith :: Ord k => (v -> v -> v) -> [k] -> v -> TrieMap k v -> TrieMap k v
insertWith f []     v0 (Tr mb_v m) = case mb_v of
                                       Just  v -> Tr (Just (f v0 v)) m
                                       Nothing -> Tr (Just v0      ) m
insertWith f (k:ks) v0 (Tr mb_v m) = case Map.lookup k m of
                                       Nothing -> Tr mb_v (Map.insert k (singleton ks v0) m)
                                       Just tr -> Tr mb_v (Map.insert k (insertWith f ks v0 tr) m)

union :: Ord k => TrieMap k v -> TrieMap k v -> TrieMap k v
union = unionWith (\a b -> a)

unionWith :: Ord k => (v -> v -> v) -> TrieMap k v -> TrieMap k v -> TrieMap k v
unionWith f (Tr mb_v1 m1) (Tr mb_v2 m2) =
  let mb_v = case (mb_v1,mb_v2) of
               (Nothing,Nothing) -> Nothing
               (Just v ,Nothing) -> Just v
               (Nothing,Just v ) -> Just v
               (Just v1,Just v2) -> Just (f v1 v2)
      m    = Map.unionWith (unionWith f) m1 m2
  in Tr mb_v m

unions :: Ord k => [TrieMap k v] -> TrieMap k v
unions = foldl union empty

unionsWith :: Ord k => (v -> v -> v) -> [TrieMap k v] -> TrieMap k v
unionsWith f = foldl (unionWith f) empty

elems :: TrieMap k v -> [v]
elems tr = collect tr []
  where
    collect (Tr mb_v m) xs = maybe id (:) mb_v (Map.fold collect xs m)

toList :: TrieMap k v -> [([k],v)]
toList tr = collect [] tr []
  where
    collect ks (Tr mb_v m) xs = maybe id (\v -> (:) (ks,v)) mb_v (Map.foldWithKey (\k -> collect (k:ks)) xs m)
