module PGF (PGF, readPGF,
            abstractName,

            CId, mkCId, showCId, readCId,
            
            categories, functions, functionType, browse,

            PGF2.Expr,Tree,showExpr,PGF2.readExpr,
            mkAbs,unAbs,
            mkApp,unApp,unapply,
            PGF2.mkStr,PGF2.unStr,
            PGF2.mkInt,PGF2.unInt,
            PGF2.mkFloat,PGF2.unFloat,
            PGF2.mkMeta,PGF2.unMeta,
            PGF2.exprSize, exprFunctions,
            compute,
            rankTreesByProbs,

            TcError, ppTcError, inferExpr,

            PGF2.Type, showType, PGF2.readType,
            mkType, unType,

            Token,

            Language, readLanguage, showLanguage,
            languages, startCat, languageCode,
            linearize, bracketedLinearize, tabularLinearizes, ParseOutput(..), 
            parse, parse_, complete,
            PGF2.BracketedString(..), PGF2.flattenBracketedString,
            showPrintName,
            
            Morpho, buildMorpho, lookupMorpho, isInMorpho, morphoMissing,

            Labels, getDepLabels, CncLabels, getCncDepLabels,

            generateAllDepth, generateRandomDepth, generateRandomFromDepth,

            PGF2.GraphvizOptions(..),
            graphvizAbstractTree, graphvizParseTree, graphvizAlignment, graphvizDependencyTree,

            -- * Tries
            ATree(..),Trie(..),toATree,toTrie
           ) where

import qualified PGF2
import qualified Data.Map as Map
import Data.List(sortBy)
import Text.PrettyPrint(text)

type Language = CId
data PGF = PGF PGF2.PGF (Map.Map String PGF2.Concr)

readPGF fpath = do
  gr <- PGF2.readPGF fpath
  return (PGF gr (PGF2.languages gr))

readLanguage = readCId
showLanguage (CId s) = s

startCat (PGF pgf _) = PGF2.startCat pgf
languageCode (PGF _ langs) lang = Just (PGF2.languageCode (getConcr langs lang))

abstractName (PGF gr _) = CId (PGF2.abstractName gr)

categories (PGF gr _) = map CId (PGF2.categories gr)
functions (PGF gr _)  = map CId (PGF2.functions gr)
functionType (PGF gr _) (CId f) = PGF2.functionType gr f

type Tree = PGF2.Expr
type Labels = Map.Map CId [String]
type CncLabels = [(String, String -> Maybe (String -> String,String,String))]
type Token = String

newtype CId = CId String deriving (Show,Read,Eq,Ord)

mkCId x = CId x
showCId (CId x) = x
readCId s = Just (CId s)

showExpr xs e = PGF2.showExpr [x | CId x <- xs] e

mkAbs bind_type (CId var) e = PGF2.mkAbs bind_type var e
unAbs e = case PGF2.unAbs e of
            Just (bind_type, var, e) -> Just (bind_type, CId var, e)
            Nothing                  -> Nothing

mkApp (CId f) es = PGF2.mkApp f es
unApp e = case PGF2.unApp e of
            Just (f,es) -> Just (CId f,es)
            Nothing     -> Nothing

unapply = error "unapply is not implemented"

instance Read PGF2.Expr where
    readsPrec _ s = case PGF2.readExpr s of
                      Just e  -> [(e,"")]
                      Nothing -> []

showType xs ty = PGF2.showType [x | CId x <- xs] ty

mkType hypos (CId var) es = PGF2.mkType [(bt,var,ty) | (bt,CId var,ty) <- hypos] var es
unType ty = case PGF2.unType ty of
              (hypos,var,es) -> ([(bt,CId var,ty) | (bt,var,ty) <- hypos],CId var,es)

linearize (PGF gr langs) lang e = PGF2.linearize (getConcr langs lang) e
bracketedLinearize (PGF gr langs) lang e = PGF2.bracketedLinearize (getConcr langs lang) e
tabularLinearizes (PGF gr langs) lang e = [PGF2.tabularLinearize (getConcr langs lang) e]

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
    PGF2.ParseOk ts -> map fst ts
    _               -> []

complete (PGF gr langs) lang cat s prefix = error "complete is not implemented"
parse_ = error "complete is not implemented"

ppTcError s = s

inferExpr (PGF gr _) e = 
  case PGF2.inferExpr gr e of
    Right res -> Right res
    Left  msg -> Left (text msg)

showPrintName (PGF gr langs) lang (CId f) = 
  case PGF2.printName (getConcr langs lang) f of
    Just n  -> n
    Nothing -> f

getDepLabels = error "getDepLabels is not implemented"
getCncDepLabels = error "getCncDepLabels is not implemented"

generateAllDepth = error "generateAllDepth is not implemented"
generateRandomDepth = error "generateRandomDepth is not implemented"
generateRandomFromDepth = error "generateRandomFromDepth is not implemented"

exprFunctions e = [CId f | f <- PGF2.exprFunctions e]

compute = error "compute is not implemented"

-- | rank from highest to lowest probability
rankTreesByProbs :: PGF -> [PGF2.Expr] -> [(PGF2.Expr,Double)]
rankTreesByProbs (PGF pgf _) ts = sortBy (\ (_,p) (_,q) -> compare q p) 
  [(t, realToFrac (PGF2.treeProbability pgf t)) | t <- ts]

languages (PGF gr _) = fmap CId (Map.keys (PGF2.languages gr))

type Morpho = PGF2.Concr

buildMorpho (PGF _ langs) lang = getConcr langs lang
lookupMorpho cnc w = [(CId lemma,CId an) | (lemma,an,_) <- PGF2.lookupMorpho cnc w]
isInMorpho cnc w = not (null (PGF2.lookupMorpho cnc w))
morphoMissing = error "morphoMissing is not implemented"

graphvizAbstractTree (PGF gr _) (funs,cats) = PGF2.graphvizAbstractTree gr PGF2.graphvizDefaults{PGF2.noFun=not funs,PGF2.noCat=not cats}
graphvizParseTree (PGF gr langs) lang  = PGF2.graphvizParseTree (getConcr langs lang)
graphvizAlignment (PGF gr all_langs) langs  = PGF2.graphvizWordAlignment (map (getConcr all_langs) langs) PGF2.graphvizDefaults
graphvizDependencyTree = error "graphvizDependencyTree is not implemented"

browse :: PGF -> CId -> Maybe (String,[CId],[CId])
browse = error "browse is not implemented"

-- | A type for plain applicative trees
data ATree t = Other t    | App CId  [ATree t]  deriving Show
data Trie    = Oth   Tree | Ap  CId [[Trie   ]] deriving Show
-- ^ A type for tries of plain applicative trees

-- | Convert a 'Tree' to an 'ATree'
toATree :: Tree -> ATree Tree
toATree e = maybe (Other e) app (PGF2.unApp e)
  where
    app (f,es) = App (mkCId f) (map toATree es)

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

getConcr langs (CId lang) =
  case Map.lookup lang langs of
    Just cnc -> cnc
    Nothing  -> error "Unknown language"
