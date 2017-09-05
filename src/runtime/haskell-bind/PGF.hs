module PGF (PGF2.PGF, PGF2.readPGF,
            PGF2.abstractName,

            PGF2.CId, mkCId, showCId, readCId,
            
            PGF2.categories, PGF2.functions, PGF2.functionType,

            PGF2.Expr,Tree,PGF2.showExpr,PGF2.readExpr,
            PGF2.mkAbs,PGF2.unAbs,
            PGF2.mkApp,PGF2.unApp,
            PGF2.mkStr,PGF2.unStr,
            PGF2.mkInt,PGF2.unInt,
            PGF2.mkFloat,PGF2.unFloat,
            PGF2.mkMeta,PGF2.unMeta,
            compute,

            PGF2.Type, PGF2.showType, PGF2.readType,
            PGF2.mkType, PGF2.unType,

            Token,

            Language, languages, PGF2.startCat, PGF2.languageCode,
            linearize, bracketedLinearize, tabularLinearizes, parse,
            PGF2.BracketedString(..), PGF2.flattenBracketedString,
            
            Morpho, buildMorpho, lookupMorpho, isInMorpho,

            Labels, getDepLabels, CncLabels, getCncDepLabels,

            generateRandomFromDepth,

            PGF2.GraphvizOptions(..),
            graphvizAbstractTree, graphvizParseTree, graphvizAlignment,

            -- * Tries
            ATree(..),Trie(..),toATree,toTrie
           ) where

import qualified PGF2
import qualified Data.Map as Map

type Language = PGF2.Concr
type Tree = PGF2.Expr
type Labels = ()
type CncLabels = ()
type Token = String

mkCId x =  x

showCId x = x
readCId s = s

linearize gr cnc e = PGF2.linearize cnc e
bracketedLinearize gr cnc e = PGF2.bracketedLinearize cnc e
tabularLinearizes gr cnc e = PGF2.tabularLinearize cnc e
parse gr cnc s = PGF2.parse cnc s

getDepLabels = error "getDepLabels is not implemented"
getCncDepLabels = error "getCncDepLabels is not implemented"

generateRandomFromDepth = error "generateRandomFromDepth is not implemented"

compute = error "compute is not implemented"

languages gr = Map.elems (PGF2.languages gr)

type Morpho = PGF2.Concr

buildMorpho gr cnc = cnc
lookupMorpho cnc w = [(lemma,an) | (lemma,an,_) <- PGF2.lookupMorpho cnc w]
isInMorpho cnc w = not (null (PGF2.lookupMorpho cnc w))

graphvizAbstractTree pgf (funs,cats) = PGF2.graphvizAbstractTree pgf PGF2.graphvizDefaults{PGF2.noFun=not funs,PGF2.noCat=not cats}
graphvizParseTree _   = PGF2.graphvizParseTree
graphvizAlignment cs  = PGF2.graphvizWordAlignment cs PGF2.graphvizDefaults

-- | A type for plain applicative trees
data ATree t = Other t    | App PGF2.CId  [ATree t]  deriving Show
data Trie    = Oth   Tree | Ap  PGF2.CId [[Trie   ]] deriving Show
-- ^ A type for tries of plain applicative trees

-- | Convert a 'Tree' to an 'ATree'
toATree :: Tree -> ATree Tree
toATree e = maybe (Other e) app (PGF2.unApp e)
  where
    app (f,es) = App f (map toATree es)

-- | Combine a list of trees into a trie
toTrie = combines . map ((:[]) . singleton)
  where
    singleton t = case t of
                    Other e -> Oth e
                    App f ts -> Ap f [map singleton ts]

    combines [] = []
    combines (ts:tss) = ts1:combines tss2
      where
        (ts1,tss2) = combines2 [] tss ts
        combines2 ots []        ts1 = (ts1,reverse ots)
        combines2 ots (ts2:tss) ts1 =
          maybe (combines2 (ts2:ots) tss ts1) (combines2 ots tss) (combine ts1 ts2)

        combine ts us = mapM combine2 (zip ts us)
          where
            combine2 (Ap f ts,Ap g us) | f==g = Just (Ap f (combines (ts++us)))
            combine2 _ = Nothing
