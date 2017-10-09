module PGF (PGF, readPGF, showPGF,
            abstractName,

            CId, mkCId, wildCId, showCId, readCId,
            
            categories, categoryContext, categoryProbability,
            functions, functionsByCat, functionType, functionIsDataCon, browse,

            PGF2.Expr,Tree,showExpr,PGF2.readExpr,pExpr,pIdent,
            mkAbs,unAbs,
            mkApp,unApp,unapply,
            PGF2.mkStr,PGF2.unStr,
            PGF2.mkInt,PGF2.unInt,
            PGF2.mkFloat,PGF2.unFloat,
            PGF2.mkMeta,PGF2.unMeta,
            PGF2.exprSize, exprFunctions,PGF2.exprSubstitute,
            compute,
            rankTreesByProbs,treeProbability,

            TcError, ppTcError, inferExpr, checkType,

            PGF2.Type, PGF2.Hypo, showType, showContext, PGF2.readType,
            mkType, unType,

            Token,

            Language, readLanguage, showLanguage,
            languages, startCat, languageCode,
            linearize, bracketedLinearize, tabularLinearizes, showBracketedString,
            ParseOutput(..), parse, parse_, complete,
            PGF2.BracketedString(..), PGF2.flattenBracketedString,
            hasLinearization,
            showPrintName,
            
            Morpho, buildMorpho, lookupMorpho, isInMorpho, morphoMissing, morphoKnown,

            Labels, getDepLabels, CncLabels, getCncDepLabels,

            generateAllDepth, generateRandom, generateRandomFrom, generateRandomDepth, generateRandomFromDepth,
            generateFromDepth,

            PGF2.GraphvizOptions(..),
            graphvizAbstractTree, graphvizParseTree, graphvizAlignment, graphvizDependencyTree, graphvizParseTreeDep,

            -- * Tries
            ATree(..),Trie(..),toATree,toTrie,
            
            defaultProbabilities, setProbabilities, readProbabilitiesFromFile,
            
            groupResults, conlls2latexDoc, gizaAlignment
           ) where

import PGF.Internal
import qualified PGF2
import qualified Data.Map as Map
import qualified Text.ParserCombinators.ReadP as RP
import Data.List(sortBy)
import Text.PrettyPrint(text)
import Data.Char(isDigit)

readPGF fpath = do
  gr <- PGF2.readPGF fpath
  return (PGF gr (PGF2.languages gr))

showPGF (PGF gr _) = PGF2.showPGF gr

readLanguage = readCId
showLanguage (CId s) = s

startCat (PGF pgf _) = PGF2.startCat pgf
languageCode pgf lang = Just (PGF2.languageCode (lookConcr pgf lang))

abstractName (PGF gr _) = CId (PGF2.abstractName gr)

categories (PGF gr _) = map CId (PGF2.categories gr)
categoryContext (PGF gr _) (CId c) = PGF2.categoryContext gr c
categoryProbability (PGF gr _) (CId c) = PGF2.categoryProbability gr c

functions (PGF gr _)  = map CId (PGF2.functions gr)
functionsByCat (PGF gr _) (CId c) = map CId (PGF2.functionsByCat gr c)
functionType (PGF gr _) (CId f) = PGF2.functionType gr f
functionIsDataCon (PGF gr _) (CId f) = PGF2.functionIsDataCon gr f

type Tree = PGF2.Expr
type Labels = Map.Map CId [String]
type CncLabels = [(String, String -> Maybe (String -> String,String,String))]


mkCId x = CId x
wildCId = CId "_"
showCId (CId x) = x
readCId s = Just (CId s)

showExpr xs e = PGF2.showExpr [x | CId x <- xs] e

pExpr = RP.readS_to_P PGF2.pExpr
pIdent = RP.readS_to_P PGF2.pIdent

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
showContext xs hypos = PGF2.showContext [x | CId x <- xs] hypos

mkType hypos (CId var) es = PGF2.mkType [(bt,var,ty) | (bt,CId var,ty) <- hypos] var es
unType ty = case PGF2.unType ty of
              (hypos,var,es) -> ([(bt,CId var,ty) | (bt,var,ty) <- hypos],CId var,es)

linearize pgf lang e = PGF2.linearize (lookConcr pgf lang) e
bracketedLinearize pgf lang e = PGF2.bracketedLinearize (lookConcr pgf lang) e
tabularLinearizes pgf lang e = [PGF2.tabularLinearize (lookConcr pgf lang) e]
showBracketedString = PGF2.showBracketedString

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

parse pgf lang cat s = 
  case PGF2.parse (lookConcr pgf lang) cat s of
    PGF2.ParseOk ts -> map fst ts
    _               -> []

parse_ pgf lang cat dp s =
  case PGF2.parse (lookConcr pgf lang) cat s of
    PGF2.ParseFailed pos _ -> (ParseFailed pos,      PGF2.Leaf s)
    PGF2.ParseOk ts        -> (ParseOk (map fst ts), PGF2.Leaf s)
    PGF2.ParseIncomplete   -> (ParseIncomplete,      PGF2.Leaf s)

complete (PGF gr langs) lang cat s prefix = error "complete is not implemented"

hasLinearization pgf lang (CId f) = PGF2.hasLinearization (lookConcr pgf lang) f

ppTcError s = s

inferExpr (PGF gr _) e = 
  case PGF2.inferExpr gr e of
    Right res -> Right res
    Left  msg -> Left (text msg)

checkType (PGF gr _) ty = 
  case PGF2.checkType gr ty of
    Right res -> Right res
    Left  msg -> Left (text msg)

showPrintName pgf lang (CId f) = 
  case PGF2.printName (lookConcr pgf lang) f of
    Just n  -> n
    Nothing -> f

getDepLabels = error "getDepLabels is not implemented"
getCncDepLabels = error "getCncDepLabels is not implemented"

generateAllDepth (PGF gr _) ty _ = map fst (PGF2.generateAll gr ty)
generateFromDepth = error "generateFromDepth is not implemented"
generateRandom = error "generateRandom is not implemented"
generateRandomFrom = error "generateRandomFrom is not implemented"
generateRandomDepth = error "generateRandomDepth is not implemented"
generateRandomFromDepth = error "generateRandomFromDepth is not implemented"

exprFunctions e = [CId f | f <- PGF2.exprFunctions e]

compute = error "compute is not implemented"

-- | rank from highest to lowest probability
rankTreesByProbs :: PGF -> [PGF2.Expr] -> [(PGF2.Expr,Double)]
rankTreesByProbs (PGF pgf _) ts = sortBy (\ (_,p) (_,q) -> compare q p) 
  [(t, realToFrac (PGF2.treeProbability pgf t)) | t <- ts]

treeProbability (PGF pgf _) t = PGF2.treeProbability pgf t

languages (PGF gr _) = fmap CId (Map.keys (PGF2.languages gr))

type Morpho = PGF2.Concr

buildMorpho pgf lang = lookConcr pgf lang
lookupMorpho cnc w = [(CId lemma,CId an) | (lemma,an,_) <- PGF2.lookupMorpho cnc w]
isInMorpho cnc w = not (null (PGF2.lookupMorpho cnc w))

graphvizAbstractTree (PGF gr _) (funs,cats) = PGF2.graphvizAbstractTree gr PGF2.graphvizDefaults{PGF2.noFun=not funs,PGF2.noCat=not cats}
graphvizParseTree pgf lang  = PGF2.graphvizParseTree (lookConcr pgf lang)
graphvizAlignment pgf langs  = PGF2.graphvizWordAlignment (map (lookConcr pgf) langs) PGF2.graphvizDefaults
graphvizDependencyTree = error "graphvizDependencyTree is not implemented"
graphvizParseTreeDep = error "graphvizParseTreeDep is not implemented"

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

defaultProbabilities = error "defaultProbabilities is not implemented"
setProbabilities _ pgf = pgf -- error "setProbabilities is not implemented"
readProbabilitiesFromFile = error "readProbabilitiesFromFile is not implemented"


groupResults :: [[(Language,String)]] -> [(Language,[String])]
groupResults = Map.toList . foldr more Map.empty . start . concat
 where
  start ls = [(l,[s]) | (l,s) <- ls]
  more (l,s) = 
    Map.insertWith (\ [x] xs -> if elem x xs then xs else (x : xs)) l s

conlls2latexDoc = error "conlls2latexDoc is not implemented"


morphoMissing  :: Morpho -> [String] -> [String]
morphoMissing = morphoClassify False

morphoKnown    :: Morpho -> [String] -> [String]
morphoKnown = morphoClassify True

morphoClassify :: Bool -> Morpho -> [String] -> [String]
morphoClassify k mo ws = [w | w <- ws, k /= null (lookupMorpho mo w), notLiteral w] where
  notLiteral w = not (all isDigit w) ---- should be defined somewhere

gizaAlignment = error "gizaAlignment is not implemented"
