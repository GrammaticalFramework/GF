{-# OPTIONS -cpp #-}

----------------------------------------------------------------------
-- |
-- Module      : GF.System.Signal
-- Maintainer  : Bjorn Bringert
-- Stability   : (stability)
-- Portability : (portability)
--
-- > CVS $Date: 2005/11/11 11:12:50 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.3 $
--
-- Import the right singal handling module.
-----------------------------------------------------------------------------

module GF.System.Signal (runInterruptibly,blockInterrupt) where

#ifdef USE_INTERRUPT

import GF.System.UseSignal (runInterruptibly,blockInterrupt)

#else

import GF.System.NoSignal (runInterruptibly,blockInterrupt)

#endif
