{-# LANGUAGE CPP,ForeignFunctionInterface #-}
-- | A variant of 'Control.Concurrent.setNumCapabilities' that automatically
-- detects the number of processors in the system, and is available
-- even when compiling with GHC<7.6.
module GF.System.Concurrency(
  -- * Controlling parallelism
  setNumCapabilities,getNumberOfProcessors) where
import qualified Control.Concurrent as C
import Foreign.C.Types(CInt(..))




-- | Set parallelism to a given number, or use the number of processors.
-- Returns 'False' if compiled with GHC<7.6 and the desired number of threads
-- hasn't already been set with @+RTS -N/n/ -RTS@.
setNumCapabilities opt_n =
  do n <- maybe getNumberOfProcessors return opt_n
#if MIN_VERSION_base(4,6,0)
     C.setNumCapabilities n
     return True
#else
     n_now <- C.getNumCapabilities
     print (n,n_now)
     return (n==n_now)
#endif

-- | Returns the number of processors in the system.
getNumberOfProcessors = fmap fromEnum c_getNumberOfProcessors

-- | According to comments in cabal-install cbits/getnumprocessors.c
-- this function is part of the RTS of GHC>=6.12.
foreign import ccall "getNumberOfProcessors" c_getNumberOfProcessors :: IO CInt
