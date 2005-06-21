----------------------------------------------------------------------
-- |
-- Module      : VisualizeTree
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 
-- > CVS $Author:
-- > CVS $Revision: 
--
-- Print a graph of an abstract syntax tree in Graphviz DOT format
-- Based on BB's VisualizeGrammar
-----------------------------------------------------------------------------

module GF.Visualization.VisualizeTree ( visualizeTrees
			) where

import GF.Infra.Ident
import GF.Infra.Option
import GF.Grammar.Abstract
import GF.Data.Zipper
import GF.Grammar.PrGrammar

import Data.List (intersperse, nub)
import Data.Maybe (maybeToList)

visualizeTrees :: Options -> [Tree] -> String
visualizeTrees opts = unlines . map (prGraph opts . tree2graph opts)

tree2graph :: Options -> Tree -> [String]
tree2graph opts = prf [] where
  prf ps t@(Tr (node, trees)) = 
    let (nod,lab) = prn ps node in
      (nod ++ " [label = " ++ lab ++ ", style = \"solid\", shape = \"plaintext\"] ;") : 
      [       pra (j:ps) nod t | (j,t) <- zip [0..] trees] ++
      concat [prf (j:ps) t     | (j,t) <- zip [0..] trees]
  prn ps (N (bi,at,val,_,_)) = 
    let 
      lab = 
        "\"" ++ 
        prb bi ++ 
        prc at val ++ 
        "\""
    in if oElem (iOpt "g") opts then (lab,lab) else (show(show (ps :: [Int])),lab)
  prb [] = ""
  prb bi = "\\" ++ concat (intersperse "," (map (prt_ . fst) bi)) ++ " -> "
  pra i nod t@(Tr (node,_)) =  nod ++ arr ++ fst (prn i node) ++ " [style = \"solid\"];"
  prc a v 
    | oElem (iOpt "c") opts = prt_ v
    | oElem (iOpt "f") opts = prt_ a
    | otherwise             = prt_ a ++ " : " ++ prt_ v
  arr = if oElem (iOpt "g") opts then " -> " else " -- "

prGraph opts ns = concat $ map (++"\n") $ [graph ++ "{\n"] ++ ns ++ ["}"] where
  graph = if oElem (iOpt "g") opts then "digraph" else "graph"
