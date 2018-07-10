module Main where

import System.FilePath ((</>),(<.>))
import Data.List (find,intersect,isPrefixOf,intercalate)
import Data.Maybe (fromJust,isJust)
import System.Environment (getArgs)
import System.Exit (ExitCode(..),die)
import System.Process (rawSystem,readProcess)
import System.Directory (createDirectoryIfMissing,copyFile,getDirectoryContents)
import Control.Monad(unless)

main :: IO ()
main = do
  putStrLn "RGL Build Script"
  getArgs >>= buildRGL

buildRGL :: [String] -> IO ()
buildRGL args = do
  let cmds = getRGLCommands args
  let modes = getOptMode args
  info <- readFile "../gf-core/GF_LIB_PATH" >>= return . Info
  mapM_ (\cmd -> cmdAction cmd modes args info) cmds

-- copyRGL :: [String] -> CopyFlags -> (PackageDescription, LocalBuildInfo) -> IO ()
-- copyRGL args flags bi = do
--   let modes = getOptMode args
--       dest = case copyDest flags of
--                NoFlag -> NoCopyDest
--                Flag d -> d
--   let inst_gf_lib_dir = datadir (uncurry absoluteInstallDirs bi dest) </> "lib"
--   copyAll "prelude"   (rgl_dst_dir (snd bi) </> "prelude") (inst_gf_lib_dir </> "prelude")
--   sequence_ [copyAll (show mode) (getRGLBuildDir (snd bi) mode) (inst_gf_lib_dir </> getRGLBuildSubDir mode)|mode<-modes]

-- copyAll :: String -> FilePath -> FilePath -> IO ()
-- copyAll s from to = do
--   putStrLn $ "Installing [" ++ s ++ "] " ++ to
--   createDirectoryIfMissing True to
--   mapM_ (\file -> when (file /= "." && file /= "..") $ copyFile (from </> file) (to </> file)) =<< getDirectoryContents from

checkRGLArgs :: [String] -> IO ()
checkRGLArgs args = do
  let args' = filter (\arg -> not (arg `elem` all_modes ||
                                   langs_prefix `isPrefixOf` arg)) args
  unless (null args') $ die $ "Unrecognised flags: " ++ intercalate ", " args'
  return ()

-------------------------------------------------------------------------------
-- Paths and directories
-- TODO this whole section

langs_prefix :: String
langs_prefix = "langs="

data Info = Info
  { infoInstallDir :: FilePath
  }

default_gf :: Info -> FilePath
default_gf bi = "gf"

-- -- | Get path to locally-built gf
-- default_gf :: LocalBuildInfo -> FilePath
-- default_gf lbi = buildDir lbi </> exeName' </> exeNameReal
--   where
--     exeName' = "gf"
--     exeNameReal = exeName' <.> exeExtension

rgl_src_dir :: FilePath
rgl_src_dir = "src"

rgl_dst_dir :: Info -> FilePath
rgl_dst_dir info = infoInstallDir info </> "rgl"

getRGLBuildDir :: Info -> Mode -> FilePath
getRGLBuildDir bi mode = rgl_dst_dir bi </> getRGLBuildSubDir mode

getRGLBuildSubDir :: Mode -> String
getRGLBuildSubDir mode =
  case mode of
    AllTenses -> "alltenses"
    Present   -> "present"

-------------------------------------------------------------------------------
-- Build modes

data Mode = AllTenses | Present
  deriving Show

all_modes :: [String]
all_modes = ["alltenses","present"]

default_modes :: [Mode]
default_modes = [AllTenses,Present]

data RGLCommand = RGLCommand
  { cmdName   :: String
  , cmdIsDef  :: Bool
  , cmdAction :: [Mode] -> [String] -> Info -> IO ()
  }

rglCommands :: [RGLCommand]
rglCommands =
  [ RGLCommand "prelude" True  $ \mode args bi -> do
       putStrLn $ "Compiling [prelude]"
       let prelude_src_dir = rgl_src_dir    </> "prelude"
           prelude_dst_dir = rgl_dst_dir bi </> "prelude"
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
  -- , RGLCommand "parse"   False $ \modes args bi ->
  --      gfc bi modes (summary parse) (map parse (optl langsParse args))
  -- , RGLCommand "none"    False $ \modes args bi ->
  --      return ()
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
  { langCode :: String -- ^ 3-letter ISO code
  , langDir :: String -- ^ directory name
  , langFunctor :: Maybe String
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
langsLang = langs -- `except` ["Amh","Ara","Lat","Tur"]

-- | Languages that have notpresent marked
langsPresent :: [LangInfo]
langsPresent = langsLang `except` ["Afr","Chi","Eus","Gre","Heb","Ice","Jpn","Mlt","Mon","Nep","Pes","Snd","Tha","Thb","Est"]

-- | Languages for which to compile Try
langsAPI :: [LangInfo]
langsAPI = langsLang `except` langsIncomplete

langsIncomplete :: [String]
langsIncomplete = ["Amh","Ara","Grc","Heb","Ina","Lat","Tur"]

-- -- | Languages for which to compile minimal Syntax
-- langsMinimal :: [LangInfo]
-- langsMinimal = langs `only` ["Ara","Eng","Bul","Rus"]

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

-- | List of languages overriding the definitions above
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

lang :: LangInfo -> FilePath
lang l = rgl_src_dir </> langDir l </> ("All" ++ langCode l ++ ".gf")

compat :: LangInfo -> FilePath
compat l = rgl_src_dir </> langDir l </> ("Compatibility" ++ langCode l ++ ".gf")

symbol :: LangInfo -> FilePath
symbol l = rgl_src_dir </> langDir l </> ("Symbol" ++ langCode l ++ ".gf")

try :: LangInfo -> FilePath
try l = rgl_src_dir </> "api" </> ("Try" ++ langCode l ++ ".gf")

syntax :: LangInfo -> FilePath
syntax l = rgl_src_dir </> "api" </> ("Syntax" ++ langCode l ++ ".gf")

symbolic :: LangInfo -> FilePath
symbolic l = rgl_src_dir </> "api" </> ("Symbolic" ++ langCode l ++ ".gf")

parse :: LangInfo -> FilePath
parse l = rgl_src_dir </> "parse" </> ("Parse" ++ langCode l ++ ".gf")

demos :: String -> [LangInfo] -> String
demos abstr ls = "gr -number=100 | l -treebank " ++ unlexer abstr ls ++ " | ps -to_html | wf -file=resdemo.html"

-------------------------------------------------------------------------------
-- Executing GF

-- | Runs the gf executable in compile mode with the given arguments
run_gfc :: Info -> [String] -> IO ()
run_gfc bi args = do
  let
    args' = ["-batch","-gf-lib-path="++rgl_src_dir] ++ filter (not . null) args
    gf = default_gf bi
  execute gf args'

gfc :: Info -> [Mode] -> String -> [String] -> IO ()
gfc bi modes summary files =
  parallel_ [gfcn bi mode summary files | mode<-modes]

gfcn :: Info -> Mode -> String -> [String] -> IO ()
gfcn bi mode summary files = do
  let dir = getRGLBuildDir bi mode
      preproc = case mode of
                  AllTenses -> ""
                  Present   -> "-preproc="++({-rgl_src_dir </>-} "mkPresent")
  createDirectoryIfMissing True dir
  putStrLn $ "Compiling [" ++ show mode ++ "] " ++ summary
  run_gfc bi (["-s", "-no-pmcfg", preproc, "--gfo-dir="++dir] ++ files)

gf :: Info -> String -> [String] -> IO ()
gf bi comm files = do
  putStrLn $ "Reading " ++ unwords files
  let gf = default_gf bi
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
-- Unfortunately, this has no effect unless Setup.hs is compiled with -threaded
parallel_ :: (Foldable t, Monad m) => t (m a) -> m ()
parallel_ ms = sequence_ ms
  -- do c <- newChan
  --    ts <- sequence [ forkIO (m >> writeChan c ()) | m <- ms]
  --    sequence_ [readChan c | _ <- ts]


-------------------------------------------------------------------------------
-- Helpers

unlexer :: String -> [LangInfo] -> String
unlexer abstr ls =
  "-unlexer=\\\"" ++ unwords
    [ abstr ++ langCode lang ++ "=" ++ fromJust unl
    | lang <- ls
    , let unl = langUnlexer lang
    , isJust unl] ++ "\\\""
