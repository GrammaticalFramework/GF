----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

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
	     trieLookup,
	     decompose,
            --- Attr, atW, atP, atWP,
             emptyTrie
	    ) where

import Map
import List

newtype TrieT a b = TrieT ([(a,TrieT a b)],[b])

newtype Trie a b = Trie (Map a (Trie a b), [b])

emptyTrieT = TrieT ([],[])
emptyTrie = Trie (empty,[])

optimize :: (Ord a,Eq b) => TrieT a b -> Trie a b
optimize (TrieT (xs,res)) = Trie ([(c,optimize t) | (c,t) <- xs] |->+ empty,
				  nub res) --- nub by AR

collapse :: Ord a => Trie a b -> [([a],[b])]
collapse trie = collapse' trie []
  where collapse' (Trie (map,(x:xs))) s = if (isEmpty map) then [(reverse s,(x:xs))]
	                                   else (reverse s,(x:xs)):
					    concat [ collapse' trie (c:s) | (c,trie) <- flatten map]
	collapse' (Trie (map,[])) s
	 = concat [ collapse' trie (c:s) | (c,trie) <- flatten map]

tcompile :: (Ord a,Eq b) => [([a],[b])] -> Trie a b
tcompile xs = optimize $ build xs emptyTrieT

build :: Ord a => [([a],[b])] -> TrieT a b -> TrieT a b
build []     trie = trie
build (x:xs) trie = build xs (insert x trie)
 where 
  insert ([],ys)     (TrieT (xs,res)) = TrieT (xs,ys ++ res)
  insert ((s:ss),ys) (TrieT (xs,res)) 
    = case (span (\(s',_) -> s' /= s) xs) of
       (xs,[])          -> TrieT (((s,(insert (ss,ys) emptyTrieT)):xs),res)
       (xs,(y,trie):zs) -> TrieT (xs ++ ((y,insert (ss,ys) trie):zs),res)

trieLookup :: Ord a => Trie a b -> [a] -> ([a],[b])
trieLookup trie s = apply trie s s

apply :: Ord a => Trie a b -> [a] -> [a] -> ([a],[b])
apply (Trie (_,res)) [] inp = (inp,res)
apply (Trie (map,_)) (s:ss) inp
 = case map ! s of
    Just trie -> apply trie ss inp
    Nothing   -> (inp,[])

-----------------------------
-- from Trie for strings; simplified for GF by making binding always possible (AR)

decompose :: Ord a => Trie a b -> [a] -> [[a]]
decompose trie sentence = backtrack [(sentence,[])] trie

react :: Ord a => [a] -> [[a]] -> [([a],[[a]])] -> 
                    [a] -> Trie a b -> Trie a b -> [[a]]
-- String -> [String] -> [(String,[String])] -> String -> Trie -> Trie -> [String]
react input output back occ (Trie (arcs,res)) init = 
    case res of -- Accept = non-empty res.
     [] -> continue back
     _ -> let pushout = (occ:output)
	    in case input of 
	        [] -> reverse $ map reverse pushout
		_ -> let pushback = ((input,pushout):back)
		      in continue pushback
 where continue cont = case input of
		        []       -> backtrack cont init
			(l:rest) -> case arcs ! l of
				     Just trie -> 
					 react rest output cont (l:occ) trie init
				     Nothing -> backtrack cont init

backtrack :: Ord a => [([a],[[a]])] -> Trie a b -> [[a]]
backtrack [] _  = []
backtrack ((input,output):back) trie 
    = react input output back [] trie trie


{- so this is not needed from the original
type Attr = Int

atW, atP, atWP :: Attr
(atW,atP,atWP) = (0,1,2)

decompose :: Ord a => Trie a (Int,b) -> [a] -> [[a]]
decompose trie sentence = legal trie $ backtrack [(sentence,[])] trie

--  The function legal checks if the decomposition is in fact a possible one.

legal :: Ord a => Trie a (Int,b) -> [[a]] -> [[a]]
legal _    []    = []
legal trie input = if (test (map ((map fst).snd.(trieLookup trie)) input)) then input else []
 where
  test []       = False
  test [xs]     = elem atW xs || elem atWP xs
  test (xs:xss) = (elem atP xs || elem atWP xs) && test xss
-}
