----------------------------------------------------------------------
-- |
-- Module      : Map
-- Maintainer  : Markus Forsberg
-- Stability   : Stable
-- Portability : Haskell 98
--
-- > CVS $Date: 2005/02/18 19:21:15 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Map (
           Map,
           empty,
           isEmpty,	   
	   (!), 
	   (!+),
	   (|->),   
	   (|->+), 
	   (<+>),   
	   flatten
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

-- | lookup operator.
(!) :: Ord key => Map key el -> key -> Maybe el
fm ! e = lookupTree e fm

-- | lookupMany operator.
(!+) :: Ord key => Map key el -> [key] -> [Maybe el]
fm !+    []  = []
fm !+ (e:es) = (lookupTree e fm): (fm !+ es)

-- | insert operator.
(|->) :: Ord key => (key,el) -> Map key el -> Map key el
(x,y) |-> fm = insertTree (x,y) fm

-- | insertMany operator.
(|->+) :: Ord key => [(key,el)] -> Map key el -> Map key el
[]         |->+ fm = fm
((x,y):xs) |->+ fm = xs |->+ (insertTree (x,y) fm)

-- | union operator.
(<+>) :: Ord key => Map key el -> Map key el -> Map key el
(<+>) fm1 fm2 =  xs |->+ fm2
 where xs = flatten fm1
