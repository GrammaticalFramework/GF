

--------------------------------------------------
-- The class of ordered finite maps
-- as described in section 2.2.2

-- and an example implementation, 
-- derived from the implementation in appendix A.2


module OrdMap2 (OrdMap(..), Map) where

import List (intersperse)


--------------------------------------------------
-- the class of ordered finite maps

class OrdMap m where
  emptyMap     :: Ord s => m s a
  (|->)        :: Ord s => s -> a -> m s a
  isEmptyMap   :: Ord s => m s a -> Bool
  (?)          :: Ord s => m s a -> s -> Maybe a
  lookupWith   :: Ord s => a -> m s a -> s -> a
  mergeWith    :: Ord s => (a -> a -> a) -> m s a -> m s a -> m s a
  unionMapWith :: Ord s => (a -> a -> a) -> [m s a] -> m s a
  makeMapWith  :: Ord s => (a -> a -> a) -> [(s,a)] -> m s a
  assocs       :: Ord s => m s a -> [(s,a)]
  ordMap       :: Ord s => [(s,a)] -> m s a
  mapMap       :: Ord s => (a -> b) -> m s a -> m s b

  lookupWith z m s = case m ? s of
		       Just a  -> a
		       Nothing -> z

  unionMapWith join = union
    where union []   = emptyMap
	  union [xs] = xs
	  union xyss = mergeWith join (union xss) (union yss)
	    where (xss, yss)       = split xyss
		  split (x:y:xyss) = let (xs, ys) = split xyss in (x:xs, y:ys)
		  split xs         = (xs, [])


--------------------------------------------------
-- finite maps as ordered associaiton lists, 
-- paired with binary search trees

data Map s a = Map [(s,a)] (TreeMap s a)

instance (Eq s, Eq a) => Eq (Map s a) where
  Map xs _ == Map ys _ = xs == ys

instance (Show s, Show a) => Show (Map s a) where
  show (Map ass _) = "{" ++ concat (intersperse "," (map show' ass)) ++ "}"
    where show' (s,a) = show s ++ "|->" ++ show a

instance OrdMap Map where
  emptyMap = Map []      (makeTree [])
  s |-> a  = Map [(s,a)] (makeTree [(s,a)])

  isEmptyMap (Map ass _) = null ass
  
  Map _ tree ? s = lookupTree s tree

  mergeWith join (Map xss _) (Map yss _) = Map xyss (makeTree xyss)
    where xyss          = merge xss yss
	  merge []  yss = yss
	  merge xss []  = xss
	  merge xss@(x@(s,x'):xss') yss@(y@(t,y'):yss')
		= case compare s t of
		    LT -> x : merge xss' yss
		    GT -> y : merge xss  yss'
		    EQ -> (s, join x' y') : merge xss' yss'

  makeMapWith join []      = emptyMap
  makeMapWith join [(s,a)] = s |-> a
  makeMapWith join xyss    = mergeWith join (makeMapWith join xss) (makeMapWith join yss)
    where (xss, yss)       = split xyss
	  split (x:y:xys)  = let (xs, ys) = split xys in (x:xs, y:ys)
	  split xs         = (xs, [])

  assocs (Map xss _) = xss
  ordMap xss         = Map xss (makeTree xss)

  mapMap f (Map ass atree) = Map [ (s,f a) | (s,a) <- ass ] (mapTree f atree)


--------------------------------------------------
-- binary search trees
-- for logarithmic lookup time

data TreeMap s a = Nil | Node (TreeMap s a) s a (TreeMap s a)

makeTree ass = tree
  where
    (tree,[])            = sl2bst (length ass) ass
    sl2bst 0 ass         = (Nil, ass)
    sl2bst 1 ((s,a):ass) = (Node Nil s a Nil, ass)
    sl2bst n ass         = (Node ltree s a rtree, css)
      where llen = (n-1) `div` 2
            rlen = n - 1 - llen
            (ltree, (s,a):bss) = sl2bst llen ass
            (rtree, css)       = sl2bst rlen bss

lookupTree s Nil = Nothing
lookupTree s (Node left s' a right) 
    = case compare s s' of
        LT -> lookupTree s left 
        GT -> lookupTree s right 
        EQ -> Just a

mapTree f Nil = Nil
mapTree f (Node left s a right) = Node (mapTree f left) s (f a) (mapTree f right)




