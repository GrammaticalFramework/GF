{-# OPTIONS -cpp #-}
----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/29 11:58:46 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Tracing utilities for debugging purposes.
-- If the CPP symbol TRACING is set, then the debugging output is shown.
-----------------------------------------------------------------------------


module GF.System.Tracing (trace, trace2, traceDot, traceCall, tracePrt) where

import qualified IOExts 

-- | emit a string inside braces, before(?) calculating the value:
-- @{str}@
trace :: String -> a -> a

-- | emit function name and debugging output:
-- @{fun: out}@
trace2 :: String -> String -> a -> a

-- | emit a dot before(?) calculating the value, for displaying progress
traceDot :: a -> a

-- | show when a value is starting to be calculated (with a '+'), 
-- and when it is finished (with a '-')
traceCall :: String -> String -> (a -> String) -> a -> a

-- | showing the resulting value (filtered through a printing function):
-- @{fun: value}@
tracePrt :: String -> (a -> String) -> a -> a

#if TRACING
trace str a = IOExts.trace (bold ++ "{" ++ normal ++ str ++ bold ++ "}" ++ normal) a
trace2 fun str a = trace (bold ++ fgcol 1 ++ fun ++ ": " ++ normal ++ str) a 
traceDot a = IOExts.unsafePerformIO (putStr ".") `seq` a
traceCall fun start prt val 
    = trace2 ("+" ++ fun) start $
      val `seq` trace2 ("-" ++ fun) (prt val) val
tracePrt mod prt val = val `seq` trace2 mod (prt val) val
#else
trace _ = id
trace2 _ _ = id
traceDot = id
traceCall _ _ _ = id
tracePrt _ _ = id
#endif


escape    = "\ESC"
highlight = escape ++ "[7m"
bold      = escape ++ "[1m"
underline = escape ++ "[4m"
normal    = escape ++ "[0m"
fgcol col = escape ++ "[0" ++ show (30+col) ++ "m"
bgcol col = escape ++ "[0" ++ show (40+col) ++ "m"
