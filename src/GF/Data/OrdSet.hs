----------------------------------------------------------------------
-- |
-- Module      : OrdSet
-- Maintainer  : Peter Ljunglöf
-- Stability   : Obsolete
-- Portability : Haskell 98
--
-- > CVS $Date: 2005/02/18 19:21:15 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- The class of ordered sets, as described in
-- \"Pure Functional Parsing\", section 2.2.1,
-- and an example implementation
-- derived from appendix A.1
--
-- /OBSOLETE/! this is only used in module "ChartParser"
-----------------------------------------------------------------------------

module OrdSet (OrdSet(..), Set) where

import List (intersperse)


--------------------------------------------------
-- the class of ordered sets

class OrdSet m where
  emptySet  :: Ord a => m a
  unitSet   :: Ord a => a -> m a
  isEmpty   :: Ord a => m a -> Bool
  elemSet   :: Ord a => a -> m a -> Bool
  (<++>)    :: Ord a => m a -> m a -> m a
  (<\\>)    :: Ord a => m a -> m a -> m a
  plusMinus :: Ord a => m a -> m a -> (m a, m a)
  union     :: Ord a => [m a] -> m a
  makeSet   :: Ord a => [a] -> m a
  elems     :: Ord a => m a -> [a]
  ordSet    :: Ord a => [a] -> m a
  limit     :: Ord a => (a -> m a) -> m a -> m a

  xs <++> ys      = fst (plusMinus xs ys)
  xs <\\> ys      = snd (plusMinus xs ys)
  plusMinus xs ys = (xs <++> ys, xs <\\> ys)

  union []   = emptySet
  union [xs] = xs
  union xyss = union xss <++> union yss
    where (xss, yss)       = split xyss
	  split (x:y:xyss) = let (xs, ys) = split xyss in (x:xs, y:ys)
	  split xs         = (xs, [])

  makeSet xs = union (map unitSet xs)

  limit more start = limit' (start, start)
    where limit' (old, new)
	      | isEmpty new' = old
	      | otherwise    = limit' (plusMinus new' old)
	    where new'       = union (map more (elems new))


--------------------------------------------------
-- sets as ordered lists, 
-- paired with a binary tree

data Set a = Set [a] (TreeSet a)

instance Eq a => Eq (Set a) where
  Set xs _ == Set ys _ = xs == ys

instance Ord a => Ord (Set a) where
  compare (Set xs _) (Set ys _) = compare xs ys

instance Show a => Show (Set a) where
  show (Set xs _) = "{" ++ concat (intersperse "," (map show xs)) ++ "}"

instance OrdSet Set where
  emptySet  = Set []  (makeTree [])
  unitSet a = Set [a] (makeTree [a])

  isEmpty   (Set xs _) = null xs
  elemSet a (Set _ xt) = elemTree a xt

  plusMinus (Set xs _) (Set ys _) = (Set ps (makeTree ps), Set ms (makeTree ms))
    where (ps, ms) = plm xs ys
	  plm [] ys = (ys, [])
	  plm xs [] = (xs, xs)
	  plm xs@(x:xs') ys@(y:ys') = case compare x y of
				        LT -> let (ps, ms) = plm xs' ys  in (x:ps, x:ms)
					GT -> let (ps, ms) = plm xs  ys' in (y:ps,   ms)
					EQ -> let (ps, ms) = plm xs' ys' in (x:ps,   ms)

  elems (Set xs _) = xs
  ordSet xs        = Set xs (makeTree xs)


--------------------------------------------------
-- binary search trees
-- for logarithmic lookup time

data TreeSet a = Nil | Node (TreeSet a) a (TreeSet a)

makeTree xs = tree
  where (tree,[])       = sl2bst (length xs) xs
	sl2bst 0 xs     = (Nil, xs)
	sl2bst 1 (a:xs) = (Node Nil a Nil, xs)
	sl2bst n xs     = (Node ltree a rtree, zs)
          where llen    = (n-1) `div` 2
                rlen    = n - 1 - llen
                (ltree, a:ys) = sl2bst llen xs
                (rtree, zs)   = sl2bst rlen ys

elemTree a Nil = False
elemTree a (Node ltree x rtree) 
    = case compare a x of
        LT -> elemTree a ltree 
        GT -> elemTree a rtree 
        EQ -> True


