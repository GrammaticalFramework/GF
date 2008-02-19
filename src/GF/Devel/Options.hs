module GF.Devel.Options 
    (
     Err(..), -- FIXME: take from somewhere else

     Options(..),
     Mode(..), Phase(..), OutputFormat(..), Optimization(..),
     parseOptions, helpMessage
    ) where

import Control.Monad
import Data.Char (toLower)
import Data.List
import Data.Maybe
import System.Console.GetOpt
import System.FilePath





usageHeader :: String
usageHeader = unlines 
 ["Usage: gfc [OPTIONS] [FILE [...]]",
  "",
  "How each FILE is handled depends on the file name suffix:",
  "",
  ".gf Normal or old GF source, will be compiled.",
  ".gfc Compiled GF source, will be loaded as is.",
  ".gfe Example-based GF source, will be converted to .gf and compiled.",
  ".ebnf Extended BNF format, will be converted to .gf and compiled.",
  ".cf Context-free (BNF) format, will be converted to .gf and compiled.",
  "",
  "If multiple FILES are given, they must be normal GF source, .gfc or .gfe files.",
  "For the other input formats, only one file can be given.",
  "",
  "Command-line options:"]


helpMessage :: String
helpMessage = usageInfo usageHeader optDescr

-- Error monad

type ErrorMsg = String

data Err a = Ok a | Errors [ErrorMsg]
  deriving (Read, Show, Eq)

instance Monad Err where
  return      = Ok
  fail e      = Errors [e]
  Ok a  >>= f = f a
  Errors s >>= f = Errors s

errors :: [ErrorMsg] -> Err a
errors = Errors

-- Types

data Mode = Version | Help | Interactive | Compiler
  deriving (Show,Eq,Ord)

data Phase = Preproc | Convert | Compile | Link
  deriving (Show,Eq,Ord)

data Encoding = UTF_8 | ISO_8859_1
  deriving (Show,Eq,Ord)

data OutputFormat = FmtGFCC | FmtJS
  deriving (Show,Eq,Ord)

data Optimization = OptStem | OptCSE
  deriving (Show,Eq,Ord)

data Warning = WarnMissingLincat
  deriving (Show,Eq,Ord)

data Dump = DumpRebuild | DumpExtend | DumpRename | DumpTypecheck | DumpRefresh | DumpOptimize | DumpCanon
  deriving (Show,Eq,Ord)

data ModuleOptions = ModuleOptions {
      optPreprocessors   :: [String],
      optEncoding        :: Encoding,
      optOptimizations   :: [Optimization],
      optLibraryPath     :: [FilePath],
      optSpeechLanguage  :: Maybe String,
      optBuildParser     :: Bool,
      optWarnings        :: [Warning],
      optDump            :: [Dump]
    }
  deriving (Show)

data Options = Options {
      optMode            :: Mode,
      optStopAfterPhase  :: Phase,
      optVerbosity       :: Int,
      optShowCPUTime     :: Bool,
      optEmitGFO         :: Bool,
      optGFODir          :: FilePath,
      optOutputFormats   :: [OutputFormat],
      optOutputName      :: Maybe String,
      optOutputFile      :: Maybe FilePath,
      optOutputDir       :: FilePath,
      optForceRecomp     :: Bool,
      optProb            :: Bool,
      optStartCategory   :: Maybe String,
      optModuleOptions   :: ModuleOptions
    }
  deriving (Show)

-- Option parsing

parseOptions :: [String] -> Err (Options, [FilePath])
parseOptions args = case errs of
                      [] -> do o <- foldM (\o f -> f o) defaultOptions opts
                               return (o, files)
                      _  -> errors errs
    where (opts, files, errs) = getOpt RequireOrder optDescr args

parseModuleFlags :: Options -> [(String,String)] -> Err ModuleOptions
parseModuleFlags opts flags = foldr setOpt (optModuleOptions opts) moduleOptDescr
  where
    setOpt (Option _ ss arg _) d
            | null values = d
            | otherwise = case arg of
                            NoArg a -> 
                            ReqArg (String -> a) _ ->
OptArg (Maybe String -> a) String
last values
        where values = [v | (k,v) <- flags, k `elem` ss ]

-- Default options

defaultModuleOptions :: ModuleOptions
defaultModuleOptions = ModuleOptions {
      optPreprocessors   = [],
      optEncoding        = ISO_8859_1,
      optOptimizations   = [OptStem,OptCSE],
      optLibraryPath     = [],  
      optSpeechLanguage  = Nothing,
      optBuildParser     = True,
      optWarnings        = [],
      optDump            = []
    }

defaultOptions :: Options
defaultOptions = Options {
      optMode            = Interactive,
      optStopAfterPhase  = Link,
      optVerbosity       = 1,
      optShowCPUTime     = False,
      optEmitGFO         = True,
      optGFODir          = ".",
      optOutputFormats   = [FmtGFCC],
      optOutputName      = Nothing,
      optOutputFile      = Nothing,
      optOutputDir       = ".",
      optForceRecomp     = False,
      optProb            = False,
      optStartCategory   = Nothing,
      optModuleOptions   = defaultModuleOptions
    }

-- Option descriptions

moduleOptDescr :: [OptDescr (ModuleOptions -> Err ModuleOptions)]
moduleOptDescr = 
    [
     Option ['i'] [] (ReqArg addLibDir "DIR") "Add DIR to the library search path.",
     Option [] ["path"] (ReqArg setLibPath "DIR:DIR:...") "Set the library search path.",
     Option [] ["preproc"] (ReqArg preproc "CMD") 
                 (unlines ["Use CMD to preprocess input files.",
                           "Multiple preprocessors can be used by giving this option multiple times."]),
     Option [] ["stem"] (onOff (optimize OptStem) True) "Perform stem-suffix analysis (default on).",
     Option [] ["cse"] (onOff (optimize OptCSE) True) "Perform common sub-expression elimination (default on).",
     Option [] ["parser"] (onOff parser True) "Build parser (default on).",
     Option [] ["language"] (ReqArg language "LANG") "Set the speech language flag to LANG in the generated grammar."
    ]
    where
       addLibDir   x o = return $ o { optLibraryPath = x:optLibraryPath o }
       setLibPath  x o = return $ o { optLibraryPath = splitSearchPath x }
       preproc     x o = return $ o { optPreprocessors = optPreprocessors o ++ [x] }
       optimize  x b o = return $ o { optOptimizations = (if b then (x:) else delete x) (optOptimizations o) }
       parser      x o = return $ o { optBuildParser = x }
       language    x o = return $ o { optSpeechLanguage = Just x }

optDescr :: [OptDescr (Options -> Err Options)]
optDescr = 
    [
     Option ['E'] [] (NoArg (phase Preproc)) "Stop after preprocessing (with --preproc).",
     Option ['C'] [] (NoArg (phase Convert)) "Stop after conversion to .gf.",
     Option ['c'] [] (NoArg (phase Compile)) "Stop after compiling to .gfo.",
     Option ['V'] ["version"] (NoArg (mode Version)) "Display GF version number.",
     Option ['?','h'] ["help"] (NoArg (mode Help)) "Show help message.",
     Option ['v'] ["verbose"] (OptArg verbosity "N") "Set verbosity (default 1). -v alone is the same as -v 3.",
     Option ['q'] ["quiet"] (NoArg (verbosity (Just "0"))) "Quiet, same as -v 0.",
     Option [] ["batch"] (NoArg (mode Compiler)) "Run in batch compiler mode.",
     Option [] ["interactive"] (NoArg (mode Interactive)) "Run in interactive mode (default).",
     Option [] ["cpu"] (NoArg (cpu True)) "Show compilation CPU time statistics.",
     Option [] ["no-cpu"] (NoArg (cpu False)) "Don't show compilation CPU time statistics (default).",
     Option [] ["emit-gfo"] (NoArg (emitGFO True)) "Create .gfo files (default).",
     Option [] ["no-emit-gfo"] (NoArg (emitGFO False)) "Do not create .gfo files.",
     Option [] ["gfo-dir"] (ReqArg gfoDir "DIR") "Directory to put .gfo files in (default = '.').",
     Option ['f'] ["output-format"] (ReqArg outFmt "FMT") 
        (unlines ["Output format. FMT can be one of:",
                  "Multiple concrete: gfcc (default), gar, js, ...",
                  "Single concrete only: cf, bnf, lbnf, gsl, srgs_xml, srgs_abnf, ...",
                  "Abstract only: haskell, ..."]),
     Option ['n'] ["output-name"] (ReqArg outName "NAME") 
           ("Use NAME as the name of the output. This is used in the output file names, "
            ++ "with suffixes depending on the formats, and, when relevant, "
            ++ "internally in the output."),
     Option ['o'] ["output-file"] (ReqArg outFile "FILE") 
           "Save output in FILE (default is out.X, where X depends on output format.",
     Option ['D'] ["output-dir"] (ReqArg outDir "DIR") 
           "Save output files (other than .gfc files) in DIR.",
     Option [] ["src","force-recomp"] (NoArg (forceRecomp True)) 
                 "Always recompile from source, i.e. disable recompilation checking.",
     Option [] ["prob"] (NoArg (prob True)) "Read probabilities from '--# prob' pragmas.",
     Option [] ["startcat"] (ReqArg startcat "CAT") "Use CAT as the start category in the generated grammar."
    ] ++ map (fmap onModuleOptions) moduleOptDescr
 where phase       x o = return $ o { optStopAfterPhase = x }
       mode        x o = return $ o { optMode = x }
       verbosity mv o  = case mv of
                           Nothing -> return $ o { optVerbosity = 3 }
                           Just v  -> case reads v of
                                        [(i,"")] | i >= 0 -> return $ o { optVerbosity = i }
                                        _        -> fail $ "Bad verbosity: " ++ show v
       cpu         x o = return $ o { optShowCPUTime = x }
       emitGFO     x o = return $ o { optEmitGFO = x }
       gfoDir      x o = return $ o { optGFODir = x }
       outFmt      x o = readOutputFormat x >>= \f ->
                         return $ o { optOutputFormats = optOutputFormats o ++ [f] }
       outName     x o = return $ o { optOutputName = Just x }
       outFile     x o = return $ o { optOutputFile = Just x }
       outDir      x o = return $ o { optOutputDir = x }
       forceRecomp x o = return $ o { optForceRecomp = x }
       prob        x o = return $ o { optProb = x }
       startcat    x o = return $ o { optStartCategory = Just x }

onModuleOptions :: Monad m => (ModuleOptions -> m ModuleOptions) -> Options -> m Options
onModuleOptions f o = do mo' <- f (optModuleOptions o)
                         return $ o { optModuleOptions = mo' }

instance Functor OptDescr where
    fmap f (Option cs ss d s) = Option cs ss (fmap f d) s

instance Functor ArgDescr where
    fmap f (NoArg x)    = NoArg (f x)
    fmap f (ReqArg g s) = ReqArg (f . g) s
    fmap f (OptArg g s) = OptArg (f . g) s

outputFormats :: [(String,OutputFormat)]
outputFormats = 
    [("gfcc", FmtGFCC),
     ("js",   FmtJS)]

onOff :: Monad m => (Bool -> (a -> m a)) -> Bool -> ArgDescr (a -> m a)
onOff f def = OptArg g "[on,off]"
  where g ma x = do b <- maybe (return def) readOnOff ma
                    f b x
        readOnOff x = case map toLower x of
                        "on"  -> return True
                        "off" -> return False
                        _     -> fail $ "Expected [on,off], got: " ++ show x

readOutputFormat :: Monad m => String -> m OutputFormat
readOutputFormat s = 
    maybe (fail $ "Unknown output format: " ++ show s) return $ lookup s outputFormats
