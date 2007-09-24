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

module  GF.Canon.GFCC.GFCCAPI where

import GF.Canon.GFCC.DataGFCC
--import GF.Canon.GFCC.GenGFCC
import GF.Canon.GFCC.AbsGFCC
import GF.Canon.GFCC.ParGFCC
import GF.Canon.GFCC.PrintGFCC
import GF.Canon.GFCC.ErrM
import GF.Parsing.FCFG
import qualified GF.Canon.GFCC.GenGFCC as G
import GF.Conversion.SimpleToFCFG (convertGrammar,FCat(..))

--import GF.Data.Operations
--import GF.Infra.UseIO
import qualified Data.Map as Map
import System.Random (newStdGen)
import System.Directory (doesFileExist)


-- This API is meant to be used when embedding GF grammars in Haskell 
-- programs. The embedded system is supposed to use the
-- .gfcm grammar format, which is first produced by the gf program.

---------------------------------------------------
-- Interface
---------------------------------------------------

data MultiGrammar = MultiGrammar {gfcc :: GFCC, parsers :: [(Language,FCFPInfo)]}
type Language     = String
type Category     = String
type Tree         = Exp

file2grammar :: FilePath -> IO MultiGrammar

linearize    :: MultiGrammar -> Language -> Tree -> String
parse        :: MultiGrammar -> Language -> Category -> String -> [Tree]

linearizeAll     :: MultiGrammar -> Tree -> [String]
linearizeAllLang :: MultiGrammar -> Tree -> [(Language,String)]

parseAll     :: MultiGrammar -> Category -> String -> [[Tree]]
parseAllLang :: MultiGrammar -> Category -> String -> [(Language,[Tree])]

generateAll    :: MultiGrammar -> Category -> [Tree]
generateRandom :: MultiGrammar -> Category -> IO [Tree]

readTree   :: MultiGrammar -> String -> Tree
showTree   ::                 Tree -> String

languages  :: MultiGrammar -> [Language]
categories :: MultiGrammar -> [Category]

startCat   :: MultiGrammar -> Category

---------------------------------------------------
-- Implementation
---------------------------------------------------

file2grammar f = do
  gfcc <- file2gfcc f
  let fcfgs = convertGrammar gfcc
  return (MultiGrammar gfcc [(lang, buildFCFPInfo fcfg) | (CId lang,fcfg) <- fcfgs])

file2gfcc f =
  readFileIf f >>= err (error "no parse") (return . mkGFCC) . pGrammar . myLexer

linearize mgr lang = GF.Canon.GFCC.DataGFCC.linearize (gfcc mgr) (CId lang)

parse mgr lang cat s = 
  case lookup lang (parsers mgr) of
    Nothing    -> error "no parser"
    Just pinfo -> case parseFCF "bottomup" pinfo (CId cat) (words s) of
                    Ok x -> x
                    Bad s -> error s

linearizeAll mgr = map snd . linearizeAllLang mgr
linearizeAllLang mgr t = 
  [(lang,linearThis mgr lang t) | lang <- languages mgr]

parseAll mgr cat = map snd . parseAllLang mgr cat

parseAllLang mgr cat s = 
  [(lang,ts) | lang <- languages mgr, let ts = parse mgr lang cat s, not (null ts)]

generateRandom mgr cat = do
  gen <- newStdGen
  return $ G.generateRandom gen (gfcc mgr) (CId cat)

generateAll mgr cat = G.generate (gfcc mgr) (CId cat)

readTree _ = err (const exp0) id . (pExp . myLexer)

showTree t = printTree t

languages mgr = [l | CId l <- cncnames (gfcc mgr)]

categories mgr = [c | CId c <- Map.keys (cats (abstract (gfcc mgr)))]

startCat mgr = "S" ----

------------ for internal use only

linearThis = GF.Canon.GFCC.GFCCAPI.linearize

err f g ex = case ex of
  Ok x -> g x
  Bad s -> f s

readFileIf f = do
  b <- doesFileExist f
  if b then readFile f 
       else putStrLn ("file " ++ f ++ " not found") >> return ""
