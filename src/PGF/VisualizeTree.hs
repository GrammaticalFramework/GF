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
-- FIXME: change this to use GF.Visualization.Graphviz, 
--        instead of rolling its own.
-----------------------------------------------------------------------------

module PGF.VisualizeTree ( visualizeTrees, alignLinearize
			) where

import PGF.CId (prCId)
import PGF.Data
import PGF.Linearize
import PGF.Macros (lookValCat)

import Data.List (intersperse)

visualizeTrees :: PGF -> (Bool,Bool) -> [Tree] -> String
visualizeTrees pgf funscats = unlines . map (prGraph False . tree2graph pgf funscats)

tree2graph :: PGF -> (Bool,Bool) -> Tree -> [String]
tree2graph pgf (funs,cats) = prf [] where
  prf ps t = case t of
    Fun cid trees -> 
      let (nod,lab) = prn ps cid in
        (nod ++ " [label = " ++ lab ++ ", style = \"solid\", shape = \"plaintext\"] ;") : 
        [       pra (j:ps) nod t | (j,t) <- zip [0..] trees] ++
        concat [prf (j:ps) t     | (j,t) <- zip [0..] trees]
  prn ps cid = 
    let
      fun = if funs then prCId cid else ""
      cat = if cats then prCat cid else ""
      colon = if funs && cats then " : " else ""
      lab = "\"" ++ fun ++ colon ++ cat ++ "\""
    in (show(show (ps :: [Int])),lab)
  pra i nod t@(Fun cid _) =  nod ++ arr ++ fst (prn i cid) ++ " [style = \"solid\"];"
  arr = " -- " -- if digr then " -> " else " -- "
  prCat = prCId . lookValCat pgf

prGraph digr ns = concat $ map (++"\n") $ [graph ++ "{\n"] ++ ns ++ ["}"] where
  graph = if digr then "digraph" else "graph"


-- word alignments from Linearize.linearizesMark
-- words are chunks like {[0,1,1,0] old}

alignLinearize :: PGF -> Tree -> String
alignLinearize pgf = prGraph True . lin2graph . linsMark  where
  linsMark t = [s | la <- cncnames pgf, s <- take 1 (linearizesMark pgf la t)]

lin2graph :: [String] -> [String]
lin2graph ss = prelude ++ nodes ++ links

 where

  prelude = ["rankdir=LR ;", "node [shape = record] ;"]

  -- the plain string, with syncategorematic words included
  strings = filter (flip notElem "{[()]}" . head) . words

  -- find all lexicalized words
  lins :: String -> [(String,String)]
  lins [] = []
  lins s = let (s1, s2)  = if null s  then ([],[]) else span (/='{') s in 
           let (s21,s22) = if null s2 then ([],[]) else span (/='}') (tail s2) in
           if null s21 then lins s22 else wlink s21 : lins s22

  -- separate a word to the link (1,2,3) and the word itself
  wlink :: String -> (String,String)
  wlink s = let (s1, s2)  = span (/=']') s in 
            (tail s1, unwords (words (init (drop 1 s2))))

  -- to merge in syncat words
  slins i s = merge (strings s) (lins s) where
    merge ws cs = case (ws,cs) of
      (w:ws2,(m,c):cs2) | w==c -> (m,c) : merge ws2 cs2
      (w:ws2,_        )        -> ("w" ++ show i,w) : merge ws2 cs
      _                        -> []

  -- make all marks unique to deal with discontinuities
  nlins :: [(Int,[((Int,String),String)])]
  nlins = [(i, [((j,m),w) | (j,(m,w)) <- zip [0..] (slins i s)]) | (i,s) <- zip [0..] ss]

  nodes = map mkStruct nlins

  mkStruct (i, ws) = struct i ++ "[label = \"" ++ fields ws ++ "\"] ;"

  fields ws = concat (intersperse "|" [tag (mark m) ++ " " ++ w | (m,w) <- ws]) 

  struct i = "struct" ++ show i

  mark (j,n) = "n" ++ show j ++ "a" ++ uncommas n

  uncommas = map (\c -> if c==',' then 'c' else c)

  tag s = "<" ++ s ++ ">"

  links = concatMap mkEdge (init nlins)

  mkEdge (i,lin) = let lin' = snd (nlins !! (i+1)) in -- next lin in the list
    [edge i v w | (v@(_,p),_) <- lin, (w@(_,q),_) <- lin', p == q]

  edge i v w = 
    struct i ++ ":" ++ mark v ++ ":e -> " ++ struct (i+1) ++ ":" ++ mark w ++ ":w ;"

{-
digraph{
rankdir ="LR" ;
node [shape = record] ;

struct1 [label = "<f0> this|<f1> very|<f2> intelligent|<f3> man"] ;
struct2 [label = "<f0> cet|<f1> homme|<f2> tres|<f3> intelligent|<f4> ci"] ;

struct1:f0 -> struct2:f0 ;
struct1:f1 -> struct2:f2 ;
struct1:f2 -> struct2:f3 ;
struct1:f3 -> struct2:f1 ;
struct1:f0 -> struct2:f4 ;
}
-}

