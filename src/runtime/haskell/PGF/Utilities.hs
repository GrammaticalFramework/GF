-- | Basic utilities
module PGF.Utilities where
import Data.Set(empty,member,insert)


-- | Like 'nub', but O(n log n) instead of O(n^2), since it uses a set to lookup previous things.
--   The result list is stable (the elements are returned in the order they occur), and lazy.
--   Requires that the list elements can be compared by Ord.
--   Code ruthlessly taken from http://hpaste.org/54411
nub' :: Ord a => [a] -> [a]
nub' = loop empty
    where loop _    []            = []
          loop seen (x : xs)
              | member x seen = loop seen xs
              | otherwise         = x : loop (insert x seen) xs


-- | Replace all occurences of an element by another element.
replace :: Eq a => a -> a -> [a] -> [a]
replace x y = map (\z -> if z == x then y else z)
