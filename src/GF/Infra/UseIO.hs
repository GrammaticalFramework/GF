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

module GF.Infra.UseIO where

import GF.Data.Operations
import GF.System.Arch (prCPU)
import GF.Infra.Option
import GF.Today (libdir)

import System.Directory
import System.IO
import System.IO.Error
import System.Environment
import Control.Monad

#ifdef mingw32_HOST_OS
import System.Win32.DLL
import System.FilePath.Windows
import System.Directory
import Foreign.Ptr
#endif


putShow' :: Show a => (c -> a) -> c -> IO ()
putShow' f = putStrLn . show . length . show . f

putIfVerb :: Options -> String -> IO ()
putIfVerb opts msg =
      if oElem beVerbose opts
         then putStrLn msg
         else return ()

putIfVerbW :: Options -> String -> IO ()
putIfVerbW opts msg =
      if oElem beVerbose opts
         then putStr (' ' : msg)
         else return ()

-- | obsolete with IOE monad
errIO :: a -> Err a -> IO a
errIO = errOptIO noOptions

errOptIO :: Options -> a -> Err a -> IO a
errOptIO os e m = case m of
  Ok x  -> return x
  Bad k -> do  
    putIfVerb os k
    return e

prOptCPU :: Options -> Integer -> IO Integer
prOptCPU opts = if (oElem noCPU opts) then (const (return 0)) else prCPU

putCPU :: IO ()
putCPU = do 
  prCPU 0 
  return ()

putPoint :: Show a => Options -> String -> IO a -> IO a
putPoint = putPoint' id

putPoint' :: Show a => (c -> a) -> Options -> String -> IO c -> IO c
putPoint' f opts msg act = do
  let sil x = if oElem beSilent opts then return () else x
      ve  x = if oElem beVerbose opts then x else return ()
  ve $ putStrLn msg
  a <- act
  ve $ putShow' f a
  ve $ putCPU
  return a

readFileStrict :: String -> IO String
readFileStrict f = do
  s <- readFile f
  return $ seq (length s) ()
  return s

readFileIf = readFileIfs readFile
readFileIfStrict  = readFileIfs readFileStrict

readFileIfs rf f = catch (rf f) (\_ -> reportOn f) where
 reportOn f = do
   putStrLnFlush ("File " ++ f ++ " does not exist. Returned empty string")
   return ""

type FileName = String
type InitPath = String
type FullPath = String

getFilePath :: [FilePath] -> String -> IO (Maybe FilePath)
getFilePath ps file = do
  getFilePathMsg ("file" +++ file +++ "not found\n") ps file

getFilePathMsg :: String -> [FilePath] -> String -> IO (Maybe FilePath)
getFilePathMsg msg paths file = get paths where
  get []     = putStrFlush msg >> return Nothing
  get (p:ps) = do
    let pfile = p </> file
    exist <- doesFileExist pfile
    if exist then return (Just pfile) else get ps
---               catch (readFileStrict pfile >> return (Just pfile)) (\_ -> get ps)

readFileIfPath :: [FilePath] -> String -> IOE (FilePath,String)
readFileIfPath paths file = do
  mpfile <- ioeIO $ getFilePath paths file
  case mpfile of
    Just pfile -> do
      s <- ioeIO $ readFileStrict pfile
      return (dropFileName pfile,s)
    _ -> ioeErr $ Bad ("File " ++ file ++ " does not exist.")

doesFileExistPath :: [FilePath] -> String -> IOE Bool
doesFileExistPath paths file = do
  mpfile <- ioeIO $ getFilePathMsg "" paths file
  return $ maybe False (const True) mpfile

gfLibraryPath    = "GF_LIB_PATH"

-- | environment variable for grammar search path
gfGrammarPathVar = "GF_GRAMMAR_PATH"

getLibraryPath :: IO FilePath
getLibraryPath =
  catch
    (getEnv gfLibraryPath)
#ifdef mingw32_HOST_OS
    (\_ -> do exepath <- getModuleFileName nullPtr
              let (path,_) = splitFileName exepath
              canonicalizePath (combine path "../lib"))
#else
    (const (return libdir))
#endif

-- | extends the search path with the
-- 'gfLibraryPath' and 'gfGrammarPathVar'
-- environment variables. Returns only existing paths.
extendPathEnv :: [FilePath] -> IO [FilePath]
extendPathEnv ps = do
  b <- getLibraryPath                             -- e.g. GF_LIB_PATH
  s <- catch (getEnv gfGrammarPathVar) (const (return ""))     -- e.g. GF_GRAMMAR_PATH
  let ss = ps ++ splitSearchPath s
  liftM concat $ mapM allSubdirs $ ss ++ [b </> s | s <- ss ++ ["prelude"]]
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
                  else return []

getSubdirs :: FilePath -> IO [FilePath]
getSubdirs dir = do
  fs  <- catch (getDirectoryContents dir) (const $ return [])
  foldM (\fs f -> do let fpath = dir </> f
                     p <- getPermissions fpath
                     if searchable p && not (take 1 f==".")
                       then return (fpath:fs)
                       else return        fs ) [] fs

justModuleName :: FilePath -> String
justModuleName = dropExtension . takeFileName

splitInModuleSearchPath :: String -> [FilePath]
splitInModuleSearchPath s = case break isPathSep s of
  (f,_:cs) -> f : splitInModuleSearchPath cs
  (f,_)    -> [f]
  where
    isPathSep :: Char -> Bool
    isPathSep c = c == ':' || c == ';'

--

getLineWell :: IO String -> IO String
getLineWell ios = 
  catch getLine (\e -> if (isEOFError e) then ios else ioError e)

putStrFlush :: String -> IO ()
putStrFlush s = putStr s >> hFlush stdout

putStrLnFlush :: String -> IO ()
putStrLnFlush s = putStrLn s >> hFlush stdout

-- * a generic quiz session

type QuestionsAndAnswers = [(String, String -> (Integer,String))]

teachDialogue :: QuestionsAndAnswers -> String -> IO ()
teachDialogue qas welc = do
  putStrLn $ welc ++++ genericTeachWelcome
  teach (0,0) qas
 where 
    teach _ [] = do putStrLn "Sorry, ran out of problems"
    teach (score,total) ((question,grade):quas) = do
      putStr ("\n" ++ question ++ "\n> ") 
      answer <- getLine
      if (answer == ".") then return () else do
        let (result, feedback) = grade answer
            score' = score + result 
            total' = total + 1
        putStr (feedback ++++ "Score" +++ show score' ++ "/" ++ show total')
        if (total' > 9 && fromInteger score' / fromInteger total' >= 0.75)
           then do putStrLn "\nCongratulations - you passed!"
           else teach (score',total') quas

    genericTeachWelcome = 
      "The quiz is over when you have done at least 10 examples" ++++
      "with at least 75 % success." +++++
      "You can interrupt the quiz by entering a line consisting of a dot ('.').\n"


-- * IO monad with error; adapted from state monad

newtype IOE a = IOE (IO (Err a))

appIOE :: IOE a -> IO (Err a)
appIOE (IOE iea) = iea

ioe :: IO (Err a) -> IOE a
ioe = IOE

ioeIO :: IO a -> IOE a
ioeIO io = ioe (io >>= return . return)

ioeErr :: Err a -> IOE a
ioeErr = ioe . return 

instance  Monad IOE where
  return a    = ioe (return (return a))
  IOE c >>= f = IOE $ do 
                  x <- c          -- Err a
                  appIOE $ err ioeBad f x         -- f :: a -> IOE a

ioeBad :: String -> IOE a
ioeBad = ioe . return . Bad

useIOE :: a -> IOE a -> IO a
useIOE a ioe = appIOE ioe >>= err (\s -> putStrLn s >> return a) return 

foldIOE :: (a -> b -> IOE a) -> a -> [b] -> IOE (a, Maybe String)
foldIOE f s xs = case xs of
  [] -> return (s,Nothing)
  x:xx -> do
    ev <- ioeIO $ appIOE (f s x) 
    case ev of 
      Ok v  -> foldIOE f v xx
      Bad m -> return $ (s, Just m)

putStrLnE :: String -> IOE ()
putStrLnE = ioeIO . putStrLnFlush 

putStrE :: String -> IOE ()
putStrE = ioeIO . putStrFlush 

-- this is more verbose
putPointE :: Options -> String -> IOE a -> IOE a
putPointE = putPointEgen (oElem beSilent)

-- this is less verbose
putPointEsil :: Options -> String -> IOE a -> IOE a
putPointEsil = putPointEgen (not . oElem beVerbose)

putPointEgen :: (Options -> Bool) -> Options -> String -> IOE a -> IOE a
putPointEgen cond opts msg act = do
  let ve x = if cond opts then return () else x
  ve $ ioeIO $ putStrFlush msg
  a <- act
---  ve $ ioeIO $ putShow' id a --- replace by a statistics command
  ve $ ioeIO $ putStrFlush " "
  ve $ ioeIO $ putCPU
  return a
{-
putPointE :: Options -> String -> IOE a -> IOE a
putPointE opts msg act = do
  let ve x = if oElem beVerbose opts then x else return ()
  ve $ putStrE msg
  a <- act
---  ve $ ioeIO $ putShow' id a --- replace by a statistics command
  ve $ ioeIO $ putCPU
  return a
-}

-- | forces verbosity
putPointEVerb :: Options -> String -> IOE a -> IOE a
putPointEVerb opts = putPointE (addOption beVerbose opts)

-- ((do {s <- readFile f; return (return s)}) ) 
readFileIOE :: FilePath -> IOE (String)
readFileIOE f = ioe $ catch (readFileStrict f >>= return . return)
                            (\e -> return (Bad (show e)))

-- | like readFileIOE but look also in the GF library if file not found
--
-- intended semantics: if file is not found, try @\$GF_LIB_PATH\/file@
-- (even if file is an absolute path, but this should always fail)
-- it returns not only contents of the file, but also the path used
readFileLibraryIOE :: String -> FilePath -> IOE (FilePath, String)
readFileLibraryIOE ini f = ioe $ do
  lp <- getLibraryPath
  tryRead ini $ \_ ->
    tryRead lp  $ \e ->
      return (Bad (show e))
  where
    tryRead path onError =
      catch (readFileStrict fpath >>= \s -> return (return (fpath,s)))
            onError
      where
        fpath = path </> f

-- | example
koeIOE :: IO ()
koeIOE = useIOE () $ do
  s  <- ioeIO  $ getLine
  s2 <- ioeErr $ mapM (!? 2) $ words s
  ioeIO $ putStrLn s2

