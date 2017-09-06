module PGF (PGF, readPGF,
            abstractName,

            PGF2.CId, mkCId, showCId, readCId,
            
            categories, functions, functionType, browse,

            PGF2.Expr,Tree,PGF2.showExpr,PGF2.readExpr,
            PGF2.mkAbs,PGF2.unAbs,
            PGF2.mkApp,PGF2.unApp,
            PGF2.mkStr,PGF2.unStr,
            PGF2.mkInt,PGF2.unInt,
            PGF2.mkFloat,PGF2.unFloat,
            PGF2.mkMeta,PGF2.unMeta,
            compute,

            TcError, ppTcError, inferExpr,

            PGF2.Type, PGF2.showType, PGF2.readType,
            PGF2.mkType, PGF2.unType,

            Token,

            Language, readLanguage, showLanguage,
            languages, PGF2.startCat, PGF2.languageCode,
            linearize, bracketedLinearize, tabularLinearizes, ParseOutput(..), parse,
            PGF2.BracketedString(..), PGF2.flattenBracketedString,
            showPrintName,
            
            Morpho, buildMorpho, lookupMorpho, isInMorpho,

            Labels, getDepLabels, CncLabels, getCncDepLabels,

            generateAllDepth, generateRandomDepth, generateRandomFromDepth,

            PGF2.GraphvizOptions(..),
            graphvizAbstractTree, graphvizParseTree, graphvizAlignment, graphvizDependencyTree,

            -- * Tries
            ATree(..),Trie(..),toATree,toTrie
           ) where

import qualified PGF2
import qualified Data.Map as Map

type Language = String
data PGF = PGF PGF2.PGF (Map.Map Language PGF2.Concr)

readPGF fpath = do
  gr <- PGF2.readPGF fpath
  return (PGF gr (PGF2.languages gr))

readLanguage s = Just s
showLanguage s = s

abstractName (PGF gr _) = PGF2.abstractName gr

categories (PGF gr _) = PGF2.categories gr
functions (PGF gr _)  = PGF2.functions gr
functionType (PGF gr _) = PGF2.functionType gr

type Tree = PGF2.Expr
type Labels = ()
type CncLabels = ()
type Token = String

mkCId x =  x

showCId x = x
readCId s = s

linearize (PGF gr langs) lang e = PGF2.linearize (getConcr langs lang) e
bracketedLinearize (PGF gr langs) lang e = PGF2.bracketedLinearize (getConcr langs lang) e
tabularLinearizes (PGF gr langs) lang e = PGF2.tabularLinearize (getConcr langs lang) e

type FId = Int
type TcError = String

-- | This data type encodes the different outcomes which you could get from the parser.
data ParseOutput
  = ParseFailed Int                -- ^ The integer is the position in number of tokens where the parser failed.
  | TypeError   [(FId,TcError)]    -- ^ The parsing was successful but none of the trees is type correct. 
                                   -- The forest id ('FId') points to the bracketed string from the parser
                                   -- where the type checking failed. More than one error is returned
                                   -- if there are many analizes for some phrase but they all are not type correct.
  | ParseOk [Tree]                 -- ^ If the parsing and the type checking are successful we get a list of abstract syntax trees.
                                   -- The list should be non-empty.
  | ParseIncomplete                -- ^ The sentence is not complete. Only partial output is produced

parse (PGF gr langs) lang cat s = 
  case PGF2.parse (getConcr langs lang) cat s of
    PGF2.ParseFailed o _ -> ParseFailed o
    PGF2.ParseOk ts      -> ParseOk (map fst ts)
    PGF2.ParseIncomplete -> ParseIncomplete

ppTcError s = s

inferExpr (PGF gr _) = PGF2.inferExpr gr

showPrintName (PGF gr langs) lang f = 
  case PGF2.printName (getConcr langs lang) f of
    Just n  -> n
    Nothing -> f

getDepLabels = error "getDepLabels is not implemented"
getCncDepLabels = error "getCncDepLabels is not implemented"

generateAllDepth = error "generateAllDepth is not implemented"
generateRandomDepth = error "generateRandomDepth is not implemented"
generateRandomFromDepth = error "generateRandomFromDepth is not implemented"

compute = error "compute is not implemented"

languages (PGF gr _) = Map.elems (PGF2.languages gr)

type Morpho = PGF2.Concr

buildMorpho gr cnc = cnc
lookupMorpho cnc w = [(lemma,an) | (lemma,an,_) <- PGF2.lookupMorpho cnc w]
isInMorpho cnc w = not (null (PGF2.lookupMorpho cnc w))

graphvizAbstractTree (PGF gr _) (funs,cats) = PGF2.graphvizAbstractTree gr PGF2.graphvizDefaults{PGF2.noFun=not funs,PGF2.noCat=not cats}
graphvizParseTree (PGF gr langs) lang  = PGF2.graphvizParseTree (getConcr langs lang)
graphvizAlignment cs  = PGF2.graphvizWordAlignment cs PGF2.graphvizDefaults
graphvizDependencyTree = error "graphvizDependencyTree is not implemented"
browse = error "browse is not implemented"

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

getConcr langs lang =
  case Map.lookup lang langs of
    Just cnc -> cnc
    Nothing  -> error "Unknown language"
