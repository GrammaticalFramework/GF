{-# OPTIONS -cpp #-}
----------------------------------------------------------------------
-- |
-- Module      : UseIO
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/08/08 09:01:25 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.17 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Infra.UseIO(module GF.Infra.UseIO,MonadIO(..),liftErr) where

import Prelude hiding (catch)

import GF.Data.Operations
import GF.Infra.Option
import GF.System.Catch
import Paths_gf(getDataDir)

import System.Directory
import System.FilePath
import System.IO
import System.IO.Error(isUserError,ioeGetErrorString)
import System.Environment
import System.Exit
import System.CPUTime
--import System.Cmd
import Text.Printf
import Control.Monad
import Control.Monad.Trans(MonadIO(..))
import Control.Exception(evaluate)

--putShow' :: Show a => (c -> a) -> c -> IO ()
--putShow' f = putStrLn . show . length . show . f

putIfVerb :: MonadIO io => Options -> String -> io ()
putIfVerb opts msg =
      when (verbAtLeast opts Verbose) $ liftIO $ putStrLn msg

putIfVerbW :: MonadIO io => Options -> String -> io ()
putIfVerbW opts msg =
      when (verbAtLeast opts Verbose) $ liftIO $ putStr (' ' : msg)
{-
errOptIO :: Options -> a -> Err a -> IO a
errOptIO os e m = case m of
  Ok x  -> return x
  Bad k -> do  
    putIfVerb os k
    return e
-}
type FileName = String
type InitPath = String -- ^ the directory portion of a pathname
type FullPath = String

gfLibraryPath    = "GF_LIB_PATH"
gfGrammarPathVar = "GF_GRAMMAR_PATH"

getLibraryDirectory :: MonadIO io => Options -> io FilePath
getLibraryDirectory opts =
  case flag optGFLibPath opts of
    Just path -> return path
    Nothing   -> liftIO $ catch (getEnv gfLibraryPath)
                                (\ex -> fmap (</> "lib") getDataDir)

getGrammarPath :: FilePath -> IO [FilePath]
getGrammarPath lib_dir = do
  catch (fmap splitSearchPath $ getEnv gfGrammarPathVar) 
        (\_ -> return [lib_dir </> "alltenses",lib_dir </> "prelude"])     -- e.g. GF_GRAMMAR_PATH

-- | extends the search path with the
-- 'gfLibraryPath' and 'gfGrammarPathVar'
-- environment variables. Returns only existing paths.
extendPathEnv :: MonadIO io => Options -> io [FilePath]
extendPathEnv opts = liftIO $ do
  let opt_path = flag optLibraryPath opts         -- e.g. paths given as options
  lib_dir  <- getLibraryDirectory opts                  -- e.g. GF_LIB_PATH
  grm_path <- getGrammarPath lib_dir                   -- e.g. GF_GRAMMAR_PATH
  let paths = opt_path ++ [lib_dir] ++ grm_path
  ps <- liftM concat $ mapM allSubdirs paths
  mapM canonicalizePath ps
  where
    allSubdirs :: FilePath -> IO [FilePath]
    allSubdirs [] = return [[]]
    allSubdirs p = case last p of
      '*' -> do let path = init p
                fs <- getSubdirs path
                return [path </> f | f <- fs]
      _   -> do exists <- doesDirectoryExist p
                if exists
                  then return [p]
                  else do when (verbAtLeast opts Verbose) $ putStrLn ("ignore path "++p)
                          return []

getSubdirs :: FilePath -> IO [FilePath]
getSubdirs dir = do
  fs  <- catch (getDirectoryContents dir) (const $ return [])
  foldM (\fs f -> do let fpath = dir </> f
                     p <- getPermissions fpath
                     if searchable p && not (take 1 f==".")
                       then return (fpath:fs)
                       else return        fs ) [] fs

--------------------------------------------------------------------------------
justModuleName :: FilePath -> String
justModuleName = dropExtension . takeFileName

isGFO :: FilePath -> Bool
isGFO = (== ".gfo") . takeExtensions

gfoFile :: FilePath -> FilePath
gfoFile f = addExtension f "gfo"

gfFile :: FilePath -> FilePath
gfFile f = addExtension f "gf"

gf2gfo :: Options -> FilePath -> FilePath
gf2gfo = gf2gfo' . flag optGFODir

gf2gfo' gfoDir file = maybe (gfoFile (dropExtension file))
                            (\dir -> dir </> gfoFile (takeBaseName file))
                            gfoDir
--------------------------------------------------------------------------------
splitInModuleSearchPath :: String -> [FilePath]
splitInModuleSearchPath s = case break isPathSep s of
  (f,_:cs) -> f : splitInModuleSearchPath cs
  (f,_)    -> [f]
  where
    isPathSep :: Char -> Bool
    isPathSep c = c == ':' || c == ';'

--

-- * IO monad with error; adapted from state monad

newtype IOE a = IOE { appIOE :: IO (Err a) }

ioe :: IO (Err a) -> IOE a
ioe = IOE

instance MonadIO IOE where liftIO io = ioe (io >>= return . return)

instance ErrorMonad IOE where
  raise = ioe . return . Bad
  handle m h = ioe $ err (appIOE . h) (return . Ok) =<< appIOE m

instance Functor IOE where fmap = liftM

instance  Monad IOE where
  return a    = ioe (return (return a))
  IOE c >>= f = IOE $ do 
                  x <- c          -- Err a
                  appIOE $ err raise f x         -- f :: a -> IOE a
  fail = raise

maybeIO io = either (const Nothing) Just `fmap` liftIO (try io)

useIOE :: a -> IOE a -> IO a
useIOE a ioe = appIOE ioe >>= err (\s -> putStrLn s >> return a) return 

--foldIOE :: (a -> b -> IOE a) -> a -> [b] -> IOE (a, Maybe String)
foldIOE f s xs = case xs of
  [] -> return (s,Nothing)
  x:xx -> do
    ev <- liftIO $ appIOE (f s x) 
    case ev of 
      Ok v  -> foldIOE f v xx
      Bad m -> return $ (s, Just m)

die :: String -> IO a
die s = do hPutStrLn stderr s
           exitFailure

ePutStr, ePutStrLn, putStrE, putStrLnE :: MonadIO m => String -> m ()
ePutStr s = liftIO $ hPutStr stderr s
ePutStrLn s = liftIO $ hPutStrLn stderr s
putStrLnE s = liftIO $ putStrLn s >> hFlush stdout
putStrE s = liftIO $ putStr s >> hFlush stdout

putPointE :: MonadIO m => Verbosity -> Options -> String -> m a -> m a
putPointE v opts msg act = do
  when (verbAtLeast opts v) $ putStrE msg

  t1 <- liftIO $ getCPUTime
  a <- act >>= liftIO . evaluate
  t2 <- liftIO $ getCPUTime

  if flag optShowCPUTime opts
      then do let msec = (t2 - t1) `div` 1000000000
              putStrLnE (printf " %5d msec" msec)
      else when (verbAtLeast opts v) $ putStrLnE ""

  return a

-- * File IO

writeUTF8File :: FilePath -> String -> IO ()
writeUTF8File fpath content =
  withFile fpath WriteMode $ \ h -> do hSetEncoding h utf8
                                       hPutStr h content

readBinaryFile path = hGetContents =<< openBinaryFile path ReadMode
writeBinaryFile path s = withBinaryFile path WriteMode (flip hPutStr s)

-- | Because GHC adds the confusing text "user error" for failures caused by
-- calls to fail.
ioErrorText e = if isUserError e
                then ioeGetErrorString e
                else show e
