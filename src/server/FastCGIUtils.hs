{-# LANGUAGE CPP #-}
module FastCGIUtils(initFastCGI,loopFastCGI) where

import Control.Concurrent(ThreadId,myThreadId)
import Control.Exception(ErrorCall(..),throw,throwTo,catch)
import Control.Monad(when,liftM,liftM2)
import Data.IORef(IORef,newIORef,readIORef,writeIORef)
import Prelude hiding (catch)
import System.Environment(getArgs,getProgName)
import System.Exit(ExitCode(..),exitWith)
import System.IO(hPutStrLn,stderr)
import System.IO.Unsafe(unsafePerformIO)
#ifndef mingw32_HOST_OS
import System.Posix
#endif

import Network.FastCGI

import CGIUtils(logError)

 -- There are used in MorphoService.hs, but not in PGFService.hs
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

#ifndef mingw32_HOST_OS
installSignalHandlers :: IO ()
installSignalHandlers =
    do t <- myThreadId
       installHandler sigUSR1 (Catch gracefulExit) Nothing
       installHandler sigTERM (Catch gracelessExit) Nothing
       installHandler sigPIPE (Catch (requestAborted t)) Nothing
       return ()

requestAborted :: ThreadId -> IO ()
requestAborted t = throwTo t (ErrorCall "**aborted**")
  
gracelessExit :: IO ()
gracelessExit = do logError "Graceless exit"
                   exitWith ExitSuccess

gracefulExit :: IO ()
gracefulExit = 
    do logError "Graceful exit"
       writeIORef shouldExit True
#else
installSignalHandlers :: IO ()
installSignalHandlers = return ()
#endif

exitIfToldTo :: IO ()
exitIfToldTo = 
    do b <- readIORef shouldExit
       when b $ do logError "Exiting..."
                   exitWith ExitSuccess

{-# NOINLINE shouldExit #-}
shouldExit :: IORef Bool
shouldExit = unsafePerformIO $ newIORef False

catchAborted ::  IO a -> IO a -> IO a
catchAborted x y = x `catch` \e -> case e of
                                     ErrorCall "**aborted**" -> y
                                     _ -> throw e

-- Restart handling for FastCGI programs.

#ifndef mingw32_HOST_OS
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

#else
restartIfModified :: IO ()
restartIfModified = return ()
#endif

