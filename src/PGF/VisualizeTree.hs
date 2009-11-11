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

module PGF.VisualizeTree ( graphvizAbstractTree
                         , graphvizParseTree
                         , graphvizDependencyTree
                         , graphvizAlignment

                         , getDepLabels
                         , PosText(..), readPosText
			 ) where

import PGF.CId (CId,showCId,pCId,mkCId)
import PGF.Data
import PGF.Tree
import PGF.Linearize
import PGF.Macros (lookValCat)

import qualified Data.Map as Map
import Data.List (intersperse,nub,isPrefixOf,sort,sortBy)
import Data.Char (isDigit)
import qualified Text.ParserCombinators.ReadP as RP

import Debug.Trace

graphvizAbstractTree :: PGF -> (Bool,Bool) -> Expr -> String
graphvizAbstractTree pgf funscats = prGraph False . tree2graph pgf funscats . expr2tree

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
      fun = if funs then showCId cid else ""
      cat = if cats then prCat cid else ""
      colon = if funs && cats then " : " else ""
      lab = "\"" ++ fun ++ colon ++ cat ++ "\""
    in (show(show (ps :: [Int])),lab)
  pra i nod t@(Fun cid _) =  nod ++ arr ++ fst (prn i cid) ++ " [style = \"solid\"];"
  arr = " -- " -- if digr then " -> " else " -- "
  prCat = showCId . lookValCat pgf

prGraph digr ns = concat $ map (++"\n") $ [graph ++ "{\n"] ++ ns ++ ["}"] where
  graph = if digr then "digraph" else "graph"


-- dependency trees from Linearize.linearizeMark

graphvizDependencyTree :: String -> Bool -> Maybe Labels -> Maybe String -> PGF -> CId -> Expr -> String
graphvizDependencyTree format debug mlab ms pgf lang exp = case format of
  "malt" -> unlines (lin2dep format)
  "malt_input" -> unlines (lin2dep format)
  _ -> prGraph True (lin2dep format) 

 where

  lin2dep format = trace (ifd (show sortedNodes ++ show nodeWords)) $ case format of
    "malt" -> map (concat . intersperse "\t") wnodes
    "malt_input" -> map (concat . intersperse "\t" . take 6) wnodes
    _ -> prelude ++ nodes ++ links

  ifd s = if debug then s else []

  pot = readPosText $ head $ linearizesMark pgf lang exp
  ---- use Just str if you have str to match against

  prelude = ["rankdir=LR ;", "node [shape = plaintext] ;"]

  nodes = map mkNode nodeWords
  mkNode (i,((_,p),ss)) = 
    node p ++ " [label = \"" ++ show i ++ ". " ++ ifd (show p) ++ unwords ss ++ "\"] ;"
  nodeWords = (0,((mkCId "",[]),["ROOT"])) : zip [1..] [((f,p),w)| 
                                       ((Just f,p),w) <- wlins pot]

  links = map mkLink thelinks 
  thelinks =  [(word y, x, label tr y x) | 
                      (_,((f,x),_)) <- tail nodeWords,
                      let y = dominant x]
  mkLink (x,y,l) = node x ++ " -> " ++ node y ++ " [label = \"" ++ l ++ "\"] ;"
  node = show . show

  dominant x = case x of 
    [] -> x
    _ | not (x == hx) -> hx
    _  -> dominant (init x)
   where
    hx = headArg (init x) tr x

  headArg x0 tr x = case (tr,x) of
    (Fun f [],[_]) -> x0 ---- ??
    (Fun f ts,[_]) -> x0 ++ [getHead (length ts - 1) f]
    (Fun f ts,i:y) -> headArg x0 (ts !! i) y

  label tr y x = case span (uncurry (==)) (zip y x) of
    (xys,(_,i):_) -> getLabel i (funAt tr (map fst xys))
    _ -> "" ----

  funAt tr x = case (tr,x) of
    (Fun f _ ,[])  -> f
    (Fun f ts,i:y) -> funAt (ts !! i) y

  word x = if elem x sortedNodes then x else 
           let x' = headArg x tr (x ++[0]) in
           if x' == x then [] else word x'

  tr = expr2tree exp
  sortedNodes = [p | (_,((_,p),_)) <- nodeWords]

  labels = maybe Map.empty id mlab
  getHead i f = case Map.lookup f labels of
    Just ls -> length $ takeWhile (/= "head") ls
    _ -> i
  getLabel i f = case Map.lookup f labels of
    Just ls | length ls > i -> ifd (showCId f ++ "#" ++ show i ++ "=") ++ ls !! i
    _ -> showCId f ++ "#" ++ show i

-- to generate CoNLL format for MaltParser
  nodeMap :: Map.Map [Int] Int
  nodeMap = Map.fromList [(p,i) | (i,((_,p),_)) <- nodeWords]

  arcMap :: Map.Map [Int] ([Int],String)
  arcMap = Map.fromList [(y,(x,l)) | (x,y,l) <- thelinks]

  lookDomLab p = case Map.lookup p arcMap of
    Just (q,l) -> (maybe 0 id (Map.lookup q nodeMap), if null l then rootlabel else l)
    _          -> (0,rootlabel)

  wnodes = [[show i, maltws ws, showCId fun, pos, pos, morph, show dom, lab, unspec, unspec] | 
              (i, ((fun,p),ws)) <- tail nodeWords,
              let pos = showCId $ lookValCat pgf fun,
              let morph = unspec,
              let (dom,lab) = lookDomLab p
           ]
  maltws = concat . intersperse "+" . words . unwords  -- no spaces in column 2
  unspec = "_"
  rootlabel = "ROOT"

type Labels = Map.Map CId [String]

getDepLabels :: [String] -> Labels
getDepLabels ss = Map.fromList [(mkCId f,ls) | f:ls <- map words ss]


-- parse trees from Linearize.linearizeMark
---- nubrec and domins are quadratic, but could be (n log n)

graphvizParseTree :: PGF -> CId -> Expr -> String
graphvizParseTree pgf lang = prGraph False . lin2tree pgf . linMark where
  linMark = head . linearizesMark pgf lang
  ---- use Just str if you have str to match against

lin2tree pgf s = trace s $ prelude ++ nodes ++ links where

  prelude = ["rankdir=BU ;", "node [shape = record, color = white] ;"]

  nodeRecs = zip [0..] 
    (nub (filter (not . null) (nlins [postext] ++ [leaves postext])))
  nlins pts = 
    nubrec [] $ [(p,cat f) | T (Just f, p) _ <- pts] : 
                   concatMap nlins [ts | T _ ts <- pts]  
  leaves pt = [(p++[j],s) | (j,(p,s)) <- 
                zip [9990..] [(p,s) | ((_,p),ss) <- wlins pt, s <- ss]]

  nubrec es rs = case rs of
    r:rr -> let r' = filter (not . flip elem es) (nub r) 
            in r' : nubrec (r' ++ es) rr
    _ -> rs

  nodes = map mkStruct nodeRecs

  mkStruct (i,cs) = struct i ++ "[label = \"" ++ fields cs ++ "\"] ;"
  cat = showCId . lookValCat pgf
  fields cs = concat (intersperse "|" [ mtag (showp p) ++ c | (p,c) <- cs])
  struct i = "struct" ++ show i

  links = map mkEdge domins
  domins = nub [((i,x),(j,y)) | 
    (i,xs) <- nodeRecs, (j,ys) <- nodeRecs, 
    x <- xs, y <- ys, dominates x y]
  dominates (p,x) (q,y) = not (null q) && p == init q
  mkEdge ((i,x),(j,y)) = 
    struct i ++ ":n" ++ uncommas (showp (fst x)) ++ ":s -- " ++ 
    struct j ++ ":n" ++ uncommas (showp (fst y)) ++ ":n ;"

  postext = readPosText s

-- auxiliaries for graphviz syntax
struct i = "struct" ++ show i
mark (j,n) = "n" ++ show j ++ "a" ++ uncommas n
uncommas = map (\c -> if c==',' then 'c' else c)
tag s = "<" ++ s ++ ">"
showp = init . tail . show
mtag = tag . ('n':) . uncommas

-- word alignments from Linearize.linearizesMark
-- words are chunks like {[0,1,1,0] old}

graphvizAlignment :: PGF -> Expr -> String
graphvizAlignment pgf = prGraph True . lin2graph . linsMark  where
  linsMark t = [s | la <- cncnames pgf, s <- take 1 (linearizesMark pgf la t)]

lin2graph :: [String] -> [String]
lin2graph ss = trace (show ss) $ prelude ++ nodes ++ links

 where

  prelude = ["rankdir=LR ;", "node [shape = record] ;"]

  nlins :: [(Int,[((Int,String),String)])]
  nlins = [(i, [((j,showp p),unw ws) | (j,((_,p),ws)) <- zip [0..] ws]) | 
                                (i,ws) <- zip [0..] (map (wlins . readPosText) ss)]

  unw = concat . intersperse "\\ "  -- space escape in graphviz

  nodes = map mkStruct nlins

  mkStruct (i, ws) = struct i ++ "[label = \"" ++ fields ws ++ "\"] ;"

  fields ws = concat (intersperse "|" [tag (mark m) ++ " " ++ w | (m,w) <- ws]) 

  links = nub $ concatMap mkEdge (init nlins)

  mkEdge (i,lin) = let lin' = snd (nlins !! (i+1)) in -- next lin in the list
    [edge i v w | (v@(_,p),_) <- lin, (w@(_,q),_) <- lin', p == q]

  edge i v w = 
    struct i ++ ":" ++ mark v ++ ":e -> " ++ struct (i+1) ++ ":" ++ mark w ++ ":w ;"
{-
alignmentData :: PGF -> [Expr] -> Map.Map String (Map.Map String Double)
alignmentData pgf = mkStat . concatMap (mkAlign . linsMark)  where
  linsMark t = 
    [s | la <- take 2 (cncnames pgf), s <- take 1 (linearizesMark pgf la t)]

  mkStat :: [(String,String)] -> Map.Map String (Map.Map String Double)
  mkStat = 

  mkAlign :: [String] -> [(String,String)]
  mkAlign ss = 

  nlins :: [(Int,[((Int,String),String)])]
  nlins = [(i, [((j,showp p),unw ws) | (j,((_,p),ws)) <- zip [0..] vs]) | 
                                (i,vs) <- zip [0..] (map (wlins . readPosText) ss)]

  nodes = map mkStruct nlins

  mkStruct (i, ws) = struct i ++ "[label = \"" ++ fields ws ++ "\"] ;"

  fields ws = concat (intersperse "|" [tag (mark m) ++ " " ++ w | (m,w) <- ws]) 

  links = nub $ concatMap mkEdge (init nlins)

  mkEdge (i,lin) = let lin' = snd (nlins !! (i+1)) in -- next lin in the list
    [edge i v w | (v@(_,p),_) <- lin, (w@(_,q),_) <- lin', p == q]

  edge i v w = 
    struct i ++ ":" ++ mark v ++ ":e -> " ++ struct (i+1) ++ ":" ++ mark w ++ ":w ;"
-}

wlins :: PosText -> [((Maybe CId,[Int]),[String])]
wlins pt = case pt of
  T p pts -> concatMap (lins p) pts
  M ws -> if null ws then [] else [((Nothing,[]),ws)]
 where
  lins p pt = case pt of
    T q pts -> concatMap (lins q) pts
    M ws -> if null ws then [] else [(p,ws)]

data PosText = 
   T (Maybe CId,[Int]) [PosText]
 | M [String]
  deriving Show

readPosText :: String -> PosText
readPosText = fst . head . (RP.readP_to_S pPosText) where
  pPosText = do
    RP.char '(' >> RP.skipSpaces
    p  <- pPos  
    RP.skipSpaces
    ts <- RP.many pPosText
    RP.char ')' >> RP.skipSpaces
    return (T p ts)
   RP.<++ do
    ws <- RP.sepBy1 (RP.munch1 (flip notElem "()")) (RP.char ' ') 
    return (M ws) 
  pPos = do
    fun <- (RP.char '(' >> pCId >>= \f -> RP.char ',' >> (return $ Just f)) 
           RP.<++ (return Nothing)
    RP.char '[' >> RP.skipSpaces
    is <- RP.sepBy (RP.munch1 isDigit) (RP.char ',')
    RP.char ']' >> RP.skipSpaces
    RP.char ')' RP.<++ return ' ' 
    return (fun,map read is)


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

