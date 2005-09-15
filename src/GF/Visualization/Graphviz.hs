----------------------------------------------------------------------
-- |
-- Module      : Graphviz
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/15 18:10:44 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Graphviz DOT format representation and printing.
-----------------------------------------------------------------------------

module GF.Visualization.Graphviz (
				  Graph(..), GraphType(..), 
				  Node(..), Edge(..),
				  Attr,
				  prGraphviz
			) where

import Data.Char

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
prEdge t (Edge x y at) = esc x ++ " " ++ edgeop t ++ " " ++ esc y ++ " " ++ prAttrList at

edgeop :: GraphType -> String
edgeop Directed = "->"
edgeop Undirected = "--"

prAttrList :: [Attr] -> String
prAttrList [] = ""
prAttrList at =	"[" ++ join "," (map prAttr at) ++ "]"

prAttr :: Attr -> String
prAttr (n,v) = esc n ++ " = " ++ esc v

esc :: String -> String
esc s | needEsc s = "\"" ++ concat [ if shouldEsc c then ['\\',c] else [c] | c <- s ] ++ "\""
      | otherwise = s
  where shouldEsc = (`elem` ['"', '\\'])

needEsc :: String -> Bool
needEsc [] = True
needEsc xs | all isDigit xs = False
needEsc (x:xs) = not (isIDFirst x && all isIDChar xs)

isIDFirst, isIDChar :: Char -> Bool
isIDFirst c = c `elem` (['_']++['a'..'z']++['A'..'Z'])
isIDChar c = isIDFirst c || isDigit c
