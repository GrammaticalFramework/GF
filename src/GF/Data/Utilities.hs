----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:49 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Basic functions not in the standard libraries
-----------------------------------------------------------------------------


module GF.Data.Utilities where

-- * functions on lists

sameLength :: [a] -> [a] -> Bool
sameLength [] [] = True
sameLength (_:xs) (_:ys) = sameLength xs ys
sameLength _ _ = False

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

-- * functions on pairs

mapFst :: (a -> a') -> (a, b) -> (a', b)
mapFst f (a, b) = (f a, b)

mapSnd :: (b -> b') -> (a, b) -> (a, b')
mapSnd f (a, b) = (a, f b)


