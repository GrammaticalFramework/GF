{- 
   **************************************************************
   * Author        : Markus Forsberg                            *
   *                 markus@cs.chalmers.se                      *
   ************************************************************** 
-}
module Trie2 (
             tcompile,
	     collapse,
             Trie,
	     trieLookup
	    ) where

import Map

newtype TrieT a b = TrieT ([(a,TrieT a b)],[b])

newtype Trie a b = Trie (Map a (Trie a b), [b])

emptyTrie = TrieT ([],[])

optimize :: Ord a => TrieT a b -> Trie a b
optimize (TrieT (xs,res)) = Trie ([(c,optimize t) | (c,t) <- xs] |->+ empty,
				  res)

collapse :: Ord a => Trie a b -> [([a],[b])]
collapse trie = collapse' trie []
  where collapse' (Trie (map,(x:xs))) s = if (isEmpty map) then [(reverse s,(x:xs))]
	                                   else (reverse s,(x:xs)):
					    concat [ collapse' trie (c:s) | (c,trie) <- flatten map]
	collapse' (Trie (map,[])) s
	 = concat [ collapse' trie (c:s) | (c,trie) <- flatten map]

tcompile :: Ord a => [([a],[b])] -> Trie a b
tcompile xs = optimize $ build xs emptyTrie

build :: Ord a => [([a],[b])] -> TrieT a b -> TrieT a b
build []     trie = trie
build (x:xs) trie = build xs (insert x trie)
 where 
  insert ([],ys)     (TrieT (xs,res)) = TrieT (xs,ys ++ res)
  insert ((s:ss),ys) (TrieT (xs,res)) 
    = case (span (\(s',_) -> s' /= s) xs) of
       (xs,[])          -> TrieT (((s,(insert (ss,ys) emptyTrie)):xs),res)
       (xs,(y,trie):zs) -> TrieT (xs ++ ((y,insert (ss,ys) trie):zs),res)

trieLookup :: Ord a => Trie a b -> [a] -> ([a],[b])
trieLookup trie s = apply trie s s

apply :: Ord a => Trie a b -> [a] -> [a] -> ([a],[b])
apply (Trie (_,res)) [] inp = (inp,res)
apply (Trie (map,_)) (s:ss) inp
 = case map ! s of
    Just trie -> apply trie ss inp
    Nothing   -> (inp,[])
