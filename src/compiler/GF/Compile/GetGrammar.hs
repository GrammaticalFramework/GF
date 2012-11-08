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

module GF.Compile.GetGrammar (getSourceModule) where

import Prelude hiding (catch)

import GF.Data.Operations

import GF.System.Catch
import GF.Infra.UseIO
import GF.Infra.Option(Options,optPreprocessors,addOptions,flag)
import GF.Grammar.Lexer
import GF.Grammar.Parser
import GF.Grammar.Grammar

import GF.Compile.ReadFiles

import Data.Char (toUpper)
import qualified Data.ByteString.Char8 as BS
import Control.Monad (foldM)
import System.Cmd (system)
import System.Directory(removeFile)

getSourceModule :: Options -> FilePath -> IOE SourceModule
getSourceModule opts file0 = ioe $
    do tmp <- foldM runPreprocessor (Source file0) (flag optPreprocessors opts)
       content <- keepTemp tmp
       case runP pModDef content of
         Left (Pn l c,msg) -> do file <- writeTemp tmp
                                 let location = file++":"++show l++":"++show c
                                 return (Bad (location++":\n   "++msg))
         Right (i,mi)      -> do removeTemp tmp
                                 return (Ok (i,mi{mflags=mflags mi `addOptions` opts, msrc=file0}))
  `catch` (return . Bad . show)

runPreprocessor :: Temporary -> String -> IO Temporary
runPreprocessor tmp0 p =
    maybe external internal (lookup p builtin_preprocessors)
  where
    internal preproc = (Internal . preproc) `fmap` readTemp tmp0
    external =
      do file0 <- writeTemp tmp0
         -- FIXME: should use System.IO.openTempFile
         let file1a = "_gf_preproc.tmp"
             file1b = "_gf_preproc2.tmp"
             -- file0 and file1 must be different
             file1 = if file0==file1a then file1b else file1a
             cmd = p +++ file0 ++ ">" ++ file1
         system cmd
         return (Temp file1)

--------------------------------------------------------------------------------

builtin_preprocessors = [("mkPresent",mkPresent),("mkMinimal",mkMinimal)]

mkPresent = omit_lines "--# notpresent"   -- grep -v "\-\-\# notpresent"
mkMinimal = omit_lines "--# notminimal"   -- grep -v "\-\-\# notminimal"

omit_lines s = BS.unlines . filter (not . BS.isInfixOf bs) . BS.lines
  where bs = BS.pack s

--------------------------------------------------------------------------------

data Temporary = Source FilePath | Temp FilePath | Internal BS.ByteString

writeTemp tmp =
    case tmp of
      Source path  -> return path
      Temp   path  -> return path
      Internal str -> do -- FIXME: should use System.IO.openTempFile
                         let tmp = "_gf_preproc.tmp"
                         BS.writeFile tmp str
                         return tmp

readTemp tmp = do str <- keepTemp tmp
                  removeTemp tmp
                  return str

keepTemp tmp =
    case tmp of
      Source path  -> BS.readFile path
      Temp   path  -> BS.readFile path
      Internal str -> return str

removeTemp (Temp path) = removeFile path
removeTemp _           = return ()
