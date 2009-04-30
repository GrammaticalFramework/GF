{-# OPTIONS -cpp #-}

----------------------------------------------------------------------
-- |
-- Module      : GF.System.Readline
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/10 15:04:01 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Uses the right readline library to read user input.
-----------------------------------------------------------------------------

module GF.System.Readline (fetchCommand, setCompletionFunction, filenameCompletionFunction) where

#ifdef USE_HASKELINE

import GF.System.UseHaskeline

#elif USE_READLINE

import GF.System.UseReadline

#elif USE_EDITLINE

import GF.System.UseEditline

#else

import GF.System.NoReadline

#endif
