----------------------------------------------------------------------
-- |
-- Module      : GetGFC
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:23 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.7 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Canon.GetGFC (getCanonModule, getCanonGrammar) where

import GF.Data.Operations
import GF.Canon.ParGFC
import GF.Canon.GFC
import GF.Canon.MkGFC
import GF.Infra.Modules
import GF.Compile.GetGrammar (err2err) ---
import GF.Infra.UseIO

getCanonModule :: FilePath -> IOE CanonModule
getCanonModule file = do
  gr <- getCanonGrammar file
  case modules gr of
    [m] -> return m
    _ -> ioeErr $ Bad "expected exactly one module in a file"

getCanonGrammar :: FilePath -> IOE CanonGrammar
getCanonGrammar file = do
  s <- ioeIO $ readFileIf file
  -- c <- ioeErr $ err2err $ pCanon $ myLexer s
  c <- ioeErr $ pCanon $ myLexer s
  return $ canon2grammar c
