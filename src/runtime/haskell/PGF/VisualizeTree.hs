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
import qualified Data.IntMap as IntMap
import Data.List (intersperse,nub,isPrefixOf,sort,sortBy)
import Data.Char (isDigit)
import Data.Maybe (fromMaybe)
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
      case IntMap.maxViewWithKey children of
        Just ((head, bss'), deps) -> concat (descend out_head head bss' : [descend (headOf head bss') fid bss | (fid,bss) <- IntMap.toList deps])
        Nothing                  -> []
      where
        children = IntMap.fromListWith (++) [(fid,bss) | Bracket _ fid _ _ bss <- bss]

        descend head fid bss = (fid,head) : getDeps head bss
        
    headOf head bss
      | null [() | Leaf _ <- bss] =
          case IntMap.maxViewWithKey children of
            Just ((head, bss), deps) -> headOf head bss
            Nothing                  -> head
      | otherwise = head
      where
        children = IntMap.fromListWith (++) [(fid,bss) | Bracket _ fid _ _ bss <- bss]

    mkNode (p,i,w) = 
      tag p <> text " [label = " <> doubleQuotes (int i <> char '.' <+> text w) <> text "] ;"

    mkLink (x,y) = tag y <+> text "->" <+> tag x -- ++ " [label = \"" ++ l ++ "\"] ;"

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
            Leaf w                -> [(level-1,parent,w)]
            Bracket _ fid i _ bss -> concatMap (getLeaves (level+1) fid) bss

        getInterns level []    = []
        getInterns level nodes =
          nub [(level-1,parent,fid,showCId cat) | (parent,Bracket cat fid _ _ _) <- nodes] :
          getInterns (level+1) [(fid,child) | (_,Bracket _ fid _ _ children) <- nodes, child <- children]

        mkStruct l cs = struct l <> text "[label = \"" <> fields cs <> text "\"] ;" $$
                        vcat [link pl pid l id | (pl,pid,id,_) <- cs]
        link pl pid l id
          | pl < 0    = empty
          | otherwise = struct pl <> colon <> tag pid <> colon <> char 's' <+>
                        text "--" <+>
                        struct l  <> colon <> tag  id <> colon <> char 'n' <+> semi
        fields cs = hsep (intersperse (char '|') [tbrackets (tag id) <> text c | (_,_,id,c) <- cs])


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
            Leaf w                -> [(parent,w)]
            Bracket _ fid _ _ bss -> concatMap (getLeaves fid) bss

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


-- auxiliaries for graphviz syntax
struct l = text ("struct" ++ show l)
tbrackets d = char '<' <> d  <> char '>'
tag i
  | i < 0     = char 'r' <> int (negate i)
  | otherwise = char 'n' <> int i
