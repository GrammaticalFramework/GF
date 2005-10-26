----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/26 18:47:16 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- Basic functions not in the standard libraries
-----------------------------------------------------------------------------


module GF.Data.Utilities where

import Data.Maybe
import Data.List
import Control.Monad (MonadPlus(..),liftM)

-- * functions on lists

sameLength :: [a] -> [a] -> Bool
sameLength [] [] = True
sameLength (_:xs) (_:ys) = sameLength xs ys
sameLength _ _ = False

notLongerThan, longerThan :: Int -> [a] -> Bool
notLongerThan n = null . snd . splitAt n
longerThan    n = not . notLongerThan n

lookupList :: Eq a => a -> [(a, b)] -> [b]
lookupList a [] = []
lookupList a (p:ps) | a == fst p = snd p : lookupList a ps
		    | otherwise  =         lookupList a ps

-- | Find the first list in a list of lists
--   which contains the argument.
findSet :: Eq c => c -> [[c]] -> Maybe [c]
findSet x = find (x `elem`)

split :: [a] -> ([a], [a])
split (x : y : as) = (x:xs, y:ys)
    where (xs, ys) = split as
split as = (as, [])

splitBy :: (a -> Bool) -> [a] -> ([a], [a])
splitBy p [] = ([], [])
splitBy p (a : as) = if p a then (a:xs, ys) else (xs, a:ys)
    where (xs, ys) = splitBy p as

foldMerge :: (a -> a -> a) -> a -> [a] -> a
foldMerge merge zero = fm
    where fm [] = zero
	  fm [a] = a
	  fm abs = let (as, bs) = split abs in fm as `merge` fm bs

select :: [a] -> [(a, [a])]
select [] = []
select (x:xs) = (x,xs) : [ (y,x:ys) | (y,ys) <- select xs ]

updateNth :: (a -> a) -> Int -> [a] -> [a]
updateNth update 0 (a : as) = update a : as
updateNth update n (a : as) = a : updateNth update (n-1) as

updateNthM :: Monad m => (a -> m a) -> Int -> [a] -> m [a]
updateNthM update 0 (a : as) = liftM (:as) (update a)
updateNthM update n (a : as) = liftM (a:)  (updateNthM update (n-1) as)

-- | Like 'init', but returns the empty list when the input is empty.
safeInit :: [a] -> [a]
safeInit [] = []
safeInit xs = init xs

-- | Like 'nub', but more efficient as it uses sorting internally.
sortNub :: Ord a => [a] -> [a]
sortNub = map head . group . sort

-- | Like 'nubBy', but more efficient as it uses sorting internally.
sortNubBy :: (a -> a -> Ordering) -> [a] -> [a]
sortNubBy f = map head . groupBy (compareEq f) . sortBy f

-- | Take the union of a list of lists.
unionAll :: Eq a => [[a]] -> [a]
unionAll = nub . concat

-- | Like 'lookup', but fails if the argument is not found,
--   instead of returning Nothing.
lookup' :: Eq a => a -> [(a,b)] -> b
lookup' x = fromJust . lookup x

-- | Like 'find', but fails if nothing is found.
find' :: (a -> Bool) -> [a] -> a
find' p = fromJust . find p

-- * equality functions

-- | Use an ordering function as an equality predicate.
compareEq :: (a -> a -> Ordering) -> a -> a -> Bool
compareEq f x y = case f x y of
                             EQ -> True
                             _ -> False

-- * ordering functions

compareBy :: Ord b => (a -> b) -> a -> a -> Ordering
compareBy f = both f compare

both :: (a -> b) -> (b -> b -> c) -> a -> a -> c
both f g x y = g (f x) (f y)

-- * functions on pairs

mapFst :: (a -> a') -> (a, b) -> (a', b)
mapFst f (a, b) = (f a, b)

mapSnd :: (b -> b') -> (a, b) -> (a, b')
mapSnd f (a, b) = (a, f b)

-- * functions on monads

-- | Return the given value if the boolean is true, els return 'mzero'.
whenMP :: MonadPlus m => Bool -> a -> m a
whenMP b x = if b then return x else mzero

-- * functions on Maybes

-- | Returns true if the argument is Nothing or Just []
nothingOrNull :: Maybe [a] -> Bool
nothingOrNull = maybe True null

-- * functions on functions

-- | Apply all the functions in the list to the argument.
foldFuns :: [a -> a] -> a -> a
foldFuns fs x = foldl (flip ($)) x fs

-- | Fixpoint iteration.
fix :: Eq a => (a -> a) -> a -> a
fix f x = let x' = f x in if x' == x then x else fix f x'

-- * functions on strings

-- | Join a number of lists by using the given glue
--   between the lists.
join :: [a] -- ^ glue
     -> [[a]] -- ^ lists to join
     -> [a]
join g = concat . intersperse g

-- * ShowS-functions

nl :: ShowS
nl = showChar '\n'

sp :: ShowS
sp = showChar ' '

wrap :: String -> ShowS -> String -> ShowS
wrap o s c = showString o . s . showString c

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

unwordsS :: [ShowS] -> ShowS
unwordsS = joinS " "

unlinesS :: [ShowS] -> ShowS
unlinesS = joinS "\n"

joinS :: String -> [ShowS] -> ShowS
joinS glue = concatS . intersperse (showString glue)



