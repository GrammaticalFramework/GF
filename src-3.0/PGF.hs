----------------------------------------------------------------------
-- |
-- Module      : GFCCAPI
-- Maintainer  : Aarne Ranta
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 
-- > CVS $Author: 
-- > CVS $Revision: 
--
-- Reduced Application Programmer's Interface to GF, meant for
-- embedded GF systems. AR 19/9/2007
-----------------------------------------------------------------------------

module PGF(module PGF, PGF, emptyPGF) where

import PGF.CId
import PGF.Linearize
import PGF.Generate
import PGF.Macros
import PGF.Data
import PGF.Raw.Convert
import PGF.Raw.Parse
import PGF.Parsing.FCFG

import GF.Data.ErrM

import Data.Char
import qualified Data.Map as Map
import Control.Monad
import System.Random (newStdGen)
import System.Directory (doesFileExist)
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP


-- This API is meant to be used when embedding GF grammars in Haskell 
-- programs. The embedded system is supposed to use the
-- .gfcc grammar format, which is first produced by the gf program.

---------------------------------------------------
-- Interface
---------------------------------------------------

type Language     = String
type Category     = String
type Tree         = Exp

file2pgf :: FilePath -> IO PGF

linearize    :: PGF -> Language -> Tree -> String
parse        :: PGF -> Language -> Category -> String -> [Tree]

linearizeAll     :: PGF -> Tree -> [String]
linearizeAllLang :: PGF -> Tree -> [(Language,String)]

parseAll     :: PGF -> Category -> String -> [[Tree]]
parseAllLang :: PGF -> Category -> String -> [(Language,[Tree])]

generateAll      :: PGF -> Category -> [Tree]
generateRandom   :: PGF -> Category -> IO [Tree]
generateAllDepth :: PGF -> Category -> Maybe Int -> [Tree]

readTree   :: String -> Tree
showTree   :: Tree -> String

languages  :: PGF -> [Language]
categories :: PGF -> [Category]

startCat   :: PGF -> Category

---------------------------------------------------
-- Implementation
---------------------------------------------------

file2pgf f = do
  s <- readFileIf f
  g <- parseGrammar s
  return $! toPGF g

linearize pgf lang = PGF.Linearize.linearize pgf (mkCId lang)

parse pgf lang cat s = 
  case lookParser pgf (mkCId lang) of
    Nothing    -> error "no parser"
    Just pinfo -> case parseFCF "bottomup" pinfo (mkCId cat) (words s) of
                    Ok x -> x
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

readTree s = case RP.readP_to_S (pExp False) s of
               [(x,"")] -> x
               _        -> error "no parse"

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


showTree = PP.render . ppExp False

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


------------ for internal use only

err f g ex = case ex of
  Ok x -> g x
  Bad s -> f s

readFileIf f = do
  b <- doesFileExist f
  if b then readFile f 
       else putStrLn ("file " ++ f ++ " not found") >> return ""
