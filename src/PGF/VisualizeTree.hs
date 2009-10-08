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

module PGF.VisualizeTree ( visualizeTrees, parseTree, dependencyTree, alignLinearize
  ,PosText(..),readPosText
			) where

import PGF.CId (CId,showCId,pCId)
import PGF.Data
import PGF.Tree
import PGF.Linearize
import PGF.Macros (lookValCat)

import Data.List (intersperse,nub,isPrefixOf,sort,sortBy)
import Data.Char (isDigit)
import qualified Text.ParserCombinators.ReadP as RP

import Debug.Trace

visualizeTrees :: PGF -> (Bool,Bool) -> [Expr] -> String
visualizeTrees pgf funscats = unlines . map (prGraph False . tree2graph pgf funscats . expr2tree)

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

dependencyTree :: Maybe String -> PGF -> CId -> Expr -> String
dependencyTree ms pgf lang = prGraph True . lin2dep pgf . linMark where
  linMark = head . linearizesMark pgf lang
  ---- use Just str if you have str to match against

lin2dep pgf s = trace s $ trace (show sortedNodeWords) $ prelude ++ nodes ++ links where

  prelude = ["rankdir=LR ;", "node [shape = plaintext] ;"]

  nodes = map mkNode nodeWords
  mkNode (i,(p,ss)) = 
    show (show i) ++ " [label = \"" ++ show i ++ ". " ++ show p ++ unwords ss ++ "\"] ;"

  links = map mkLink [(x,dominant x) | x <- init sortedNodeWords]
  dominant x = head [y | y <- sortedNodeWords, y /=x, dominates (pos y) (pos x)]
  dominates y x = y /= x && isPrefixOf y x
  sortedNodeWords = reverse $ sortBy (\x y -> compare (length (pos x)) (length (pos y))) $ 
                              sortBy (\x y -> compare (pos x) (pos y)) nodeWords
  pos = fst . snd

  linkss = map mkLink [(x,y) | x <- nodeWords, y <- nodeWords, x /= y, depends x y]
  mkLink (x,y) = show (fst x) ++ " -> " ++ show (fst y) ;
  depends (_,(p,_)) (_,(q,_)) = sister p q || daughter p q
  daughter p q = not (null p) && init p == q && (null q || last q == 0)
  sister p q = False -- not (null p) && not (null q) && init p == init q && last q == 0

  nodeWords = (0,([],["ROOT"])) : zip [1..] [(p++[0],f)| (p,f) <- wlins (readPosText s)]


-- parse trees from Linearize.linearizeMark
---- nubrec and domins are quadratic, but could be (n log n)

parseTree :: Maybe String -> PGF -> CId -> Expr -> String
parseTree ms pgf lang = prGraph False . lin2tree pgf . linMark where
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
                zip [9990..] [(p,s) | (p,ss) <- wlins pt, s <- ss]]

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

alignLinearize :: PGF -> Expr -> String
alignLinearize pgf = prGraph True . lin2graph . linsMark  where
  linsMark t = [s | la <- cncnames pgf, s <- take 1 (linearizesMark pgf la t)]

lin2graph :: [String] -> [String]
lin2graph ss = trace (show ss) $ prelude ++ nodes ++ links

 where

  prelude = ["rankdir=LR ;", "node [shape = record] ;"]

  nlins :: [(Int,[((Int,String),String)])]
  nlins = [(i, [((j,showp p),unw ws) | (j,(p,ws)) <- zip [0..] ws]) | 
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

wlins :: PosText -> [([Int],[String])]
wlins pt = case pt of
  T (_,p) pts -> concatMap (lins p) pts
  M ws -> if null ws then [] else [([],ws)]
 where
  lins p pt = case pt of
    T (_,q) pts -> concatMap (lins q) pts
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

