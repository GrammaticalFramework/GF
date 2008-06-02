-------------------------------------------------
-- |
-- Module      : PGF
-- Maintainer  : Aarne Ranta
-- Stability   : stable
-- Portability : portable
--
-- This module is an Application Programming Interface to 
-- to load and interpret grammars compiled Portable Grammar Format (PGF).
-- The PGF format is produced as a final output from the GF compiler.
-- The API is meant to be used when embedding GF grammars in Haskell 
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
           Language, languages, abstractName,
           
           -- ** Category
           Category, categories, startCat,

           -- * Expressions
           Exp(..), Equation(..),
           showExp, readExp,

           -- * Operations
           -- ** Linearization
           linearize, linearizeAllLang, linearizeAll,
           
           -- ** Parsing
           parse, parseAllLang, parseAll,

           -- ** Generation
           generateRandom, generateAll, generateAllDepth
          ) where

import PGF.CId
import PGF.Linearize hiding (linearize)
import qualified PGF.Linearize (linearize)
import PGF.Generate
import PGF.Macros
import PGF.Data
import PGF.Raw.Convert
import PGF.Raw.Parse
import PGF.Raw.Print (printTree)
import PGF.Parsing.FCFG
import GF.Text.UTF8

import GF.Data.ErrM

import Data.Char
import qualified Data.Map as Map
import Control.Monad
import System.Random (newStdGen)
import System.Directory (doesFileExist)
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP


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
linearize    :: PGF -> Language -> Exp -> String

-- | Tries to parse the given string in the specified language
-- and to produce abstract syntax expression. An empty
-- list is returned if the parsing is not successful. The list may also
-- contain more than one element if the grammar is ambiguous.
parse        :: PGF -> Language -> Category -> String -> [Exp]

-- | The same as 'linearizeAllLang' but does not return
-- the language.
linearizeAll     :: PGF -> Exp -> [String]

-- | Linearizes given expression as string in all languages
-- available in the grammar.
linearizeAllLang :: PGF -> Exp -> [(Language,String)]

-- | The same as 'parseAllLang' but does not return
-- the language.
parseAll     :: PGF -> Category -> String -> [[Exp]]

-- | Tries to parse the given string with every language
-- available in the grammar and to produce abstract syntax 
-- expression. The returned list contains pairs of language
-- and list of possible expressions. Only those languages
-- for which at least one parsing is possible are listed.
-- More than one abstract syntax expressions are possible
-- if the grammar is ambiguous.
parseAllLang :: PGF -> Category -> String -> [(Language,[Exp])]

-- | The same as 'generateAllDepth' but does not limit
-- the depth in the generation.
generateAll      :: PGF -> Category -> [Exp]

-- | Generates an infinite list of random abstract syntax expressions.
-- This is usefull for tree bank generation which after that can be used
-- for grammar testing.
generateRandom   :: PGF -> Category -> IO [Exp]

-- | Generates an exhaustive possibly infinite list of
-- abstract syntax expressions. A depth can be specified
-- to limit the search space.
generateAllDepth :: PGF -> Category -> Maybe Int -> [Exp]

-- | parses 'String' as an expression
readExp :: String -> Maybe Exp

-- | renders expression as 'String'
showExp :: Exp -> String

-- | List of all languages available in the given grammar.
languages    :: PGF -> [Language]

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
  s <- readFile f
  g <- parseGrammar s
  return $! toPGF g

linearize pgf lang = PGF.Linearize.linearize pgf (mkCId lang)

parse pgf lang cat s = 
  case lookParser pgf (mkCId lang) of
    Nothing    -> error ("Unknown language: " ++ lang)
    Just pinfo -> case parseFCF "bottomup" pinfo (mkCId cat) (words s) of
                    Ok x  -> x
                    Bad s -> error s

linearizeAll mgr = map snd . linearizeAllLang mgr
linearizeAllLang mgr t = 
  [(lang,PGF.linearize mgr lang t) | lang <- languages mgr]

parseAll mgr cat = map snd . parseAllLang mgr cat

parseAllLang mgr cat s = 
  [(lang,ts) | lang <- languages mgr, let ts = parse mgr lang cat s, not (null ts)]

generateRandom pgf cat = do
  gen <- newStdGen
  return $ genRandom gen pgf (mkCId cat)

generateAll pgf cat = generate pgf (mkCId cat) Nothing
generateAllDepth pgf cat = generate pgf (mkCId cat)

readExp s = case RP.readP_to_S (pExp False) s of
              [(x,"")] -> Just x
              _        -> Nothing

pExps :: RP.ReadP [Exp]
pExps = liftM2 (:) (pExp True) pExps RP.<++ (RP.skipSpaces >> return [])

pExp :: Bool -> RP.ReadP Exp
pExp isNested = RP.skipSpaces >> (pParen RP.<++ pAbs RP.<++ pApp RP.<++ pNum RP.<++ pStr RP.<++ pMeta)
  where 
        pParen = RP.between (RP.char '(') (RP.char ')') (pExp False)
        pAbs = do xs <- RP.between (RP.char '\\') (RP.skipSpaces >> RP.string "->") (RP.sepBy1 (RP.skipSpaces >> pIdent) (RP.skipSpaces >> RP.char ','))
                  t  <- pExp False
                  return (EAbs xs t)
        pApp = do f  <- pIdent
                  ts <- (if isNested then return [] else pExps)
                  return (EApp f ts)
        pStr = RP.char '"' >> liftM EStr (RP.manyTill (pEsc RP.<++ RP.get) (RP.char '"'))
        pEsc = RP.char '\\' >> RP.get
        pNum = do x <- RP.munch1 isDigit
                  ((RP.char '.' >> RP.munch1 isDigit >>= \y -> return (EFloat (read (x++"."++y))))
                   RP.<++
                   (return (EInt (read x))))
        pMeta = do RP.char '?'
                   x <- RP.munch1 isDigit
                   return (EMeta (read x))

        pIdent = fmap mkCId (liftM2 (:) (RP.satisfy isIdentFirst) (RP.munch isIdentRest))
        isIdentFirst c = c == '_' || isLetter c
        isIdentRest c = c == '_' || c == '\'' || isAlphaNum c


showExp = PP.render . ppExp False

ppExp isNested (EAbs xs t) = ppParens isNested (PP.char '\\' PP.<>
                                                PP.hsep (PP.punctuate PP.comma (map (PP.text . prCId) xs)) PP.<+>
                                                PP.text "->" PP.<+>
                                                ppExp False t)
ppExp isNested (EApp f []) = PP.text (prCId f)
ppExp isNested (EApp f ts) = ppParens isNested (PP.text (prCId f) PP.<+> PP.hsep (map (ppExp True) ts))
ppExp isNested (EStr   s)  = PP.text (show s)
ppExp isNested (EInt   n)  = PP.integer n
ppExp isNested (EFloat d)  = PP.double d
ppExp isNested (EMeta  n)  = PP.char '?' PP.<> PP.integer n
ppExp isNested (EVar  id)  = PP.text (prCId id)

ppParens True  = PP.parens
ppParens False = id

abstractName pgf = prCId (absname pgf)

languages pgf = [prCId l | l <- cncnames pgf]

categories pgf = [prCId c | c <- Map.keys (cats (abstract pgf))]

startCat pgf = lookStartCat pgf
