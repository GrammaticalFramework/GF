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
             ( graphvizAbstractTree
             , graphvizParseTree
             , graphvizDependencyTree
             , graphvizBracketedString
             , graphvizAlignment
             , getDepLabels
			 ) where

import PGF.CId (CId,showCId,ppCId,mkCId)
import PGF.Data
import PGF.Expr (showExpr, Tree)
import PGF.Linearize
import PGF.Macros (lookValCat, BracketedString(..), flattenBracketedString)

import qualified Data.Map as Map
import Data.List (intersperse,nub,isPrefixOf,sort,sortBy)
import Data.Char (isDigit)
import Text.PrettyPrint

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
    
    getApp (EApp x y)   es = getApp x (y:es)
    getApp (ETyped e _) es = getApp e es
    getApp e            es = (e,es)

    getLbl scope (EFun f)     = let fun = if funs then ppCId f else empty
                                    cat = if cats then ppCId (lookValCat pgf f) else empty
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
    "malt"       -> vcat (map (hcat . intersperse (char '\t')         ) wnodes)
    "malt_input" -> vcat (map (hcat . intersperse (char '\t') . take 6) wnodes)
    _            -> text "digraph {" $$
                    space $$
                    nest 2 (text "rankdir=LR ;" $$
                            text "node [shape = plaintext] ;" $$
                            vcat nodes $$
                            links) $$
                    text "}"
  where
    nodes  = map mkNode leaves
    links  = empty
    wnodes = undefined

    nil = -1

    bs = bracketedLinearize pgf lang t

    leaves = (nil,0,"ROOT") : (groupAndIndexIt 1 . getLeaves nil) bs

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
        Leaf w              -> [(parent,w)]
        Bracket fid _ _ bss -> concatMap (getLeaves fid) bss

    mkNode (p,i,w) = 
      tag p <> text " [label = " <> doubleQuotes (int i <> char '.' <+> text w) <> text "] ;"

{-
    ifd s = if debug then s else []

    pot = readPosText $ concat $ take 1 $ markLinearizes pgf lang exp

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
      _ -> x0 ----

    label tr y x = case span (uncurry (==)) (zip y x) of
      (xys,(_,i):_) -> getLabel i (funAt tr (map fst xys))
      _ -> "" ----

    funAt tr x = case (tr,x) of
      (Fun f _ ,[])  -> f
      (Fun f ts,i:y) -> funAt (ts !! i) y
      _ -> mkCId (prTree tr) ----

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
-}


getDepLabels :: [String] -> Labels
getDepLabels ss = Map.fromList [(mkCId f,ls) | f:ls <- map words ss]


graphvizParseTree :: PGF -> Language -> Tree -> String
graphvizParseTree pgf lang = graphvizBracketedString . bracketedLinearize pgf lang

graphvizBracketedString :: BracketedString -> String
graphvizBracketedString = render . lin2tree
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
            Leaf w              -> [(level-1,parent,w)]
            Bracket fid i _ bss -> concatMap (getLeaves (level+1) fid) bss

        getInterns level []    = []
        getInterns level nodes =
          nub [(level-1,parent,fid,showCId cat) | (parent,Bracket fid _ cat _) <- nodes] :
          getInterns (level+1) [(fid,child) | (_,Bracket fid _ _ children) <- nodes, child <- children]

        mkStruct l cs = struct l <> text "[label = \"" <> fields cs <> text "\"] ;" $$
                        vcat [link pl pid l id | (pl,pid,id,_) <- cs]
        link pl pid l id
          | pl < 0    = empty
          | otherwise = struct pl <> colon <> tag pid <> colon <> char 's' <+>
                        text "--" <+>
                        struct l  <> colon <> tag  id <> colon <> char 'n' <+> semi
        fields cs = hsep (intersperse (char '|') [tbrackets (tag id) <> text c | (_,_,id,c) <- cs])


-- auxiliaries for graphviz syntax
struct l = text ("struct" ++ show l)
tbrackets d = char '<' <> d  <> char '>'
tag i = char 'n' <> int i

-- word alignments from Linearize.markLinearize
-- words are chunks like {[0,1,1,0] old}

graphvizAlignment :: PGF -> [Language] -> Expr -> String
graphvizAlignment pgf langs = render . lin2graph . linsBracketed
  where
    linsBracketed t = [bracketedLinearize pgf lang t | lang <- langs]

    lin2graph :: [BracketedString] -> Doc
    lin2graph bss =
      text "digraph {" $$
      space $$
      nest 2 (text "rankdir=LR ;" $$
              text "node [shape = record] ;" $$
              space $$
              mkLayers 0 leaves) $$
      text "}"
      where
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
            Leaf w              -> [(parent,w)]
            Bracket fid _ _ bss -> concatMap (getLeaves fid) bss

        mkLayers l []       = empty
        mkLayers l (cs:css) = struct l <> text "[label = \"" <> fields cs <> text "\"] ;" $$
                              (case css of
                                 (ncs:_) -> vcat (map (mkLinks l ncs) cs)
                                 _       -> empty)  $$
                              mkLayers (l+1) css

        mkLinks l cs (p0,id0,_) = 
          vcat (map (\id1 -> struct l     <> colon <> tag id0 <> colon <> char 'e' <+>
                             text "->" <+>
                             struct (l+1) <> colon <> tag id1 <> colon <> char 'w' <+> semi) indices)
          where
            indices = [id1 | (p1,id1,_) <- cs, p1 == p0]

        fields cs = hsep (intersperse (char '|') [tbrackets (tag id) <> text w | (_,id,w) <- cs])
