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

module GF.Devel.Compile.GetGrammar where

import GF.Devel.UseIO
import GF.Devel.Grammar.Modules
----import GF.Devel.PrGrammar
import GF.Devel.Grammar.SourceToGF
---- import Macros
---- import Rename
--- import Custom
import GF.Devel.Grammar.ParGF
import qualified GF.Devel.Grammar.LexGF as L

import GF.Data.Operations
import qualified GF.Devel.Grammar.ErrM as E ----
import GF.Infra.Option ----
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
  mo1  <- ioeErr $ err2err $ pModDef tokens
  ioeErr $ transModDef mo1

err2err e = case e of
  E.Ok v -> Ok v
  E.Bad s -> Bad s

