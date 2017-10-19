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
            
            Morpho, buildMorpho,
            lookupMorpho, isInMorpho, morphoMissing, morphoKnown, fullFormLexicon,

            Labels, getDepLabels, CncLabels, getCncDepLabels,

            generateAllDepth, generateRandom, generateRandomFrom, generateRandomDepth, generateRandomFromDepth,
            generateFromDepth,

            PGF2.GraphvizOptions(..),
            graphvizAbstractTree, graphvizParseTree, graphvizAlignment, graphvizDependencyTree, graphvizParseTreeDep,

            -- * Tries
            ATree(..),Trie(..),toATree,toTrie,
            
            readProbabilitiesFromFile,
            
            groupResults, conlls2latexDoc, gizaAlignment
           ) where

import PGF.Internal
import qualified PGF2
import qualified Data.Map as Map
import qualified Text.ParserCombinators.ReadP as RP
import Data.List(sortBy)
import Text.PrettyPrint(text)
import Data.Char(isDigit)

readPGF = PGF2.readPGF

showPGF gr = PGF2.showPGF gr

readLanguage = readCId
showLanguage (CId s) = s

startCat = PGF2.startCat
languageCode pgf lang = Just (PGF2.languageCode (lookConcr pgf lang))

abstractName gr = CId (PGF2.abstractName gr)

categories gr = map CId (PGF2.categories gr)
categoryContext gr (CId c) = PGF2.categoryContext gr c
categoryProbability gr (CId c) = PGF2.categoryProbability gr c

functions gr  = map CId (PGF2.functions gr)
functionsByCat gr (CId c) = map CId (PGF2.functionsByCat gr c)
functionType gr (CId f) = PGF2.functionType gr f
functionIsDataCon gr (CId f) = PGF2.functionIsDataCon gr f

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

unapply = PGF2.unapply

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

complete pgf lang cat s prefix = 
  let compls = Map.fromListWith (++) [(tok,[CId fun]) | (tok,_,fun,_) <- PGF2.complete (lookConcr pgf lang) cat s prefix]
  in (PGF2.Leaf [],s,compls)

hasLinearization pgf lang (CId f) = PGF2.hasLinearization (lookConcr pgf lang) f

ppTcError s = s

inferExpr gr e = 
  case PGF2.inferExpr gr e of
    Right res -> Right res
    Left  msg -> Left (text msg)

checkType gr ty = 
  case PGF2.checkType gr ty of
    Right res -> Right res
    Left  msg -> Left (text msg)

showPrintName pgf lang (CId f) = 
  case PGF2.printName (lookConcr pgf lang) f of
    Just n  -> n
    Nothing -> f

getDepLabels :: String -> Labels
getDepLabels s = Map.fromList [(mkCId f,ls) | f:ls <- map words (lines s)]

getCncDepLabels :: String -> CncLabels
getCncDepLabels = PGF2.getCncDepLabels

generateAllDepth gr ty _ = map fst (PGF2.generateAll gr ty)
generateFromDepth = error "generateFromDepth is not implemented"
generateRandom = error "generateRandom is not implemented"
generateRandomFrom = error "generateRandomFrom is not implemented"
generateRandomDepth = error "generateRandomDepth is not implemented"
generateRandomFromDepth = error "generateRandomFromDepth is not implemented"

exprFunctions e = [CId f | f <- PGF2.exprFunctions e]

compute = error "compute is not implemented"

-- | rank from highest to lowest probability
rankTreesByProbs :: PGF -> [PGF2.Expr] -> [(PGF2.Expr,Double)]
rankTreesByProbs pgf ts = sortBy (\ (_,p) (_,q) -> compare q p) 
  [(t, realToFrac (PGF2.treeProbability pgf t)) | t <- ts]

treeProbability = PGF2.treeProbability

languages pgf = fmap CId (Map.keys (PGF2.languages pgf))

type Morpho = PGF2.Concr

buildMorpho pgf lang = lookConcr pgf lang
lookupMorpho cnc w = [(CId lemma,an) | (lemma,an,_) <- PGF2.lookupMorpho cnc w]
isInMorpho cnc w = not (null (PGF2.lookupMorpho cnc w))
fullFormLexicon cnc = [(w, [(CId fun,an) | (fun,an,_) <- analyses]) | (w, analyses) <- PGF2.fullFormLexicon cnc]

graphvizAbstractTree pgf (funs,cats) = PGF2.graphvizAbstractTree pgf PGF2.graphvizDefaults{PGF2.noFun=not funs,PGF2.noCat=not cats}
graphvizParseTree pgf lang  = PGF2.graphvizParseTree (lookConcr pgf lang)
graphvizAlignment pgf langs  = PGF2.graphvizWordAlignment (map (lookConcr pgf) langs) PGF2.graphvizDefaults
graphvizDependencyTree format debug lbls cnclbls pgf lang e = 
  let to_lbls' lbls = Map.fromList [(id,xs) | (CId id,xs) <- Map.toList lbls]
  in PGF2.graphvizDependencyTree format debug (fmap to_lbls' lbls) cnclbls (lookConcr pgf lang) e
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

readProbabilitiesFromFile :: FilePath -> IO (Map.Map CId Double)
readProbabilitiesFromFile fpath = do
  s <- readFile fpath
  return $ Map.fromList [(mkCId f,read p) | f:p:_ <- map words (lines s)]

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
