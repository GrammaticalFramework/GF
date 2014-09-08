-- | Lifted concurrency operators and a some useful concurrency abstractions
module GF.Infra.Concurrency(
    module GF.Infra.Concurrency,
    C.forkIO,
    C.MVar,C.modifyMVar,C.modifyMVar_,
    C.Chan
 ) where
import qualified Control.Concurrent as C
import System.IO.Unsafe(unsafeInterleaveIO)
import Control.Monad((<=<))
import Control.Monad.Trans(MonadIO(..))

-- * Futures

newtype Future a = Future {now::IO a}

spawn io = do v <- newEmptyMVar
              C.forkIO $ putMVar v =<< io
              return (Future (readMVar v))

parMapM f = mapM now <=< mapM (spawn . f)

-- * Single-threaded logging

newLog put =
  do logchan <- newChan
     liftIO $ C.forkIO (mapM_ put =<< getChanContents logchan)
     return (writeChan logchan)

-- * Lifted concurrency operators

newMVar x = liftIO $ C.newMVar x
readMVar v = liftIO $ C.readMVar v
putMVar v = liftIO . C.putMVar v

newEmptyMVar :: MonadIO io => io (C.MVar a)
newEmptyMVar = liftIO C.newEmptyMVar

newChan :: MonadIO io => io (C.Chan a)
newChan = liftIO C.newChan

getChanContents ch = liftIO $ C.getChanContents ch
writeChan ch = liftIO . C.writeChan ch


-- * Delayed IO

lazyIO = unsafeInterleaveIO
