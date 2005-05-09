----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/09 09:28:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Basic functions not in the standard libraries
-----------------------------------------------------------------------------


module GF.Data.Utilities where

import Monad (liftM)

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

-- * functions on pairs

mapFst :: (a -> a') -> (a, b) -> (a', b)
mapFst f (a, b) = (f a, b)

mapSnd :: (b -> b') -> (a, b) -> (a, b')
mapSnd f (a, b) = (a, f b)


