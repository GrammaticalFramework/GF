----------------------------------------------------------------------
-- |
-- Module      : GF.System.Signal
-- Maintainer  : Bjorn Bringert
-- Stability   : (stability)
-- Portability : (portability)
--
-- > CVS $Date: 2005/11/07 20:15:05 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- Allows SIGINT (Ctrl-C) to interrupt computations.
-----------------------------------------------------------------------------

module GF.System.Signal where

import Control.Concurrent (myThreadId, killThread)
import Control.Exception (Exception,catch)
import Prelude hiding (catch)
import System.IO
import System.Posix.Signals

-- | Run an IO action, and allow it to be interrupted
--   by a SIGINT to the current process. Returns
--   an exception if the process did not complete 
--   normally.
--   NOTES: 
--   * This will replace any existing SIGINT
--     handlers, and after the computation has completed
--     the default handler will be installed for SIGINT.
--   * If the IO action is lazy (e.g. using readFile,
--     unsafeInterleaveIO etc.) the lazy computation will
--     not be interruptible, as it will be performed
--     after the signal handler has been removed.
runInterruptibly :: IO a -> IO (Either Exception a)
runInterruptibly a = do t <- myThreadId
                        installHandler sigINT (Catch (killThread t)) Nothing
                        x <- p `catch` h
                        installHandler sigINT Default Nothing
                        return x
  where p = a >>= \x -> return $! Right $! x
        h e = return $ Left e

-- | Like 'runInterruptibly', but always returns (), whether
--   the computation fails or not.
runInterruptibly_ :: IO () -> IO ()
runInterruptibly_ = fmap (either (const ()) id) . runInterruptibly
