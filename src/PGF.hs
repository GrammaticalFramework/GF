-------------------------------------------------
-- |
-- Module      : PGF
-- Maintainer  : Aarne Ranta
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
           Type,
           showType, readType,
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


           -- * Operations
           -- ** Linearization
           linearize, linearizeAllLang, linearizeAll,
           showPrintName,

           -- ** Parsing
           parse, canParse, parseAllLang, parseAll,
           
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
           
           -- ** Word Completion (Incremental Parsing)
           complete,
           Incremental.ParseState,
           Incremental.initState, Incremental.nextState, Incremental.getCompletions, Incremental.extractTrees,

           -- ** Generation
           generateRandom, generateAll, generateAllDepth,
           
           -- ** Morphological Analysis
           Lemma, Analysis, Morpho,
           lookupMorpho, buildMorpho
          ) where

import PGF.CId
import PGF.Linearize
import PGF.Generate
import PGF.TypeCheck
import PGF.Paraphrase
import PGF.Macros
import PGF.Expr (Tree)
import PGF.Morphology
import PGF.Data hiding (functions)
import PGF.Binary
import qualified PGF.Parsing.FCFG.Active as Active
import qualified PGF.Parsing.FCFG.Incremental as Incremental
import qualified GF.Compile.GeneratePMCFG as PMCFG

import GF.Infra.Option
import GF.Data.Utilities (replace)

import Data.Char
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Data.Maybe
import Data.Binary
import System.Random (newStdGen)
import Control.Monad

---------------------------------------------------
-- Interface
---------------------------------------------------

-- | Reads file in Portable Grammar Format and produces
-- 'PGF' structure. The file is usually produced with:
--
-- > $ gf -make <grammar file name>
readPGF  :: FilePath -> IO PGF

-- | Linearizes given expression as string in the language
linearize    :: PGF -> Language -> Tree -> String

-- | Tries to parse the given string in the specified language
-- and to produce abstract syntax expression. An empty
-- list is returned if the parsing is not successful. The list may also
-- contain more than one element if the grammar is ambiguous.
-- Throws an exception if the given language cannot be used
-- for parsing, see 'canParse'.
parse        :: PGF -> Language -> Type -> String -> [Tree]

-- | Checks whether the given language can be used for parsing.
canParse     :: PGF -> Language -> Bool

-- | The same as 'linearizeAllLang' but does not return
-- the language.
linearizeAll     :: PGF -> Tree -> [String]

-- | Linearizes given expression as string in all languages
-- available in the grammar.
linearizeAllLang :: PGF -> Tree -> [(Language,String)]

-- | Show the printname of a type
showPrintName :: PGF -> Language -> Type -> String

-- | The same as 'parseAllLang' but does not return
-- the language.
parseAll     :: PGF -> Type -> String -> [[Tree]]

-- | Tries to parse the given string with all available languages.
-- Languages which cannot be used for parsing (see 'canParse')
-- are ignored.
-- The returned list contains pairs of language
-- and list of abstract syntax expressions 
-- (this is a list, since grammars can be ambiguous). 
-- Only those languages
-- for which at least one parsing is possible are listed.
parseAllLang :: PGF -> Type -> String -> [(Language,[Tree])]

-- | The same as 'generateAllDepth' but does not limit
-- the depth in the generation.
generateAll      :: PGF -> Type -> [Expr]

-- | Generates an infinite list of random abstract syntax expressions.
-- This is usefull for tree bank generation which after that can be used
-- for grammar testing.
generateRandom   :: PGF -> Type -> IO [Expr]

-- | Generates an exhaustive possibly infinite list of
-- abstract syntax expressions. A depth can be specified
-- to limit the search space.
generateAllDepth :: PGF -> Type -> Maybe Int -> [Expr]

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
categories :: PGF -> [Type]

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

readPGF f = decodeFile f >>= addParsers

-- Adds parsers for all concretes that don't have a parser and that have parser=ondemand.
addParsers :: PGF -> IO PGF
addParsers pgf = do cncs <- sequence [if wantsParser cnc then addParser lang cnc else return (lang,cnc)
                                           | (lang,cnc) <- Map.toList (concretes pgf)]
                    return pgf { concretes = Map.fromList cncs }
    where
      wantsParser cnc = isNothing (parser cnc) && Map.lookup (mkCId "parser") (cflags cnc) == Just "ondemand"
      addParser lang cnc = do pinfo <- PMCFG.convertConcrete noOptions (abstract pgf) lang cnc
                              return (lang,cnc { parser = Just pinfo })

linearize pgf lang = concat . take 1 . PGF.Linearize.linearizes pgf lang

parse pgf lang typ s = 
  case Map.lookup lang (concretes pgf) of
    Just cnc -> case parser cnc of
                  Just pinfo -> if Map.lookup (mkCId "erasing") (cflags cnc) == Just "on"
                                  then Incremental.parse pgf lang typ (words s)
                                  else Active.parse "t"  pinfo typ (words s)
                  Nothing    -> error ("No parser built for language: " ++ showCId lang)
    Nothing  -> error ("Unknown language: " ++ showCId lang)

canParse pgf cnc = isJust (lookParser pgf cnc)

linearizeAll mgr = map snd . linearizeAllLang mgr
linearizeAllLang mgr t = 
  [(lang,PGF.linearize mgr lang t) | lang <- languages mgr]

showPrintName pgf lang (DTyp _ c _) = realize $ lookPrintName pgf lang c

parseAll mgr typ = map snd . parseAllLang mgr typ

parseAllLang mgr typ s = 
  [(lang,ts) | lang <- languages mgr, canParse mgr lang, let ts = parse mgr lang typ s, not (null ts)]

generateRandom pgf cat = do
  gen <- newStdGen
  return $ genRandom gen pgf cat

generateAll pgf cat = generate pgf cat Nothing
generateAllDepth pgf cat = generate pgf cat

abstractName pgf = absname pgf

languages pgf = cncnames pgf

languageCode pgf lang = 
    fmap (replace '_' '-') $ lookConcrFlag pgf lang (mkCId "language")

categories pgf = [DTyp [] c (map EMeta [0..length hs]) | (c,hs) <- Map.toList (cats (abstract pgf))]

startCat pgf = DTyp [] (lookStartCat pgf) []

functions pgf = Map.keys (funs (abstract pgf))

functionType pgf fun =
  case Map.lookup fun (funs (abstract pgf)) of
    Just (ty,_,_) -> Just ty
    Nothing       -> Nothing

complete pgf from typ input = 
         let (ws,prefix) = tokensAndPrefix input
             state0 = Incremental.initState pgf from typ
         in case foldM Incremental.nextState state0 ws of
              Nothing -> []
              Just state -> 
                (if null prefix && not (null (Incremental.extractTrees state typ)) then [unwords ws ++ " "] else [])
                ++ [unwords (ws++[c]) ++ " " | c <- Map.keys (Incremental.getCompletions state prefix)]
  where
    tokensAndPrefix :: String -> ([String],String)
    tokensAndPrefix s | not (null s) && isSpace (last s) = (ws, "")
                      | null ws = ([],"")
                      | otherwise = (init ws, last ws)
        where ws = words s

-- | Converts an expression to normal form
compute :: PGF -> Expr -> Expr
compute pgf = PGF.Data.normalForm (funs (abstract pgf)) 0 []
