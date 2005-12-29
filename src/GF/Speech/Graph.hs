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
module GF.Speech.Graph ( Graph(..), Node, Edge, Incoming, Outgoing
                        , newGraph, nodes, edges
                        , nmap, emap, newNode, newNodes, newEdge, newEdges
                        , incoming, incomingToList
                        , outgoing, getOutgoing
                        , getFrom, getTo, getLabel
                        , reverseGraph, renameNodes
                       ) where

import GF.Data.Utilities

import Data.List

import Data.Map (Map)
import qualified Data.Map as Map

data Graph n a b = Graph [n] [Node n a] [Edge n b]
		 deriving (Eq,Show)

type Node n a = (n,a)
type Edge n b = (n,n,b)

type Incoming n a b = Map n (a, [Edge n b])
type Outgoing n a b = Map n (a, [Edge n b])

newGraph :: [n] -> Graph n a b
newGraph ns = Graph ns [] []

nodes :: Graph n a b -> [Node n a]
nodes (Graph _ ns _) = ns

edges :: Graph n a b -> [Edge n b]
edges (Graph _ _ es) = es

-- | Map a function over the node label.s
nmap :: (a -> c) -> Graph n a b -> Graph n c b
nmap f (Graph c ns es) = Graph c [(n,f l) | (n,l) <- ns] es

-- | Map a function over the edge labels.
emap :: (b -> c) -> Graph n a b -> Graph n a c
emap f (Graph c ns es) = Graph c ns [(x,y,f l) | (x,y,l) <- es]

newNode :: a -> Graph n a b -> (Graph n a b,n)
newNode l (Graph (c:cs) ns es) = (Graph cs ((c,l):ns) es, c)

newNodes :: [a] -> Graph n a b -> (Graph n a b,[Node n a])
newNodes ls (Graph cs ns es) = (Graph cs' (ns'++ns) es, ns')
  where (xs,cs') = splitAt (length ls) cs
        ns' = zip xs ls

newEdge :: Edge n b -> Graph n a b -> Graph n a b
newEdge e (Graph c ns es) = Graph c ns (e:es)

newEdges :: [Edge n b] -> Graph n a b -> Graph n a b
newEdges es' (Graph c ns es) = Graph c ns (es'++es)

-- | Get a map of nodes and their incoming edges.
incoming :: Ord n => Graph n a b -> Incoming n a b
incoming = groupEdgesBy getTo

incomingToList :: Incoming n a b -> [(Node n a, [Edge n b])]
incomingToList out = [ ((n,x),es) | (n,(x,es)) <- Map.toList out ]

-- | Get a map of nodes and their outgoing edges.
outgoing :: Ord n => Graph n a b -> Outgoing n a b
outgoing = groupEdgesBy getFrom

-- | Get all edges starting at a given node.
getOutgoing :: Ord n => Outgoing n a b -> n -> [Edge n b]
getOutgoing out x = maybe [] snd (Map.lookup x out)

groupEdgesBy :: (Ord n) => (Edge n b -> n) -> Graph n a b -> Map n (a,[Edge n b])
groupEdgesBy f (Graph _ ns es) = 
    foldl (\m e -> Map.adjust (\ (x,el) -> (x,e:el)) (f e) m) nm es
  where nm = Map.fromList [ (n, (x,[])) | (n,x) <- ns ]

getFrom :: Edge n b -> n
getFrom (f,_,_) = f

getTo :: Edge n b -> n
getTo (_,t,_) = t

getLabel :: Edge n b -> b
getLabel (_,_,l) = l

reverseGraph :: Graph n a b -> Graph n a b
reverseGraph (Graph c ns es) = Graph c ns [ (t,f,l) | (f,t,l) <- es ]


-- | Re-name the nodes in the graph.
renameNodes :: (n -> m) -- ^ renaming function
            -> [m] -- ^ infinite supply of fresh node names, to
                   --   use when adding nodes in the future.
            -> Graph n a b -> Graph m a b
renameNodes newName c (Graph _ ns es) = Graph c ns' es'
    where ns' = [ (newName n,x) | (n,x) <- ns ]
	  es' = [ (newName f, newName t, l) | (f,t,l) <- es]
