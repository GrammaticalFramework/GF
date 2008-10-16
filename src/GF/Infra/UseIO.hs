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
import GF.Infra.Option
import Paths_gf(getDataDir)

import System.Directory
import System.FilePath
import System.IO
import System.IO.Error
import System.Environment
import System.Exit
import System.CPUTime
import Text.Printf
import Control.Monad
import Control.Exception(evaluate)
import qualified Data.ByteString.Char8 as BS

putShow' :: Show a => (c -> a) -> c -> IO ()
putShow' f = putStrLn . show . length . show . f

putIfVerb :: Options -> String -> IO ()
putIfVerb opts msg =
      when (verbAtLeast opts Verbose) $ putStrLn msg

putIfVerbW :: Options -> String -> IO ()
putIfVerbW opts msg =
      when (verbAtLeast opts Verbose) $ putStr (' ' : msg)

errOptIO :: Options -> a -> Err a -> IO a
errOptIO os e m = case m of
  Ok x  -> return x
  Bad k -> do  
    putIfVerb os k
    return e

readFileIf f = catch (readFile f) (\_ -> reportOn f) where
 reportOn f = do
   putStrLnFlush ("File " ++ f ++ " does not exist. Returned empty string")
   return ""

readFileIfStrict f = catch (BS.readFile f) (\_ -> reportOn f) where
 reportOn f = do
   putStrLnFlush ("File " ++ f ++ " does not exist. Returned empty string")
   return BS.empty

type FileName = String
type InitPath = String
type FullPath = String

getFilePath :: [FilePath] -> String -> IO (Maybe FilePath)
getFilePath ps file = getFilePathMsg ("file" +++ file +++ "not found\n") ps file

getFilePathMsg :: String -> [FilePath] -> String -> IO (Maybe FilePath)
getFilePathMsg msg paths file = get paths where
  get []     = putStrFlush msg >> return Nothing
  get (p:ps) = do
    let pfile = p </> file
    exist <- doesFileExist pfile
    if not exist
      then get ps
      else do pfile <- canonicalizePath pfile
              return (Just pfile)

readFileIfPath :: [FilePath] -> String -> IOE (FilePath,BS.ByteString)
readFileIfPath paths file = do
  mpfile <- ioeIO $ getFilePath paths file
  case mpfile of
    Just pfile -> do
      s <- ioeIO $ BS.readFile pfile
      return (dropFileName pfile,s)
    _ -> ioeErr $ Bad ("File " ++ file ++ " does not exist.")

doesFileExistPath :: [FilePath] -> String -> IOE Bool
doesFileExistPath paths file = do
  mpfile <- ioeIO $ getFilePathMsg "" paths file
  return $ maybe False (const True) mpfile

gfLibraryPath    = "GF_LIB_PATH"
gfGrammarPathVar = "GF_GRAMMAR_PATH"

getLibraryPath :: IO FilePath
getLibraryPath =
  catch
    (getEnv gfLibraryPath)
    (\ex -> getDataDir >>= \path -> return (path </> "lib"))

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

dieIOE :: IOE a -> IO a
dieIOE x = appIOE x >>= err die return

die :: String -> IO a
die s = do hPutStrLn stderr s
           exitFailure

putStrLnE :: String -> IOE ()
putStrLnE = ioeIO . putStrLnFlush 

putStrE :: String -> IOE ()
putStrE = ioeIO . putStrFlush 

putPointE :: Verbosity -> Options -> String -> IOE a -> IOE a
putPointE v opts msg act = do
  when (verbAtLeast opts v) $ ioeIO $ putStrFlush msg

  t1 <- ioeIO $ getCPUTime
  a <- act >>= ioeIO . evaluate
  t2 <- ioeIO $ getCPUTime

  if flag optShowCPUTime opts
      then do let msec = (t2 - t1) `div` 1000000000
              putStrLnE (printf " %5d msec" msec)
      else when (verbAtLeast opts v) $ putStrLnE ""

  return a


-- ((do {s <- readFile f; return (return s)}) ) 
readFileIOE :: FilePath -> IOE BS.ByteString
readFileIOE f = ioe $ catch (BS.readFile f >>= return . return)
                            (\e -> return (Bad (show e)))

-- | like readFileIOE but look also in the GF library if file not found
--
-- intended semantics: if file is not found, try @\$GF_LIB_PATH\/file@
-- (even if file is an absolute path, but this should always fail)
-- it returns not only contents of the file, but also the path used
readFileLibraryIOE :: String -> FilePath -> IOE (FilePath, BS.ByteString)
readFileLibraryIOE ini f = ioe $ do
  lp <- getLibraryPath
  tryRead ini $ \_ ->
    tryRead lp  $ \e ->
      return (Bad (show e))
  where
    tryRead path onError =
      catch (BS.readFile fpath >>= \s -> return (return (fpath,s)))
            onError
      where
        fpath = path </> f

-- | example
koeIOE :: IO ()
koeIOE = useIOE () $ do
  s  <- ioeIO  $ getLine
  s2 <- ioeErr $ mapM (!? 2) $ words s
  ioeIO $ putStrLn s2

