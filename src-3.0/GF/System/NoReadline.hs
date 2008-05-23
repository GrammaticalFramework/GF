----------------------------------------------------------------------
-- |
-- Module      : GF.System.NoReadline
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/10 15:04:01 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- Do not use readline.
-----------------------------------------------------------------------------

module GF.System.NoReadline (fetchCommand) where

import System.IO.Error (try)
import System.IO (stdout,hFlush)

fetchCommand :: String -> IO (String)
fetchCommand s = do
  putStr s
  hFlush stdout
  res <- try getLine
  case res of
   Left e -> return "q"
   Right l -> return l
