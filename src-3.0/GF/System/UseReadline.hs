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

module GF.System.UseReadline (fetchCommand, setCompletionFunction) where

import System.Console.Readline

fetchCommand :: String -> IO (String)
fetchCommand s = do
  res <- readline s
  case res of
   Nothing -> return "q"
   Just s -> do addHistory s
                return s

setCompletionFunction :: Maybe (String -> String -> Int -> IO [String]) -> IO ()
setCompletionFunction Nothing   = setCompletionEntryFunction Nothing
setCompletionFunction (Just fn) = setCompletionEntryFunction (Just my_fn)
  where
    my_fn prefix = do
      s <- getLineBuffer
      p <- getPoint
      fn s prefix p
