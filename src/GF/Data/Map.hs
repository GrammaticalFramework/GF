----------------------------------------------------------------------
-- |
-- Module      : Map
-- Maintainer  : Markus Forsberg
-- Stability   : Stable
-- Portability : Haskell 98
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Map 
           (
           Map,
           empty,
           isEmpty,	   
	   (!),     -- lookup operator.
	   (!+),    -- lookupMany operator.
	   (|->),   -- insert operator.
	   (|->+),  -- insertMany operator.
	   (<+>),   -- union operator.
	   flatten  -- 
	   ) where

import RedBlack

type Map key el = Tree key el

infixl 6 |->
infixl 6 |->+
infixl 5 !
infixl 5 !+
infixl 4 <+>

empty :: Map key el
empty = emptyTree

(!) :: Ord key => Map key el -> key -> Maybe el
fm ! e = lookupTree e fm

(!+) :: Ord key => Map key el -> [key] -> [Maybe el]
fm !+    []  = []
fm !+ (e:es) = (lookupTree e fm): (fm !+ es)

(|->) :: Ord key => (key,el) -> Map key el -> Map key el
(x,y) |-> fm = insertTree (x,y) fm

(|->+) :: Ord key => [(key,el)] -> Map key el -> Map key el
[]         |->+ fm = fm
((x,y):xs) |->+ fm = xs |->+ (insertTree (x,y) fm)

(<+>) :: Ord key => Map key el -> Map key el -> Map key el
(<+>) fm1 fm2 =  xs |->+ fm2
 where xs = flatten fm1
