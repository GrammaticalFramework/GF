module GF.Infra.Option
    (
     -- * Option types
     Options, ModuleOptions,
     Flags(..), ModuleFlags(..),
     Mode(..), Phase(..), Verbosity(..), Encoding(..), OutputFormat(..), Optimization(..),
     Dump(..), Printer(..), Recomp(..),
     -- * Option parsing 
     parseOptions, parseModuleOptions,
     -- * Option pretty-printing
     moduleOptionsGFO,
     -- * Option manipulation
     addOptions, concatOptions, noOptions,
     moduleOptions,
     addModuleOptions, concatModuleOptions, noModuleOptions,
     helpMessage,
     -- * Checking specific options
     flag, moduleFlag,
     -- * Setting specific options
     setOptimization,
     -- * Convenience methods for checking options    
     verbAtLeast, dump
    ) where

import Control.Monad
import Data.Char (toLower)
import Data.List
import Data.Maybe
import GF.Infra.GetOpt
--import System.Console.GetOpt
import System.FilePath

import GF.Data.ErrM

import Data.Set (Set)
import qualified Data.Set as Set




usageHeader :: String
usageHeader = unlines 
 ["Usage: gfc [OPTIONS] [FILE [...]]",
  "",
  "How each FILE is handled depends on the file name suffix:",
  "",
  ".gf Normal or old GF source, will be compiled.",
  ".gfo Compiled GF source, will be loaded as is.",
  ".gfe Example-based GF source, will be converted to .gf and compiled.",
  ".ebnf Extended BNF format, will be converted to .gf and compiled.",
  ".cf Context-free (BNF) format, will be converted to .gf and compiled.",
  "",
  "If multiple FILES are given, they must be normal GF source, .gfo or .gfe files.",
  "For the other input formats, only one file can be given.",
  "",
  "Command-line options:"]


helpMessage :: String
helpMessage = usageInfo usageHeader optDescr


-- FIXME: do we really want multi-line errors?
errors :: [String] -> Err a
errors = fail . unlines

-- Types

data Mode = ModeVersion | ModeHelp | ModeInteractive | ModeCompiler
  deriving (Show,Eq,Ord)

data Verbosity = Quiet | Normal | Verbose | Debug
  deriving (Show,Eq,Ord,Enum,Bounded)

data Phase = Preproc | Convert | Compile | Link
  deriving (Show,Eq,Ord)

data Encoding = UTF_8 | ISO_8859_1
  deriving (Show,Eq,Ord)

data OutputFormat = FmtPGF 
                  | FmtJavaScript 
                  | FmtHaskell 
                  | FmtHaskell_GADT 
                  | FmtBNF
                  | FmtSRGS_XML 
                  | FmtSRGS_ABNF 
                  | FmtJSGF 
                  | FmtGSL 
                  | FmtVoiceXML
                  | FmtSLF
                  | FmtRegExp
                  | FmtFA
  deriving (Eq,Ord)

data Optimization = OptStem | OptCSE | OptExpand | OptParametrize | OptValues
  deriving (Show,Eq,Ord)

data Warning = WarnMissingLincat
  deriving (Show,Eq,Ord)

data Dump = DumpRebuild | DumpExtend | DumpRename | DumpTypeCheck | DumpRefresh | DumpOptimize | DumpCanon
  deriving (Show,Eq,Ord)

-- | Pretty-printing options
data Printer = PrinterStrip -- ^ Remove name qualifiers.
  deriving (Show,Eq,Ord)

data Recomp = AlwaysRecomp | RecompIfNewer | NeverRecomp
  deriving (Show,Eq,Ord)

data ModuleFlags = ModuleFlags {
      optName            :: Maybe String,
      optAbsName         :: Maybe String,
      optCncName         :: Maybe String,
      optResName         :: Maybe String,
      optPreprocessors   :: [String],
      optEncoding        :: Encoding,
      optOptimizations   :: Set Optimization,
      optLibraryPath     :: [FilePath],
      optStartCat        :: Maybe String,
      optSpeechLanguage  :: Maybe String,
      optLexer           :: Maybe String,
      optUnlexer         :: Maybe String,
      optErasing         :: Bool,
      optBuildParser     :: Bool,
      optWarnings        :: [Warning],
      optDump            :: [Dump]
    }
  deriving (Show)

data Flags = Flags {
      optMode            :: Mode,
      optStopAfterPhase  :: Phase,
      optVerbosity       :: Verbosity,
      optShowCPUTime     :: Bool,
      optEmitGFO         :: Bool,
      optGFODir          :: FilePath,
      optOutputFormats   :: [OutputFormat],
      optOutputFile      :: Maybe FilePath,
      optOutputDir       :: Maybe FilePath,
      optRecomp          :: Recomp,
      optPrinter         :: [Printer],
      optProb            :: Bool,
      optRetainResource  :: Bool,
      optModuleFlags     :: ModuleFlags
    }
  deriving (Show)

newtype Options = Options (Flags -> Flags)

instance Show Options where
    show (Options o) = show (o defaultFlags)

newtype ModuleOptions = ModuleOptions (ModuleFlags -> ModuleFlags)

-- Option parsing

parseOptions :: [String] -> Err (Options, [FilePath])
parseOptions args 
    | not (null errs) = errors errs
    | otherwise = do opts <- liftM concatOptions $ sequence optss
                     return (opts, files)
  where (optss, files, errs) = getOpt RequireOrder optDescr args

parseModuleOptions :: [String] -> Err ModuleOptions
parseModuleOptions args 
    | not (null errs)  = errors errs
    | not (null files) = errors $ map ("Non-option among module options: " ++) files
    | otherwise        = liftM concatModuleOptions $ sequence flags
  where (flags, files, errs) = getOpt RequireOrder moduleOptDescr args

-- Showing options

-- | Pretty-print the module options that are preserved in .gfo files.
moduleOptionsGFO :: ModuleOptions -> [(String,String)]
moduleOptionsGFO (ModuleOptions o) = 
         maybe [] (\x -> [("language",x)]) (optSpeechLanguage mfs)
      ++ maybe [] (\x -> [("startcat",x)]) (optStartCat mfs)
      ++ (if optErasing mfs then [("erasing","on")] else [])
  where mfs = o defaultModuleFlags


-- Option manipulation

noOptions :: Options
noOptions = Options id

addOptions :: Options -- ^ Existing options.
           -> Options -- ^ Options to add (these take preference).
           -> Options
addOptions (Options o1) (Options o2) = Options (o2 . o1)

concatOptions :: [Options] -> Options
concatOptions = foldr addOptions noOptions

moduleOptions :: ModuleOptions -> Options
moduleOptions (ModuleOptions f) = Options (\o -> o { optModuleFlags = f (optModuleFlags o) })

addModuleOptions :: ModuleOptions -- ^ Existing options.
                 -> ModuleOptions -- ^ Options to add (these take preference).
                 -> ModuleOptions
addModuleOptions (ModuleOptions o1) (ModuleOptions o2) = ModuleOptions (o2 . o1)

concatModuleOptions :: [ModuleOptions] -> ModuleOptions
concatModuleOptions = foldr addModuleOptions noModuleOptions

noModuleOptions :: ModuleOptions
noModuleOptions = ModuleOptions id

flag :: (Flags -> a) -> Options -> a
flag f (Options o) = f (o defaultFlags)

moduleFlag :: (ModuleFlags -> a) -> Options -> a
moduleFlag f = flag (f . optModuleFlags)

modifyFlags :: (Flags -> Flags) -> Options
modifyFlags = Options

modifyModuleFlags :: (ModuleFlags -> ModuleFlags) -> Options
modifyModuleFlags = moduleOptions . ModuleOptions


{-

parseModuleFlags :: Options -> [(String,Maybe String)] -> Err ModuleOptions
parseModuleFlags opts flags = 
    mapM (uncurry (findFlag moduleOptDescr)) flags >>= foldM (flip ($)) (optModuleOptions opts)

findFlag :: Monad m => [OptDescr a] -> String -> Maybe String -> m a
findFlag opts n mv = 
    case filter (`flagMatches` n) opts of
      []    -> fail $ "Unknown option: " ++ n
      [opt] -> flagValue opt n mv
      _     -> fail $ n ++ " matches multiple options."

flagMatches :: OptDescr a -> String -> Bool
flagMatches (Option cs ss _ _) n = n `elem` (map (:[]) cs ++ ss)

flagValue :: Monad m => OptDescr a -> String -> Maybe String -> m a
flagValue (Option _ _ arg _) n mv =
    case (arg, mv) of
      (NoArg x,    Nothing) -> return x
      (NoArg _,    Just _ ) -> fail $ "Option " ++ n ++ " does not take a value."
      (ReqArg _ _, Nothing) -> fail $ "Option " ++ n ++ " requires a value."
      (ReqArg f _, Just x ) -> return (f x)
      (OptArg f _, mx     ) -> return (f mx)

-}

-- Default options

defaultModuleFlags :: ModuleFlags
defaultModuleFlags = ModuleFlags {
      optName            = Nothing,
      optAbsName         = Nothing,
      optCncName         = Nothing,
      optResName         = Nothing,
      optPreprocessors   = [],
      optEncoding        = ISO_8859_1,
      optOptimizations   = Set.fromList [OptStem,OptCSE,OptExpand,OptParametrize,OptValues],
      optLibraryPath     = [],
      optStartCat        = Nothing,
      optSpeechLanguage  = Nothing,
      optLexer           = Nothing,
      optUnlexer         = Nothing,
      optErasing         = False,
      optBuildParser     = True,
      optWarnings        = [],
      optDump            = []
    }

defaultFlags :: Flags
defaultFlags = Flags {
      optMode            = ModeInteractive,
      optStopAfterPhase  = Compile,
      optVerbosity       = Normal,
      optShowCPUTime     = False,
      optEmitGFO         = True,
      optGFODir          = ".",
      optOutputFormats   = [FmtPGF],
      optOutputFile      = Nothing,
      optOutputDir       = Nothing,
      optRecomp          = RecompIfNewer,
      optPrinter         = [],
      optProb            = False,
      optRetainResource  = False,
      optModuleFlags     = defaultModuleFlags
    }

-- Option descriptions

moduleOptDescr :: [OptDescr (Err ModuleOptions)]
moduleOptDescr = 
    [
     Option ['n'] ["name"] (ReqArg name "NAME") 
           (unlines ["Use NAME as the name of the output. This is used in the output file names, ",
                     "with suffixes depending on the formats, and, when relevant, ",
                     "internally in the output."]),
     Option [] ["abs"] (ReqArg absName "NAME")
            ("Use NAME as the name of the abstract syntax module generated from "
             ++ "a grammar in GF 1 format."),
     Option [] ["cnc"] (ReqArg cncName "NAME")
            ("Use NAME as the name of the concrete syntax module generated from "
             ++ "a grammar in GF 1 format."),
     Option [] ["res"] (ReqArg resName "NAME")
            ("Use NAME as the name of the resource module generated from "
             ++ "a grammar in GF 1 format."),
     Option ['i'] [] (ReqArg addLibDir "DIR") "Add DIR to the library search path.",
     Option [] ["path"] (ReqArg setLibPath "DIR:DIR:...") "Set the library search path.",
     Option [] ["preproc"] (ReqArg preproc "CMD") 
                 (unlines ["Use CMD to preprocess input files.",
                           "Multiple preprocessors can be used by giving this option multiple times."]),
     Option [] ["coding"] (ReqArg coding "ENCODING") 
                ("Character encoding of the source grammar, ENCODING = "
                 ++ concat (intersperse " | " (map fst encodings)) ++ "."),
     Option [] ["erasing"] (onOff erasing False) "Generate erasing grammar (default off).",
     Option [] ["parser"] (onOff parser True) "Build parser (default on).",
     Option [] ["startcat"] (ReqArg startcat "CAT") "Grammar start category.",
     Option [] ["language"] (ReqArg language "LANG") "Set the speech language flag to LANG in the generated grammar.",
     Option [] ["lexer"] (ReqArg lexer "LEXER") "Use lexer LEXER.",
     Option [] ["unlexer"] (ReqArg unlexer "UNLEXER") "Use unlexer UNLEXER.",
     Option [] ["optimize"] (ReqArg optimize "OPT") 
                "Select an optimization package. OPT = all | values | parametrize | none",
     Option [] ["stem"] (onOff (toggleOptimize OptStem) True) "Perform stem-suffix analysis (default on).",
     Option [] ["cse"] (onOff (toggleOptimize OptCSE) True) "Perform common sub-expression elimination (default on).",
     dumpOption "rebuild" DumpRebuild,
     dumpOption "extend" DumpExtend,
     dumpOption "rename" DumpRename,
     dumpOption "tc" DumpTypeCheck,
     dumpOption "refresh" DumpRefresh,
     dumpOption "opt" DumpOptimize,
     dumpOption "canon" DumpCanon
    ]
    where
       name        x = set $ \o -> o { optName = Just x }
       absName     x = set $ \o -> o { optAbsName = Just x }
       cncName     x = set $ \o -> o { optCncName = Just x }
       resName     x = set $ \o -> o { optResName = Just x }
       addLibDir   x = set $ \o -> o { optLibraryPath = x:optLibraryPath o }
       setLibPath  x = set $ \o -> o { optLibraryPath = splitInModuleSearchPath x }
       preproc     x = set $ \o -> o { optPreprocessors = optPreprocessors o ++ [x] }
       coding      x = case lookup x encodings of
                         Just c  -> set $ \o -> o { optEncoding = c }
                         Nothing -> fail $ "Unknown character encoding: " ++ x
       erasing     x = set $ \o -> o { optErasing = x }
       parser      x = set $ \o -> o { optBuildParser = x }
       startcat    x = set $ \o -> o { optStartCat = Just x }
       language    x = set $ \o -> o { optSpeechLanguage = Just x }
       lexer       x = set $ \o -> o { optLexer = Just x }
       unlexer     x = set $ \o -> o { optUnlexer = Just x }

       optimize    x = case lookup x optimizationPackages of
                         Just p  -> set $ \o -> o { optOptimizations = p }
                         Nothing -> fail $ "Unknown optimization package: " ++ x

       toggleOptimize x b = set $ setOptimization' x b

       dumpOption s d = Option [] ["dump-"++s] (NoArg (set $ \o -> o { optDump = d:optDump o})) ("Dump output of the " ++ s ++ " phase.")

       set = return . ModuleOptions

optDescr :: [OptDescr (Err Options)]
optDescr = 
    [
     Option ['?','h'] ["help"] (NoArg (mode ModeHelp)) "Show help message.",
     Option ['V'] ["version"] (NoArg (mode ModeVersion)) "Display GF version number.",
     Option ['v'] ["verbose"] (OptArg verbosity "N") "Set verbosity (default 1). -v alone is the same as -v 2.",
     Option ['q','s'] ["quiet"] (NoArg (verbosity (Just "0"))) "Quiet, same as -v 0.",
     Option [] ["batch"] (NoArg (mode ModeCompiler)) "Run in batch compiler mode.",
     Option [] ["interactive"] (NoArg (mode ModeInteractive)) "Run in interactive mode (default).",
     Option ['E'] [] (NoArg (phase Preproc)) "Stop after preprocessing (with --preproc).",
     Option ['C'] [] (NoArg (phase Convert)) "Stop after conversion to .gf.",
     Option ['c'] [] (NoArg (phase Compile)) "Stop after compiling to .gfo (default) .",
     Option [] ["make"] (NoArg (phase Link)) "Build .pgf file and other output files.",
     Option [] ["cpu"] (NoArg (cpu True)) "Show compilation CPU time statistics.",
     Option [] ["no-cpu"] (NoArg (cpu False)) "Don't show compilation CPU time statistics (default).",
     Option [] ["emit-gfo"] (NoArg (emitGFO True)) "Create .gfo files (default).",
     Option [] ["no-emit-gfo"] (NoArg (emitGFO False)) "Do not create .gfo files.",
     Option [] ["gfo-dir"] (ReqArg gfoDir "DIR") "Directory to put .gfo files in (default = '.').",
     Option ['f'] ["output-format"] (ReqArg outFmt "FMT") 
        (unlines ["Output format. FMT can be one of:",
                  "Multiple concrete: pgf (default), gar, js, ...",
                  "Single concrete only: cf, bnf, lbnf, gsl, srgs_xml, srgs_abnf, ...",
                  "Abstract only: haskell, ..."]),
     Option ['o'] ["output-file"] (ReqArg outFile "FILE") 
           "Save output in FILE (default is out.X, where X depends on output format.",
     Option ['D'] ["output-dir"] (ReqArg outDir "DIR") 
           "Save output files (other than .gfc files) in DIR.",
     Option [] ["src","force-recomp"] (NoArg (recomp AlwaysRecomp)) 
                 "Always recompile from source.",
     Option [] ["gfo","recomp-if-newer"] (NoArg (recomp RecompIfNewer)) 
                 "(default) Recompile from source if the source is newer than the .gfo file.",
     Option [] ["gfo","no-recomp"] (NoArg (recomp NeverRecomp)) 
                 "Never recompile from source, if there is already .gfo file.",
     Option [] ["strip"] (NoArg (printer PrinterStrip))
                 "Remove name qualifiers when pretty-printing.",
     Option [] ["retain"] (NoArg (set $ \o -> o { optRetainResource = True })) "Retain opers.",
     Option [] ["prob"] (NoArg (prob True)) "Read probabilities from '--# prob' pragmas."
    ] ++ map (fmap (liftM moduleOptions)) moduleOptDescr
 where phase       x = set $ \o -> o { optStopAfterPhase = x }
       mode        x = set $ \o -> o { optMode = x }
       verbosity mv  = case mv of
                           Nothing -> set $ \o -> o { optVerbosity = Verbose }
                           Just v  -> case readMaybe v >>= toEnumBounded of
                                        Just i  -> set $ \o -> o { optVerbosity = i }
                                        Nothing -> fail $ "Bad verbosity: " ++ show v
       cpu         x = set $ \o -> o { optShowCPUTime = x }
       emitGFO     x = set $ \o -> o { optEmitGFO = x }
       gfoDir      x = set $ \o -> o { optGFODir = x }
       outFmt      x = readOutputFormat x >>= \f ->
                         set $ \o -> o { optOutputFormats = optOutputFormats o ++ [f] }
       outFile     x = set $ \o -> o { optOutputFile = Just x }
       outDir      x = set $ \o -> o { optOutputDir = Just x }
       recomp      x = set $ \o -> o { optRecomp = x }
       printer     x = set $ \o -> o { optPrinter = x : optPrinter o }
       prob        x = set $ \o -> o { optProb = x }

       set = return . Options

outputFormats :: [(String,OutputFormat)]
outputFormats = 
    [("pgf",          FmtPGF),
     ("js",           FmtJavaScript),
     ("haskell",      FmtHaskell),
     ("haskell_gadt", FmtHaskell_GADT),
     ("bnf",          FmtBNF),
     ("srgs",         FmtSRGS_XML),
     ("srgs_xml",     FmtSRGS_XML),
     ("srgs_abnf",    FmtSRGS_ABNF),
     ("jsgf",         FmtJSGF),
     ("gsl",          FmtGSL),
     ("vxml",         FmtVoiceXML),
     ("slf",          FmtSLF),
     ("regexp",       FmtRegExp),
     ("fa",           FmtFA)]

instance Show OutputFormat where
    show = lookupShow outputFormats

instance Read OutputFormat where
    readsPrec = lookupReadsPrec outputFormats

optimizationPackages :: [(String, Set Optimization)]
optimizationPackages = 
    [("all_subs",    Set.fromList [OptStem,OptCSE,OptExpand,OptParametrize,OptValues]), -- deprecated
     ("all",         Set.fromList [OptStem,OptCSE,OptExpand,OptParametrize,OptValues]),
     ("values",      Set.fromList [OptStem,OptCSE,OptExpand,OptValues]),
     ("parametrize", Set.fromList [OptStem,OptCSE,OptExpand,OptParametrize]),
     ("none",        Set.fromList [OptStem,OptCSE,OptExpand]),
     ("noexpand",    Set.fromList [OptStem,OptCSE])]

encodings :: [(String,Encoding)]
encodings = 
    [("utf8",   UTF_8),
     ("latin1", ISO_8859_1)]

lookupShow :: Eq a => [(String,a)] -> a -> String
lookupShow xs z = fromMaybe "lookupShow" $ lookup z [(y,x) | (x,y) <- xs]

lookupReadsPrec :: [(String,a)] -> Int -> ReadS a
lookupReadsPrec xs _ s = [(z,rest) | (x,rest) <- lex s, (y,z) <- xs, y == x]

onOff :: Monad m => (Bool -> m a) -> Bool -> ArgDescr (m a)
onOff f def = OptArg g "[on,off]"
  where g ma = maybe (return def) readOnOff ma >>= f
        readOnOff x = case map toLower x of
                        "on"  -> return True
                        "off" -> return False
                        _     -> fail $ "Expected [on,off], got: " ++ show x

readOutputFormat :: Monad m => String -> m OutputFormat
readOutputFormat s = 
    maybe (fail $ "Unknown output format: " ++ show s) return $ lookup s outputFormats

-- FIXME: this is a copy of the function in GF.Devel.UseIO.
splitInModuleSearchPath :: String -> [FilePath]
splitInModuleSearchPath s = case break isPathSep s of
  (f,_:cs) -> f : splitInModuleSearchPath cs
  (f,_)    -> [f]
  where
    isPathSep :: Char -> Bool
    isPathSep c = c == ':' || c == ';'

-- 
-- * Convenience functions for checking options
--

verbAtLeast :: Options -> Verbosity -> Bool
verbAtLeast opts v = flag optVerbosity opts >= v

dump :: Options -> Dump -> Bool
dump opts d = moduleFlag ((d `elem`) . optDump) opts

-- 
-- * Convenience functions for setting options
--

setOptimization :: Optimization -> Bool -> Options
setOptimization o b = modifyModuleFlags (setOptimization' o b)

setOptimization' :: Optimization -> Bool -> ModuleFlags -> ModuleFlags
setOptimization' o b f = f { optOptimizations = g (optOptimizations f)}
  where g = if b then Set.insert o else Set.delete o

--
-- * General utilities
--

readMaybe :: Read a => String -> Maybe a
readMaybe s = case reads s of
                [(x,"")] -> Just x
                _        -> Nothing

toEnumBounded :: (Bounded a, Enum a, Ord a) => Int -> Maybe a
toEnumBounded i = let mi = minBound
                      ma = maxBound `asTypeOf` mi                      
                   in if i >= fromEnum mi && i <= fromEnum ma 
                        then Just (toEnum i `asTypeOf` mi)
                        else Nothing


instance Functor OptDescr where
    fmap f (Option cs ss d s) = Option cs ss (fmap f d) s

instance Functor ArgDescr where
    fmap f (NoArg x)    = NoArg (f x)
    fmap f (ReqArg g s) = ReqArg (f . g) s
    fmap f (OptArg g s) = OptArg (f . g) s