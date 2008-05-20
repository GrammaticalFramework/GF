----------------------------------------------------------------------
-- |
-- Module      : GF.System.UseReadline
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/10 15:04:01 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- Use GNU readline
-----------------------------------------------------------------------------

module GF.System.UseReadline (fetchCommand) where

import System.Console.Readline (readline, addHistory)

fetchCommand :: String -> IO (String)
fetchCommand s = do
  res <- readline s
  case res of
   Nothing -> return "q"
   Just s -> do addHistory s
                return s
