{-# LANGUAGE DeriveDataTypeable #-}
module FastCGIUtils (initFastCGI, loopFastCGI,
                     DataRef, newDataRef, getData,
                     throwCGIError, handleCGIErrors) where

import Control.Concurrent
import Control.Exception
import Control.Monad
import Data.Dynamic
import Data.IORef
import Prelude hiding (catch)
import System.Directory
import System.Environment
import System.Exit
import System.IO
import System.IO.Unsafe
import System.Posix
import System.Time


import Network.FastCGI

initFastCGI :: IO ()
initFastCGI = installSignalHandlers

loopFastCGI :: CGI CGIResult -> IO ()
loopFastCGI f = 
    do (do runOneFastCGI f
           exitIfToldTo
           restartIfModified) 
         `catchAborted` logError "Request aborted"
       loopFastCGI f


-- Signal handling for FastCGI programs.


installSignalHandlers :: IO ()
installSignalHandlers =
    do t <- myThreadId
       installHandler sigUSR1 (Catch gracefulExit) Nothing
       installHandler sigTERM (Catch gracelessExit) Nothing
       installHandler sigPIPE (Catch (requestAborted t)) Nothing
       return ()

{-# NOINLINE shouldExit #-}
shouldExit :: IORef Bool
shouldExit = unsafePerformIO $ newIORef False

catchAborted ::  IO a -> IO a -> IO a
catchAborted x y = x `catch` \e -> case e of
                                     ErrorCall "**aborted**" -> y
                                     _ -> throw e

requestAborted :: ThreadId -> IO ()
requestAborted t = throwTo t (ErrorCall "**aborted**")
  
gracelessExit :: IO ()
gracelessExit = do logError "Graceless exit"
                   exitWith ExitSuccess

gracefulExit :: IO ()
gracefulExit = 
    do logError "Graceful exit"
       writeIORef shouldExit True

exitIfToldTo :: IO ()
exitIfToldTo = 
    do b <- readIORef shouldExit
       when b $ do logError "Exiting..."
                   exitWith ExitSuccess


-- Restart handling for FastCGI programs.

{-# NOINLINE myModTimeRef #-}
myModTimeRef :: IORef EpochTime
myModTimeRef = unsafePerformIO (getProgModTime >>= newIORef)

-- FIXME: doesn't get directory
myProgPath :: IO FilePath
myProgPath = getProgName

getProgModTime :: IO EpochTime
getProgModTime = liftM modificationTime (myProgPath >>= getFileStatus)

needsRestart :: IO Bool
needsRestart = liftM2 (/=) (readIORef myModTimeRef) getProgModTime

exitIfModified :: IO ()
exitIfModified = 
    do restart <- needsRestart
       when restart $ exitWith ExitSuccess

restartIfModified :: IO ()
restartIfModified = 
    do restart <- needsRestart
       when restart $ do prog <- myProgPath
                         args <- getArgs
                         hPutStrLn stderr $ prog ++ " has been modified, restarting ..."
                         -- FIXME: setCurrentDirectory?
                         executeFile prog False args Nothing

-- Utilities for getting and caching read-only data from disk.
-- The data is reloaded when the file on disk has been modified.

data DataRef a = DataRef {
      dataFile :: FilePath,
      dataLoad :: FilePath -> IO a,
      dataValue :: MVar (ClockTime, a)
    }

newDataRef :: (FilePath -> IO a) -> FilePath -> IO (DataRef a)
newDataRef load file = 
    do t <- getModificationTime file
       x <- load file
       v <- newMVar (t,x)
       return $ DataRef { dataFile = file, dataLoad = load, dataValue = v }

getData :: DataRef a -> IO a
getData ref = 
    do t' <- getModificationTime (dataFile ref)
       (t,x) <- takeMVar (dataValue ref)
       x' <- if t' == t then return x else (dataLoad ref) (dataFile ref)
       putMVar (dataValue ref) (t',x')
       return x'

-- Logging

logError :: String -> IO ()
logError s = hPutStrLn stderr s

-- * General CGI Error exception mechanism

data CGIError = CGIError { cgiErrorCode :: Int, cgiErrorMessage :: String, cgiErrorText :: [String] }
                deriving Typeable

throwCGIError :: Int -> String -> [String] -> CGI a
throwCGIError c m t = throwCGI $ DynException $ toDyn $ CGIError c m t

handleCGIErrors :: CGI CGIResult -> CGI CGIResult
handleCGIErrors x = x `catchCGI` \e -> case e of
                                         DynException d -> case fromDynamic d of
                                                             Nothing -> throw e
                                                             Just (CGIError c m t) -> outputError c m t
                                         _ -> throw e
