import System.FilePath ((</>),(<.>))
import Data.List (find,intersect,isPrefixOf)
import Data.Maybe (fromJust,isJust,catMaybes)
import System.Environment (getArgs,lookupEnv)
import System.Exit (ExitCode(..),die)
import System.Process (rawSystem,readProcess)
import System.Directory (createDirectoryIfMissing,copyFile,getDirectoryContents,removeDirectoryRecursive)
import System.IO.Error (catchIOError)
import Control.Monad (unless,when)

main :: IO ()
main = do
  aargs <- getArgs
  case aargs of
    [] -> putStrLn $ "Must specify command, one of: " ++ unwords commands
    a:_ | a `notElem` commands -> putStrLn $ "Unknown command: " ++ a ++ " (valid commands: " ++ unwords commands ++ ")"
    "build":args -> buildRGL args
    "copy":args -> copyRGL args
    "install":args -> buildRGL args >> copyRGL args
    "clean":_ -> clean
  where
    commands = ["build","copy","install","clean"]

-- | Build grammars into dist
buildRGL :: [String] -> IO ()
buildRGL args = do
  checkArgs args
  let cmds = getRGLCommands args
  let modes = getOptMode args
  info <- mkInfo
  mapM_ (\cmd -> cmdAction cmd modes args info) cmds

-- | Copy from dist to install location
copyRGL :: [String] -> IO ()
copyRGL args = do
  let modes = getOptMode args
  info <- mkInfo
  gf_lib_dir <- maybe (die errLocation) return (infoInstallDir info)
  copyAll "prelude" (infoBuildDir info </> "prelude") (gf_lib_dir </> "prelude")
  sequence_ [copyAll (show mode) (getRGLBuildDir info mode) (gf_lib_dir </> getRGLBuildSubDir mode)|mode<-modes]

-- | Error message when install location cannot be determined
errLocation :: String
errLocation = unlines $
  [ "Unable to determine where to install the RGL. Please do one of the following:"
  , " - Pass the " ++ install_prefix ++ "... flag to this script"
  , " - Set the GF_LIB_PATH environment variable"
  , " - Compile GF from the gf-core repository (must be in same directory as gf-rgl)"
  ]

-- | Copy all files between directories
copyAll :: String -> FilePath -> FilePath -> IO ()
copyAll msg from to = do
  putStrLn $ "Installing [" ++ msg ++ "] " ++ to
  createDirectoryIfMissing True to
  mapM_ (\file -> when (file /= "." && file /= "..") $ copyFile (from </> file) (to </> file)) =<< getDirectoryContents from

-- | Remove dist directory
clean :: IO ()
clean = do
  info <- mkInfo
  removeDirectoryRecursive (infoBuildDir info)

-- | Flag for specifying languages
langs_prefix :: String
langs_prefix = "langs="

-- | Flag for specifying gf location
gf_prefix :: String
gf_prefix = "gf="

-- | Flag for specifying RGL install location
install_prefix :: String
install_prefix = "dest="

-- | Check arguments are valid
checkArgs :: [String] -> IO ()
checkArgs args = do
  let args' = flip filter args (\arg -> not
        (  arg `elem` (map cmdName rglCommands)
        || arg `elem` all_modes
        || langs_prefix `isPrefixOf` arg
        || gf_prefix `isPrefixOf` arg
        || install_prefix `isPrefixOf` arg
        ))
  unless (null args') $ die $ "Unrecognised flags: " ++ unwords args'
  return ()

-- | List of languages overriding the definitions below
getOptLangs :: [LangInfo] -> [String] -> [LangInfo]
getOptLangs defaultLangs args =
    case [ls | arg <- args,
               let (f,ls) = splitAt (length langs_prefix) arg,
               f==langs_prefix] of
      ('+':ls):_ -> foldr addLang defaultLangs (seps ls)
      ('-':ls):_ -> foldr removeLang defaultLangs (seps ls)
      ls:_ -> findLangs langs (seps ls)
      _    -> defaultLangs
  where
    seps = words . map (\c -> if c==',' then ' ' else c)
    findLangs langs ls = [lang | lang <- langs, langCode lang `elem` ls]
    removeLang l ls = [lang | lang <- ls, langCode lang /= l]
    addLang l ls = if null (findLangs ls [l])
                   then findLangs langs [l]++ls
                   else ls

-- | Get flag value from list of args
getFlag :: String -> [String] -> Maybe String
getFlag flag args = fmap (drop (length flag)) $ find (isPrefixOf flag) args

-------------------------------------------------------------------------------
-- Paths and directories

-- | RGL source directory
sourceDir :: FilePath
sourceDir = "src"

-- | Information needed in build
data Info = Info
  { infoBuildDir :: FilePath -- ^ where to put built RGL modules (fixed)
  , infoInstallDir :: Maybe FilePath -- ^ install directory (found dynamically)
  , infoGFPath :: FilePath -- ^ path to GF
  }

-- | Build info object from command line args
mkInfo :: IO Info
mkInfo = do
  args <- getArgs

  -- Look for install location in a few different places
  let mflag = getFlag install_prefix args
  mbuilt <- catchIOError (readFile "../gf-core/GF_LIB_PATH" >>= return . Just) (\e -> return Nothing)
  menvar <- lookupEnv "GF_LIB_PATH"
  let
    inst_dir =
      case catMaybes [mflag,menvar,mbuilt] of
        [] -> Nothing
        p:_ -> Just p

  return $ Info
    { infoBuildDir = "dist"
    , infoInstallDir = inst_dir
    , infoGFPath = maybe default_gf id (getFlag gf_prefix args)
    }
  where
    default_gf = "gf"

getRGLBuildDir :: Info -> Mode -> FilePath
getRGLBuildDir info mode = infoBuildDir info </> getRGLBuildSubDir mode

getRGLBuildSubDir :: Mode -> String
getRGLBuildSubDir mode =
  case mode of
    AllTenses -> "alltenses"
    Present   -> "present"

-------------------------------------------------------------------------------
-- Build modes

data Mode = AllTenses | Present
  deriving (Show)

all_modes :: [String]
all_modes = ["alltenses","present"]

default_modes :: [Mode]
default_modes = [AllTenses,Present]

-- | An RGL build command
data RGLCommand = RGLCommand
  { cmdName   :: String -- ^ name of command
  , cmdIsDef  :: Bool   -- ^ is default?
  , cmdAction :: [Mode] -> [String] -> Info -> IO () -- ^ action
  }

-- | Possible build commands
rglCommands :: [RGLCommand]
rglCommands =
  [ RGLCommand "prelude" True  $ \mode args bi -> do
       putStrLn $ "Compiling [prelude]"
       let prelude_src_dir = sourceDir       </> "prelude"
           prelude_dst_dir = infoBuildDir bi </> "prelude"
       createDirectoryIfMissing True prelude_dst_dir
       files <- getDirectoryContents prelude_src_dir
       run_gfc bi (["-s", "--gfo-dir="++prelude_dst_dir] ++ [prelude_src_dir </> file | file <- files, file /= "." && file /= ".."])

  , RGLCommand "all"     True  $ gfcp [l,s,c,t,sc]
  , RGLCommand "lang"    False $ gfcp [l,s]
  , RGLCommand "api"     False $ gfcp [t,sc]
  , RGLCommand "compat"  False $ gfcp [c]

  , RGLCommand "pgf"     False $ \modes args bi ->
     parallel_ [
       do let dir = getRGLBuildDir bi mode
          createDirectoryIfMissing True dir
          sequence_ [run_gfc bi ["-s","-make","-name=Lang"++la,
                                       dir ++ "/Lang" ++ la ++ ".gfo"]
                      | l <- optl langsPGF args, let la = langCode l]
          run_gfc bi (["-s","-make","-name=Lang"]++
                           ["Lang" ++ langCode l ++ ".pgf"|l <- optl langsPGF args])
       | mode <- modes]
  , RGLCommand "demo"    False $ \modes args bi -> do
       let ls = optl langsDemo args
       gf bi (demos "Demo" ls) ["demo/Demo" ++ langCode l ++ ".gf" | l <- ls]
       return ()
  , RGLCommand "parse"   False $ \modes args bi ->
       gfc bi modes (summary parse) (map parse (optl langsParse args))
  ]
  where
    gfcp :: [Mode -> [String] -> (LangInfo -> FilePath,[LangInfo])] -> [Mode] -> [String] -> Info -> IO ()
    gfcp cs modes args bi = parallel_ [gfcp' bi mode args cs | mode <- modes]

    gfcp' :: Info -> Mode -> [String] -> [Mode -> [String] -> (LangInfo -> FilePath,[LangInfo])] -> IO ()
    gfcp' bi mode args cs = gfcn bi mode (unwords ss) (concat fss)
      where (ss,fss) = unzip [(summary f,map f as)|c<-cs,let (f,as)=c mode args]

    summary :: (LangInfo -> FilePath) -> FilePath
    summary f = f (LangInfo "*" "*" Nothing Nothing)

    l mode args = (lang,optml mode langsLang args)
    s mode args = (symbol,optml mode langsAPI args)
    c mode args = (compat,optl langsCompat args)
    t mode args = (try,optml mode langsAPI args)
    sc mode args = (symbolic,optml mode langsSymbolic args)

    optl :: [LangInfo] -> [String] -> [LangInfo]
    optl = optml AllTenses

    optml :: Mode -> [LangInfo] -> [String] -> [LangInfo]
    optml mode ls args = getOptLangs (shrink ls) args
      where
        shrink = case mode of
                   Present -> intersect langsPresent
                   _ -> id

-- | Get mode from args (may be missing)
getOptMode :: [String] -> [Mode]
getOptMode args =
    if null explicit_modes
    then default_modes
    else explicit_modes
  where
    explicit_modes =
      [Present|have "present"]++
      [AllTenses|have "alltenses"]
    have mode = mode `elem` args

-- | Get RGL command from args
getRGLCommands :: [String] -> [RGLCommand]
getRGLCommands args =
  let cmds0 = [cmd | arg <- args,
                     cmd <- rglCommands,
                     cmdName cmd == arg]
  in if null cmds0
       then [cmd | cmd <- rglCommands, cmdIsDef cmd]
       else cmds0

-------------------------------------------------------------------------------
-- Languages of the RGL

-- | Information about a language
data LangInfo = LangInfo
  { langCode :: String -- ^ 3-letter ISO 639-2/B code
  , langDir :: String -- ^ directory name
  , langFunctor :: Maybe String -- ^ functor (not used)
  , langUnlexer :: Maybe String -- ^ decoding for postprocessing linearizations
  } deriving (Eq)

-- | List of all languages known to RGL
langs :: [LangInfo]
langs =
  [ LangInfo "Afr" "afrikaans" Nothing Nothing
  , LangInfo "Amh" "amharic" Nothing Nothing
  , LangInfo "Ara" "arabic" Nothing Nothing
  , LangInfo "Eus" "basque" Nothing Nothing
  , LangInfo "Bul" "bulgarian" Nothing Nothing
  , LangInfo "Cat" "catalan" (Just "Romance") Nothing
  , LangInfo "Chi" "chinese" Nothing Nothing
  , LangInfo "Dan" "danish" (Just "Scand") Nothing
  , LangInfo "Dut" "dutch" Nothing Nothing
  , LangInfo "Eng" "english" Nothing Nothing
  , LangInfo "Est" "estonian" Nothing Nothing
  , LangInfo "Fin" "finnish" Nothing Nothing
  , LangInfo "Fre" "french" (Just "Romance") Nothing
  , LangInfo "Grc" "ancient_greek" Nothing Nothing
  , LangInfo "Gre" "greek" Nothing Nothing
  , LangInfo "Heb" "hebrew" Nothing Nothing
  , LangInfo "Hin" "hindi" (Just "Hindustani") (Just "to_devanagari")
  , LangInfo "Ger" "german" Nothing Nothing
  , LangInfo "Ice" "icelandic" Nothing Nothing
  , LangInfo "Ina" "interlingua" Nothing Nothing
  , LangInfo "Ita" "italian" (Just "Romance") Nothing
  , LangInfo "Jpn" "japanese" Nothing Nothing
  , LangInfo "Lat" "latin" Nothing Nothing
  , LangInfo "Lav" "latvian" Nothing Nothing
  , LangInfo "Mlt" "maltese" Nothing Nothing
  , LangInfo "Mon" "mongolian" Nothing Nothing
  , LangInfo "Nep" "nepali" Nothing Nothing
  , LangInfo "Nor" "norwegian" (Just "Scand") Nothing
  , LangInfo "Nno" "nynorsk" Nothing Nothing
  , LangInfo "Pes" "persian" Nothing Nothing
  , LangInfo "Pol" "polish" Nothing Nothing
  , LangInfo "Por" "portuguese" (Just "Romance") Nothing
  , LangInfo "Pnb" "punjabi" Nothing Nothing
  , LangInfo "Ron" "romanian" Nothing Nothing
  , LangInfo "Rus" "russian" Nothing Nothing
  , LangInfo "Snd" "sindhi" Nothing Nothing
  , LangInfo "Spa" "spanish" (Just "Romance") Nothing
  , LangInfo "Swe" "swedish" (Just "Scand") Nothing
  , LangInfo "Tha" "thai" Nothing (Just "to_thai")
  , LangInfo "Tur" "turkish" Nothing Nothing
  , LangInfo "Urd" "urdu" (Just "Hindustani") Nothing
  ]

-- | Languagues for which to compile Lang
langsLang :: [LangInfo]
langsLang = langs

-- | Languages that have notpresent marked
langsPresent :: [LangInfo]
langsPresent = langsLang `except` ["Afr","Chi","Eus","Gre","Heb","Ice","Jpn","Mlt","Mon","Nep","Pes","Snd","Tha","Thb","Est"]

-- | Languages for which to compile Try
langsAPI :: [LangInfo]
langsAPI = langsLang `except` langsIncomplete

-- | Languages which compile but which are incomplete
langsIncomplete :: [String]
langsIncomplete = ["Amh","Ara","Grc","Heb","Ina","Lat","Tur"]

-- | Languages for which to compile Symbolic
langsSymbolic :: [LangInfo]
langsSymbolic  = langsAPI `except` ["Afr","Ice","Mon","Nep"]

-- | Languages for which to run demo test
langsDemo :: [LangInfo]
langsDemo = langsLang `except` ["Ara","Hin","Ina","Lav","Tha"]

-- | Languages for which to compile parsing grammars
langsParse :: [LangInfo]
langsParse = langs `only` ["Eng"]

-- | Languages for which langs.pgf is built
langsPGF :: [LangInfo]
langsPGF = langsLang `except` ["Ara","Hin","Ron","Tha"]

-- | Languages for which Compatibility exists (to be extended)
langsCompat :: [LangInfo]
langsCompat = langsLang `only` ["Cat","Eng","Fin","Fre","Ita","Lav","Spa","Swe"]

-- | Exclude langs from list by code
except :: [LangInfo] -> [String] -> [LangInfo]
except ls es = filter (flip notElem es . langCode) ls

-- | Only specified langs by code
only ::  [LangInfo] -> [String] -> [LangInfo]
only ls es = filter (flip elem es . langCode) ls

-------------------------------------------------------------------------------
-- Getting module paths/names

lang :: LangInfo -> FilePath
lang l = sourceDir </> langDir l </> ("All" ++ langCode l ++ ".gf")

compat :: LangInfo -> FilePath
compat l = sourceDir </> langDir l </> ("Compatibility" ++ langCode l ++ ".gf")

symbol :: LangInfo -> FilePath
symbol l = sourceDir </> langDir l </> ("Symbol" ++ langCode l ++ ".gf")

try :: LangInfo -> FilePath
try l = sourceDir </> "api" </> ("Try" ++ langCode l ++ ".gf")

syntax :: LangInfo -> FilePath
syntax l = sourceDir </> "api" </> ("Syntax" ++ langCode l ++ ".gf")

symbolic :: LangInfo -> FilePath
symbolic l = sourceDir </> "api" </> ("Symbolic" ++ langCode l ++ ".gf")

parse :: LangInfo -> FilePath
parse l = sourceDir </> "parse" </> ("Parse" ++ langCode l ++ ".gf")

demos :: String -> [LangInfo] -> String
demos abstr ls = "gr -number=100 | l -treebank " ++ unlexer abstr ls ++ " | ps -to_html | wf -file=resdemo.html"

-- | Get unlexer flags for languages
unlexer :: String -> [LangInfo] -> String
unlexer abstr ls =
  "-unlexer=\\\"" ++ unwords
    [ abstr ++ langCode lang ++ "=" ++ fromJust unl
    | lang <- ls
    , let unl = langUnlexer lang
    , isJust unl] ++ "\\\""

-------------------------------------------------------------------------------
-- Executing GF

-- | Runs the gf executable in compile mode with the given arguments
run_gfc :: Info -> [String] -> IO ()
run_gfc bi args = do
  let
    args' = ["-batch","-gf-lib-path="++sourceDir] ++ filter (not . null) args
    gf = infoGFPath bi
  execute gf args'

gfc :: Info -> [Mode] -> String -> [String] -> IO ()
gfc bi modes summary files =
  parallel_ [gfcn bi mode summary files | mode<-modes]

gfcn :: Info -> Mode -> String -> [String] -> IO ()
gfcn bi mode summary files = do
  let dir = getRGLBuildDir bi mode
      preproc = case mode of
                  AllTenses -> ""
                  Present   -> "-preproc="++({-sourceDir </>-} "mkPresent")
  createDirectoryIfMissing True dir
  putStrLn $ "Compiling [" ++ show mode ++ "] " ++ summary
  run_gfc bi (["-s", "-no-pmcfg", preproc, "--gfo-dir="++dir] ++ files)

gf :: Info -> String -> [String] -> IO ()
gf bi comm files = do
  putStrLn $ "Reading " ++ unwords files
  let gf = infoGFPath bi
  putStrLn ("executing: " ++ comm ++ "\n" ++ "in " ++ gf)
  out <- readProcess gf ("-s":files) comm
  putStrLn out

-- | Run an arbitrary system command
execute :: String -> [String] -> IO ()
execute command args =
  do let cmdline = command ++ " " ++ unwords (map showArg args)
     e <- rawSystem command args
     case e of
       ExitSuccess   -> return ()
       ExitFailure i -> do putStrLn $ "Ran: " ++ cmdline
                           die $ command++" exited with exit code: " ++ show i
  where
    showArg arg = if ' ' `elem` arg then "'" ++ arg ++ "'" else arg

-- | For parallel RGL module compilation
-- Unfortunately, this has no effect unless compiled with -threaded
parallel_ :: (Foldable t, Monad m) => t (m a) -> m ()
parallel_ ms = sequence_ ms
  -- do c <- newChan
  --    ts <- sequence [ forkIO (m >> writeChan c ()) | m <- ms]
  --    sequence_ [readChan c | _ <- ts]
