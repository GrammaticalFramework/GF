----------------------------------------------------------------------
-- |
-- Module      : GetGrammar
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/15 17:56:13 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.16 $
--
-- this module builds the internal GF grammar that is sent to the type checker
-----------------------------------------------------------------------------

module GF.Compile.GetGrammar (getSourceModule, getOldGrammar, getCFGrammar, getEBNFGrammar,
		   err2err
		  ) where

import GF.Data.Operations
import qualified GF.Data.ErrM as E ----

import GF.Infra.UseIO
import GF.Grammar.Grammar
import GF.Infra.Modules
import GF.Grammar.PrGrammar
import qualified GF.Source.AbsGF as A
import GF.Source.SourceToGrammar
---- import Macros
---- import Rename
import GF.Infra.Option
--- import Custom
import GF.Source.ParGF
import qualified GF.Source.LexGF as L

import GF.CF.CF (rules2CF)
import GF.CF.PPrCF
import GF.CF.CFtoGrammar
import GF.CF.EBNF

import GF.Infra.ReadFiles ----

import Data.Char (toUpper)
import Data.List (nub)
import Control.Monad (foldM)

getSourceModule :: FilePath -> IOE SourceModule
getSourceModule file = do
  string    <- readFileIOE file
  let tokens = myLexer string
  mo1  <- ioeErr $ {- err2err $ -} pModDef tokens
  ioeErr $ transModDef mo1


-- for old GF format with includes

getOldGrammar :: Options -> FilePath -> IOE SourceGrammar
getOldGrammar opts file = do
  defs <- parseOldGrammarFiles file
  let g = A.OldGr A.NoIncl defs
  let name = justFileName file
  ioeErr $ transOldGrammar opts name g

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
  A.OldGr incl topdefs <- ioeErr $ pOldGrammar $ oldLexer $ fixNewlines s
  includes <- ioeErr $ transInclude incl
  return (includes, topdefs)

----

err2err :: E.Err a -> Err a
err2err (E.Ok v) = Ok v
err2err (E.Bad s) = Bad s

ioeEErr = ioeErr . err2err

-- | To resolve the new reserved words: 
-- change them by turning the final letter to upper case.
--- There is a risk of clash. 
oldLexer :: String -> [L.Token]
oldLexer = map change . L.tokens where
  change t = case t of
    (L.PT p (L.TS s)) | elem s newReservedWords -> 
        (L.PT p (L.TV (init s ++ [toUpper (last s)])))
    _ -> t

getCFGrammar :: Options -> FilePath -> IOE SourceGrammar
getCFGrammar opts file = do
  let mo = takeWhile (/='.') file
  s    <- ioeIO  $ readFileIf file
  let files = case words (concat (take 1 (lines s))) of
        "--":"include":fs -> fs
        _ -> []
  ss   <- ioeIO  $ mapM readFileIf files
  cfs  <- ioeErr $ mapM (pCF mo) $ s:ss
  defs <- return $ cf2grammar $ rules2CF $ concat cfs
  let g = A.OldGr A.NoIncl defs
---  let ma = justModuleName file
---  let mc = 'C':ma ---
---  let opts' = addOptions (options [useAbsName ma, useCncName mc]) opts
  ioeErr $ transOldGrammar opts file g

getEBNFGrammar :: Options -> FilePath -> IOE SourceGrammar
getEBNFGrammar opts file = do
  let mo = takeWhile (/='.') file
  s    <- ioeIO $ readFileIf file
  defs <- ioeErr $ pEBNFasGrammar s
  let g = A.OldGr A.NoIncl defs
---  let ma = justModuleName file
---  let mc = 'C':ma ---
---  let opts' = addOptions (options [useAbsName ma, useCncName mc]) opts
  ioeErr $ transOldGrammar opts file g
