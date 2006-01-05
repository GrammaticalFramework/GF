----------------------------------------------------------------------
-- |
-- Module      : FiniteState
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/10 16:43:44 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.16 $
--
-- A simple finite state network module.
-----------------------------------------------------------------------------
module GF.Speech.FiniteState (FA(..), State, NFA, DFA,
			      startState, finalStates,
			      states, transitions,
			      newFA, 
			      addFinalState,
			      newState, newStates,
                              newTransition, newTransitions,
			      mapStates, mapTransitions,
                              oneFinalState,
                              insertNFA,
                              onGraph,
			      moveLabelsToNodes, removeTrivialEmptyNodes,
                              minimize,
                              dfa2nfa,
                              unusedNames, renameStates,
			      prFAGraphviz, faToGraphviz) where

import Data.List
import Data.Maybe 
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

import GF.Data.Utilities
import GF.Speech.Graph
import qualified GF.Visualization.Graphviz as Dot

type State = Int

data FA n a b = FA !(Graph n a b) !n ![n]

type NFA a = FA State () (Maybe a)

type DFA a = FA State () a


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

newStates :: [a] -> FA n a b -> (FA n a b, [(n,a)])
newStates xs (FA g s ss) = (FA g' s ss, ns)
    where (g',ns) = newNodes xs g

newTransition :: n -> n -> b -> FA n a b -> FA n a b
newTransition f t l = onGraph (newEdge (f,t,l))

newTransitions :: [(n, n, b)] -> FA n a b -> FA n a b
newTransitions es = onGraph (newEdges es)

mapStates :: (a -> c) -> FA n a b -> FA n c b
mapStates f = onGraph (nmap f)

mapTransitions :: (b -> c) -> FA n a b -> FA n a c
mapTransitions f = onGraph (emap f)

minimize :: Ord a => NFA a -> DFA a
minimize = determinize . reverseNFA . dfa2nfa . determinize . reverseNFA

unusedNames :: FA n a b -> [n]
unusedNames (FA (Graph names _ _) _ _) = names

-- | Give new names to all nodes.
renameStates :: Ord x => [y] -- ^ Infinite supply of new names
             -> FA x a b
             -> FA y a b
renameStates supply (FA g s fs) = FA (renameNodes newName rest g) s' fs'
    where (ns,rest) = splitAt (length (nodes g)) supply
          newNodes = Map.fromList (zip (map fst (nodes g)) ns)
	  newName n = Map.findWithDefault (error "FiniteState.newName") n newNodes
          s' = newName s
          fs' = map newName fs

-- | Insert an NFA into another
insertNFA :: NFA a -- ^ NFA to insert into
          -> (State, State) -- ^ States to insert between
          -> NFA a -- ^ NFA to insert.
          -> NFA a
insertNFA (FA g1 s1 fs1) (f,t) (FA g2 s2 fs2) 
    = FA (newEdges es g') s1 fs1
    where 
    es = (f,ren s2,Nothing):[(ren f2,t,Nothing) | f2 <- fs2]
    (g',ren) = mergeGraphs g1 g2

onGraph :: (Graph n a b -> Graph n c d) -> FA n a b -> FA n c d
onGraph f (FA g s ss) = FA (f g) s ss


-- | Make the finite automaton have a single final state
--   by adding a new final state and adding an edge
--   from the old final states to the new state.
oneFinalState :: a        -- ^ Label to give the new node
              -> b        -- ^ Label to give the new edges
              -> FA n a b -- ^ The old network
              -> FA n a b -- ^ The new network
oneFinalState nl el fa =
    let (FA g s fs,nf) = newState nl fa
        es = [ (f,nf,el) | f <- fs ]
     in FA (newEdges es g) s [nf]

-- | Transform a standard finite automaton with labelled edges
--   to one where the labels are on the nodes instead. This can add
--   up to one extra node per edge.
moveLabelsToNodes :: (Ord n,Eq a) => FA n () (Maybe a) -> FA n (Maybe a) ()
moveLabelsToNodes = onGraph f
  where f g@(Graph c _ _) = Graph c' ns (concat ess)
	    where is = [ ((n,l),inc) | (n, (l,inc,_)) <- Map.toList (nodeInfo g)]
		  (c',is') = mapAccumL fixIncoming c is
		  (ns,ess) = unzip (concat is')


-- | Remove empty nodes which are not start or final, and have
--   exactly one outgoing edge or exactly one incoming edge.
removeTrivialEmptyNodes :: Ord n => FA n (Maybe a) () -> FA n (Maybe a) ()
removeTrivialEmptyNodes = pruneUnusable . skipSimpleEmptyNodes

-- | Move edges to empty nodes with exactly one outgoing edge 
--   or exactly one incoming edge to point to the next node(s).
skipSimpleEmptyNodes :: Ord n => FA n (Maybe a) () -> FA n (Maybe a) ()
skipSimpleEmptyNodes = onGraph og
  where 
  og g@(Graph c ns es) = Graph c ns (concatMap changeEdge es)
    where
    info = nodeInfo g
    changeEdge e@(f,t,()) 
      | isNothing (getNodeLabel info t)
        && (inDegree info t == 1 || outDegree info t == 1)
          = [ (f,t',()) | (_,t',()) <- getOutgoing info t]
      | otherwise = [e]


isInternal :: Eq n => FA n a b -> n -> Bool
isInternal (FA _ start final) n = n /= start && n `notElem` final

-- | Remove all internal nodes with no incoming edges
--   or no outgoing edges.
pruneUnusable :: Ord n => FA n (Maybe a) () -> FA n (Maybe a) ()
pruneUnusable fa = onGraph f fa
 where
 f g = removeNodes (Set.fromList [ n | (n,_) <- nodes g, 
                                   isInternal fa n,
                                   inDegree info n == 0 
                                    || outDegree info n == 0]) g
  where info = nodeInfo g

fixIncoming :: (Ord n, Eq a) => [n] 
            -> (Node n (),[Edge n (Maybe a)]) -- ^ A node and its incoming edges
            -> ([n],[(Node n (Maybe a),[Edge n ()])]) -- ^ Replacement nodes with their
                                                      -- incoming edges.
fixIncoming cs c@((n,()),es) = (cs'', ((n,Nothing),es'):newContexts)
  where ls = nub $ map edgeLabel es
	(cs',cs'') = splitAt (length ls) cs
	newNodes = zip cs' ls
	es' = [ (x,n,()) | x <- map fst newNodes ]
	-- separate cyclic and non-cyclic edges
	(cyc,ncyc) = partition (\ (f,_,_) -> f == n) es
	          -- keep all incoming non-cyclic edges with the right label
	to (x,l) = [ (f,x,()) | (f,_,l') <- ncyc, l == l']
	          -- for each cyclic edge with the right label, 
	          -- add an edge from each of the new nodes (including this one)
		    ++ [ (y,x,()) | (f,_,l') <- cyc, l == l', (y,_) <- newNodes]
	newContexts = [ (v, to v) | v <- newNodes ]

alphabet :: Eq b => Graph n a (Maybe b) -> [b]
alphabet = nub . catMaybes . map edgeLabel . edges

determinize :: Ord a => NFA a -> DFA a
determinize (FA g s f) = let (ns,es) = h (Set.singleton start) Set.empty Set.empty
                             (ns',es') = (Set.toList ns, Set.toList es)
                             final = filter isDFAFinal ns'
                             fa = FA (Graph undefined [(n,()) | n <- ns'] es') start final
 		          in renameStates [0..] fa
  where info = nodeInfo g
--        reach = nodesReachable out
	start = closure info $ Set.singleton s
        isDFAFinal n = not (Set.null (Set.fromList f `Set.intersection` n))
	h currentStates oldStates es
	    | Set.null currentStates = (oldStates,es)
	    | otherwise = ((h $! uniqueNewStates) $! allOldStates) $! es'
	    where 
	    allOldStates = oldStates `Set.union` currentStates
            (newStates,es') = new (Set.toList currentStates) Set.empty es
	    uniqueNewStates = newStates Set.\\ allOldStates
        -- Get the sets of states reachable from the given states 
        -- by consuming one symbol, and the associated edges.
        new [] rs es = (rs,es)
        new (n:ns) rs es = new ns rs' es'
          where cs = reachable info n --reachable reach n
                rs' = rs `Set.union` Set.fromList (map snd cs)
                es' = es `Set.union` Set.fromList [(n,s,c) | (c,s) <- cs]


-- | Get all the nodes reachable from a list of nodes by only empty edges.
closure :: Ord n => NodeInfo n a (Maybe b) -> Set n -> Set n
closure info x = closure_ x x
  where closure_ acc check | Set.null check = acc
                           | otherwise = closure_ acc' check'
            where
            reach = Set.fromList [y | x <- Set.toList check, 
                                      (_,y,Nothing) <- getOutgoing info x]
            acc' = acc `Set.union` reach
            check' = reach Set.\\ acc

-- | Get a map of labels to sets of all nodes reachable
--   from a the set of nodes by one edge with the given
--   label and then any number of empty edges.
reachable :: (Ord n,Ord b) => NodeInfo n a (Maybe b) -> Set n -> [(b,Set n)]
reachable info ns = Map.toList $ Map.map (closure info . Set.fromList) $ reachable1 info ns
reachable1 info ns = Map.fromListWith (++) [(c, [y]) | n <- Set.toList ns, (_,y,Just c) <- getOutgoing info n]

reverseNFA :: NFA a -> NFA a
reverseNFA (FA g s fs) = FA g''' s' [s]
    where g' = reverseGraph g
	  (g'',s') = newNode () g'
	  g''' = newEdges [(s',f,Nothing) | f <- fs] g''

dfa2nfa :: DFA a -> NFA a
dfa2nfa = mapTransitions Just

--
-- * Visualization
--

prFAGraphviz :: (Eq n,Show n) => FA n String String -> String
prFAGraphviz  = Dot.prGraphviz . faToGraphviz

prFAGraphviz_ :: (Eq n,Show n,Show a, Show b) => FA n a b -> String
prFAGraphviz_  = Dot.prGraphviz . faToGraphviz . mapStates show . mapTransitions show

faToGraphviz :: (Eq n,Show n) => FA n String String -> Dot.Graph
faToGraphviz (FA (Graph _ ns es) s f) 
    = Dot.Graph Dot.Directed Nothing [] (map mkNode ns) (map mkEdge es) []
   where mkNode (n,l) = Dot.Node (show n) attrs
	     where attrs = [("label",l)]
			   ++ if n == s then [("shape","box")] else []
			   ++ if n `elem` f then [("style","bold")] else []
	 mkEdge (x,y,l) = Dot.Edge (show x) (show y) [("label",l)]

--
-- * Utilities
--

lookups :: Ord k => [k] -> Map k a -> [a]
lookups xs m = mapMaybe (flip Map.lookup m) xs
