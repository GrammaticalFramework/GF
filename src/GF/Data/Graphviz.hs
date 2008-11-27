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

module GF.Data.Graphviz (
				  Graph(..), GraphType(..), 
				  Node(..), Edge(..),
				  Attr,
                                  addSubGraphs,
                                  setName,
                                  setAttr,
				  prGraphviz
			) where

import Data.Char

import GF.Data.Utilities

-- | Graph type, graph ID, graph attirbutes, graph nodes, graph edges, subgraphs
data Graph = Graph {
                    gType :: GraphType,
                    gId :: Maybe String,
                    gAttrs :: [Attr],
                    gNodes :: [Node],
                    gEdges :: [Edge],
                    gSubgraphs :: [Graph]
                   }
  deriving (Show)

data GraphType = Directed | Undirected
  deriving (Show)

data Node = Node String [Attr]
  deriving Show

data Edge = Edge String String [Attr]
  deriving Show

type Attr = (String,String)

--
-- * Graph construction
--

addSubGraphs :: [Graph] -> Graph -> Graph
addSubGraphs gs g = g { gSubgraphs = gs ++ gSubgraphs g }

setName :: String -> Graph -> Graph
setName n g = g { gId = Just n }

setAttr :: String -> String -> Graph -> Graph
setAttr n v g = g { gAttrs = tableSet n v (gAttrs g) }

--
-- * Pretty-printing
--

prGraphviz :: Graph -> String
prGraphviz g@(Graph t i _ _ _ _) =
    graphtype t ++ " " ++ maybe "" esc i ++ " {\n" ++ prGraph g ++ "}\n"

prSubGraph :: Graph -> String
prSubGraph g@(Graph _ i _ _ _ _) = 
    "subgraph" ++ " " ++ maybe "" esc i ++ " {\n" ++ prGraph g ++ "}"

prGraph :: Graph -> String
prGraph (Graph t id at ns es ss) = 
    unlines $ map (++";") (map prAttr at
		           ++ map prNode ns 
		           ++ map (prEdge t) es
                           ++ map prSubGraph ss)

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
