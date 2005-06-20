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
visualizeTrees opts = unlines . map (prGraph . tree2graph opts)

tree2graph :: Options -> Tree -> [String]
tree2graph opts = prf (0,0) where
  prf (i,j) t@(Tr (node, trees)) = 
    let nod = prn (i,j) node in
      (nod ++ " [style = \"solid\", shape = \"plaintext\"] ;") : 
      [pra (i+1,j) nod t    | (j,t) <- zip [0..] trees] ++
      concat [prf (i+1,j) t | (j,t) <- zip [0..] trees]
  prn (i,j) (N (bi,at,val,_,_)) = 
    "\"" ++ prs i ++ 
    prb bi ++ 
    prc at val ++ 
    prs j ++ "\""
  prb [] = ""
  prb bi = "\\" ++ concat (intersperse "," (map (prt_ . fst) bi)) ++ " -> "
  pra i nod t@(Tr (node,_)) =  nod ++ " -- " ++ prn i node ++ " [style = \"solid\"];"

  prs k = if oElem (iOpt "g") opts then "" else replicate k ' '
  prc a v 
    | oElem (iOpt "c") opts = prt_ v
    | oElem (iOpt "f") opts = prt_ a
    | otherwise             = prt_ a ++ " : " ++ prt_ v

prGraph ns = concat $ map (++"\n") $ ["graph {\n"] ++ ns ++ ["}"]
