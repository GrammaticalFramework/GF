module Graph where

import qualified Data.Map as M
import Data.Map( Map, (!) )
import qualified Data.Set as S
import Data.Set( Set )
import Data.List( nub, sort, (\\) )
--import Test.QuickCheck hiding ( generate )

-- == almost everything in this module is inspired by King & Launchbury ==

--------------------------------------------------------------------------------
-- depth-first trees

data Tree a
  = Node a [Tree a]
  | Cut a
 deriving ( Eq, Show )

type Forest a
  = [Tree a]

top :: Tree a -> a
top (Node x _) = x
top (Cut x)    = x

-- pruning a possibly infinite forest
prune :: Ord a => Forest a -> Forest a
prune ts = go S.empty ts
 where
  go seen []             = []
  go seen (Cut x    :ts) = Cut x : go seen ts
  go seen (Node x vs:ts)
    | x `S.member` seen  = Cut x : go seen ts
    | otherwise          = Node x (take n ws) : drop n ws
   where
    n  = length vs
    ws = go (S.insert x seen) (vs ++ ts)

-- pre- and post-order traversals
preorder :: Tree a -> [a]
preorder t = preorderF [t]

preorderF :: Forest a -> [a]
preorderF ts = go ts []
 where
  go []               xs = xs
  go (Cut x     : ts) xs = go ts xs
  go (Node x vs : ts) xs = x : go vs (go ts xs)

postorder :: Tree a -> [a]
postorder t = postorderF [t]

postorderF :: Forest a -> [a]
postorderF ts = go ts []
 where
  go []               xs = xs
  go (Cut x     : ts) xs = go ts xs
  go (Node x vs : ts) xs = go vs (x : go ts xs)

-- computing back-arrows
backs :: Ord a => Tree a -> Set a
backs t = S.fromList (go S.empty t)
 where
  go ups (Node x ts) = concatMap (go (S.insert x ups)) ts
  go ups (Cut x)     = [x | x `S.member` ups ]

--------------------------------------------------------------------------------
-- graphs

type Graph a
  = Map a [a]

vertices :: Graph a -> [a]
vertices g = [ x | (x,_) <- M.toList g ]

transposeG :: Ord a => Graph a -> Graph a
transposeG g =
  M.fromListWith (++) $
  [ (y,[x]) | (x,ys) <- M.toList g, y <- ys ] ++
  [ (x,[])  | x <- vertices g ]

--------------------------------------------------------------------------------
-- graphs and trees

generate :: Ord a => Graph a -> a -> Tree a
generate g x = Node x (map (generate g) (g!x))

dfs :: Ord a => Graph a -> [a] -> Forest a
dfs g xs = prune (map (generate g) xs)

reach :: Ord a => Graph a -> [a] -> Graph a
reach g xs = M.fromList [ (x,g!x) | x <- preorderF (dfs g xs) ]

dff :: Ord a => Graph a -> Forest a
dff g = dfs g (vertices g)

preOrd :: Ord a => Graph a -> [a]
preOrd g = preorderF (dff g)

postOrd :: Ord a => Graph a -> [a]
postOrd g = postorderF (dff g)

scc1 :: Ord a => Graph a -> Forest a
scc1 g = reverse (dfs (transposeG g) (reverse (postOrd g)))

scc2 :: Ord a => Graph a -> Forest a
scc2 g = dfs g (reverse (postOrd (transposeG g)))

scc :: Ord a => Graph a -> Forest a
scc g = scc2 g

sccs :: Ord a => Graph a -> [[a]]
sccs = map preorder . scc

--------------------------------------------------------------------------------
-- testing correctness

{-
newtype G = G (Graph Int) deriving ( Show )

set :: (Ord a, Num a, Arbitrary a) => Gen [a]
set = (nub . sort . map abs) `fmap` arbitrary

instance Arbitrary G where
  arbitrary =
    do xs  <- set `suchThat` (not . null)
       yss <- sequence [ listOf (elements xs) | x <- xs ]
       return (G (M.fromList (xs `zip` yss)))

  shrink (G g) =
    [ G (delNode x g)
    | (x,_) <- M.toList g
    ] ++
    [ G (delEdge x y g)
    | (x,ys) <- M.toList g
    , y <- ys
    ]
   where
    delNode v g =
      M.fromList
      [ (x,filter (v/=) ys)
      | (x,ys) <- M.toList g
      , x /= v
      ]

    delEdge v w g =
      M.insert v ((g!v) \\ [w]) g

-- all vertices in a component can reach each other
prop_Scc_StronglyConnected (G g) =
  whenFail (print cs) $
    and [ y `S.member` r | c <- cs, x <- c, let r = reach x, y <- c ]
 where
  cs = sccs g

  reach x = go S.empty [x]
   where
    go seen []            = seen
    go seen (x:xs)
      | x `S.member` seen = go seen xs
      | otherwise         = go (S.insert x seen) ((g!x) ++ xs)

-- vertices cannot forward-reach to other components
prop_Scc_NotConnected (G g) =
  whenFail (print cs) $
    -- every vertex is somewhere
    and [ or [ x `elem` c | c <- cs ]
        | x <- vertices g
        ] &&
    -- cannot foward-reach
    and [ y `S.notMember` rx
        | (c,d) <- pairs cs
        , x <- c
        , let rx = reach x
        , y <- d
        ]
 where
  cs = sccs g

  pairs (x:xs) = [ (x,y) | y <- xs ] ++ pairs xs
  pairs []     = []

  reach x = go S.empty [x]
   where
    go seen []            = seen
    go seen (x:xs)
      | x `S.member` seen = go seen xs
      | otherwise         = go (S.insert x seen) ((g!x) ++ xs)
-}

--------------------------------------------------------------------------------

