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

           -- * Languages
           Language, 
           showLanguage, readLanguage,
           languages, abstractName, languageCode,

           -- * Types
           Type, Hypo,
           showType, readType,
           mkType, mkHypo, mkDepHypo, mkImplHypo,
           categories, startCat,

           -- * Functions
           functions, functionType,

           -- * Expressions & Trees
           -- ** Tree
           Tree,

           -- ** Expr
           Expr,
           showExpr, readExpr,
           mkApp,    unApp,
           mkStr,    unStr,
           mkInt,    unInt,
           mkDouble, unDouble,
           mkMeta,   isMeta,

           -- * Operations
           -- ** Linearization
           linearize, linearizeAllLang, linearizeAll, bracketedLinearize, tabularLinearizes,
           groupResults, -- lins of trees by language, removing duplicates
           showPrintName,
           
           BracketedString(..), FId, LIndex,
           Forest.showBracketedString,

           -- ** Parsing
           parse, parseWithRecovery, parseAllLang, parseAll,

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
           complete,
           Parse.ParseState,
           Parse.initState, Parse.nextState, Parse.getCompletions, Parse.recoveryStates, 
           Parse.ParseResult(..), Parse.getParseResult,

           -- ** Generation
           generateRandom, generateAll, generateAllDepth,
           generateRandomFrom, -- from initial expression, possibly weighed

           -- ** Morphological Analysis
           Lemma, Analysis, Morpho,
           lookupMorpho, buildMorpho, fullFormLexicon,

           -- ** Visualizations
           graphvizAbstractTree,
           graphvizParseTree,
           graphvizDependencyTree,
           graphvizBracketedString,
           graphvizAlignment,

           -- * Browsing
           browse
          ) where

import PGF.CId
import PGF.Linearize
import PGF.Generate
import PGF.TypeCheck
import PGF.Paraphrase
import PGF.VisualizeTree
import PGF.Macros
import PGF.Expr (Tree)
import PGF.Morphology
import PGF.Data
import PGF.Binary
import qualified PGF.Forest as Forest
import qualified PGF.Parse as Parse

import GF.Data.Utilities (replace)

import Data.Char
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Data.Maybe
import Data.Binary
import Data.List(mapAccumL)
import System.Random (newStdGen)
import Control.Monad
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
parse        :: PGF -> Language -> Type -> String -> (Parse.ParseResult,Maybe BracketedString)

-- | This is an experimental function. Use it on your own risk
parseWithRecovery :: PGF -> Language -> Type -> [Type] -> String -> (Parse.ParseResult,Maybe BracketedString)

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

-- | The same as 'generateAllDepth' but does not limit
-- the depth in the generation, and doesn't give an initial expression.
generateAll      :: PGF -> Type -> [Expr]

-- | Generates an infinite list of random abstract syntax expressions.
-- This is usefull for tree bank generation which after that can be used
-- for grammar testing.
generateRandom   :: PGF -> Type -> IO [Expr]

-- | Generates an exhaustive possibly infinite list of
-- abstract syntax expressions. A depth can be specified
-- to limit the search space.
generateAllDepth :: Maybe Expr -> PGF -> Type -> Maybe Int -> [Expr]

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

-- | The start category is defined in the grammar with
-- the \'startcat\' flag. This is usually the sentence category
-- but it is not necessary. Despite that there is a start category
-- defined you can parse with any category. The start category
-- definition is just for convenience.
startCat   :: PGF -> Type

-- | List of all functions defined in the abstract syntax
functions :: PGF -> [CId]

-- | The type of a given function
functionType :: PGF -> CId -> Maybe Type

-- | Complete the last word in the given string. If the input
-- is empty or ends in whitespace, the last word is considred
-- to be the empty string. This means that the completions
-- will be all possible next words.
complete :: PGF -> Language -> Type -> String 
         -> [String] -- ^ Possible completions, 
                     -- including the given input.


---------------------------------------------------
-- Implementation
---------------------------------------------------

readPGF f = decodeFile f

parse pgf lang typ s = 
  case Map.lookup lang (concretes pgf) of
    Just cnc -> Parse.parse pgf lang typ (words s)
    Nothing  -> error ("Unknown language: " ++ showCId lang)

parseWithRecovery pgf lang typ open_typs s = Parse.parseWithRecovery pgf lang typ open_typs (words s)

groupResults :: [[(Language,String)]] -> [(Language,[String])]
groupResults = Map.toList . foldr more Map.empty . start . concat
 where
  start ls = [(l,[s]) | (l,s) <- ls]
  more (l,s) = 
    Map.insertWith (\ [x] xs -> if elem x xs then xs else (x : xs)) l s

parseAll mgr typ = map snd . parseAllLang mgr typ

parseAllLang mgr typ s = 
  [(lang,ts) | lang <- languages mgr, (Parse.ParseResult ts,_) <- [parse mgr lang typ s], not (null ts)]

generateRandom pgf cat = do
  gen <- newStdGen
  return $ genRandom gen pgf cat

generateAll pgf cat = generate pgf cat Nothing
generateAllDepth mex pgf cat = generateAllFrom mex pgf cat

abstractName pgf = absname pgf

languages pgf = Map.keys (concretes pgf)

languageCode pgf lang = 
    case lookConcrFlag pgf lang (mkCId "language") of
      Just (LStr s) -> Just (replace '_' '-' s)
      _             -> Nothing

categories pgf = [c | (c,hs) <- Map.toList (cats (abstract pgf))]

startCat pgf = DTyp [] (lookStartCat pgf) []

functions pgf = Map.keys (funs (abstract pgf))

functionType pgf fun =
  case Map.lookup fun (funs (abstract pgf)) of
    Just (ty,_,_) -> Just ty
    Nothing       -> Nothing

complete pgf from typ input = 
  let (ws,prefix) = tokensAndPrefix input
      state0 = Parse.initState pgf from typ
  in case loop state0 ws of
       Nothing    -> []
       Just state -> (if null prefix && isSuccessful state then [unwords ws ++ " "] else [])
                      ++ [unwords (ws++[c]) ++ " " | c <- Map.keys (Parse.getCompletions state prefix)]
  where
    isSuccessful state =
      case Parse.getParseResult state typ of
        (Parse.ParseResult ts, _) -> not (null ts)
        _                         -> False

    tokensAndPrefix :: String -> ([String],String)
    tokensAndPrefix s | not (null s) && isSpace (last s) = (ws, "")
                      | null ws = ([],"")
                      | otherwise = (init ws, last ws)
        where ws = words s

    loop ps []     = Just ps
    loop ps (t:ts) = case Parse.nextState ps t of
                       Left  es -> Nothing
                       Right ps -> loop ps ts

-- | Converts an expression to normal form
compute :: PGF -> Expr -> Expr
compute pgf = PGF.Data.normalForm (funs (abstract pgf),const Nothing) 0 []

browse :: PGF -> CId -> Maybe (String,[CId],[CId])
browse pgf id = fmap (\def -> (def,producers,consumers)) definition
  where
    definition = case Map.lookup id (funs (abstract pgf)) of
                   Just (ty,_,Just eqs) -> Just $ render (text "fun" <+> ppCId id <+> colon <+> ppType 0 [] ty $$
                                                          if null eqs
                                                            then empty
                                                            else text "def" <+> vcat [let scope = foldl pattScope [] patts
                                                                                          ds    = map (ppPatt 9 scope) patts
                                                                                      in ppCId id <+> hsep ds <+> char '=' <+> ppExpr 0 scope res | Equ patts res <- eqs])
                   Just (ty,_,Nothing ) -> Just $ render (text "data" <+> ppCId id <+> colon <+> ppType 0 [] ty)
                   Nothing   -> case Map.lookup id (cats (abstract pgf)) of
                                  Just (hyps,_) -> Just $ render (text "cat" <+> ppCId id <+> hsep (snd (mapAccumL (ppHypo 4) [] hyps)))
                                  Nothing       -> Nothing

    (producers,consumers) = Map.foldWithKey accum ([],[]) (funs (abstract pgf))
      where
        accum f (ty,_,_) (plist,clist) = 
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
