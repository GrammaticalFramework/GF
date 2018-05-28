{-# LANGUAGE BangPatterns #-}
-------------------------------------------------
-- |
-- Module      : PGF
-- Maintainer  : Krasimir Angelov
-- Stability   : stable
-- Portability : portable
--
-- This module is an Application Programming Interface to 
-- load and interpret grammars compiled in Portable Grammar Format (PGF).
-- The PGF format is produced as a final output from the GF compiler.
-- The API is meant to be used for embedding GF grammars in Haskell 
-- programs
-------------------------------------------------

module PGF(
           -- * PGF
           PGF,
           readPGF,

           -- * Identifiers
           CId, mkCId, wildCId,
           showCId, readCId,
           -- extra
           ppCId, pIdent, utf8CId,

           -- * Languages
           Language, 
           showLanguage, readLanguage,
           languages, abstractName, languageCode,

           -- * Types
           Type, Hypo,
           showType, readType,
           mkType, mkHypo, mkDepHypo, mkImplHypo,
           unType,
           categories, categoryContext, startCat,

           -- * Functions
           functions, functionsByCat, functionType, missingLins,

           -- * Expressions & Trees
           -- ** Tree
           Tree,

           -- ** Expr
           Expr,
           showExpr, readExpr,
           mkAbs,    unAbs,
           mkApp,    unApp, unapply,
           mkStr,    unStr,
           mkInt,    unInt,
           mkDouble, unDouble,
           mkFloat,  unFloat,
           mkMeta,   unMeta,
           -- extra
           pExpr, exprSize, exprFunctions,

           -- * Operations
           -- ** Linearization
           linearize, linearizeAllLang, linearizeAll, bracketedLinearize, bracketedLinearizeAll, tabularLinearizes,
           groupResults, -- lins of trees by language, removing duplicates
           showPrintName,
           
           BracketedString(..), FId, LIndex, Token,
           Forest.showBracketedString,flattenBracketedString,

           -- ** Parsing
           parse, parseAllLang, parseAll, parse_, parseWithRecovery, complete,

           -- ** Evaluation
           PGF.compute, paraphrase,

           -- ** Type Checking
           -- | The type checker in PGF does both type checking and renaming
           -- i.e. it verifies that all identifiers are declared and it
           -- distinguishes between global function or type indentifiers and
           -- variable names. The type checker should always be applied on
           -- expressions entered by the user i.e. those produced via functions
           -- like 'readType' and 'readExpr' because otherwise unexpected results
           -- could appear. All typechecking functions returns updated versions
           -- of the input types or expressions because the typechecking could
           -- also lead to metavariables instantiations.
           checkType, checkExpr, inferExpr,
           TcError(..), ppTcError,

           -- ** Low level parsing API
           Parse.ParseState,
           Parse.initState, Parse.nextState, Parse.getCompletions, Parse.recoveryStates, 
           Parse.ParseInput(..),  Parse.simpleParseInput, Parse.mkParseInput,
           Parse.ParseOutput(..), Parse.getParseOutput,
           Parse.getContinuationInfo,

           -- ** Generation
           -- | The PGF interpreter allows automatic generation of
           -- abstract syntax expressions of a given type. Since the
           -- type system of GF allows dependent types, the generation
           -- is in general undecidable. In fact, the set of all type
           -- signatures in the grammar is equivalent to a Turing-complete language (Prolog).
           --
           -- There are several generation methods which mainly differ in:
           --
           --     * whether the expressions are sequentially or randomly generated?
           --
           --     * are they generated from a template? The template is an expression
           --     containing meta variables which the generator will fill in.
           --
           --     * is there a limit of the depth of the expression?
           --     The depth can be used to limit the search space, which 
           --     in some cases is the only way to make the search decidable.
           generateAll,         generateAllDepth,
           generateFrom,        generateFromDepth,
           generateRandom,      generateRandomDepth,
           generateRandomFrom,  generateRandomFromDepth,

           -- ** Morphological Analysis
           Lemma, Analysis, Morpho,
           lookupMorpho, buildMorpho, fullFormLexicon,
           morphoMissing,
           -- extra:
           morphoKnown, isInMorpho,

           -- ** Visualizations
           graphvizAbstractTree,
           graphvizParseTree,
           graphvizParseTreeDep,
           graphvizDependencyTree,
           graphvizBracketedString,
           graphvizAlignment,
           gizaAlignment,
           GraphvizOptions(..),
           graphvizDefaults,
           conlls2latexDoc,
           -- extra:
           Labels, getDepLabels,
           CncLabels, getCncDepLabels,
 
           -- * Probabilities
           Probabilities,
           mkProbabilities,
           defaultProbabilities,
           showProbabilities,
           readProbabilitiesFromFile,
           -- extra:
           probTree, setProbabilities, rankTreesByProbs,
           
           -- -- ** SortTop
--         forExample,

           -- * Browsing
           browse,
           -- * Tries
           ATree(..),Trie(..),toATree,toTrie
          ) where

import PGF.CId
import PGF.Linearize
--import PGF.SortTop
import PGF.Generate
import PGF.TypeCheck
import PGF.Paraphrase
import PGF.VisualizeTree
import PGF.Probabilistic
import PGF.Macros
import PGF.Expr (Tree)
import PGF.Morphology
import PGF.Data
import PGF.Binary()
import qualified PGF.Forest as Forest
import qualified PGF.Parse as Parse
import PGF.Utilities(replace)

--import Data.Char
import qualified Data.Map as Map
--import qualified Data.IntMap as IntMap
--import Data.Maybe
import Data.Binary
import Data.List(mapAccumL)
--import System.Random (newStdGen)
--import Control.Monad
import Text.PrettyPrint

---------------------------------------------------
-- Interface
---------------------------------------------------

-- | Reads file in Portable Grammar Format and produces
-- 'PGF' structure. The file is usually produced with:
--
-- > $ gf -make <grammar file name>
readPGF  :: FilePath -> IO PGF

-- | Tries to parse the given string in the specified language
-- and to produce abstract syntax expression.
parse        :: PGF -> Language -> Type -> String -> [Tree]

-- | The same as 'parseAllLang' but does not return
-- the language.
parseAll     :: PGF -> Type -> String -> [[Tree]]

-- | Tries to parse the given string with all available languages.
-- The returned list contains pairs of language
-- and list of abstract syntax expressions 
-- (this is a list, since grammars can be ambiguous). 
-- Only those languages
-- for which at least one parsing is possible are listed.
parseAllLang :: PGF -> Type -> String -> [(Language,[Tree])]

-- | The same as 'parse' but returns more detailed information
parse_       :: PGF -> Language -> Type -> Maybe Int -> String -> (Parse.ParseOutput,BracketedString)

-- | This is an experimental function. Use it on your own risk
parseWithRecovery :: PGF -> Language -> Type -> [Type] -> Maybe Int -> String -> (Parse.ParseOutput,BracketedString)

-- | List of all languages available in the given grammar.
languages    :: PGF -> [Language]

-- | Gets the RFC 4646 language tag 
-- of the language which the given concrete syntax implements,
-- if this is listed in the source grammar.
-- Example language tags include @\"en\"@ for English,
-- and @\"en-UK\"@ for British English.
languageCode :: PGF -> Language -> Maybe String

-- | The abstract language name is the name of the top-level
-- abstract module
abstractName :: PGF -> Language

-- | List of all categories defined in the given grammar.
-- The categories are defined in the abstract syntax
-- with the \'cat\' keyword.
categories :: PGF -> [CId]

categoryContext :: PGF -> CId -> Maybe [Hypo]

-- | The start category is defined in the grammar with
-- the \'startcat\' flag. This is usually the sentence category
-- but it is not necessary. Despite that there is a start category
-- defined you can parse with any category. The start category
-- definition is just for convenience.
startCat   :: PGF -> Type

-- | List of all functions defined in the abstract syntax
functions :: PGF -> [CId]

-- | List of all functions defined for a given category
functionsByCat :: PGF -> CId -> [CId]

-- | The type of a given function
functionType :: PGF -> CId -> Maybe Type


---------------------------------------------------
-- Implementation
---------------------------------------------------

readPGF f = decodeFile f

parse pgf lang typ s =
  case parse_ pgf lang typ (Just 4) s of
    (Parse.ParseOk ts,_) -> ts
    _                    -> []

parseAll mgr typ = map snd . parseAllLang mgr typ

parseAllLang mgr typ s = 
  [(lang,ts) | lang <- languages mgr, (Parse.ParseOk ts,_) <- [parse_ mgr lang typ (Just 4) s]]

parse_ pgf lang typ dp s = 
  case Map.lookup lang (concretes pgf) of
    Just cnc -> Parse.parse pgf lang typ dp (words s)
    Nothing  -> error ("Unknown language: " ++ showCId lang)

parseWithRecovery pgf lang typ open_typs dp s = Parse.parseWithRecovery pgf lang typ open_typs dp (words s)

complete :: PGF -> Language -> Type -> String -> String -> (BracketedString,String,Map.Map Token [CId])
complete pgf from typ input prefix =
  let ws  = words input
      ps0 = Parse.initState pgf from typ
      (ps,ws') = loop ps0 ws
      bs       = snd (Parse.getParseOutput ps typ Nothing)
  in if not (null ws')
       then (bs, unwords (if null prefix then ws' else ws'++[prefix]), Map.empty)
       else (bs, prefix, fmap getFuns (Parse.getCompletions ps prefix))
  where
    loop ps []     = (ps,[])
    loop ps (w:ws) = case Parse.nextState ps (Parse.simpleParseInput w) of
                       Left  es -> (ps,w:ws)
                       Right ps -> loop ps ws

    getFuns ps = [cid | (funid,cid,seq) <- snd . head $ Map.toList contInfo]
      where
        contInfo = Parse.getContinuationInfo ps

groupResults :: [[(Language,String)]] -> [(Language,[String])]
groupResults = Map.toList . foldr more Map.empty . start . concat
 where
  start ls = [(l,[s]) | (l,s) <- ls]
  more (l,s) = 
    Map.insertWith (\ [x] xs -> if elem x xs then xs else (x : xs)) l s

abstractName pgf = absname pgf

languages pgf = Map.keys (concretes pgf)

languageCode pgf lang = 
    case lookConcrFlag pgf lang (mkCId "language") of
      Just (LStr s) -> Just (replace '_' '-' s)
      _             -> Nothing

categories pgf = [c | (c,hs) <- Map.toList (cats (abstract pgf))]

categoryContext pgf cat =
  case Map.lookup cat (cats (abstract pgf)) of
    Just (hypos,_,_) -> Just hypos
    Nothing          -> Nothing

startCat pgf = DTyp [] (lookStartCat pgf) []

functions pgf = Map.keys (funs (abstract pgf))

functionsByCat pgf cat =
  case Map.lookup cat (cats (abstract pgf)) of
    Just (_,fns,_) -> map snd fns
    Nothing        -> []

functionType pgf fun =
  case Map.lookup fun (funs (abstract pgf)) of
    Just (ty,_,_,_) -> Just ty
    Nothing         -> Nothing

-- | Converts an expression to normal form
compute :: PGF -> Expr -> Expr
compute pgf = PGF.Data.normalForm (funs (abstract pgf),const Nothing) 0 []

exprSize :: Expr -> Int
exprSize (EAbs _ _ e) = exprSize e
exprSize (EApp e1 e2) = exprSize e1 + exprSize e2
exprSize (ETyped e ty)= exprSize e
exprSize (EImplArg e) = exprSize e
exprSize _            = 1

exprFunctions :: Expr -> [CId]
exprFunctions (EAbs _ _ e) = exprFunctions e
exprFunctions (EApp e1 e2) = exprFunctions e1 ++ exprFunctions e2
exprFunctions (ETyped e ty)= exprFunctions e
exprFunctions (EImplArg e) = exprFunctions e
exprFunctions (EFun f)     = [f]
exprFunctions _            = []

--exprFunctions :: Expr -> [Fun]

browse :: PGF -> CId -> Maybe (String,[CId],[CId])
browse pgf id = fmap (\def -> (def,producers,consumers)) definition
  where
    definition = case Map.lookup id (funs (abstract pgf)) of
                   Just (ty,_,Just (eqs,_),_) -> Just $ render (text "fun" <+> ppCId id <+> colon <+> ppType 0 [] ty $$
                                                                if null eqs
                                                                  then empty
                                                                  else text "def" <+> vcat [let scope = foldl pattScope [] patts
                                                                                                ds    = map (ppPatt 9 scope) patts
                                                                                            in ppCId id <+> hsep ds <+> char '=' <+> ppExpr 0 scope res | Equ patts res <- eqs])
                   Just (ty,_,Nothing,_)      -> Just $ render (text "data" <+> ppCId id <+> colon <+> ppType 0 [] ty)
                   Nothing   -> case Map.lookup id (cats (abstract pgf)) of
                                  Just (hyps,_,_) -> Just $ render (text "cat" <+> ppCId id <+> hsep (snd (mapAccumL (ppHypo 4) [] hyps)))
                                  Nothing         -> Nothing

    (producers,consumers) = Map.foldWithKey accum ([],[]) (funs (abstract pgf))
      where
        accum f (ty,_,_,_) (plist,clist) = 
          let !plist' = if id `elem` ps then f : plist else plist
              !clist' = if id `elem` cs then f : clist else clist
          in (plist',clist')
          where
            (ps,cs) = tyIds ty

    tyIds (DTyp hyps cat es) = (foldr expIds (cat:concat css) es,concat pss)
      where
        (pss,css) = unzip [tyIds ty | (_,_,ty) <- hyps]

    expIds (EAbs _ _ e) ids = expIds e ids
    expIds (EApp e1 e2) ids = expIds e1 (expIds e2 ids)
    expIds (EFun id)    ids = id : ids
    expIds (ETyped e _) ids = expIds e ids
    expIds _            ids = ids

-- | A type for plain applicative trees
data ATree t = Other t    | App CId  [ATree t]  deriving Show
data Trie    = Oth   Tree | Ap  CId [[Trie   ]] deriving Show
-- ^ A type for tries of plain applicative trees

-- | Convert a 'Tree' to an 'ATree'
toATree :: Tree -> ATree Tree
toATree e = maybe (Other e) app (unApp e)
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
