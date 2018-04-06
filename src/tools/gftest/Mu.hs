module Mu where

import Data.Map( Map, (!) )
import qualified Data.Map as M
import Data.Set( Set )
import qualified Data.Set as S
import Graph

--------------------------------------------------------------------------------

-- naive implementation of fixpoint computation
mu0 :: (Ord x, Eq a) => a -> [(x, [x], [a] -> a)] -> [x] -> [a]
mu0 bot defs zs = [ done!z | z <- zs ]
 where
  xs    = [ x | (x, _, _) <- defs ]
  done  = iter [ bot | _ <- xs ]

  iter as
    | as == as' = tab
    | otherwise = iter as'
   where
    tab = M.fromList (xs `zip` as)
    as' = [ f [ tab!y | y <- ys ]
          | (_,(_, ys, f)) <- as `zip` defs
          ]

--------------------------------------------------------------------------------

-- scc-based implementation of fixpoint computation
{-
   a         --^ initial/bottom value (smallest element) in the fixpoint computation
-> [( x, [x] --^ A single category, its arguments
    , [a] -> a) --^ function that takes as its argument a list of values that we want to compute for the [x] 
   ]        
-> [x]       --^ All categories that you want to see the answer for
-> [a]       --^ Values for the given categories 
-}

mu :: (Ord x, Eq a) => a  -> [(x, [x], [a] -> a)] -> [x] -> [a]
mu bot defs zs = [ vtab?z | z <- zs ]
 where
  ftab  = M.fromList [ (x,f)  | (x,_,f) <- defs ]
  graph = reach (M.fromList [ (x,xs) | (x,xs,_) <- defs ]) zs
  vtab  = foldl compute M.empty (scc graph)

  compute vtab t = fix (-1) vtab (map (vtab ?) xs)
   where
    xs = S.toList (backs t)

    fix 0 vtab _ = vtab
    fix n vtab as
      | as' == as = vtab'
      | otherwise = fix (n-1) vtab' as'
     where
      (_,vtab') = eval t vtab
      as'       = map (vtab' ?) xs

  eval (Cut x)     vtab = (vtab?x, vtab)
  eval (Node x ts) vtab = (a, M.insert x a vtab')
   where
    (as, vtab') = evalList ts vtab
    a           = (ftab!x) as

  evalList []     vtab = ([], vtab)
  evalList (t:ts) vtab = (a:as, vtab'')
   where
    (a, vtab')  = eval t vtab
    (as,vtab'') = evalList ts vtab'

  vtab ? x = case M.lookup x vtab of
               Nothing -> bot
               Just a  -> a

--------------------------------------------------------------------------------

-- diff/scc-based implementation of fixpoint computation
muDiff :: (Ord x, Eq a)
       => a -> (a->Bool) -> (a->a->a) -> (a->a->a)
       -> [(x, [x], [a] -> a)]
       -> [x] -> [a]
muDiff bot isBot diff apply defs zs = [ vtab?z | z <- zs ]
 where
  ftab  = M.fromList [ (x,f)  | (x,_,f) <- defs ]
  graph = reach (M.fromList [ (x,xs) | (x,xs,_) <- defs ]) zs
  vtab  = foldl compute M.empty (scc graph)

  compute vtab t = fix vtab M.empty
   where
    xs = S.toList (backs t)

    fix dtab vtab
      | all isBot ds = vtab'
      | otherwise    = fix (M.fromList (xs `zip` ds)) vtab'
     where
      dtab' = eval t dtab
      vtab' = foldr (\(x,d) -> M.alter (Just . apply' d) x) vtab (M.toList dtab')
      ds    = map (dtab' ?) xs

      apply' d Nothing  = apply d bot
      apply' d (Just a) = apply d a

      eval (Cut x)     tab = tab
      eval (Node x ts) tab = M.insert x d tab'
       where
        tab' = foldl (flip eval) tab ts
        d    = (ftab!x) [ tab'?x | x <- map top ts ] `diff` (vtab?x)

  vtab ? x = case M.lookup x vtab of
               Nothing -> bot
               Just a  -> a

--------------------------------------------------------------------------------

