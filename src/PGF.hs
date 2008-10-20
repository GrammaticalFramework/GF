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
           
           -- * Languages
           Language, 
           showLanguage, readLanguage,
           languages, abstractName, languageCode,
           
           -- * Types
           Type(..),
           showType, readType,
           categories, startCat,

           -- * Expressions
           -- ** Identifiers
           CId, mkCId, prCId, wildCId,

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
           tree2expr, expr2tree, compute, paraphrase, typecheck,
           
           -- ** Word Completion (Incremental Parsing)
           complete,
           Incremental.ParseState,
	   initState, Incremental.nextState, Incremental.getCompletions, extractExps,

           -- ** Generation
           generateRandom, generateAll, generateAllDepth
          ) where

import PGF.CId
import PGF.Linearize
import PGF.Generate
import PGF.AbsCompute
import PGF.TypeCheck
import PGF.Paraphrase
import PGF.Macros
import PGF.Data
import PGF.Raw.Convert
import PGF.Raw.Parse
import PGF.Raw.Print (printTree)
import PGF.Parsing.FCFG
import qualified PGF.Parsing.FCFG.Incremental as Incremental
import GF.Text.UTF8

import GF.Data.ErrM
import GF.Data.Utilities (replace)

import Data.Char
import qualified Data.Map as Map
import Data.Maybe
import System.Random (newStdGen)
import Control.Monad

---------------------------------------------------
-- Interface
---------------------------------------------------

-- | This is just a 'CId' with the language name.
-- A language name is the identifier that you write in the 
-- top concrete or abstract module in GF after the 
-- concrete/abstract keyword. Example:
-- 
-- > abstract Lang = ...
-- > concrete LangEng of Lang = ...
type Language     = CId

readLanguage :: String -> Maybe Language

showLanguage :: Language -> String

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
parse        :: PGF -> Language -> Type -> String -> [Tree]

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

-- | Creates an initial parsing state for a given language and
-- startup category.
initState :: PGF -> Language -> Type -> Incremental.ParseState

-- | This function extracts the list of all completed parse trees
-- that spans the whole input consumed so far. The trees are also
-- limited by the category specified, which is usually
-- the same as the startup category.
extractExps :: Incremental.ParseState -> Type -> [Tree]

-- | The same as 'generateAllDepth' but does not limit
-- the depth in the generation.
generateAll      :: PGF -> Type -> [Tree]

-- | Generates an infinite list of random abstract syntax expressions.
-- This is usefull for tree bank generation which after that can be used
-- for grammar testing.
generateRandom   :: PGF -> Type -> IO [Tree]

-- | Generates an exhaustive possibly infinite list of
-- abstract syntax expressions. A depth can be specified
-- to limit the search space.
generateAllDepth :: PGF -> Type -> Maybe Int -> [Tree]

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
-- The categories are defined in the abstract syntax
-- with the \'cat\' keyword.
categories :: PGF -> [Type]

-- | The start category is defined in the grammar with
-- the \'startcat\' flag. This is usually the sentence category
-- but it is not necessary. Despite that there is a start category
-- defined you can parse with any category. The start category
-- definition is just for convenience.
startCat   :: PGF -> Type

-- | Complete the last word in the given string. If the input
-- is empty or ends in whitespace, the last word is considred
-- to be the empty string. This means that the completions
-- will be all possible next words.
complete :: PGF -> Language -> Type -> String 
         -> [String] -- ^ Possible word completions of, 
                     -- including the given input.


---------------------------------------------------
-- Implementation
---------------------------------------------------

readLanguage = readCId

showLanguage = prCId

readPGF f = do
  s <- readFile f >>= return . decodeUTF8 -- pgf is in UTF8, internal in unicode
  g <- parseGrammar s
  return $! toPGF g

linearize pgf lang = concat . take 1 . PGF.Linearize.linearizes pgf lang

parse pgf lang typ s = 
  case Map.lookup lang (concretes pgf) of
    Just cnc -> case parser cnc of
                  Just pinfo -> if Map.lookup (mkCId "erasing") (cflags cnc) == Just "on"
                                  then Incremental.parse pinfo typ (words s)
                                  else case parseFCFG "topdown" pinfo typ (words s) of
                                         Ok x  -> x
                                         Bad s -> error s
                  Nothing    -> error ("No parser built for language: " ++ prCId lang)
    Nothing  -> error ("Unknown language: " ++ prCId lang)

canParse pgf cnc = isJust (lookParser pgf cnc)

linearizeAll mgr = map snd . linearizeAllLang mgr
linearizeAllLang mgr t = 
  [(lang,PGF.linearize mgr lang t) | lang <- languages mgr]

parseAll mgr typ = map snd . parseAllLang mgr typ

parseAllLang mgr typ s = 
  [(lang,ts) | lang <- languages mgr, canParse mgr lang, let ts = parse mgr lang typ s, not (null ts)]

initState pgf lang typ =
  case lookParser pgf lang of
    Just pinfo -> Incremental.initState pinfo typ
    _          -> error ("Unknown language: " ++ prCId lang)

extractExps state typ = Incremental.extractExps state typ

generateRandom pgf cat = do
  gen <- newStdGen
  return $ genRandom gen pgf cat

generateAll pgf cat = generate pgf cat Nothing
generateAllDepth pgf cat = generate pgf cat

abstractName pgf = absname pgf

languages pgf = cncnames pgf

languageCode pgf lang = 
    fmap (replace '_' '-') $ lookConcrFlag pgf lang (mkCId "language")

categories pgf = [DTyp [] c [EMeta i | (Hyp _ _,i) <- zip hs [0..]] | (c,hs) <- Map.toList (cats (abstract pgf))]

startCat pgf = DTyp [] (lookStartCat pgf) []

complete pgf from typ input = 
         let (ws,prefix) = tokensAndPrefix input
             state0 = initState pgf from typ
         in case foldM Incremental.nextState state0 ws of
              Nothing -> []
              Just state -> let compls = Incremental.getCompletions state prefix
                            in [unwords (ws++[c]) ++ " " | c <- Map.keys compls]
  where
    tokensAndPrefix :: String -> ([String],String)
    tokensAndPrefix s | not (null s) && isSpace (last s) = (words s, "")
                      | null ws = ([],"")
                      | otherwise = (init ws, last ws)
        where ws = words s
