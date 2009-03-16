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

module GF.Compile.GetGrammar (getSourceModule, addOptionsToModule) where

import GF.Data.Operations

import GF.Infra.UseIO
import GF.Infra.Modules
import GF.Infra.Option
import GF.Grammar.Lexer
import GF.Grammar.Parser
import GF.Grammar.Grammar

import GF.Compile.ReadFiles

import Data.Char (toUpper)
import Data.List (nub)
import qualified Data.ByteString.Char8 as BS
import Control.Monad (foldM)
import System.Cmd (system)

getSourceModule :: Options -> FilePath -> IOE SourceModule
getSourceModule opts file0 = ioe $
  catch (do file <- foldM runPreprocessor file0 (flag optPreprocessors opts)
            content <- BS.readFile file
            case runP pModDef content of
              Left (Pn l c,msg) -> return (Bad (file++":"++show l++":"++show c++": "++msg))
              Right mo          -> return (Ok (addOptionsToModule opts mo)))
        (\e -> return (Bad (show e)))

addOptionsToModule :: Options -> SourceModule -> SourceModule
addOptionsToModule opts = mapSourceModule (\m -> m { flags = flags m `addOptions` opts })

-- FIXME: should use System.IO.openTempFile
runPreprocessor :: FilePath -> String -> IO FilePath
runPreprocessor file0 p = do
  let tmp = "_gf_preproc.tmp"
      cmd = p +++ file0 ++ ">" ++ tmp
  system cmd
  return tmp
