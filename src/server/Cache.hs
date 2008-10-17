module Cache (Cache,newCache,readCache) where

import Control.Concurrent
import Data.Map (Map)
import qualified Data.Map as Map 
import System.Directory (getModificationTime)
import System.Time (ClockTime)

data Cache a = Cache {
      cacheLoad :: FilePath -> IO a,
      cacheObjects :: MVar (Map FilePath (MVar (ClockTime, a)))
    }

newCache :: (FilePath -> IO a) -> IO (Cache a)
newCache load = 
    do objs <- newMVar Map.empty
       return $ Cache { cacheLoad = load, cacheObjects = objs }

readCache :: Cache a -> FilePath -> IO a
readCache c file = 
    do t' <- getModificationTime file
       objs <- takeMVar (cacheObjects c)
       case Map.lookup file objs of
         -- object is in cache
         Just v  -> do (t,x) <- takeMVar v
                       putMVar (cacheObjects c) objs
                       -- check timestamp
                       x' <- if t == t' then return x else cacheLoad c file
                       putMVar v (t',x')
                       return x'
         -- first time this object is requested
         Nothing -> do v <- newEmptyMVar
                       putMVar (cacheObjects c) (Map.insert file v objs)
                       x' <- cacheLoad c file
                       putMVar v (t',x')
                       return x'
