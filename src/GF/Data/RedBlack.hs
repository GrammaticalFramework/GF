{- 
   **************************************************************
   * Filename      : RedBlack.hs                                *
   * Author        : Markus Forsberg                            *
   *                 markus@cs.chalmers.se                      *
   * Last Modified : 15 December, 2001                          *
   * Lines         : 57                                         *
   ************************************************************** 
-} -- Modified version of Osanaki's implementation.

module RedBlack (
                emptyTree,
		isEmpty,		
		Tree,
		lookupTree,
		insertTree,
		flatten
		) where

data Color = R | B
 deriving (Show,Read)

data Tree key el = E | T Color (Tree key el) (key,el) (Tree key el)
 deriving (Show,Read)

balance :: Color -> Tree a b -> (a,b) -> Tree a b -> Tree a b  
balance B (T R (T R a x b) y c) z d = T R (T B a x b) y (T B c z d)
balance B (T R a x (T R b y c)) z d = T R (T B a x b) y (T B c z d)
balance B a x (T R (T R b y c) z d) = T R (T B a x b) y (T B c z d)
balance B a x (T R b y (T R c z d)) = T R (T B a x b) y (T B c z d)
balance color a x b = T color a x b

emptyTree :: Tree key el
emptyTree = E

isEmpty :: Tree key el -> Bool
isEmpty (E) = True
isEmpty _   = False

lookupTree :: Ord a => a -> Tree a b -> Maybe b
lookupTree _ E = Nothing
lookupTree x (T _ a (y,z) b)
   | x < y      = lookupTree x a
   | x > y      = lookupTree x b
   | otherwise  = return z
   
insertTree :: Ord a => (a,b) -> Tree a b -> Tree a b
insertTree (key,el) tree = T B a y b
  where 
    T _ a y b = ins tree
    ins E = T R E (key,el) E
    ins (T color a y@(key',el') b)
      | key < key'    = balance color (ins a) y b
      | key > key'    = balance color a y (ins b)
      | otherwise     = T color a (key',el) b

flatten :: Tree a b -> [(a,b)]
flatten E = []
flatten (T _ left (key,e) right) 
  = (flatten left) ++ ((key,e):(flatten right))
