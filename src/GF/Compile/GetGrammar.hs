module GetGrammar where

import Operations
import qualified ErrM as E ----

import UseIO
import Grammar
import Modules
import PrGrammar
import qualified AbsGF as A
import SourceToGrammar
---- import Macros
---- import Rename
import Option
--- import Custom
import ParGF
import qualified LexGF as L

import ReadFiles ----

import List (nub)
import Monad (foldM)

-- this module builds the internal GF grammar that is sent to the type checker

getSourceModule :: FilePath -> IOE SourceModule
getSourceModule file = do
  string    <- readFileIOE file
  let tokens = myLexer string
  mo1  <- ioeErr $ err2err $ pModDef tokens
  ioeErr $ transModDef mo1


-- for old GF format with includes

getOldGrammar :: FilePath -> IOE SourceGrammar
getOldGrammar file = do
  defs <- parseOldGrammarFiles file
  let g = A.OldGr A.NoIncl defs
  ioeErr $ transOldGrammar g file

parseOldGrammarFiles :: FilePath -> IOE [A.TopDef]
parseOldGrammarFiles file = do
   putStrE $ "reading grammar of old format" +++ file
   (_, g) <- getImports "" ([],[]) file
   return g  -- now we can throw away includes
  where 
   getImports oldInitPath (oldImps, oldG) f = do
     (path,s) <- readFileLibraryIOE oldInitPath f
     if not (elem path oldImps) 
       then do
         (imps,g) <- parseOldGrammar path
         foldM (getImports (initFilePath path)) (path : oldImps, g ++ oldG) imps
       else 
         return (oldImps, oldG)

parseOldGrammar :: FilePath -> IOE ([FilePath],[A.TopDef])
parseOldGrammar file = do
  putStrE $ "reading old file" +++ file
  s <- ioeIO $ readFileIf file
  A.OldGr incl topdefs <- ioeErr $ err2err $ pOldGrammar $ oldLexer $ fixNewlines s
  includes <- ioeErr $ transInclude incl
  return (includes, topdefs)

----

err2err :: E.Err a -> Err a
err2err (E.Ok v) = Ok v
err2err (E.Bad s) = Bad s

ioeEErr = ioeErr . err2err

-- To resolve the new reserved words: change them by turning the final letter to Z.
--- There is a risk of clash. 

oldLexer :: String -> [L.Token]
oldLexer = map change . L.tokens where
  change t = case t of
    (L.PT p (L.TS s)) | elem s new -> (L.PT p (L.TV (init s ++ "Z")))
    _ -> t
  new = words $ "abstract concrete interface incomplete " ++ 
                                  "instance out open resource reuse transfer with"
