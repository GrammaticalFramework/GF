-- | Shell IO: a monad that can restrict acesss to arbitrary IO and has the
-- ability to capture output that normally would be sent to stdout.
{-# LANGUAGE CPP, FlexibleInstances, FlexibleContexts #-}
module GF.Infra.SIO(
       -- * The SIO monad
       SIO,MonadSIO(..),
       -- * Running SIO operations
       runSIO,hRunSIO,captureSIO,
       -- * Unrestricted, safe operations
       -- ** From the standard libraries
       getCPUTime,getCurrentDirectory,getLibraryDirectory,
       newStdGen,print,putStrLn,
       -- ** Specific to GF
       importGrammar,importSource,
#ifdef C_RUNTIME
       readPGF2,
#endif
       putStrLnFlush,runInterruptibly,lazySIO,
       -- * Restricted accesss to arbitrary (potentially unsafe) IO operations
       -- | If the environment variable GF_RESTRICTED is defined, these
       -- operations will fail. Otherwise, they will be executed normally.
       -- Output to stdout will /not/ be captured or redirected.
       restricted,restrictedSystem
  ) where
import Prelude hiding (putStrLn,print)
import Control.Applicative(Applicative(..))
import Control.Monad(liftM,ap)
import Control.Monad.Trans(MonadTrans(..))
import System.IO(hPutStrLn,hFlush,stdout)
import GF.System.Catch(try)
import System.Process(system)
import System.Environment(getEnv)
import Control.Concurrent.Chan(newChan,writeChan,getChanContents)
import GF.Infra.Concurrency(lazyIO)
import GF.Infra.UseIO(Output(..))
import qualified System.CPUTime as IO(getCPUTime)
import qualified System.Directory as IO(getCurrentDirectory)
import qualified System.Random as IO(newStdGen)
import qualified GF.Infra.UseIO as IO(getLibraryDirectory)
import qualified GF.System.Signal as IO(runInterruptibly)
import qualified GF.Command.Importing as GF(importGrammar, importSource)
#ifdef C_RUNTIME
import qualified PGF2
#endif

-- * The SIO monad

type PutStrLn = String -> IO ()
newtype SIO a = SIO {unS::PutStrLn->IO a}

instance Functor SIO where fmap = liftM

instance Applicative SIO where
  pure = return
  (<*>) = ap

instance Monad SIO where
  return x = SIO (const (return x))
  SIO m1 >>= xm2 = SIO $ \ h -> m1 h >>= \ x -> unS (xm2 x) h

instance Output SIO where
  ePutStr = lift0 . ePutStr
  ePutStrLn = lift0 . ePutStrLn
  putStrLnE = putStrLnFlush
--putStrE = --- !!!

class MonadSIO m where liftSIO :: SIO a -> m a

instance MonadSIO SIO where liftSIO = id

instance (MonadTrans t,Monad m,MonadSIO m) => MonadSIO (t m) where
  liftSIO = lift . liftSIO

-- * Running SIO operations

-- | Run normally
runSIO           = hRunSIO stdout

-- | Redirect 'stdout' to the given handle
hRunSIO h sio    = unS sio (\s->hPutStrLn h s>>hFlush h)

-- | Capture 'stdout'
captureSIO sio   = do ch <- newChan
                      result <- unS sio (writeChan ch . Just)
                      writeChan ch Nothing
                      output <- fmap takeJust (getChanContents ch)
                      return (output,result)
                   where
                     takeJust (Just xs:ys) = xs++'\n':takeJust ys
                     takeJust _ = []

-- * Restricted accesss to arbitrary (potentially unsafe) IO operations

restricted io    = SIO (const (restrictedIO io))
restrictedSystem = restricted . system

restrictedIO io =
    either (const io) (const $ fail message) =<< try (getEnv "GF_RESTRICTED")
  where
    message =
      "This operation is not allowed when GF is running in restricted mode."

-- * Unrestricted, safe IO operations

lift0 io         = SIO $ const io
lift1 f io       = SIO $ f . unS io

putStrLn         = putStrLnFlush
putStrLnFlush s  = SIO ($ s)
print x          = putStrLn (show x)

getCPUTime           = lift0   IO.getCPUTime
getCurrentDirectory  = lift0   IO.getCurrentDirectory
getLibraryDirectory  = lift0 . IO.getLibraryDirectory
newStdGen            = lift0   IO.newStdGen
runInterruptibly     = lift1   IO.runInterruptibly
lazySIO              = lift1   lazyIO

importGrammar pgf opts files = lift0 $ GF.importGrammar pgf opts files
importSource      opts files = lift0 $ GF.importSource      opts files

#ifdef C_RUNTIME
readPGF2 = lift0 . PGF2.readPGF
#endif
