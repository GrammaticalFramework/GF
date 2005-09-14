----------------------------------------------------------------------
-- |
-- Module      : Graphviz
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/14 15:17:30 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- Graphviz DOT format representation and printing.
-----------------------------------------------------------------------------

module GF.Visualization.Graphviz (
				  Graph(..), GraphType(..), 
				  Node(..), Edge(..),
				  Attr,
				  prGraphviz
			) where

import GF.Data.Utilities

data Graph = Graph GraphType [Attr] [Node] [Edge]
  deriving (Show)

data GraphType = Directed | Undirected
  deriving (Show)

data Node = Node String [Attr]
  deriving Show

data Edge = Edge String String [Attr]
  deriving Show

type Attr = (String,String)

prGraphviz :: Graph -> String
prGraphviz (Graph t at ns es) = 
    unlines $ [graphtype t ++ " {"] 
		++ map (++";") (map prAttr at
				++ map prNode ns 
				++ map (prEdge t) es) 
		++ ["}\n"]

graphtype :: GraphType -> String
graphtype Directed = "digraph"
graphtype Undirected = "graph"

prNode :: Node -> String
prNode (Node n at) = esc n ++ " " ++ prAttrList at

prEdge :: GraphType -> Edge -> String
prEdge t (Edge x y at) = esc x ++ " " ++ edgeop t ++ " " ++ prAttrList at

edgeop :: GraphType -> String
edgeop Directed = "->"
edgeop Undirected = "--"

prAttrList :: [Attr] -> String
prAttrList = join "," . map prAttr

prAttr :: Attr -> String
prAttr (n,v) = esc n ++ " = " ++ esc v

esc :: String -> String
esc s = "\"" ++ concat [ if shouldEsc c then ['\\',c] else [c] | c <- s ] ++ "\""
  where shouldEsc = (`elem` ['"', '\\'])