{-# OPTIONS -cpp #-}

----------------------------------------------------------------------
-- |
-- Module      : GF.System.Readline
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/10 14:55:01 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- Uses the right readline library to read user input.
-----------------------------------------------------------------------------

module GF.System.Readline (fetchCommand) where

#ifdef USE_READLINE

import System.Console.Readline (readline, addHistory)

#else

import System.IO.Error (try)
import System.IO (stdout,hFlush)

#endif

#ifdef USE_READLINE

fetchCommand :: String -> IO (String)
fetchCommand s = do
  res <- readline s
  case res of
   Nothing -> return "q"
   Just s -> do addHistory s
                return s

#else

fetchCommand :: String -> IO (String)
fetchCommand s = do
  putStr s
  hFlush stdout
  res <- try getLine
  case res of
   Left e -> return "q"
   Right l -> return l

#endif
