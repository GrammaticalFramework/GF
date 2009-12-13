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

module GF.System.UseHaskeline (fetchCommand, setCompletionFunction, filenameCompletionFunction) where

import System.Console.Haskeline
import System.Directory

fetchCommand :: String -> IO (String)
fetchCommand s = do
  settings <- getGFSettings
  res <- runInputT settings (getInputLine s)
  case res of
   Nothing -> return "q"
   Just s  -> return s

getGFSettings :: IO (Settings IO)
getGFSettings = do
  path <- getAppUserDataDirectory "gf_history"
  return $
    Settings {
      complete = completeFilename,
      historyFile = Just path,
      autoAddHistory = True
    }


setCompletionFunction :: Maybe (String -> String -> Int -> IO [String]) -> IO ()
setCompletionFunction _   = return ()

filenameCompletionFunction :: String -> IO [String]
filenameCompletionFunction _ = return []
