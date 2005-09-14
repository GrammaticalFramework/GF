----------------------------------------------------------------------
-- |
-- Module      : FiniteState
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/14 15:29:53 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.8 $
--
-- A simple finite state network module.
-----------------------------------------------------------------------------
module GF.Speech.FiniteState (FA, State,
			      startState, finalStates,
			      states, transitions,
			      newFA, 
			      addFinalState,
			      newState, newTransition,
			      mapStates, mapTransitions,
			      moveLabelsToNodes, minimize,
			      prFAGraphviz) where

import Data.List
import Data.Maybe (fromJust)

import GF.Data.Utilities
import qualified GF.Visualization.Graphviz as Dot


data FA a b = FA (Graph State a b) State [State]

type State = Node

startState :: FA a b -> State
startState (FA _ s _) = s

finalStates :: FA a b -> [State]
finalStates (FA _ _ ss) = ss

states :: FA a b -> [(State,a)]
states (FA g _ _) = nodes g

transitions :: FA a b -> [(State,State,b)]
transitions (FA g _ _) = edges g

newFA :: a -- ^ Start node label
      -> FA a b
newFA l = FA g s []
    where (g,s) = newNode l (newGraph [0..])

addFinalState :: State -> FA a b -> FA a b
addFinalState f (FA g s ss) = FA g s (f:ss)

newState :: a -> FA a b -> (FA a b, State)
newState x (FA g s ss) = (FA g' s ss, n)
    where (g',n) = newNode x g

newTransition :: State -> State -> b -> FA a b -> FA a b
newTransition f t l = onGraph (newEdge f t l)

mapStates :: (a -> c) -> FA a b -> FA c b
mapStates f = onGraph (nmap f)

mapTransitions :: (b -> c) -> FA a b -> FA a c
mapTransitions f = onGraph (emap f)

minimize :: FA () (Maybe a) -> FA () (Maybe a)
minimize = onGraph mimimizeGr1

onGraph :: (Graph State a b -> Graph State c d) -> FA a b -> FA c d
onGraph f (FA g s ss) = FA (f g) s ss

-- | Transform a standard finite automaton with labelled edges
--   to one where the labels are on the nodes instead. This can add
--   up to one extra node per edge.
moveLabelsToNodes :: Eq a => FA () (Maybe a) -> FA (Maybe a) ()
moveLabelsToNodes = onGraph moveLabelsToNodes_

prFAGraphviz :: FA String String -> String
prFAGraphviz  = Dot.prGraphviz . mkGraphviz
 where
 mkGraphviz (FA (Graph _ ns es) s f) = Dot.Graph Dot.Directed [] (map mkNode ns) (map mkEdge es)
   where mkNode (n,l) = Dot.Node (show n) attrs
	     where attrs = [("label",l)] 
			   ++ if n == s then [("shape","box")] else []
			   ++ if n `elem` f then [("style","bold")] else []
	 mkEdge (x,y,l) = Dot.Edge (show x) (show y) [("label",l)]

--
-- * Graphs 
--

data Graph n a b = Graph [n] [(n,a)] [(n,n,b)]
		 deriving (Eq,Show)

type Node = Int

newGraph :: [n] -> Graph n a b
newGraph ns = Graph ns [] []

nodes :: Graph n a b -> [(n,a)]
nodes (Graph _ ns _) = ns

edges :: Graph n a b -> [(n,n,b)]
edges (Graph _ _ es) = es

nmap :: (a -> c) -> Graph n a b -> Graph n c b
nmap f (Graph c ns es) = Graph c [(n,f l) | (n,l) <- ns] es

emap :: (b -> c) -> Graph n a b -> Graph n a c
emap f (Graph c ns es) = Graph c ns [(x,y,f l) | (x,y,l) <- es]

newNode :: a -> Graph n a b -> (Graph n a b,n)
newNode l (Graph (c:cs) ns es) = (Graph cs ((c,l):ns) es, c)

newEdge :: n -> n -> b -> Graph n a b -> Graph n a b
newEdge f t l (Graph c ns es) = Graph c ns ((f,t,l):es)

incoming :: Ord n => Graph n a b -> [(n,a,[(n,n,b)])]
incoming (Graph _ ns es) = snd $ mapAccumL f (sortBy compareDest es) (sortBy compareFst ns)
  where destIs d (_,t,_) = t == d
        compareDest (_,t1,_) (_,t2,_) = compare t1 t2
	compareFst p1 p2 = compare (fst p1) (fst p2)
	f es' (n,l) = let (nes,es'') = span (destIs n) es' in (es'',(n,l,nes))

moveLabelsToNodes_ :: (Ord n, Eq a) => Graph n () (Maybe a) -> Graph n (Maybe a) ()
moveLabelsToNodes_ gr@(Graph c _ _) = mimimizeGr2 $ Graph c' (zip ns ls) (concat ess)
  where is = incoming gr
	(c',is') = mapAccumL fixIncoming c is
	(ns,ls,ess) = unzip3 (concat is')

fixIncoming :: (Eq n, Eq a) => [n] -> (n,(),[(n,n,Maybe a)]) -> ([n],[(n,Maybe a,[(n,n,())])])
fixIncoming cs c@(n,(),es) = (cs'', (n,Nothing,es'):newContexts)
  where ls = nub $ map getLabel es
	(cs',cs'') = splitAt (length ls) cs
	newNodes = zip cs' ls
	es' = [ (x,n,()) | x <- map fst newNodes ]
	-- separate cyclic and non-cyclic edges
	(cyc,ncyc) = partition (\ (f,_,_) -> f == n) es
	       -- keep all incoming non-cyclic edges with the right label
	to x l = [ (f,x,()) | (f,_,l') <- ncyc, l == l']
	       -- for each cyclic edge with the right label, 
	       -- add an edge from each of the new nodes (including this one)
		 ++ [ (y,x,()) | (f,_,l') <- cyc, l == l', (y,_) <- newNodes]
	newContexts = [ (x, l, to x l) | (x,l) <- newNodes ]

getLabel :: (n,n,b) -> b
getLabel (_,_,l) = l

mimimizeGr1 :: Eq n => Graph n () (Maybe a) -> Graph n () (Maybe a)
mimimizeGr1 = removeEmptyLoops1

removeEmptyLoops1 :: Eq n => Graph n () (Maybe a) -> Graph n () (Maybe a)
removeEmptyLoops1 (Graph c ns es) = Graph c ns (filter (not . isEmptyLoop) es)
    where isEmptyLoop (f,t,Nothing) | f == t = True
	  isEmptyLoop _ = False

mimimizeGr2 :: Graph n (Maybe a) () -> Graph n (Maybe a) ()
mimimizeGr2 = id

removeDuplicateEdges :: (Eq n, Ord b) => Graph n a b -> Graph n a b
removeDuplicateEdges (Graph c ns es) = Graph c ns (nub es)

reverseGraph :: Graph n a b -> Graph n a b
reverseGraph (Graph c ns es) = Graph c ns [ (t,f,l) | (f,t,l) <- es ]
