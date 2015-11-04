----------------------------------------------------------------------
-- |
-- Module      : VisualizeTree
-- Maintainer  : KA
-- Stability   : (stable)
-- Portability : (portable)
--
-- Print a graph of an abstract syntax tree in Graphviz DOT format
-- Based on BB's VisualizeGrammar
-----------------------------------------------------------------------------

module PGF.VisualizeTree
             ( GraphvizOptions(..)
             , graphvizDefaults
             , graphvizAbstractTree
             , graphvizParseTree
             , graphvizDependencyTree
             , graphvizBracketedString
             , graphvizAlignment
             , gizaAlignment
             , getDepLabels
             ) where

import PGF.CId (wildCId,showCId,ppCId,mkCId) --CId,pCId,
import PGF.Data
import PGF.Expr (Tree) -- showExpr
import PGF.Linearize
import PGF.Macros (lookValCat, BracketedString(..))
                   --lookMap, BracketedTokn(..), flattenBracketedString

import qualified Data.Map as Map
--import qualified Data.IntMap as IntMap
import Data.List (intersperse,nub,mapAccumL,find)
--import Data.Char (isDigit)
import Data.Maybe (fromMaybe)
import Text.PrettyPrint

--import Data.Array.IArray
--import Control.Monad
--import qualified Data.Set as Set
--import qualified Text.ParserCombinators.ReadP as RP


data GraphvizOptions = GraphvizOptions {noLeaves :: Bool,
                                        noFun :: Bool,
                                        noCat :: Bool,
                                        noDep :: Bool,
                                        nodeFont :: String,
                                        leafFont :: String,
                                        nodeColor :: String,
                                        leafColor :: String,
                                        nodeEdgeStyle :: String,
                                        leafEdgeStyle :: String
                                       }

graphvizDefaults = GraphvizOptions False False False True "" "" "" "" "" ""


-- | Renders abstract syntax tree in Graphviz format
graphvizAbstractTree :: PGF -> (Bool,Bool) -> Tree -> String
graphvizAbstractTree pgf (funs,cats) = render . tree2graph
  where
    tree2graph t =
      text "graph {" $$
      ppGraph [] [] 0 t $$
      text "}"

    getAbs xs (EAbs _ x e) = getAbs (x:xs) e
    getAbs xs (ETyped e _) = getAbs xs e
    getAbs xs e            = (xs,e)

    getApp (EApp x (EImplArg y)) es = getApp x es
    getApp (EApp x y)            es = getApp x (y:es)
    getApp (ETyped e _)          es = getApp e es
    getApp e                     es = (e,es)

    getLbl scope (EFun f)     = let fun = if funs then ppCId f else empty
                                    cat = if cats then ppCId (lookValCat (abstract pgf) f) else empty
                                    sep = if funs && cats then colon else empty
                                in fun <+> sep <+> cat
    getLbl scope (ELit l)     = text (escapeStr (render (ppLit l)))
    getLbl scope (EMeta i)    = ppMeta i
    getLbl scope (EVar i)     = ppCId (scope !! i)
    getLbl scope (ETyped e _) = getLbl scope e
    getLbl scope (EImplArg e) = getLbl scope e

    ppGraph scope ps i e0 =
      let (xs,  e1) = getAbs [] e0
          (e2,args) = getApp e1 []
          binds     = if null xs
                        then empty
                        else text "\\\\" <> hcat (punctuate comma (map ppCId xs)) <+> text "->"
          (lbl,eargs) = case e2 of
                          EAbs _ _ _ -> (char '@', e2:args) -- eta-redexes are rendered with artificial "@" node
                          _          -> (getLbl scope' e2, args)
          scope'    = xs ++ scope
      in ppNode (i:ps) <> text "[label =" <+> doubleQuotes (binds <+> lbl) <> text ", style = \"solid\", shape = \"plaintext\"] ;" $$
         (if null ps
            then empty
            else ppNode ps <+> text "--" <+> ppNode (i:ps) <+> text "[style = \"solid\"];") $$
         vcat (zipWith (ppGraph scope' (i:ps)) [0..] eargs)

    ppNode ps = char 'n' <> hcat (punctuate (char '_') (map int ps))

    escapeStr []        = []
    escapeStr ('\\':cs) = '\\':'\\':escapeStr cs
    escapeStr ('"' :cs) = '\\':'"' :escapeStr cs
    escapeStr (c   :cs) = c        :escapeStr cs


type Labels = Map.Map CId [String]

graphvizDependencyTree :: String -> Bool -> Maybe Labels -> Maybe String -> PGF -> CId -> Tree -> String
graphvizDependencyTree format debug mlab ms pgf lang t = render $
  case format of
    "conll"      -> vcat (map (hcat . intersperse (char '\t')         ) wnodes)
    "malt_tab"   -> vcat (map (hcat . intersperse (char '\t') . (\ws -> [ws !! 0,ws !! 1,ws !! 3,ws !! 6,ws !! 7])) wnodes)
    "malt_input" -> vcat (map (hcat . intersperse (char '\t') . take 6) wnodes)
    _            -> text "digraph {" $$
                    space $$
                    nest 2 (text "rankdir=LR ;" $$
                            text "node [shape = plaintext] ;" $$
                            vcat nodes $$
                            vcat links) $$
                    text "}"
  where
    nodes  = map mkNode leaves
    links  = map mkLink [(fid, fromMaybe (dep_lbl,nil) (lookup fid deps)) | ((cat,fid,fun),_,w) <- tail leaves]

    wnodes = [[int i, maltws ws, ppCId fun, ppCId cat, ppCId cat, unspec, int parent, text lab, unspec, unspec] |
              ((cat,fid,fun),i,ws) <- tail leaves,
              let (lab,parent) = fromMaybe (dep_lbl,0)
                                           (do (lbl,fid) <- lookup fid deps
                                               (_,i,_) <- find (\((_,fid1,_),i,_) -> fid == fid1) leaves
                                               return (lbl,i))
             ]
    maltws = text . concat . intersperse "+" . words  -- no spaces in column 2

    nil = -1

    bss = bracketedLinearize pgf lang t

    root = (wildCId,nil,wildCId)

    leaves = (root,0,root_lbl) : (groupAndIndexIt 1 . concatMap (getLeaves root)) bss
    deps   = let (_,(h,deps)) = getDeps 0 [] t []
             in (h,(dep_lbl,nil)):deps

    groupAndIndexIt id []          = []
    groupAndIndexIt id ((p,w):pws) = let (ws,pws1) = collect pws
                                     in (p,id,unwords (w:ws)) : groupAndIndexIt (id+1) pws1
      where
        collect pws@((p1,w):pws1)
          | p == p1   = let (ws,pws2) = collect pws1
                        in (w:ws,pws2)
        collect pws   = ([],pws)

    getLeaves parent bs =
      case bs of
        Leaf w                      -> [(parent,w)]
        Bracket cat fid _ fun _ bss -> concatMap (getLeaves (cat,fid,fun)) bss

    mkNode ((_,p,_),i,w) =
      tag p <+> brackets (text "label = " <> doubleQuotes (int i <> char '.' <+> text w)) <+> semi

    mkLink (x,(lbl,y)) = tag y <+> text "->" <+> tag x  <+> text "[label = " <> doubleQuotes (text lbl) <> text "] ;"

    labels = maybe Map.empty id mlab

    getDeps n_fid xs (EAbs _ x e) es = getDeps n_fid (x:xs) e      es
    getDeps n_fid xs (EApp e1 e2) es = getDeps n_fid xs     e1 (e2:es)
    getDeps n_fid xs (EImplArg e) es = getDeps n_fid xs     e      es
    getDeps n_fid xs (ETyped e _) es = getDeps n_fid xs     e      es
    getDeps n_fid xs (EFun f)     es = let (n_fid_1,ds) = descend n_fid xs es
                                           (mb_h, deps) = selectHead f ds
                                       in case mb_h of
                                            Just (fid,deps0) -> (n_fid_1+1,(fid,deps0++
                                                                                [(n_fid_1,(dep_lbl,fid))]++
                                                                                concat [(m,(lbl,fid)):ds | (lbl,(m,ds)) <- deps]))
                                            Nothing          -> (n_fid_1+1,(n_fid_1,concat [(m,(lbl,n_fid_1)):ds | (lbl,(m,ds)) <- deps]))
    getDeps n_fid xs (EMeta i)    es = (n_fid+2,(n_fid,[]))
    getDeps n_fid xs (EVar  i)    _  = (n_fid+2,(n_fid,[]))
    getDeps n_fid xs (ELit l)     [] = (n_fid+1,(n_fid,[]))

    descend n_fid xs es = mapAccumL (\n_fid e -> getDeps n_fid xs e []) n_fid es

    selectHead f ds =
      case Map.lookup f labels of
        Just lbls -> extractHead (zip lbls ds)
        Nothing   -> extractLast ds
      where
        extractHead []    = (Nothing, [])
        extractHead (ld@(l,d):lds)
          | l == head_lbl = (Just d,lds)
          | otherwise     = let (mb_h,deps) = extractHead lds
                            in (mb_h,ld:deps)

        extractLast []    = (Nothing, [])
        extractLast (d:ds)
          | null ds       = (Just d,[])
          | otherwise     = let (mb_h,deps) = extractLast ds
                            in (mb_h,(dep_lbl,d):deps)

    dep_lbl  = "dep"
    head_lbl = "head"
    root_lbl = "ROOT"
    unspec   = text "_"

getDepLabels :: [String] -> Labels
getDepLabels ss = Map.fromList [(mkCId f,ls) | f:ls <- map words ss]

-- the old function, without dependencies
graphvizParseTree :: PGF -> Language -> GraphvizOptions -> Tree -> String
graphvizParseTree = graphvizParseTreeDep Nothing

graphvizParseTreeDep :: Maybe Labels -> PGF -> Language -> GraphvizOptions -> Tree -> String
graphvizParseTreeDep mbl pgf lang opts tree = graphvizBracketedString opts mbl tree $ bracketedLinearize pgf lang tree

graphvizBracketedString :: GraphvizOptions -> Maybe Labels -> Tree -> [BracketedString] -> String
graphvizBracketedString opts mbl tree bss = render graphviz_code
    where
      graphviz_code
          = text "graph {" $$
            text node_style $$
            vcat internal_nodes $$
            (if noLeaves opts then empty
             else text leaf_style $$
                  leaf_nodes
            ) $$ text "}"

      leaf_style = mkOption "edge" "style" (leafEdgeStyle opts) ++
                   mkOption "edge" "color" (leafColor opts) ++
                   mkOption "node" "fontcolor" (leafColor opts) ++
                   mkOption "node" "fontname" (leafFont opts) ++
                   mkOption "node" "shape" "plaintext"

      node_style = mkOption "edge" "style" (nodeEdgeStyle opts) ++
                   mkOption "edge" "color" (nodeColor opts) ++
                   mkOption "node" "fontcolor" (nodeColor opts) ++
                   mkOption "node" "fontname" (nodeFont opts) ++
                   mkOption "node" "shape" nodeshape
          where nodeshape | noFun opts && noCat opts = "point"
                          | otherwise = "plaintext"

      mkOption object optname optvalue
          | null optvalue  = ""
          | otherwise      = object ++ "[" ++ optname ++ "=\"" ++ optvalue ++ "\"]; "

      mkNode fun cat
          | noFun opts = showCId cat
          | noCat opts = showCId fun
          | otherwise  = showCId fun ++ " : " ++ showCId cat

      nil = -1
      internal_nodes = [mkLevel internals |
                        internals <- getInternals (map ((,) nil) bss),
                        not (null internals)]
      leaf_nodes = mkLevel [(parent, id, word) |
                            (id, (parent, word)) <- zip [100000..] (concatMap (getLeaves nil) bss)]

      getInternals []    = []
      getInternals nodes
          = nub [(parent, fid, mkNode fun cat) |
                 (parent, Bracket cat fid lind fun _ _) <- nodes]
            : getInternals [(fid, child) |
                            (_, Bracket _ fid _ _ _ children) <- nodes,
                            child <- children]

      getLeaves parent (Leaf word) = [(parent, word)]
      getLeaves parent (Bracket _ fid i _ _ children)
          = concatMap (getLeaves fid) children

      mkLevel nodes
          = text "subgraph {rank=same;" $$
            nest 2 (-- the following gives the name of the node and its label:
                    vcat [tag id <> text (mkOption "" "label" lbl) | (_, id, lbl) <- nodes] $$
                    -- the following is for fixing the order between the children:
                    (if length nodes > 1 then
                         text (mkOption "edge" "style" "invis") $$
                         hsep (intersperse (text " -- ") [tag id | (_, id, _) <- nodes]) <+> semi
                     else empty)
                   ) $$
            text "}" $$
            -- the following is for the edges between parent and children:
            vcat [tag pid <> text " -- " <> tag id <> text (depLabel node) | node@(pid, id, _) <- nodes, pid /= nil] $$
            space

      depLabel node@(parent,id,lbl) 
        | noDep opts = ";"
        | otherwise = case getArg id of
            Just (fun,arg) -> (mkOption "" "label" (showCId fun ++ "#" ++ show arg))
            _ -> ";"
      getArg i = getArgumentPlace i (expr2numtree tree) Nothing

---- to restore the argument place from bracketed linearization
data NumTree = NumTree Int CId [NumTree]

getArgumentPlace :: Int -> NumTree -> Maybe (CId,Int) -> Maybe (CId,Int)
getArgumentPlace i tree@(NumTree int fun ts) mfi
 | i == int  = mfi
 | otherwise = case [fj | (t,x) <- zip ts [0..], Just fj <- [getArgumentPlace i t (Just (fun,x))]] of
     fj:_ -> Just fj
     _ -> Nothing

expr2numtree :: Expr -> NumTree
expr2numtree = fst . renumber 0 . flatten where
  flatten e = case e of
    EApp f a -> case flatten f of
      NumTree _ g ts -> NumTree 0 g (ts ++ [flatten a])
    EFun f -> NumTree 0 f []
  renumber i t@(NumTree _ f ts) = case renumbers i ts of
    (ts',j) -> (NumTree j f ts', j+1)
  renumbers i ts = case ts of
    t:tt -> case renumber i t of
      (t',j) -> case renumbers j tt of (tt',k) -> (t':tt',k)
    _ -> ([],i)
----- end this terrible stuff
 



type Rel = (Int,[Int])
-- possibly needs changes after clearing about many-to-many on this level

type IndexedSeq = (Int,[String])
type LangSeq = [IndexedSeq]

data PreAlign = PreAlign [LangSeq] [[Rel]]
  deriving Show
-- alignment structure for a phrase in 2 languages, along with the
-- many-to-many relations


genPreAlignment :: PGF -> [Language] -> Expr -> PreAlign
genPreAlignment pgf langs = lin2align . linsBracketed
 where
      linsBracketed t = [bracketedLinearize pgf lang t | lang <- langs]

      lin2align :: [[BracketedString]] -> PreAlign
      lin2align bsss =  PreAlign langSeqs langRels
          where
           (langSeqs,langRels) = mkLayers leaves
           nil = -1
           leaves = map (groupAndIndexIt 0 . concatMap (getLeaves nil)) bsss

           groupAndIndexIt id []          = []
           groupAndIndexIt id ((p,w):pws) = let (ws,pws1) = collect pws
                                             in (p,id,unwords (w:ws)) : groupAndIndexIt (id+1) pws1
            where
              collect pws@((p1,w):pws1)
                | p == p1   = let (ws,pws2) = collect pws1
                                in (w:ws,pws2)
              collect pws   = ([],pws)

           getLeaves parent bs =
                  case bs of
                    Leaf w                -> [(parent,w)]
                    Bracket _ fid _ _ _ bss -> concatMap (getLeaves fid) bss

           mkLayers (cs:css:rest) = let (lrest, rrest) =  mkLayers (css:rest)
                                     in ((fields cs) : lrest, (map (mkLinks css) cs) : rrest)
           mkLayers [cs] = ([fields cs], [])
           mkLayers _ = ([],[])

           mkLinks cs (p0,id0,_) = (id0,indices)
                    where
                     indices = [id1 | (p1,id1,_) <- cs, p1 == p0]

           fields cs = [(id, [w]) | (_,id,w) <- cs]


-- we assume we have 2 languages - source and target
gizaAlignment :: PGF -> (Language,Language) -> Expr -> (String,String,String)
gizaAlignment pgf (l1,l2) e = let PreAlign [rl1,rl2] rels = genPreAlignment pgf [l1,l2] e
                                   in
                                     (unwords (map showIndSeq rl1), unwords (concat $ map snd rl2),
                                        unwords $ words $ showRels rl2 (concat rels))


showIndSeq (_,l) = let ww = map words l
                       w_ = map (intersperse "_")  ww
                      in
                       concat $ concat w_

showRels inds2 [] = []
showRels inds2 ((ind,is):rest) =
                       let lOffs = computeOffset inds2 0
                           ltemp = [(i,getOffsetIndex i lOffs) | i <- is]
                           lcurr = concat $ map (\(offset,ncomp) -> [show ind ++ "-" ++ show (-1 + offset + ii)  ++ " "| ii <- [1..ncomp]]) (map snd ltemp)
                           lrest = showRels inds2 rest
                            in
                             (unwords lcurr) ++ lrest







getOffsetIndex i lst = let ll = filter (\(x,_) -> x == i) lst
                           in
                           snd $ head ll

computeOffset [] transp = []
computeOffset ((i,l):rest) transp = let nw = (length $ words $ concat l)
                                     in (i,(transp,nw)) : (computeOffset rest (transp + nw))



-- alignment in the Graphviz format from the intermediate structure
-- same effect as the old direct function
graphvizAlignment :: PGF -> [Language] -> Expr -> String
graphvizAlignment pgf langs exp =
    render (text "digraph {" $$
      space $$
      nest 2 (text "rankdir=LR ;" $$
              text "node [shape = record] ;" $$
              space $$
              renderList 0 lrels rrels) $$
      text "}")
  where
     (PreAlign lrels rrels) = genPreAlignment pgf langs exp


     renderList ii (l:ls) (r:rs) = struct ii <> text "[label = \"" <> fields l <> text "\"] ;" $$
                                 (case ls of
                                       [] -> empty
                                       _  -> vcat [struct ii  <> colon <> tag id0
                                               <> colon <> char 'e' <+> text "->" <+> struct (ii+1)
                                               <> colon <> tag id1 <> colon <> char 'w' <+> semi
                                                   | (id0,ids) <- r, id1 <- ids] $$ renderList (ii + 1) ls rs)
     renderList ii [] _ = empty
     renderList ii [l] [] = struct ii <> text "[label = \"" <> fields l <> text "\"] ;"

     fields cs = hsep (intersperse (char '|') [tbrackets (tag id) <> text (' ':w) | (id,ws) <- cs, w <- ws])



-- auxiliaries for graphviz syntax
struct l = text ("struct" ++ show l)
tbrackets d = char '<' <> d  <> char '>'
tag i
  | i < 0     = char 'r' <> int (negate i)
  | otherwise = char 'n' <> int i
