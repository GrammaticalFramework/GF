{-# LANGUAGE DeriveDataTypeable, CPP #-}
-- | CGI utility functions for output, error handling and logging
module CGIUtils (throwCGIError, handleCGIErrors,
                 stderrToFile,logError,
                 outputJSONP,outputEncodedJSONP,
                 outputPNG,outputBinary,outputBinary',
                 outputHTML,outputPlain,outputText) where

import Control.Exception(Exception(..),SomeException(..),throw)
import Data.Typeable(Typeable,cast)
import Prelude hiding (catch)
import System.IO(hPutStrLn,stderr)
#ifndef mingw32_HOST_OS
import System.Posix
#endif

import CGI(CGI,CGIResult,setHeader,output,outputFPS,outputError,
           getInput,catchCGI,throwCGI)

import Text.JSON
import qualified Codec.Binary.UTF8.String as UTF8 (encodeString)
import qualified Data.ByteString.Lazy as BS

-- * Logging

#ifndef mingw32_HOST_OS
logError :: String -> IO ()
logError s = hPutStrLn stderr s

stderrToFile :: FilePath -> IO ()
stderrToFile file =
    do let mode = ownerReadMode<>ownerWriteMode<>groupReadMode<>otherReadMode
           (<>) = unionFileModes
           flags = defaultFileFlags { append = True }
       fileFd <- openFd file WriteOnly (Just mode) flags
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
handleCGIErrors x =
    x `catchCGI` \e -> case fromException e of
                         Nothing -> throw e
                         Just (CGIError c m t) -> do setXO; outputError c m t

-- * General CGI and JSON stuff

outputJSONP :: JSON a => a -> CGI CGIResult
outputJSONP = outputEncodedJSONP . encode

outputEncodedJSONP :: String -> CGI CGIResult
outputEncodedJSONP json = 
    do mc <- getInput "jsonp"
       let (ty,str) = case mc of
                        Nothing -> ("json",json)
                        Just c  -> ("javascript",c ++ "(" ++ json ++ ")")
           ct = "application/"++ty++"; charset=utf-8"
       outputText ct str

outputPNG :: BS.ByteString -> CGI CGIResult
outputPNG = outputBinary' "image/png"

outputBinary :: BS.ByteString -> CGI CGIResult
outputBinary = outputBinary' "application/binary"

outputBinary' :: String -> BS.ByteString -> CGI CGIResult
outputBinary' ct x = do
       setHeader "Content-Type" ct
       setXO
       outputFPS x

outputHTML :: String -> CGI CGIResult
outputHTML = outputText "text/html; charset=utf-8"

outputPlain :: String -> CGI CGIResult
outputPlain = outputText "text/plain; charset=utf-8"

outputText ct = outputStrict ct . UTF8.encodeString

outputStrict :: String -> String -> CGI CGIResult
outputStrict ct x | x == x = do setHeader "Content-Type" ct
                                setXO
                                output x
                  | otherwise = fail "I am the pope."

setXO = setHeader "Access-Control-Allow-Origin" "*"
     -- https://developer.mozilla.org/en-US/docs/HTTP/Access_control_CORS
