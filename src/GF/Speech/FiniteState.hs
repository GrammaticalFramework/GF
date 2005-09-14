----------------------------------------------------------------------
-- |
-- Module      : FiniteState
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/14 16:08:35 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.9 $
--
-- A simple finite state network module.
-----------------------------------------------------------------------------
module GF.Speech.FiniteState (FA, State, NFA, DFA,
			      startState, finalStates,
			      states, transitions,
			      newFA, 
			      addFinalState,
			      newState, newTransition,
			      mapStates, mapTransitions,
			      moveLabelsToNodes, minimize,
			      prFAGraphviz) where

import Data.List
import Data.Maybe (catMaybes,fromJust)

import GF.Data.Utilities
import qualified GF.Visualization.Graphviz as Dot

type State = Int

data FA n a b = FA (Graph n a b) n [n]

type NFA a = FA State () (Maybe a)

type DFA a = FA [State] () a


startState :: FA n a b -> n
startState (FA _ s _) = s

finalStates :: FA n a b -> [n]
finalStates (FA _ _ ss) = ss

states :: FA n a b -> [(n,a)]
states (FA g _ _) = nodes g

transitions :: FA n a b -> [(n,n,b)]
transitions (FA g _ _) = edges g

newFA :: Enum n => a -- ^ Start node label
      -> FA n a b
newFA l = FA g s []
    where (g,s) = newNode l (newGraph [toEnum 0..])

addFinalState :: n -> FA n a b -> FA n a b
addFinalState f (FA g s ss) = FA g s (f:ss)

newState :: a -> FA n a b -> (FA n a b, n)
newState x (FA g s ss) = (FA g' s ss, n)
    where (g',n) = newNode x g

newTransition :: n -> n -> b -> FA n a b -> FA n a b
newTransition f t l = onGraph (newEdge f t l)

mapStates :: (a -> c) -> FA n a b -> FA n c b
mapStates f = onGraph (nmap f)

mapTransitions :: (b -> c) -> FA n a b -> FA n a c
mapTransitions f = onGraph (emap f)

minimize :: NFA a -> NFA a
minimize = onGraph id

onGraph :: (Graph n a b -> Graph n c d) -> FA n a b -> FA n c d
onGraph f (FA g s ss) = FA (f g) s ss

-- | Transform a standard finite automaton with labelled edges
--   to one where the labels are on the nodes instead. This can add
--   up to one extra node per edge.
moveLabelsToNodes :: (Ord n,Eq a) => FA n () (Maybe a) -> FA n (Maybe a) ()
moveLabelsToNodes = onGraph moveLabelsToNodes_
  where moveLabelsToNodes_ gr@(Graph c _ _) = Graph c' (zip ns ls) (concat ess)
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

alphabet :: Eq b => Graph n a (Maybe b) -> [b]
alphabet = nub . catMaybes . map getLabel . edges

reachable :: (Eq b, Eq n) => Graph n a (Maybe b) -> n -> b -> [n]
reachable = undefined

determinize :: NFA a -> DFA a
determinize (FA g s f) = undefined


prFAGraphviz :: (Eq n,Show n) => FA n String String -> String
prFAGraphviz  = Dot.prGraphviz . toGraphviz

toGraphviz :: (Eq n,Show n) => FA n String String -> Dot.Graph
toGraphviz (FA (Graph _ ns es) s f) = Dot.Graph Dot.Directed [] (map mkNode ns) (map mkEdge es)
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

getLabel :: (n,n,b) -> b
getLabel (_,_,l) = l

reverseGraph :: Graph n a b -> Graph n a b
reverseGraph (Graph c ns es) = Graph c ns [ (t,f,l) | (f,t,l) <- es ]

