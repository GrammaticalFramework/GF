----------------------------------------------------------------------
-- |
-- Module      : Graph
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/26 17:13:13 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- A simple graph module.
-----------------------------------------------------------------------------
module GF.Speech.Graph ( Graph(..), Node, Edge, Incoming, Outgoing
                        , newGraph, nodes, edges
                        , nmap, emap, newNode, newEdge, newEdges
                        , incoming, outgoing, getOutgoing
                        , getFrom, getTo, getLabel
                        , reverseGraph                             
                       ) where

import GF.Data.Utilities

import Data.List

data Graph n a b = Graph [n] [Node n a] [Edge n b]
		 deriving (Eq,Show)

type Node n a = (n,a)
type Edge n b = (n,n,b)

type Incoming n a b = [(Node n a,[Edge n b])]
type Outgoing n a b = [(Node n a,[Edge n b])]

newGraph :: [n] -> Graph n a b
newGraph ns = Graph ns [] []

nodes :: Graph n a b -> [Node n a]
nodes (Graph _ ns _) = ns

edges :: Graph n a b -> [Edge n b]
edges (Graph _ _ es) = es

nmap :: (a -> c) -> Graph n a b -> Graph n c b
nmap f (Graph c ns es) = Graph c [(n,f l) | (n,l) <- ns] es

emap :: (b -> c) -> Graph n a b -> Graph n a c
emap f (Graph c ns es) = Graph c ns [(x,y,f l) | (x,y,l) <- es]

newNode :: a -> Graph n a b -> (Graph n a b,n)
newNode l (Graph (c:cs) ns es) = (Graph cs ((c,l):ns) es, c)

newEdge :: Edge n b -> Graph n a b -> Graph n a b
newEdge e (Graph c ns es) = Graph c ns (e:es)

newEdges :: [Edge n b] -> Graph n a b -> Graph n a b
newEdges es' (Graph c ns es) = Graph c ns (es'++es)

-- | Get a list of all nodes and their incoming edges.
incoming :: Ord n => Graph n a b -> Incoming n a b
incoming = groupEdgesBy getTo

-- | Get a list of all nodes and their outgoing edges.
outgoing :: Ord n => Graph n a b -> Outgoing n a b
outgoing = groupEdgesBy getFrom

-- | From a list of outgoing edges, get all edges
--   starting at a given node.
getOutgoing :: Eq n => Outgoing n a b -> n -> [Edge n b]
getOutgoing out x = head [ es | ((y,_),es) <- out, x == y ]

groupEdgesBy :: (Ord n) => (Edge n b -> n) -> Graph n a b -> [(Node n a,[Edge n b])]
groupEdgesBy h (Graph _ ns es) = 
    snd $ mapAccumL f (sortBy (compareBy h) es) (sortBy (compareBy fst) ns)
  where f es' v@(n,_) = let (nes,es'') = span ((==n) . h) es' in (es'',(v,nes))

getFrom :: Edge n b -> n
getFrom (f,_,_) = f

getTo :: Edge n b -> n
getTo (_,t,_) = t

getLabel :: Edge n b -> b
getLabel (_,_,l) = l

reverseGraph :: Graph n a b -> Graph n a b
reverseGraph (Graph c ns es) = Graph c ns [ (t,f,l) | (f,t,l) <- es ]

