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

readFileIf :: String -> IO String
readFileIf f = catch (readFile f) (\_ -> reportOn f) where
 reportOn f = do
   putStrLnFlush ("File " ++ f ++ " does not exist. Returned empty string")
   return ""

type FileName = String
type InitPath = String
type FullPath = String

isPathSep :: Char -> Bool
isPathSep c = c == ':' || c == ';'

isSep :: Char -> Bool
isSep c = c == '/' || c == '\\'

getFilePath :: [FilePath] -> String -> IO (Maybe FilePath)
getFilePath ps file = getFilePathMsg ("file" +++ file +++ "not found\n") ps file

getFilePathMsg :: String -> [FilePath] -> String -> IO (Maybe FilePath)
getFilePathMsg msg paths file = get paths where
  get []     = putStrFlush msg >> return Nothing
  get (p:ps) = let pfile = prefixPathName p file in
               catch (readFile pfile >> return (Just pfile)) (\_ -> get ps)

readFileIfPath :: [FilePath] -> String -> IOE (FilePath,String)
readFileIfPath paths file = do
  mpfile <- ioeIO $ getFilePath paths file
  case mpfile of
    Just pfile -> do
      s <- ioeIO $ readFile pfile
      return (justInitPath pfile,s)
    _ -> ioeErr $ Bad ("File " ++ file ++ " does not exist.")

doesFileExistPath :: [FilePath] -> String -> IOE Bool
doesFileExistPath paths file = do
  mpfile <- ioeIO $ getFilePathMsg "" paths file
  return $ maybe False (const True) mpfile

-- | first var is lib prefix, second is like class path
-- | path in environment variable has lower priority
extendPathEnv :: String -> String -> [FilePath] -> IO [FilePath]
extendPathEnv lib var ps = do
  b <- catch (getEnv lib) (const (return libdir)) -- e.g. GF_LIB_PATH
  s <- catch (getEnv var) (const (return ""))     -- e.g. GF_GRAMMAR_PATH
  let fs = pFilePaths s
  let ss = ps ++ fs
  liftM concat $ mapM allSubdirs $ ss ++ [b ++ "/" ++ s | s <- ss]

pFilePaths :: String -> [FilePath]
pFilePaths s = case break isPathSep s of
  (f,_:cs) -> f : pFilePaths cs
  (f,_)    -> [f]

getFilePaths :: String -> IO [FilePath]
getFilePaths s = do
  let ps = pFilePaths s
  liftM concat $ mapM allSubdirs ps

getSubdirs :: FilePath -> IO [FilePath]
getSubdirs p = do
  fs  <- catch (getDirectoryContents p) (const $ return [])
  fps <- mapM getPermissions (map (prefixPathName p) fs)
  let ds = [f | (f,p) <- zip fs fps, searchable p, not (take 1 f==".")]
  return ds

allSubdirs :: FilePath -> IO [FilePath]
allSubdirs [] = return [[]]
allSubdirs p = case last p of
  '*' -> do
    fs <- getSubdirs (init p)
    return [prefixPathName (init p) f | f <- fs]
  _ -> return [p]

prefixPathName :: String -> FilePath -> FilePath
prefixPathName p f = case f of
    c:_ | isSep c -> f  -- do not prefix [Unix style] absolute paths
    _ -> case p of
        "" -> f
        _  -> p ++ "/" ++ f -- note: / actually works on windows

justInitPath :: FilePath -> FilePath
justInitPath = reverse . drop 1 . dropWhile (not . isSep) . reverse

nameAndSuffix :: FilePath -> (String,String)
nameAndSuffix file = case span (/='.') (reverse file) of
  (_,[])      -> (file,[])
  (xet,deman) -> if any isSep xet 
                   then (file,[]) -- cover cases like "foo.bar/baz"
                   else (reverse $ drop 1 deman,reverse xet)

unsuffixFile, fileBody :: FilePath -> String
unsuffixFile = fst . nameAndSuffix
fileBody = unsuffixFile

fileSuffix :: FilePath -> String
fileSuffix = snd . nameAndSuffix

justFileName :: FilePath -> String
justFileName = reverse . takeWhile (not . isSep) . reverse

suffixFile :: String -> FilePath -> FilePath
suffixFile suff file = file ++ "." ++ suff

justModuleName :: FilePath -> String
justModuleName = fileBody . justFileName

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

gfLibraryPath = "GF_LIB_PATH"

-- ((do {s <- readFile f; return (return s)}) ) 
readFileIOE :: FilePath -> IOE (String)
readFileIOE f = ioe $ catch (readFile f >>= return . return)
                      (\_ -> return (Bad (reportOn f))) where
  reportOn f = "File " ++ f ++ " not found."

-- | like readFileIOE but look also in the GF library if file not found
--
-- intended semantics: if file is not found, try @\$GF_LIB_PATH\/file@
-- (even if file is an absolute path, but this should always fail)
-- it returns not only contents of the file, but also the path used
--
-- FIXME: unix-specific, \/ is \\ on Windows
readFileLibraryIOE :: String -> FilePath -> IOE (FilePath, String)
readFileLibraryIOE ini f = 
	ioe $ catch ((do {s <- readFile initPath; return (return (initPath,s))}))
	 (\_ -> tryLibrary ini f) where
		tryLibrary :: String -> FilePath -> IO (Err (FilePath, String))
		tryLibrary ini f = 
			catch (do {
				lp <- getLibPath; 
				s <- readFile (lp ++ f);
				return (return (lp ++ f, s))
			}) (\_ -> return (Bad (reportOn f)))
		initPath = addInitFilePath ini f
		getLibPath :: IO String
		getLibPath = do {
			lp <- catch (getEnv gfLibraryPath) (const (return libdir)) ;
			return (if isSep (last lp) then lp else lp ++ ['/']);
		} 
		reportOn f = "File " ++ f ++ " not found."
		libPath ini f = f
		addInitFilePath ini file = case file of
			c:_ | isSep c -> file        -- absolute path name
			_     -> ini ++ file -- relative path name


-- | example
koeIOE :: IO ()
koeIOE = useIOE () $ do
  s  <- ioeIO  $ getLine
  s2 <- ioeErr $ mapM (!? 2) $ words s
  ioeIO $ putStrLn s2

