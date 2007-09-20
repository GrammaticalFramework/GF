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

module GF.Devel.GetGrammar where

import GF.Data.Operations
import qualified GF.Data.ErrM as E ----

import GF.Devel.UseIO
import GF.Grammar.Grammar
import GF.Infra.Modules
import GF.Devel.PrGrammar
import qualified GF.Source.AbsGF as A
import GF.Source.SourceToGrammar
---- import Macros
---- import Rename
import GF.Infra.Option
--- import Custom
import GF.Source.ParGF
import qualified GF.Source.LexGF as L

import GF.Devel.ReadFiles ----

import Data.Char (toUpper)
import Data.List (nub)
import Control.Monad (foldM)
import System (system)

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
  mo1  <- ioeErr $ {- err2err $ -} pModDef tokens
  ioeErr $ transModDef mo1

