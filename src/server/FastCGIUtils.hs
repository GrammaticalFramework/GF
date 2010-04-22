{-# LANGUAGE DeriveDataTypeable, CPP #-}
module FastCGIUtils (initFastCGI, loopFastCGI,
                     throwCGIError, handleCGIErrors,
                     stderrToFile,
                     outputJSONP,
                     outputPNG,
                     outputHTML,
                     splitBy) where

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
#ifndef mingw32_HOST_OS
import System.Posix
#endif
import System.Time

import Network.FastCGI

import Text.JSON
import qualified Codec.Binary.UTF8.String as UTF8 (encodeString, decodeString)
import qualified Data.ByteString.Lazy as BS


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

-- Logging

#ifndef mingw32_HOST_OS
logError :: String -> IO ()
logError s = hPutStrLn stderr s

stderrToFile :: FilePath -> IO ()
stderrToFile file =
    do let mode = ownerReadMode `unionFileModes` ownerWriteMode `unionFileModes` groupReadMode `unionFileModes` otherReadMode
       fileFd <- openFd file WriteOnly (Just mode) (defaultFileFlags { append = True })
       dupTo fileFd stdError
       return ()
#else
logError :: String -> IO ()
logError s = return ()

stderrToFile :: FilePath -> IO ()
stderrToFile s = return ()
#endif

-- * General CGI Error exception mechanism

data CGIError = CGIError { cgiErrorCode :: Int, cgiErrorMessage :: String, cgiErrorText :: [String] }
                deriving (Show,Typeable)

instance Exception CGIError where
  toException e = SomeException e
  fromException (SomeException e) = cast e

throwCGIError :: Int -> String -> [String] -> CGI a
throwCGIError c m t = throwCGI $ toException $ CGIError c m t

handleCGIErrors :: CGI CGIResult -> CGI CGIResult
handleCGIErrors x = x `catchCGI` \e -> case fromException e of
                                         Nothing -> throw e
                                         Just (CGIError c m t) -> outputError c m t

-- * General CGI and JSON stuff

outputJSONP :: JSON a => a -> CGI CGIResult
outputJSONP x = 
    do mc <- getInput "jsonp"
       let str = case mc of
                   Nothing -> encode x
                   Just c  -> c ++ "(" ++ encode x ++ ")"
       setHeader "Content-Type" "text/json; charset=utf-8"
       outputStrict $ UTF8.encodeString str

outputPNG :: BS.ByteString -> CGI CGIResult
outputPNG x = do
       setHeader "Content-Type" "image/png"
       outputFPS x

outputHTML :: String -> CGI CGIResult
outputHTML x = do
       setHeader "Content-Type" "text/html"
       outputStrict x

outputStrict :: String -> CGI CGIResult
outputStrict x | x == x = output x
               | otherwise = fail "I am the pope."

-- * General utilities

splitBy :: (a -> Bool) -> [a] -> [[a]]
splitBy _ [] = [[]]
splitBy f list = case break f list of
                   (first,[]) -> [first]
                   (first,_:rest) -> first : splitBy f rest
