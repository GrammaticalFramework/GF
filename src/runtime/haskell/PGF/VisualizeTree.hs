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
             , graphvizParseTreeDep
             , graphvizDependencyTree
             , Labels, getDepLabels
             , graphvizBracketedString
             , graphvizAlignment
             , gizaAlignment
             , conlls2latexDoc
             ) where

import PGF.CId (wildCId,showCId,ppCId,mkCId) --CId,pCId,
import PGF.Data
import PGF.Expr (Tree) -- showExpr
import PGF.Linearize
----import PGF.LatexVisualize (conll2latex) ---- should be separate module?
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


-- | Renders abstract syntax tree in Graphviz format.
-- The pair of 'Bool' @(funs,cats)@ lets you control whether function names and
-- category names are included in the rendered tree.
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

-- | Visualize word dependency tree.
graphvizDependencyTree
  :: String -- ^ Output format: @"latex"@, @"conll"@, @"malt_tab"@, @"malt_input"@ or @"dot"@
  -> Bool -- ^ Include extra information (debug)
  -> Maybe Labels -- ^ Label information obtained with 'getDepLabels'
  -> unused -- ^ not used (was: @Maybe String@)
  -> PGF
  -> CId -- ^ The language of analysis
  -> Tree
  -> String -- ^ Rendered output in the specified format
graphvizDependencyTree format debug mlab ms pgf lang t = 
  case format of
    "latex"      -> render . ppLaTeX $ conll2latex' conll
    "svg"        -> render . ppSVG . toSVG $ conll2latex' conll
    "conll"      -> render $ vcat (map (hcat . intersperse (char '\t')         ) wnodes)
    "malt_tab"   -> render $ vcat (map (hcat . intersperse (char '\t') . (\ws -> [ws !! 0,ws !! 1,ws !! 3,ws !! 6,ws !! 7])) wnodes)
    "malt_input" -> render $ vcat (map (hcat . intersperse (char '\t') . take 6) wnodes)
    _            -> render $ text "digraph {" $$
                    space $$
                    nest 2 (text "rankdir=LR ;" $$
                            text "node [shape = plaintext] ;" $$
                            vcat nodes $$
                            vcat links) $$
                    text "}"
  where
    conll  = (map.map) render wnodes
    nodes  = map mkNode leaves
    links  = map mkLink [(fid, fromMaybe (dep_lbl,nil) (lookup fid deps)) | ((cat,fid,fun),_,w) <- tail leaves]

-- CoNLL format: ID FORM LEMMA PLEMMA POS PPOS FEAT PFEAT HEAD PHEAD DEPREL PDEPREL
-- P variants are automatically predicted rather than gold standard

    wnodes = [[int i, maltws ws, ppCId fun, ppCId (posCat cat), ppCId cat, unspec, int parent, text lab, unspec, unspec] |
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

    posCat cat = case Map.lookup cat labels of
        Just [p] -> mkCId p
        _ -> cat

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

-- | Prepare lines obtained from a configuration file for labels for
-- use with 'graphvizDependencyTree'. Format per line /fun/ /label/@*@.
getDepLabels :: String -> Labels
getDepLabels s = Map.fromList [(mkCId f,ls) | f:ls <- map words (lines s)]

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
      leaf_nodes = mkLevel [(parent, id, mkLeafNode cat word) |
                            (id, (parent, (cat,word))) <- zip [100000..] (concatMap (getLeaves (mkCId "?") nil) bss)]

      getInternals []    = []
      getInternals nodes
          = nub [(parent, fid, mkNode fun cat) |
                 (parent, Bracket cat fid _ fun _ _) <- nodes]
            : getInternals [(fid, child) |
                            (_, Bracket _ fid _ _ _ children) <- nodes,
                            child <- children]

      getLeaves cat parent (Leaf word) = [(parent, (cat, word))] -- the lowest cat before the word
      getLeaves _ parent (Bracket cat fid i _ _ children)
          = concatMap (getLeaves cat fid) children

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
            Just (fun,arg) -> mkOption "" "label" (lookLabel fun arg) 
            _ -> ";"
      getArg i = getArgumentPlace i (expr2numtree tree) Nothing

      labels = maybe Map.empty id mbl

      lookLabel fun arg = case Map.lookup fun labels of
        Just xx | length xx > arg -> case xx !! arg of
          "head" -> ""
          l -> l
        _ -> argLabel fun arg
      argLabel fun arg = if arg==0 then "" else "dep#" ++ show arg --showCId fun ++ "#" ++ show arg
                         -- assuming the arg is head, if no configuration is given; always true for 1-arg funs
      mkLeafNode cat word
       | noDep opts = word        --- || not (noCat opts) -- show POS only if intermediate nodes hidden
       | otherwise = posCat cat ++ "\n" ++ word         -- show POS in dependency tree

      posCat cat = case Map.lookup cat labels of
        Just [p] -> p
        _ -> showCId cat

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
----- end this terrible stuff AR 4/11/2015
 



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


---------------------- should be a separate module?

-- visualization with latex output. AR Nov 2015

conlls2latexDoc :: [String] -> String
conlls2latexDoc =
  render .
  latexDoc .
  vcat .
  intersperse (text "" $+$ app "vspace" (text "4mm")) .
  map conll2latex .
  filter (not . null)

conll2latex :: String -> Doc
conll2latex = ppLaTeX . conll2latex' . parseCoNLL

conll2latex' :: CoNLL -> [LaTeX]
conll2latex' = dep2latex . conll2dep'

data Dep = Dep {
    wordLength  :: Int -> Double        -- length of word at position int       -- was: fixed width, millimetres (>= 20.0)
  , tokens      :: [(String,String)]    -- word, pos (0..)
  , deps        :: [((Int,Int),String)] -- from, to, label
  , root        :: Int                  -- root word position
  }

-- some general measures
defaultWordLength = 20.0  -- the default fixed width word length, making word 100 units
defaultUnit       = 0.2   -- unit in latex pictures, 0.2 millimetres
spaceLength       = 10.0
charWidth = 1.8

wsize rwld  w  = 100 * rwld w + spaceLength                   -- word length, units
wpos rwld i    = sum [wsize rwld j | j <- [0..i-1]]           -- start position of the i'th word
wdist rwld x y = sum [wsize rwld i | i <- [min x y .. max x y - 1]]    -- distance between words x and y
labelheight h  = h + arcbase + 3    -- label just above arc; 25 would put it just below
labelstart c   = c - 15.0           -- label starts 15u left of arc centre
arcbase        = 30.0               -- arcs start and end 40u above the bottom
arcfactor r    = r * 600            -- reduction of arc size from word distance
xyratio        = 3                  -- width/height ratio of arcs

putArc :: (Int -> Double) -> Int -> Int -> Int -> String -> [DrawingCommand]
putArc frwld height x y label = [oval,arrowhead,labelling] where
  oval = Put (ctr,arcbase) (OvalTop (wdth,hght))
  arrowhead = Put (endp,arcbase + 5) (ArrowDown 5)   -- downgoing arrow 5u above the arc base
  labelling = Put (labelstart ctr,labelheight (hght/2)) (TinyText label)
  dxy  = wdist frwld x y             -- distance between words, >>= 20.0
  ndxy = 100 * rwld * fromIntegral height  -- distance that is indep of word length
  hdxy = dxy / 2                     -- half the distance
  wdth = dxy - (arcfactor rwld)/dxy  -- longer arcs are wider in proportion
  hght = ndxy / (xyratio * rwld)      -- arc height is independent of word length
  begp = min x y                     -- begin position of oval
  ctr  = wpos frwld begp + hdxy + (if x < y then 20 else  10)  -- LR arcs are farther right from center of oval
  endp = (if x < y then (+) else (-)) ctr (wdth/2)            -- the point of the arrow
  rwld = 0.5 ----

dep2latex :: Dep -> [LaTeX]
dep2latex d =
  [Comment (unwords (map fst (tokens d))),
   Picture defaultUnit (width,height) (
     [Put (wpos rwld i,0) (Text w) | (i,w) <- zip [0..] (map fst (tokens d))]   -- words
  ++ [Put (wpos rwld i,15) (TinyText w) | (i,w) <- zip [0..] (map snd (tokens d))]   -- pos tags 15u above bottom
  ++ concat [putArc rwld (aheight x y) x y label | ((x,y),label) <- deps d]    -- arcs and labels
  ++ [Put (wpos rwld (root d) + 15,height) (ArrowDown (height-arcbase))]
  ++ [Put (wpos rwld (root d) + 20,height - 10) (TinyText "ROOT")]
  )]
 where
   wld i  = wordLength d i  -- >= 20.0
   rwld i = (wld i) / defaultWordLength       -- >= 1.0
   aheight x y = depth (min x y) (max x y) + 1    ---- abs (x-y)
   arcs = [(min u v, max u v) | ((u,v),_) <- deps d]
   depth x y = case [(u,v) | (u,v) <- arcs, (x < u && v <= y) || (x == u && v < y)] of ---- only projective arcs counted
     [] -> 0
     uvs -> 1 + maximum (0:[depth u v | (u,v) <- uvs])
   width = {-round-} (sum [wsize rwld w | (w,_) <- zip [0..] (tokens d)]) + {-round-} spaceLength * fromIntegral ((length (tokens d)) - 1)
   height = 50 + 20 * {-round-} (maximum (0:[aheight x y | ((x,y),_) <- deps d]))

type CoNLL = [[String]]
parseCoNLL :: String -> CoNLL
parseCoNLL = map words . lines

--conll2dep :: String -> Dep
--conll2dep = conll2dep' . parseCoNLL

conll2dep' :: CoNLL -> Dep
conll2dep' ls = Dep {
    wordLength = wld 
  , tokens = toks
  , deps = dps
  , root = head $ [read x-1 | x:_:_:_:_:_:"0":_ <- ls] ++ [1]
  }
 where
   wld i = maximum (0:[charWidth * fromIntegral (length w) | w <- let (tok,pos) = toks !! i in [tok,pos]])
   toks = [(w,c) | _:w:_:c:_ <- ls]
   dps = [((read y-1, read x-1),lab) | x:_:_:_:_:_:y:lab:_ <- ls, y /="0"]
   --maxdist = maximum [abs (x-y) | ((x,y),_) <- dps]


-- * LaTeX Pictures (see https://en.wikibooks.org/wiki/LaTeX/Picture)

-- We render both LaTeX and SVG from this intermediate representation of
-- LaTeX pictures.

data LaTeX = Comment String | Picture UnitLengthMM Size [DrawingCommand]
data DrawingCommand = Put Position Object
data Object = Text String | TinyText String | OvalTop Size | ArrowDown Length

type UnitLengthMM = Double
type Size = (Double,Double)
type Position = (Double,Double)
type Length = Double


-- * latex formatting
ppLaTeX = vcat . map ppLaTeX1
  where
    ppLaTeX1 el =
      case el of
        Comment s -> comment s
        Picture unit size cmds ->
          app "setlength{\\unitlength}" (text (show unit ++ "mm"))
          $$ hang (app "begin" (text "picture")<>text (show size)) 2
                  (vcat (map ppDrawingCommand cmds))
          $$ app "end" (text "picture")
          $$ text ""

    ppDrawingCommand (Put pos obj) = put pos (ppObject obj)

    ppObject obj =
      case obj of
        Text s -> text s
        TinyText s -> small (text s)
        OvalTop size -> text "\\oval" <> text (show size) <> text "[t]"
        ArrowDown len -> app "vector(0,-1)" (text (show len))

    put p@(_,_) = app ("put" ++ show p)
    small w = text "{\\tiny" <+> w <> text "}"
    comment s = text "%%" <+> text s -- line break show follow
    
app macro arg = text "\\" <> text macro <> text "{" <> arg <> text "}"


latexDoc :: Doc -> Doc
latexDoc body =
  vcat [text "\\documentclass{article}",
        text "\\usepackage[utf8]{inputenc}",
        text "\\begin{document}",
        body,
        text "\\end{document}"]

-- * SVG (see https://www.w3.org/Graphics/SVG/IG/resources/svgprimer.html)

-- | Render LaTeX pictures as SVG
toSVG = concatMap toSVG1
  where
    toSVG1 el =
      case el of
        Comment s -> []
        Picture unit size@(w,h) cmds ->
          [Elem "svg" ["width".=x1,"height".=y0+5,
                       ("viewBox",unwords (map show [0,0,x1,y0+5])),
                       ("version","1.1"),
                       ("xmlns","http://www.w3.org/2000/svg")]
                       (white_bg:concatMap draw cmds)]
          where
            white_bg =
              Elem "rect" ["x".=0,"y".=0,"width".=x1,"height".=y0+5,
                           ("fill","white")] []

            draw (Put pos obj) = objectSVG pos obj

            objectSVG pos obj =
              case obj of
                Text s -> [text 16 pos s]
                TinyText s -> [text 10 pos s]
                OvalTop size -> [ovalTop pos size]
                ArrowDown len -> arrowDown pos len

            text h (x,y) s =
              Elem "text" ["x".=xc x,"y".=yc y-2,"font-size".=h]
                          [CharData s]

            ovalTop (x,y) (w,h) =
              Elem "path" [("d",path),("stroke","black"),("fill","none")] []
              where
                x1 = x-w/2
                x2 = min x (x1+r)
                x3 = max x (x4-r)
                x4 = x+w/2
                y1 = y
                y2 = y+r
                r = h/2
                sx = show . xc
                sy = show . yc
                path = unwords (["M",sx x1,sy y1,"Q",sx x1,sy y2,sx x2,sy y2,
                                 "L",sx x3,sy y2,"Q",sx x4,sy y2,sx x4,sy y1])

            arrowDown (x,y) len =
                [Elem "line" ["x1".=xc x,"y1".=yc y,"x2".=xc x,"y2".=y2,
                              ("stroke","black")] [],
                 Elem "path" [("d",unwords arrowhead)] []]
               where
                 x2 = xc x
                 y2 = yc (y-len)
                 arrowhead = "M":map show [x2,y2,x2-3,y2-6,x2+3,y2-6]

            xc x = num x+5
            yc y = y0-num y
            x1 = num w+10
            y0 = num h+20
            num x = round (scale*x)
            scale = unit*5

            infix 0 .=
            n.=v = (n,show v)

-- * SVG is XML

data SVG = CharData String | Elem TagName Attrs [SVG]
type TagName = String
type Attrs = [(String,String)]

ppSVG svg =
  vcat [text "<?xml version=\"1.0\" standalone=\"no\"?>",
        text "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\"",
        text "\"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">",
        text "",
        vcat (map ppSVG1 svg)] -- It should be a single <svg> element...
  where
    ppSVG1 svg1 =
      case svg1 of
        CharData s -> text (encode s)
        Elem tag attrs [] ->
            text "<"<>text tag<>cat (map attr attrs) <> text "/>"
        Elem tag attrs svg ->
            cat [text "<"<>text tag<>cat (map attr attrs) <> text ">",
                 nest 2 (cat (map ppSVG1 svg)),
                 text "</"<>text tag<>text ">"]

    attr (n,v) = text " "<>text n<>text "=\""<>text (encode v)<>text "\""

    encode s = foldr encodeEntity "" s

    encodeEntity = encodeEntity' (const False)
    encodeEntity' esc c r =
      case c of
        '&' -> "&amp;"++r
        '<' -> "&lt;"++r
        '>' -> "&gt;"++r
        _ -> c:r
