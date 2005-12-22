----------------------------------------------------------------------
-- |
-- Module      : GF.System.NoSignal
-- Maintainer  : Bjorn Bringert
-- Stability   : (stability)
-- Portability : (portability)
--
-- > CVS $Date: 2005/11/11 11:12:50 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- Dummy implementation of signal handling.
-----------------------------------------------------------------------------

module GF.System.NoSignal where

import Control.Exception (Exception,catch)
import Prelude hiding (catch)

{-# NOINLINE runInterruptibly #-}
runInterruptibly :: IO a -> IO (Either Exception a)
--runInterruptibly = fmap Right
runInterruptibly a = 
    p `catch` h
  where p = a >>= \x -> return $! Right $! x
        h e = return $ Left e
