{- 
   **************************************************************
   * Filename      : Trie.hs                                    *
   * Author        : Markus Forsberg                            *
   *                 markus@cs.chalmers.se                      *
   * Last Modified : 17 December, 2001                          *
   * Lines         : 51                                         *
   ************************************************************** 
-}

module Trie (
             tcompile,
             Trie,
	     trieLookup,
	     decompose,
             Attr,
             atW, atP, atWP
	    ) where

import Map

--- data Attr = W | P | WP deriving Eq
type Attr = Int

atW, atP, atWP :: Attr
(atW,atP,atWP) = (0,1,2)

newtype TrieT = TrieT ([(Char,TrieT)],[(Attr,String)])

newtype Trie = Trie (Map Char Trie, [(Attr,String)])

emptyTrie = TrieT ([],[])

optimize :: TrieT -> Trie
optimize (TrieT (xs,res)) = Trie ([(c,optimize t) | (c,t) <- xs] |->+ empty,
				  res)

tcompile :: [(String,[(Attr,String)])] -> Trie
tcompile xs = optimize $ build xs emptyTrie

build :: [(String,[(Attr,String)])] -> TrieT -> TrieT
build []     trie = trie
build (x:xs) trie = build xs (insert x trie)
 where 
  insert ([],ys)     (TrieT (xs,res)) = TrieT (xs,ys ++ res)
  insert ((s:ss),ys) (TrieT (xs,res)) 
    = case (span (\(s',_) -> s' /= s) xs) of
       (xs,[])          -> TrieT (((s,(insert (ss,ys) emptyTrie)):xs),res)
       (xs,(y,trie):zs) -> TrieT (xs ++ ((y,insert (ss,ys) trie):zs),res)

trieLookup :: Trie -> String -> (String,[(Attr,String)])
trieLookup trie s = apply trie s s

apply :: Trie -> String -> String -> (String,[(Attr,String)])
apply (Trie (_,res)) [] inp = (inp,res)
apply (Trie (map,_)) (s:ss) inp
 = case map ! s of
    Just trie -> apply trie ss inp
    Nothing   -> (inp,[])

-- Composite analysis (Huet's unglue algorithm)
-- only legaldecompositions are accepted.
-- With legal means that the composite forms are ordered correctly
-- with respect to the attributes W,P and WP.

-- Composite analysis

testTrie = tcompile [("flick",[(atP,"P")]),("knopp",[(atW,"W")]),("flaggstångs",[(atWP,"WP")])]

decompose :: Trie -> String -> [String]
decompose trie sentence = legal trie $ backtrack [(sentence,[])] trie

--  The function legal checks if the decomposition is in fact a possible one.

legal :: Trie -> [String] -> [String]
legal _    []    = []
legal trie input = if (test (map ((map fst).snd.(trieLookup trie)) input)) then input else []
 where
  test []       = False
  test [xs]     = elem atW xs || elem atWP xs
  test (xs:xss) = (elem atP xs || elem atWP xs) && test xss

react :: String -> [String] -> [(String,[String])] -> String -> Trie -> Trie -> [String]
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

backtrack :: [(String,[String])] -> Trie -> [String]
backtrack [] _  = []
backtrack ((input,output):back) trie 
    = react input output back [] trie trie

{-
--  The function legal checks if the decomposition is in fact a possible one.
legal :: Trie -> [String] -> [String]
legal _    []    = [] 
legal trie input 
  | test $ 
     map ((map fst).snd.(trieLookup trie)) input =  input
  | otherwise                                    = []
 where -- test checks that the Attrs are in the correct order.
  test []       = False -- This case should never happen.
  test [xs]     = elem W xs || elem WP xs 
  test (xs:xss) = (elem P xs || elem WP xs) && test xss
-}
