----------------------------------------------------------------------
-- |
-- Module      : MkConcrete
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 
-- > CVS $Author: 
-- > CVS $Revision: 
--
-- Compile a gfe file into a concrete syntax by using the parser on a resource grammar.
-----------------------------------------------------------------------------

module GF.Compile.MkConcrete (mkConcretes,mkCncLine) where

import GF.Grammar.Values (Tree,tree2exp)
import GF.Grammar.PrGrammar (prt_)
import GF.Grammar.Grammar (Term(Q,QC)) ---
import GF.Grammar.Macros (composSafeOp, record2subst)
import GF.Compile.ShellState (firstStateGrammar)
import GF.Compile.PGrammar (pTerm)
import GF.API
import qualified GF.Embed.EmbedAPI as EA

import GF.Data.Operations
import GF.Infra.UseIO
import GF.Infra.Option

import Data.Char
import Control.Monad

-- translate strings into lin rules by parsing in a resource
-- grammar. AR 2/6/2005

-- Format of rule (on one line):
--    lin F x y = in C "ssss" ;
-- Format of resource path (on first line):
--    --# -resource=PATH
-- Other lines are copied verbatim.
-- The resource has to be built with 
--    i -src -optimize=share SOURCE
-- because mcfg parsing is used.
-- A sequence of files can be processed with the same resource without
-- rebuilding the grammar and parser.

-- notice: we use a hand-crafted lexer and parser in order to preserve
-- the layout and comments in the rest of the file.


mkConcretes :: [FilePath] -> IO ()
mkConcretes [] = putStrLn "no files to process"
mkConcretes files@(file:_) = do
  cont <- liftM lines $ readFileIf file
  let res = getResPath cont
  egr <- appIOE $ 
    optFile2grammar (options 
      [useOptimizer "share",fromSource,beSilent,notEmitCode]) res --- for -mcfg
  gr  <- err (\s -> putStrLn s >> error "resource file rejected") return egr
  let parser cat = errVal ([],"No parse") . 
                   optParseArgErrMsg (options [newMParser, firstCat cat, beVerbose]) gr
  let morpho = isKnownWord gr
  mapM_ (mkConcrete parser morpho) files

type Parser = String -> String -> ([Tree],String)
type Morpho = String -> Bool 

mkConcrete :: Parser -> Morpho -> FilePath -> IO ()
mkConcrete parser morpho file = do
  cont <- liftM getExLines $ readFileIf file
  let out = suffixFile "gf" $ justModuleName file
  writeFile out ""
  mapM_ (mkCnc out parser morpho) cont

getResPath :: [String] -> String
getResPath s = case head (dropWhile (all isSpace) s) of
  '-':'-':'#':path -> reverse (takeWhile (not . (=='=')) (reverse path))
  _ -> error "first line must be --# -resource=<PATH>" 

getExLines :: String -> [Either String String]
getExLines = getl . lines where
  getl ls = case ls of
    s:ss | begEx (words s) -> case break endEx ls of
      (x,y:z) -> Left (unwords (x ++ [y])) : getl z
      _ -> Left s : getl ss
    s:ss -> Right s : getl ss
    [] -> []
  begEx s = case s of
    "=":"in":_ -> True
    _:ws -> begEx ws
    _ -> False
  endEx s = case dropWhile isSpace (reverse s) of
    ';':_ -> True
    _ -> False

mkCnc :: FilePath -> Parser -> Morpho -> Either String String -> IO ()
mkCnc out parser morpho line = do
  let (res,msg) = mkCncLine parser morpho line
  appendFile out res
  appendFile out "\n"
  ifNull (return ()) putStrLnFlush msg

mkCncLine :: (String -> String -> ([Tree],String)) -> (String -> Bool) -> 
             Either String String -> (String,String)
mkCncLine parser morpho (Right line) = (line,[])
mkCncLine parser morpho (Left line) = mkLinRule (words line) where
  mkLinRule s = 
    let
       (pre,str)     = span (/= "in") s
       ([mcat],rest) = splitAt 1 $ tail str
       (lin,subst)   = span (/= '"') $ tail $ unwords rest
       cat = reverse $ takeWhile (/= '.') $ reverse mcat
       substs = doSubst (init (tail subst))
       def
        | last pre /= "=" = line  -- ordinary lin rule
        | otherwise  = case parser cat lin of 
           (t:ts,_) -> ind ++ unwords pre +++ 
                       substs (tree2exp t) +++ ";" ++
                       if null ts then [] else (" -- AMBIGUOUS:" ++++
                         unlines ["-- " ++ substs (tree2exp s) +++ ";" | s <- ts])
           ([],msg) -> "{-" ++ line ++++ morph lin ++++ "-}" 
    in
     (def,def)
  morph s = case [w | w <- words s, not (morpho w)] of
    [] -> ""
    ws -> "unknown words: " ++ unwords ws
  ind = takeWhile isSpace line

doSubst :: String -> Term -> String
doSubst subst0 trm = prt_ $ subt subst trm where
  subst 
    | all isSpace subst0 = []
    | otherwise = err error id $ pTerm subst0 >>= record2subst
  subt g t = case t of
    Q  _ c -> maybe t id $ lookup c g
    QC _ c -> maybe t id $ lookup c g
    _      -> composSafeOp (subt g) t
