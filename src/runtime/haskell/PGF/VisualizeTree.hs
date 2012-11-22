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

module PGF.VisualizeTree 
             ( GraphvizOptions(..)
             , graphvizDefaults
             , graphvizAbstractTree
             , graphvizParseTree
             , graphvizParseTreeOld
             , graphvizDependencyTree
             , graphvizBracketedString
             , graphvizAlignment
             , gizaAlignment
             , getDepLabels
             ) where

import PGF.CId (CId,showCId,ppCId,pCId,mkCId)
import PGF.Data
import PGF.Expr (showExpr, Tree)
import PGF.Linearize
import PGF.Macros (lookValCat, lookMap,
                   BracketedString(..), BracketedTokn(..), flattenBracketedString)

import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Data.List (intersperse,nub,isPrefixOf,sort,sortBy)
import Data.Char (isDigit)
import Data.Maybe (fromMaybe)
import Text.PrettyPrint

import Data.Array.IArray
import Control.Monad
import qualified Data.Set as Set
import qualified Text.ParserCombinators.ReadP as RP


data GraphvizOptions = GraphvizOptions {noLeaves :: Bool,
                                        noFun :: Bool,
                                        noCat :: Bool,
                                        nodeFont :: String,
                                        leafFont :: String,
                                        nodeColor :: String,
                                        leafColor :: String,
                                        nodeEdgeStyle :: String,
                                        leafEdgeStyle :: String
                                       }

graphvizDefaults = GraphvizOptions False False False "" "" "" "" "" ""


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

{- This is an attempt to build the dependency tree from the bracketed string.
   Unfortunately it doesn't quite work. See the actual implementation at
   the end of this module.

graphvizDependencyTree :: String -> Bool -> Maybe Labels -> Maybe String -> PGF -> CId -> Tree -> String
graphvizDependencyTree format debug mlab ms pgf lang t = render $
  case format of
    "malt"       -> vcat (map (hcat . intersperse (char '\t')         ) wnodes)
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
    links  = map mkLink [(fid, fromMaybe nil (lookup fid deps)) | (fid,_,w) <- tail leaves]
    wnodes = undefined

    nil = -1

    bs = bracketedLinearize pgf lang t

    leaves = (nil,0,"ROOT") : (groupAndIndexIt 1 . getLeaves nil) bs
    deps   = getDeps nil [bs]

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
        Bracket _ fid _ _ bss -> concatMap (getLeaves fid) bss

    getDeps out_head bss =
      case selectHead (children bss) of
        Just ((head, bss'), deps) -> concat (descend out_head head bss' : [descend (headOf head bss') fid bss | (fid,bss) <- IntMap.toList deps])
        Nothing                   -> []
      where
        descend head fid bss = (fid,head) : getDeps head bss
        
    headOf head bss
      | null [() | Leaf _ <- bss] =
          case selectHead (children bss) of
            Just ((head, bss), deps) -> headOf head bss
            Nothing                  -> head
      | otherwise = head

    children bss = IntMap.fromListWith (++) [(fid,bss) | Bracket _ fid _ _ bss <- bss]  

    selectHead children = IntMap.maxViewWithKey children

    mkNode (p,i,w) = 
      tag p <+> brackets (text "label = " <> doubleQuotes (int i <> char '.' <+> text w)) <+> semi

    mkLink (x,y) = tag y <+> text "->" <+> tag x -- ++ " [label = \"" ++ l ++ "\"] ;"
-}

getDepLabels :: [String] -> Labels
getDepLabels ss = Map.fromList [(mkCId f,ls) | f:ls <- map words ss]


graphvizParseTree :: PGF -> Language -> GraphvizOptions -> Tree -> String
graphvizParseTree pgf lang opts = graphvizBracketedString opts . bracketedLinearize pgf lang


graphvizBracketedString :: GraphvizOptions -> BracketedString -> String
graphvizBracketedString opts bs = render graphviz_code
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
                        internals <- getInternals [(nil, bs)], 
                        not (null internals)]
      leaf_nodes = mkLevel [(parent, id, word) | 
                            (id, (parent, word)) <- zip [100000..] (getLeaves nil bs)]

      getInternals []    = []
      getInternals nodes 
          = nub [(parent, fid, mkNode fun cat) | 
                 (parent, Bracket cat fid _ fun _ _) <- nodes] 
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
            vcat [tag pid <> text " -- " <> tag id <> semi | (pid, id, _) <- nodes, pid /= nil] $$
            space



graphvizParseTreeOld :: PGF -> Language -> Tree -> String
graphvizParseTreeOld pgf lang = graphvizBracketedStringOld . bracketedLinearize pgf lang


graphvizBracketedStringOld :: BracketedString -> String
graphvizBracketedStringOld = render . lin2tree
  where
    lin2tree bs =
      text "graph {" $$
      space $$
      nest 2 (text "rankdir=BU ;" $$
              text "node [shape = record, color = white] ;" $$
              space $$
              vcat (nodes bs)) $$
      text "}"
      where
        nodes bs = zipWith mkStruct [0..] (interns ++ [zipWith (\i (l,p,w) -> (l,p,i,w)) [99990..] leaves])

        nil = -1
        
        leaves  = getLeaves  0 nil bs
        interns = getInterns 0 [(nil,bs)]

        getLeaves  level parent bs =
          case bs of
            Leaf w                -> [(level-1,parent,w)]
            Bracket _ fid i _ _ bss -> concatMap (getLeaves (level+1) fid) bss

        getInterns level []    = []
        getInterns level nodes =
          nub [(level-1,parent,fid,showCId cat) | (parent,Bracket cat fid _ _ _ _) <- nodes] :
          getInterns (level+1) [(fid,child) | (_,Bracket _ fid _ _ _ children) <- nodes, child <- children]

        mkStruct l cs = struct l <> text "[label = \"" <> fields cs <> text "\"] ;" $$
                        vcat [link pl pid l id | (pl,pid,id,_) <- cs]
        link pl pid l id
          | pl < 0    = empty
          | otherwise = struct pl <> colon <> tag pid <> colon <> char 's' <+>
                        text "--" <+>
                        struct l  <> colon <> tag  id <> colon <> char 'n' <+> semi
        fields cs = hsep (intersperse (char '|') [tbrackets (tag id) <> text c | (_,_,id,c) <- cs])


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

      lin2align :: [BracketedString] -> PreAlign
      lin2align bss =  PreAlign langSeqs langRels
          where
           (langSeqs,langRels) = mkLayers leaves
           nil = -1
           leaves = map (groupAndIndexIt 0 . getLeaves nil) bss

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
 
     fields cs = hsep (intersperse (char '|') [tbrackets (tag id) <> text w | (id,ws) <- cs, w <- ws])

  

-- auxiliaries for graphviz syntax
struct l = text ("struct" ++ show l)
tbrackets d = char '<' <> d  <> char '>'
tag i
  | i < 0     = char 'r' <> int (negate i)
  | otherwise = char 'n' <> int i



--------------------------------------------------------------------
-- The linearization code bellow is needed just in order to 
-- produce the dependency tree. Unfortunately the bracketed string
-- doesn't give us an easy way to find which part of the string
-- corresponds to which argument of the parent function.
--
-- Uuuuugly!!! I hope that this code will be removed one day.

type LinTable = Array LIndex [BracketedTokn]


linTree :: PGF -> Language -> (Maybe CId -> [Int] -> LinTable -> LinTable) -> Expr -> [LinTable]
linTree pgf lang mark e = lin0 [] [] [] Nothing e
  where
    cnc   = lookMap (error "no lang") lang (concretes pgf)
    lp    = lproductions cnc

    lin0 path xs ys mb_fid (EAbs _ x e)  = lin0 path (showCId x:xs) ys mb_fid e
    lin0 path xs ys mb_fid (ETyped e _)  = lin0 path xs ys mb_fid e
    lin0 path xs ys mb_fid e             = lin path ys mb_fid e []

    lin path xs mb_fid (EApp e1 e2) es = lin path xs mb_fid e1 (e2:es)
    lin path xs mb_fid (ELit l)     [] = case l of
                                           LStr s -> return (mark Nothing path (ss s))
                                           LInt n -> return (mark Nothing path (ss (show n)))
                                           LFlt f -> return (mark Nothing path (ss (show f)))
    lin path xs mb_fid (EFun f)     es = map (mark (Just f) path) (apply path xs mb_fid f  es)
    lin path xs mb_fid (ETyped e _) es = lin path xs mb_fid e es
    lin path xs mb_fid (EImplArg e) es = lin path xs mb_fid e es

    ss s = listArray (0,0) [[LeafKS [s]]]

    apply path xs mb_fid f es =
      case Map.lookup f lp of
        Just prods -> case lookupProds mb_fid prods of
                        Just set -> do prod <- Set.toList set
                                       case prod of
                                         PApply funid fids -> do guard (length fids == length es)
                                                                 args <- sequence (zipWith3 (\i (PArg _ fid) e -> lin0 (sub i path) [] xs (Just fid) e) [0..] fids es)
                                                                 let (CncFun _ lins) = cncfuns cnc ! funid
                                                                 return (listArray (bounds lins) [computeSeq seqid args | seqid <- elems lins])
                                         PCoerce fid       -> apply path xs (Just fid) f es
                        Nothing  -> mzero
      where
        lookupProds (Just fid) prods = IntMap.lookup fid prods
        lookupProds Nothing    prods = Just (Set.filter isApp (Set.unions (IntMap.elems prods)))

        sub i path = i:path

        isApp (PApply _ _) = True
        isApp _            = False

        computeSeq seqid args = concatMap compute (elems seq)
          where
            seq = sequences cnc ! seqid

            compute (SymCat d r)    = (args !! d) ! r
            compute (SymLit d r)    = (args !! d) ! r
            compute (SymKS ts)      = [LeafKS ts]
            compute (SymKP ts alts) = [LeafKP ts alts]

untokn :: [BracketedTokn] -> [String]
untokn ts = case ts of
  LeafKP d _  : [] -> d
  LeafKP d vs : ws -> let ss@(s:_) = untokn ws in sel d vs s ++ ss
  LeafKS s    : ws -> s ++ untokn ws
  []               -> []
 where
   sel d vs w = case [v | Alt v cs <- vs, any (\c -> isPrefixOf c w) cs] of
     v:_ -> v
     _   -> d


-- show bracketed markup with references to tree structure
markLinearizes :: PGF -> CId -> Expr -> [String]
markLinearizes pgf lang = map (unwords . untokn . (! 0)) . linTree pgf lang mark
  where
    mark mb_f path lint = amap (bracket mb_f path) lint

    bracket Nothing  path ts = [LeafKS ["("++show (reverse path)]] ++ ts ++ [LeafKS [")"]]
    bracket (Just f) path ts = [LeafKS ["(("++showCId f++","++show (reverse path)++")"]] ++ ts ++ [LeafKS [")"]]


graphvizDependencyTree :: String -> Bool -> Maybe Labels -> Maybe String -> PGF -> CId -> Expr -> String
graphvizDependencyTree format debug mlab ms pgf lang tr = case format of
  "malt" -> unlines (lin2dep format)
  "malt_input" -> unlines (lin2dep format)
  _ ->  concat $ map (++"\n") $ ["digraph {\n"] ++ lin2dep format ++ ["}"]
 where
 
  lin2dep format = -- trace (ifd (show sortedNodes ++ show nodeWords)) $ 
    case format of
      "malt" -> map (concat . intersperse "\t") wnodes
      "malt_input" -> map (concat . intersperse "\t" . take 6) wnodes
      _ -> prelude ++ nodes ++ links

  ifd s = if debug then s else []

  pot = readPosText $ concat $ take 1 $ markLinearizes pgf lang tr
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

  headArg x0 tr x = case (unApp tr,x) of
    (Just (f,[]),[_]) -> x0 ---- ??
    (Just (f,ts),[_]) -> x0 ++ [getHead (length ts - 1) f]
    (Just (f,ts),i:y) -> headArg x0 (ts !! i) y
    _ -> x0 ----

  label tr y x = case span (uncurry (==)) (zip y x) of
    (xys,(_,i):_) -> getLabel i (funAt tr (map fst xys))
    _ -> "" ----

  funAt tr x = case (unApp tr,x) of
    (Just (f,_) ,[])  -> f
    (Just (f,ts),i:y) -> funAt (ts !! i) y
    _ -> mkCId (render (ppExpr 0 [] tr)) ----

  word x = if elem x sortedNodes then x else 
           let x' = headArg x tr (x ++[0]) in
           if x' == x then [] else word x'

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
              let pos = showCId $ lookValCat (abstract pgf) fun,
              let morph = unspec,
              let (dom,lab) = lookDomLab p
           ]
  maltws = concat . intersperse "+" . words . unwords  -- no spaces in column 2
  unspec = "_"
  rootlabel = "ROOT"

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
