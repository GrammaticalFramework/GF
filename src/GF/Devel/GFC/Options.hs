module GF.Devel.Options where

import Control.Monad
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


data Mode = Version | Help | Compiler
  deriving (Show)

data Phase = Preproc | Convert | Compile | Link
  deriving (Show)

data OutputFormat = FmtGFCC | FmtJS
  deriving (Show)

data Optimization = None
  deriving (Show)

data Options = Options {
                        optMode :: Mode,
                        optStopAfterPhase :: Phase,
                        optVerbosity :: Int,
                        optShowCPUTime :: Bool,
                        optEmitGFC :: Bool,
                        optGFCDir :: FilePath,
                        optOutputFormat :: OutputFormat,
                        optOutputFile :: Maybe FilePath,
                        optLibraryPath :: [FilePath],
                        optForceRecomp :: Bool,
                        optPreprocessors :: [String],
                        optOptimization :: Optimization,
                        optProb :: Bool,
                        optStartCategory :: Maybe String,
                        optSpeechLanguage :: Maybe String
                       }
  deriving (Show)

defaultOptions :: Options
defaultOptions = Options {
                          optMode = Compiler,
                          optStopAfterPhase = Link,
                          optVerbosity = 1,
                          optShowCPUTime = False,
                          optEmitGFC = True,
                          optGFCDir = ".",
                          optOutputFormat = FmtGFCC,
                          optOutputFile = Nothing,
                          optLibraryPath = [],
                          optForceRecomp = False,
                          optPreprocessors = [],
                          optOptimization = None,
                          optProb = False,
                          optStartCategory = Nothing,
                          optSpeechLanguage = Nothing
                         }



parseOptions :: [String] -> Err (Options, [FilePath])
parseOptions args = do case errs of
                         [] -> do o <- foldM (\o f -> f o) defaultOptions opts
                                  return (o, files)
                         _  -> errors errs
    where (opts, files, errs) = getOpt RequireOrder optDescr args

optDescr :: [OptDescr (Options -> Err Options)]
optDescr = 
    [
     Option ['E'] [] (NoArg (phase Preproc)) "Stop after preprocessing (with --preproc).",
     Option ['C'] [] (NoArg (phase Convert)) "Stop after conversion to .gf.",
     Option ['c'] [] (NoArg (phase Compile)) "Stop after compiling to .gfc.",
     Option ['V'] ["version"] (NoArg (mode Version)) "Display GF version number.",
     Option ['?','h'] ["help"] (NoArg (mode Help)) "Show help message.",
     Option ['v'] ["verbose"] (OptArg verbosity "N") "Set verbosity (default 1). -v alone is the same as -v 3.",
     Option ['q'] ["quiet"] (NoArg (verbosity (Just "0"))) "Quiet, same as -v 0.",
     Option [] ["cpu"] (NoArg (cpu True)) "Show compilation CPU time statistics.",
     Option [] ["no-cpu"] (NoArg (cpu False)) "Don't show compilation CPU time statistics (default).",
     Option [] ["emit-gfc"] (NoArg (emitGFC True)) "Create .gfc files (default).",
     Option [] ["no-emit-gfc"] (NoArg (emitGFC False)) "Do not create .gfc files.",
     Option [] ["gfc-dir"] (ReqArg gfcDir "DIR") "Directory to put .gfc files in (default = '.').",
     Option ['f'] ["output-format"] (ReqArg outFmt "FMT") 
        (unlines ["Output format. FMT can be one of:",
                  "Multiple concrete: gfcc (default), gar, js, ...",
                  "Single concrete only: cf, bnf, lbnf, gsl, srgs_xml, srgs_abnf, ...",
                  "Abstract only: haskell, ..."]),
     Option ['o'] ["output-file"] (ReqArg outFile "FILE") 
           "Save output in FILE (default is out.X, where X depends on output format.",
     Option ['i'] [] (ReqArg addLibDir "DIR") "Add DIR to the library search path.",
     Option [] ["path"] (ReqArg setLibPath "DIR:DIR:...") "Set the library search path.",
     Option [] ["src","force-recomp"] (NoArg (forceRecomp True)) 
                 "Always recompile from source, i.e. disable recompilation checking.",
     Option [] ["preproc"] (ReqArg preproc "CMD") 
                 (unlines ["Use CMD to preprocess input files.",
                           "Multiple preprocessors can be used by giving this option multiple times."]),
     Option ['O'] [] (OptArg optimize "OPT") 
                 "Perform the named optimization. Just -O means FIXME.",
     Option [] ["prob"] (NoArg (prob True)) "Read probabilities from '--# prob' pragmas.",
     Option [] ["startcat"] (ReqArg startcat "CAT") "Use CAT as the start category in the generated grammar.",
     Option [] ["language"] (ReqArg language "LANG") "Set the speech language flag to LANG in the generated grammar."
    ]
 where phase       x o = return $ o { optStopAfterPhase = x }
       mode        x o = return $ o { optMode = x }
       verbosity mv o  = case mv of
                           Nothing -> return $ o { optVerbosity = 3 }
                           Just v  -> case reads v of
                                        [(i,"")] | i >= 0 -> return $ o { optVerbosity = i }
                                        _        -> fail $ "Bad verbosity: " ++ show v
       cpu         x o = return $ o { optShowCPUTime = x }
       emitGFC     x o = return $ o { optEmitGFC = x }
       gfcDir      x o = return $ o { optGFCDir = x }
       outFmt      x o = readOutputFormat x >>= \f -> return $ o { optOutputFormat = f }
       outFile     x o = return $ o { optOutputFile = Just x }
       addLibDir   x o = return $ o { optLibraryPath = x:optLibraryPath o }
       setLibPath  x o = return $ o { optLibraryPath = splitSearchPath x }
       forceRecomp x o = return $ o { optForceRecomp = x }
       preproc     x o = return $ o { optPreprocessors = optPreprocessors o ++ [x] }
       optimize    x o = return $ o { optOptimization = None }
       prob        x o = return $ o { optProb = x }
       startcat    x o = return $ o { optStartCategory = Just x }
       language    x o = return $ o { optSpeechLanguage = Just x }


outputFormats :: [(String,OutputFormat)]
outputFormats = 
    [("gfcc", FmtGFCC),
     ("js",   FmtJS)]

readOutputFormat :: Monad m => String -> m OutputFormat
readOutputFormat s = 
    maybe (fail $ "Unknown output format: " ++ show s) return $ lookup s outputFormats
