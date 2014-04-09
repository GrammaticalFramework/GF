module Cache (Cache,newCache,flushCache,readCache,readCache') where

import Control.Concurrent.MVar
import Data.Map (Map)
import qualified Data.Map as Map 
import System.Directory (getModificationTime)
import Data.Time (UTCTime)
import Data.Time.Compat (toUTCTime)

data Cache a = Cache {
      cacheLoad :: FilePath -> IO a,
      cacheObjects :: MVar (Map FilePath (MVar (Maybe (UTCTime, a))))
    }

newCache :: (FilePath -> IO a) -> IO (Cache a)
newCache load = 
    do objs <- newMVar Map.empty
       return $ Cache { cacheLoad = load, cacheObjects = objs }

flushCache :: Cache a -> IO ()
flushCache c = modifyMVar_ (cacheObjects c) (const (return Map.empty))

readCache :: Cache a -> FilePath -> IO a
readCache c file = snd `fmap` readCache' c file

readCache' :: Cache a -> FilePath -> IO (UTCTime,a)
readCache' c file =
    do v <- modifyMVar (cacheObjects c) findEntry
       modifyMVar v readObject
  where
    -- Find the cache entry, inserting a new one if neccessary.
    findEntry objs = case Map.lookup file objs of
                       Just v -> return (objs,v)
                       Nothing -> do v <- newMVar Nothing
                                     return (Map.insert file v objs, v)
    -- Check time stamp, and reload if different than the cache entry
    readObject m = do t' <- toUTCTime `fmap` getModificationTime file
                      x' <- case m of
                        Just (t,x) | t' == t -> return x
                        _                    -> cacheLoad c file
                      return (Just (t',x'), (t',x'))
