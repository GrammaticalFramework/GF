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
-- programs.
-------------------------------------------------

module PGF(
           -- * PGF
           PGF,
           readPGF,

           -- * Identifiers
           -- ** CId
           CId, mkCId, prCId,
           
           -- ** Language
           Language, languages, abstractName, languageCode,
           
           -- ** Category
           Category, categories, startCat,

           -- * Expressions
           -- ** Tree
           Tree(..), Literal(..),
           showTree, readTree,
           
           -- ** Expr
           Expr(..), Equation(..),
           showExpr, readExpr,

           -- * Operations
           -- ** Linearization
           linearize, linearizeAllLang, linearizeAll,
           
           -- ** Parsing
           parse, canParse, parseAllLang, parseAll,
           
           -- ** Evaluation
           tree2expr, expr2tree,
           
           -- ** Word Completion (Incremental Parsing)
           Incremental.ParseState,
	   initState, Incremental.nextState, Incremental.getCompletions, extractExps,

           -- ** Generation
           generateRandom, generateAll, generateAllDepth
          ) where

import PGF.CId
import PGF.Linearize
import PGF.Generate
import PGF.Macros
import PGF.Data
import PGF.Expr
import PGF.Raw.Convert
import PGF.Raw.Parse
import PGF.Raw.Print (printTree)
import PGF.Parsing.FCFG
import qualified PGF.Parsing.FCFG.Incremental as Incremental
import GF.Text.UTF8

import GF.Data.ErrM
import GF.Data.Utilities

import qualified Data.Map as Map
import Data.Maybe
import System.Random (newStdGen)

---------------------------------------------------
-- Interface
---------------------------------------------------

-- | This is just a string with the language name.
-- A language name is the identifier that you write in the 
-- top concrete or abstract module in GF after the 
-- concrete/abstract keyword. Example:
-- 
-- > abstract Lang = ...
-- > concrete LangEng of Lang = ...
type Language     = String

-- | This is just a string with the category name.
-- The categories are defined in the abstract syntax
-- with the \'cat\' keyword.
type Category     = String

-- | Reads file in Portable Grammar Format and produces
-- 'PGF' structure. The file is usually produced with:
--
-- > $ gfc --make <grammar file name>
readPGF  :: FilePath -> IO PGF

-- | Linearizes given expression as string in the language
linearize    :: PGF -> Language -> Tree -> String

-- | Tries to parse the given string in the specified language
-- and to produce abstract syntax expression. An empty
-- list is returned if the parsing is not successful. The list may also
-- contain more than one element if the grammar is ambiguous.
-- Throws an exception if the given language cannot be used
-- for parsing, see 'canParse'.
parse        :: PGF -> Language -> Category -> String -> [Tree]

-- | Checks whether the given language can be used for parsing.
canParse     :: PGF -> Language -> Bool

-- | The same as 'linearizeAllLang' but does not return
-- the language.
linearizeAll     :: PGF -> Tree -> [String]

-- | Linearizes given expression as string in all languages
-- available in the grammar.
linearizeAllLang :: PGF -> Tree -> [(Language,String)]

-- | The same as 'parseAllLang' but does not return
-- the language.
parseAll     :: PGF -> Category -> String -> [[Tree]]

-- | Tries to parse the given string with all available languages.
-- Languages which cannot be used for parsing (see 'canParse')
-- are ignored.
-- The returned list contains pairs of language
-- and list of abstract syntax expressions 
-- (this is a list, since grammars can be ambiguous). 
-- Only those languages
-- for which at least one parsing is possible are listed.
parseAllLang :: PGF -> Category -> String -> [(Language,[Tree])]

-- | Creates an initial parsing state for a given language and
-- startup category.
initState :: PGF -> Language -> Category -> Incremental.ParseState

-- | This function extracts the list of all completed parse trees
-- that spans the whole input consumed so far. The trees are also
-- limited by the category specified, which is usually
-- the same as the startup category.
extractExps :: Incremental.ParseState -> Category -> [Tree]

-- | The same as 'generateAllDepth' but does not limit
-- the depth in the generation.
generateAll      :: PGF -> Category -> [Tree]

-- | Generates an infinite list of random abstract syntax expressions.
-- This is usefull for tree bank generation which after that can be used
-- for grammar testing.
generateRandom   :: PGF -> Category -> IO [Tree]

-- | Generates an exhaustive possibly infinite list of
-- abstract syntax expressions. A depth can be specified
-- to limit the search space.
generateAllDepth :: PGF -> Category -> Maybe Int -> [Tree]

-- | List of all languages available in the given grammar.
languages    :: PGF -> [Language]

-- | Gets the RFC 4646 language tag 
-- of the language which the given concrete syntax implements,
-- if this is listed in the source grammar.
-- Example language tags include @"en"@ for English,
-- and @"en-UK"@ for British English.
languageCode :: PGF -> Language -> Maybe String

-- | The abstract language name is the name of the top-level
-- abstract module
abstractName :: PGF -> Language

-- | List of all categories defined in the given grammar.
categories :: PGF -> [Category]

-- | The start category is defined in the grammar with
-- the \'startcat\' flag. This is usually the sentence category
-- but it is not necessary. Despite that there is a start category
-- defined you can parse with any category. The start category
-- definition is just for convenience.
startCat   :: PGF -> Category

---------------------------------------------------
-- Implementation
---------------------------------------------------

readPGF f = do
  s <- readFile f >>= return . decodeUTF8 -- pgf is in UTF8, internal in unicode
  g <- parseGrammar s
  return $! toPGF g

linearize pgf lang = concat . take 1 . PGF.Linearize.linearizes pgf (mkCId lang)

parse pgf lang cat s = 
  case Map.lookup (mkCId lang) (concretes pgf) of
    Just cnc -> case parser cnc of
                  Just pinfo -> if Map.lookup (mkCId "erasing") (cflags cnc) == Just "on"
                                  then Incremental.parse pinfo (mkCId cat) (words s)
                                  else case parseFCFG "bottomup" pinfo (mkCId cat) (words s) of
                                         Ok x  -> x
                                         Bad s -> error s
                  Nothing    -> error ("No parser built for language: " ++ lang)
    Nothing  -> error ("Unknown language: " ++ lang)

canParse pgf cnc = isJust (lookParser pgf (mkCId cnc))

linearizeAll mgr = map snd . linearizeAllLang mgr
linearizeAllLang mgr t = 
  [(lang,PGF.linearize mgr lang t) | lang <- languages mgr]

parseAll mgr cat = map snd . parseAllLang mgr cat

parseAllLang mgr cat s = 
  [(lang,ts) | lang <- languages mgr, canParse mgr lang, let ts = parse mgr lang cat s, not (null ts)]

initState pgf lang cat =
  case lookParser pgf langCId of
    Just pinfo -> Incremental.initState pinfo catCId
    _          -> error ("Unknown language: " ++ lang)
  where
    langCId = mkCId lang
    catCId  = mkCId cat

extractExps state cat = Incremental.extractExps state (mkCId cat)

generateRandom pgf cat = do
  gen <- newStdGen
  return $ genRandom gen pgf (mkCId cat)

generateAll pgf cat = generate pgf (mkCId cat) Nothing
generateAllDepth pgf cat = generate pgf (mkCId cat)

abstractName pgf = prCId (absname pgf)

languages pgf = [prCId l | l <- cncnames pgf]

languageCode pgf lang = 
    fmap (replace '_' '-') $ lookConcrFlag pgf (mkCId lang) (mkCId "language")

categories pgf = [prCId c | c <- Map.keys (cats (abstract pgf))]

startCat pgf = lookStartCat pgf
