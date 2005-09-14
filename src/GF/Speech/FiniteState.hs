----------------------------------------------------------------------
-- |
-- Module      : FiniteState
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/14 15:17:29 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.7 $
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


data FA a b = FA (Graph a b) State [State]

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
    where (g,s) = newNode l newGraph

addFinalState :: Node -> FA a b -> FA a b
addFinalState f (FA g s ss) = FA g s (f:ss)

newState :: a -> FA a b -> (FA a b, State)
newState x (FA g s ss) = (FA g' s ss, n)
    where (g',n) = newNode x g

newTransition :: Node -> Node -> b -> FA a b -> FA a b
newTransition f t l = onGraph (newEdge f t l)

mapStates :: (a -> c) -> FA a b -> FA c b
mapStates f = onGraph (nmap f)

mapTransitions :: (b -> c) -> FA a b -> FA a c
mapTransitions f = onGraph (emap f)

asGraph :: FA a b -> Graph a b
asGraph (FA g _ _) = g

minimize :: FA () (Maybe a) -> FA () (Maybe a)
minimize = onGraph mimimizeGr1

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
type Node = Int

data Graph a b = Graph Node [(Node,a)] [(Node,Node,b)]
		 deriving (Eq,Show)

onGraph :: (Graph a b -> Graph c d) -> FA a b -> FA c d
onGraph f (FA g s ss) = FA (f g) s ss

-- graphToFA :: State -> [State] -> Graph a b -> FA a b
-- graphToFA s fs (Graph _ ss ts) = buildFA s fs ss ts

newGraph :: Graph a b
newGraph = Graph 0 [] []

nodes :: Graph a b -> [(Node,a)]
nodes (Graph _ ns _) = ns

edges :: Graph a b -> [(Node,Node,b)]
edges (Graph _ _ es) = es

nmap :: (a -> c) -> Graph a b -> Graph c b
nmap f (Graph c ns es) = Graph c [(n,f l) | (n,l) <- ns] es

emap :: (b -> c) -> Graph a b -> Graph a c
emap f (Graph c ns es) = Graph c ns [(x,y,f l) | (x,y,l) <- es]

newNode :: a -> Graph a b -> (Graph a b,State)
newNode l (Graph c ns es) = (Graph s ((s,l):ns) es, s)
  where s = c+1

newEdge :: State -> State -> b -> Graph a b -> Graph a b
newEdge f t l (Graph c ns es) = Graph c ns ((f,t,l):es)

incoming :: Graph a b -> [(Node,a,[(Node,Node,b)])]
incoming (Graph _ ns es) = snd $ mapAccumL f (sortBy compareDest es) (sortBy compareFst ns)
  where destIs d (_,t,_) = t == d
        compareDest (_,t1,_) (_,t2,_) = compare t1 t2
	compareFst p1 p2 = compare (fst p1) (fst p2)
	f es' (n,l) = let (nes,es'') = span (destIs n) es' in (es'',(n,l,nes))

moveLabelsToNodes_ :: Eq a => Graph () (Maybe a) -> Graph (Maybe a) ()
moveLabelsToNodes_ gr@(Graph c _ _) = mimimizeGr2 $ Graph c' (zip ns ls) (concat ess)
  where is = incoming gr
	(c',is') = mapAccumL fixIncoming c is
	(ns,ls,ess) = unzip3 (concat is')

fixIncoming :: Eq a => Node -> (Node,(),[(Node,Node,Maybe a)]) -> (Node,[(Node,Maybe a,[(Node,Node,())])])
fixIncoming next c@(n,(),es) = (next', (n,Nothing,es'):newContexts)
  where ls = nub $ map getLabel es
	next' = next + length ls
	newNodes = zip [next..next'-1] ls
	es' = [ (x,n,()) | x <- map fst newNodes ]
	-- separate cyclic and non-cyclic edges
	(cyc,ncyc) = partition (\ (f,_,_) -> f == n) es
	       -- keep all incoming non-cyclic edges with the right label
	to x l = [ (f,x,()) | (f,_,l') <- ncyc, l == l']
	       -- for each cyclic edge with the right label, 
	       -- add an edge from each of the new nodes (including this one)
		 ++ [ (y,x,()) | (f,_,l') <- cyc, l == l', (y,_) <- newNodes]
	newContexts = [ (x, l, to x l) | (x,l) <- newNodes ]

getLabel :: (Node,Node,b) -> b
getLabel (_,_,l) = l

mimimizeGr1 :: Graph () (Maybe a) -> Graph () (Maybe a)
mimimizeGr1 = removeEmptyLoops1

removeEmptyLoops1 :: Graph () (Maybe a) -> Graph () (Maybe a)
removeEmptyLoops1 (Graph c ns es) = Graph c ns (filter (not . isEmptyLoop) es)
    where isEmptyLoop (f,t,Nothing) | f == t = True
	  isEmptyLoop _ = False

mimimizeGr2 :: Graph (Maybe a) () -> Graph (Maybe a) ()
mimimizeGr2 = id

removeDuplicateEdges :: Ord b => Graph a b -> Graph a b
removeDuplicateEdges (Graph c ns es) = Graph c ns (sortNub es)

reverseGraph :: Graph a b -> Graph a b
reverseGraph (Graph c ns es) = Graph c ns [ (t,f,l) | (f,t,l) <- es ]
