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

module GF.Compile.GetGrammar where

import GF.Data.Operations
import qualified GF.Source.ErrM as E

import GF.Infra.UseIO
import GF.Infra.Modules
import GF.Grammar.Grammar
import qualified GF.Source.AbsGF as A
import GF.Source.SourceToGrammar
---- import Macros
---- import Rename
import GF.Infra.Option
--- import Custom
import GF.Source.ParGF
import qualified GF.Source.LexGF as L

import GF.Compile.ReadFiles

import Data.Char (toUpper)
import Data.List (nub)
import qualified Data.ByteString.Char8 as BS
import Control.Monad (foldM)
import System.Cmd (system)

getSourceModule :: Options -> FilePath -> IOE SourceModule
getSourceModule opts file0 = do
  file <- case getOptVal opts usePreprocessor of
    Just p -> do
      let tmp = "_gf_preproc.tmp"
          cmd = p +++ file0 ++ ">" ++ tmp
      ioeIO $ system cmd
      -- ioeIO $ putStrLn $ "preproc" +++ cmd
      return tmp
    _ -> return file0
  string    <- readFileIOE file
  let tokens = myLexer string
  mo1  <- ioeErr $ pModDef tokens
  ioeErr $ transModDef mo1
