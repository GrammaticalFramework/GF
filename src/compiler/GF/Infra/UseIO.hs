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

module GF.Infra.UseIO(-- ** Files and IO
                      module GF.Infra.UseIO,
                      -- *** Reused
                      MonadIO(..),liftErr) where

import Prelude hiding (catch)

import GF.Data.Operations
import GF.Infra.Option
import GF.System.Catch
import Paths_gf(getDataDir)

import GF.System.Directory
import System.FilePath
import System.IO
import System.IO.Error(isUserError,ioeGetErrorString)
import System.Environment
import System.Exit
import System.CPUTime
--import System.Cmd
import Text.Printf
--import Control.Applicative(Applicative(..))
import Control.Monad(when,liftM,foldM)
import Control.Monad.Trans(MonadIO(..))
import Control.Monad.State(StateT,lift)
import Control.Exception(evaluate)
import Data.List (nub)

--putIfVerb :: MonadIO io => Options -> String -> io ()
putIfVerb opts msg = when (verbAtLeast opts Verbose) $ putStrLnE msg

-- *** GF files path and library path manipulation

type FileName = String
type InitPath = String -- ^ the directory portion of a pathname
type FullPath = String

gfLibraryPath    = "GF_LIB_PATH"
gfGrammarPathVar = "GF_GRAMMAR_PATH"

getLibraryDirectory :: MonadIO io => Options -> io [FilePath]
getLibraryDirectory opts =
  case flag optGFLibPath opts of
    Just path -> return path
    Nothing   -> liftM splitSearchPath $ liftIO (catch (getEnv gfLibraryPath)
                                                (\ex -> fmap (</> "lib") getDataDir))

getGrammarPath :: MonadIO io => [FilePath] -> io [FilePath]
getGrammarPath lib_dirs = liftIO $ do
  catch (fmap splitSearchPath $ getEnv gfGrammarPathVar) 
        (\_ -> return $ concat [[lib_dir </> "alltenses", lib_dir </> "prelude"]
                               | lib_dir <- lib_dirs ])     -- e.g. GF_GRAMMAR_PATH

-- | extends the search path with the
-- 'gfLibraryPath' and 'gfGrammarPathVar'
-- environment variables. Returns only existing paths.
extendPathEnv :: MonadIO io => Options -> io [FilePath]
extendPathEnv opts = liftIO $ do
  let opt_path = nub $ flag optLibraryPath opts         -- e.g. paths given as options
  lib_dirs <- getLibraryDirectory opts                  -- e.g. GF_LIB_PATH
  grm_path <- getGrammarPath lib_dirs                   -- e.g. GF_GRAMMAR_PATH
  let paths = opt_path ++ lib_dirs ++ grm_path
  when (verbAtLeast opts Verbose) $ putStrLn ("extendPathEnv: opt_path is "++ show opt_path)
  when (verbAtLeast opts Verbose) $ putStrLn ("extendPathEnv: lib_dirs is "++ show lib_dirs)
  when (verbAtLeast opts Verbose) $ putStrLn ("extendPathEnv: grm_path is "++ show grm_path)
  ps <- liftM (nub . concat) $ mapM allSubdirs (nub paths)
  mapM canonicalizePath ps
  where
    allSubdirs :: FilePath -> IO [FilePath]
    allSubdirs [] = return [[]]
    allSubdirs p = case last p of
      '*' -> do let path = init p
                fs <- getSubdirs path
                let starpaths = [path </> f | f <- fs]
                when (verbAtLeast opts Verbose) $ putStrLn ("extendPathEnv: allSubdirs: * found "++show starpaths)
                return starpaths
      _   -> do exists <- doesDirectoryExist p
                if exists
                  then do
                       when (verbAtLeast opts Verbose) $ putStrLn ("extendPathEnv: allSubdirs: found path "++show p)
                       return [p]
                  else do when (verbAtLeast opts Verbose) $ putStrLn ("extendPathEnv: allSubdirs: ignore path "++ show p)
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

isGF,isGFO :: FilePath -> Bool
isGF  = (== ".gf")  . takeExtensions
isGFO = (== ".gfo") . takeExtensions

gfFile,gfoFile :: FilePath -> FilePath
gfFile  f = addExtension f "gf"
gfoFile f = addExtension f "gfo"

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

-- *** Error handling in the IO monad

-- | Was: @newtype IOE a = IOE { appIOE :: IO (Err a) }@
type IOE a = IO a

--ioe :: IO (Err a) -> IOE a
--ioe io = err fail return =<< io

-- | Catch exceptions caused by calls to 'raise' or 'fail' in the 'IO' monad.
-- To catch all 'IO' exceptions, use 'try' instead.
tryIOE :: IOE a -> IO (Err a)
tryIOE ioe = handle (fmap Ok ioe) (return . Bad)

--runIOE :: IOE a -> IO a
--runIOE = id

-- instance MonadIO IOE where liftIO io = ioe (io >>= return . return)

-- | Make raise and handle mimic behaviour of the old IOE monad
instance ErrorMonad IO where
  raise = fail
  handle m h = catch m $ \ e -> if isUserError e
                                then h (ioeGetErrorString e)
                                else ioError e
{-
instance Functor IOE where fmap = liftM

instance Applicative IOE where
  pure = return
  (<*>) = ap

instance  Monad IOE where
  return a    = ioe (return (return a))
  IOE c >>= f = IOE $ do 
                  x <- c          -- Err a
                  appIOE $ err raise f x         -- f :: a -> IOE a
  fail = raise
-}

-- | Print the error message and return a default value if the IO operation 'fail's
useIOE :: a -> IOE a -> IO a
useIOE a ioe = handle ioe (\s -> putStrLn s >> return a)

maybeIO io = either (const Nothing) Just `fmap` liftIO (try io)
{-
--foldIOE :: (a -> b -> IOE a) -> a -> [b] -> IOE (a, Maybe String)
foldIOE f s xs = case xs of
  [] -> return (s,Nothing)
  x:xx -> do
    ev <- liftIO $ appIOE (f s x) 
    case ev of 
      Ok v  -> foldIOE f v xx
      Bad m -> return $ (s, Just m)
-}
die :: String -> IO a
die s = do hPutStrLn stderr s
           exitFailure

-- *** Diagnostic output

class Monad m => Output m where
  ePutStr, ePutStrLn, putStrE, putStrLnE :: String -> m ()

instance Output IO where
  ePutStr   s = hPutStr stderr s `catch` oops
    where oops _ = return () -- prevent crash on character encoding problem
  ePutStrLn s = hPutStrLn stderr s `catch` oops
    where oops _ = ePutStrLn "" -- prevent crash on character encoding problem
  putStrLnE s = putStrLn s >> hFlush stdout
  putStrE   s = putStr s >> hFlush stdout
{-
instance Output IOE where
  ePutStr   = liftIO . ePutStr
  ePutStrLn = liftIO . ePutStrLn
  putStrLnE = liftIO . putStrLnE
  putStrE   = liftIO . putStrE
-}

instance Output m => Output (StateT s m) where
  ePutStr = lift . ePutStr
  ePutStrLn = lift . ePutStrLn
  putStrE = lift . putStrE
  putStrLnE = lift . putStrLnE

--putPointE :: Verbosity -> Options -> String -> IO a -> IO a
putPointE v opts msg act = do
  when (verbAtLeast opts v) $ putStrE msg

  (t,a) <- timeIt act

  if flag optShowCPUTime opts
      then do let msec = t `div` 1000000000
              putStrLnE (printf " %5d msec" msec)
      else when (verbAtLeast opts v) $ putStrLnE ""

  return a

-- | Because GHC adds the confusing text "user error" for failures caused by
-- calls to 'fail'.
ioErrorText e = if isUserError e
                then ioeGetErrorString e
                else show e

-- *** Timing

timeIt act =
  do t1 <- liftIO $ getCPUTime
     a <- liftIO . evaluate =<< act
     t2 <- liftIO $ getCPUTime
     return (t2-t1,a)

-- *** File IO

writeUTF8File :: FilePath -> String -> IO ()
writeUTF8File fpath content =
  withFile fpath WriteMode $ \ h -> do hSetEncoding h utf8
                                       hPutStr h content

readBinaryFile path = hGetContents =<< openBinaryFile path ReadMode
writeBinaryFile path s = withBinaryFile path WriteMode (flip hPutStr s)
