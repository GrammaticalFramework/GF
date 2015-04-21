-- | pgf-hsbind-trans: A simple batch translator to illustrate the use of the Haskell binding
--   to the C implementation of the PGF run-time system.
--
-- AR April 2015 modified from pgf-shell

import PGF2
import PGF.Lexing (lexText')

import Data.Char(isSpace,toLower)
import Data.List (nub)
import System.Environment
import qualified Data.Map as Map

maxNumTrees :: Int
maxNumTrees = 1

maxNumVariants :: Int
maxNumVariants = 1

main = getPGF =<< getArgs

getPGF args = case args of
  [path,from,to,cat,mxt,mxv] -> pgfTrans from to (Just cat) (read mxt, read mxv) =<< readPGF path
  [path,from,to]        -> pgfTrans from to Nothing (maxNumTrees,maxNumVariants) =<< readPGF path
  _                     -> putStrLn "Usage: pgf-hsbind-trans <path to pgf> <from-lang> <to-lang> [<cat> <#trees> <#variants>]"

pgfTrans from to mcat mx pgf = do
  cfrom <- getConcr' pgf from
  cto   <- getConcr' pgf to
  let cat = maybe (startCat pgf) id mcat
  interact (unlines . map (translates pgf cfrom cto cat mx) . lines)

getConcr' pgf lang =
    maybe (fail $ "Concrete syntax not found: "++show lang) return $
    Map.lookup lang (languages pgf)

linearizeAndShow gr mxv (t,p) = [show t]++take mxv (nub (map unstar (linearizeAll gr t)))++[show p]
  where
    unstar s = case s of
      '*':' ':cs -> cs
      _ -> s

translates pgf cfrom cto cat (mxt,mxv) s0 = 
  let s1 = lextext cfrom s0
      (s,p) = case reverse s1 of c:_ | elem c ".?!" -> (init s1,[c]) ; _ -> (s1,[]) -- separate final punctuation
  in
  case cparse pgf cfrom cat s of
    Left tok -> unlines [s,"Parse error: "++tok]
    Right ts -> unlines $ (("> "++ s):) $ take mxt $ map ((++p) . unlines . linearizeAndShow cto mxv) ts -- append punctuation

cparse pgf concr cat input = parseWithHeuristics concr cat input (-1) callbacks where
  callbacks = maybe [] cb $ lookup "App" literalCallbacks
  cb fs = [(cat,f pgf ("TranslateEng",concr))|(cat,f)<-fs]

lextext cnc = unwords . lexText' (\w -> case lookupMorpho cnc w of
  _:_ -> w
  _ -> case lookupMorpho cnc (uncapitInit w) of 
    [] -> w 
    _ -> uncapitInit w
  )
 where uncapitInit (c:cs) = toLower c : cs
