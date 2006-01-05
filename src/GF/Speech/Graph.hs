----------------------------------------------------------------------
-- |
-- Module      : Graph
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/10 16:43:44 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- A simple graph module.
-----------------------------------------------------------------------------
module GF.Speech.Graph ( Graph(..), Node, Edge, NodeInfo
                        , newGraph, nodes, edges
                        , nmap, emap, newNode, newNodes, newEdge, newEdges
                        , removeNodes
                        , nodeInfo
                        , getIncoming, getOutgoing, getNodeLabel
                        , inDegree, outDegree
                        , edgeFrom, edgeTo, edgeLabel
                        , reverseGraph, renameNodes
                       ) where

import GF.Data.Utilities

import Data.List
import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

data Graph n a b = Graph [n] ![Node n a] ![Edge n b]
		 deriving (Eq,Show)

type Node n a = (n,a)
type Edge n b = (n,n,b)

type NodeInfo n a b = Map n (a, [Edge n b], [Edge n b])

-- | Create a new empty graph.
newGraph :: [n] -> Graph n a b
newGraph ns = Graph ns [] []

-- | Get all the nodes in the graph.
nodes :: Graph n a b -> [Node n a]
nodes (Graph _ ns _) = ns

-- | Get all the edges in the graph.
edges :: Graph n a b -> [Edge n b]
edges (Graph _ _ es) = es

-- | Map a function over the node labels.
nmap :: (a -> c) -> Graph n a b -> Graph n c b
nmap f (Graph c ns es) = Graph c [(n,f l) | (n,l) <- ns] es

-- | Map a function over the edge labels.
emap :: (b -> c) -> Graph n a b -> Graph n a c
emap f (Graph c ns es) = Graph c ns [(x,y,f l) | (x,y,l) <- es]

-- | Add a node to the graph.
newNode :: a               -- ^ Node label
        -> Graph n a b 
        -> (Graph n a b,n) -- ^ Node graph and name of new node
newNode l (Graph (c:cs) ns es) = (Graph cs ((c,l):ns) es, c)

newNodes :: [a] -> Graph n a b -> (Graph n a b,[Node n a])
newNodes ls g = (g', zip ns ls)
  where (g',ns) = mapAccumL (flip newNode) g ls
-- lazy version:
--newNodes ls (Graph cs ns es) = (Graph cs' (ns'++ns) es, ns')
--  where (xs,cs') = splitAt (length ls) cs
--        ns' = zip xs ls

newEdge :: Edge n b -> Graph n a b -> Graph n a b
newEdge e (Graph c ns es) = Graph c ns (e:es)

newEdges :: [Edge n b] -> Graph n a b -> Graph n a b
newEdges es g = foldl' (flip newEdge) g es
-- lazy version:
-- newEdges es' (Graph c ns es) = Graph c ns (es'++es)

-- | Remove a set of nodes and all edges to and from those nodes.
removeNodes :: Ord n => Set n -> Graph n a b -> Graph n a b
removeNodes xs (Graph c ns es) = Graph c ns' es'
  where 
  keepNode n = not (Set.member n xs)
  ns' = [ x | x@(n,_) <- ns, keepNode n ]
  es' = [ e | e@(f,t,_) <- es, keepNode f && keepNode t ]

-- | Get a map of node names to info about each node.
nodeInfo :: Ord n => Graph n a b -> NodeInfo n a b
nodeInfo g = Map.fromList [ (n, (x, fn inc n, fn out n)) | (n,x) <- nodes g ]
  where 
  inc = groupEdgesBy edgeTo g
  out = groupEdgesBy edgeFrom g
  fn m n = fromMaybe [] (Map.lookup n m)

groupEdgesBy :: (Ord n) => (Edge n b -> n) -- ^ Gets the node to group by
             -> Graph n a b -> Map n [Edge n b]
groupEdgesBy f g = Map.fromListWith (++) [(f e, [e]) | e <- edges g]

lookupNode :: Ord n => NodeInfo n a b -> n -> (a, [Edge n b], [Edge n b])
lookupNode i n = fromJust $ Map.lookup n i

getIncoming :: Ord n => NodeInfo n a b -> n -> [Edge n b]
getIncoming i n = let (_,inc,_) = lookupNode i n in inc

getOutgoing :: Ord n => NodeInfo n a b -> n -> [Edge n b]
getOutgoing i n = let (_,_,out) = lookupNode i n in out

inDegree :: Ord n => NodeInfo n a b -> n -> Int
inDegree i n = length $ getIncoming i n

outDegree :: Ord n => NodeInfo n a b -> n -> Int
outDegree i n = length $ getOutgoing i n

getNodeLabel :: Ord n => NodeInfo n a b -> n -> a
getNodeLabel i n = let (l,_,_) = lookupNode i n in l

{-
-- | Get a map of nodes and their incoming edges.
incoming :: Ord n => Graph n a b -> Incoming n a b
incoming = groupEdgesBy getTo

-- | Get all edges ending at a given node.
getIncoming :: Ord n => Incoming n a b -> n -> [Edge n b]
getIncoming out x = maybe [] snd (Map.lookup x out)

incomingToList :: Incoming n a b -> [(Node n a, [Edge n b])]
incomingToList out = [ ((n,x),es) | (n,(x,es)) <- Map.toList out ]

-- | Get a map of nodes and their outgoing edges.
outgoing :: Ord n => Graph n a b -> Outgoing n a b
outgoing = groupEdgesBy getFrom

-- | Get all edges starting at a given node.
getOutgoing :: Ord n => Outgoing n a b -> n -> [Edge n b]
getOutgoing out x = maybe [] snd (Map.lookup x out)

-- | Get the label of a node given its outgoing list.
getLabelOut :: Ord n => Outgoing n a b -> n -> a
getLabelOut out x = fst $ fromJust (Map.lookup x out)

groupEdgesBy :: (Ord n) => (Edge n b -> n) -> Graph n a b -> Map n (a,[Edge n b])
groupEdgesBy f (Graph _ ns es) = 
    foldl' (\m e -> Map.adjust (\ (x,el) -> (x,e:el)) (f e) m) nm es
  where nm = Map.fromList [ (n, (x,[])) | (n,x) <- ns ]
-}

edgeFrom :: Edge n b -> n
edgeFrom (f,_,_) = f

edgeTo :: Edge n b -> n
edgeTo (_,t,_) = t

edgeLabel :: Edge n b -> b
edgeLabel (_,_,l) = l

reverseGraph :: Graph n a b -> Graph n a b
reverseGraph (Graph c ns es) = Graph c ns [ (t,f,l) | (f,t,l) <- es ]


-- | Rename the nodes in the graph.
renameNodes :: (n -> m) -- ^ renaming function
            -> [m] -- ^ infinite supply of fresh node names, to
                   --   use when adding nodes in the future.
            -> Graph n a b -> Graph m a b
renameNodes newName c (Graph _ ns es) = Graph c ns' es'
    where ns' = map' (\ (n,x) -> (newName n,x)) ns
	  es' = map' (\ (f,t,l) -> (newName f, newName t, l)) es

-- | A strict 'map'
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = ((:) $! f x) $! map' f xs
