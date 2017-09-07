module GF.Infra.Option
    (
     -- ** Command line options
     -- *** Option types
     Options, 
     Flags(..), 
     Mode(..), Phase(..), Verbosity(..), 
     OutputFormat(..), 
     SISRFormat(..), Optimization(..), CFGTransform(..), HaskellOption(..),
     Dump(..), Pass(..), Recomp(..),
     outputFormatsExpl, 
     -- *** Option parsing
     parseOptions, parseModuleOptions, fixRelativeLibPaths,
     -- *** Option pretty-printing
     optionsGFO,
     optionsPGF,
     -- *** Option manipulation
     addOptions, concatOptions, noOptions,
     modifyFlags,
     helpMessage,
     -- *** Checking specific options
     flag, cfgTransform, haskellOption, readOutputFormat,
     isLexicalCat, isLiteralCat, renameEncoding, getEncoding, defaultEncoding,
     -- *** Setting specific options
     setOptimization, setCFGTransform,
     -- *** Convenience methods for checking options
     verbAtLeast, dump
    ) where

import Control.Monad
import Data.Char (toLower, isDigit)
import Data.List
import Data.Maybe
import GF.Infra.Ident
import GF.Infra.GetOpt
import GF.Grammar.Predef
--import System.Console.GetOpt
import System.FilePath
--import System.IO

import GF.Data.Operations(Err,ErrorMonad(..),liftErr)

import Data.Set (Set)
import qualified Data.Set as Set

import PGF.Internal(Literal(..))

usageHeader :: String
usageHeader = unlines 
 ["Usage: gf [OPTIONS] [FILE [...]]",
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
errors :: ErrorMonad err => [String] -> err a
errors = raise . unlines

-- Types

data Mode = ModeVersion | ModeHelp
          | ModeInteractive | ModeRun
          | ModeInteractive2 | ModeRun2
          | ModeCompiler
          | ModeServer {-port::-}Int
  deriving (Show,Eq,Ord)

data Verbosity = Quiet | Normal | Verbose | Debug
  deriving (Show,Eq,Ord,Enum,Bounded)

data Phase = Preproc | Convert | Compile | Link
  deriving (Show,Eq,Ord)

data OutputFormat = FmtPGFPretty
                  | FmtJavaScript 
                  | FmtPython 
                  | FmtHaskell 
                  | FmtJava
                  | FmtProlog
                  | FmtBNF
                  | FmtEBNF
                  | FmtRegular
                  | FmtNoLR
                  | FmtSRGS_XML
                  | FmtSRGS_XML_NonRec
                  | FmtSRGS_ABNF 
                  | FmtSRGS_ABNF_NonRec
                  | FmtJSGF 
                  | FmtGSL 
                  | FmtVoiceXML
                  | FmtSLF
                  | FmtRegExp
                  | FmtFA
  deriving (Eq,Ord)

data SISRFormat = 
    -- | SISR Working draft 1 April 2003
    --   <http://www.w3.org/TR/2003/WD-semantic-interpretation-20030401/>
    SISR_WD20030401    
  | SISR_1_0
 deriving (Show,Eq,Ord)

data Optimization = OptStem | OptCSE | OptExpand | OptParametrize
  deriving (Show,Eq,Ord)

data CFGTransform = CFGNoLR 
                  | CFGRegular
                  | CFGTopDownFilter 
                  | CFGBottomUpFilter 
                  | CFGStartCatOnly
                  | CFGMergeIdentical
                  | CFGRemoveCycles
  deriving (Show,Eq,Ord)

data HaskellOption = HaskellNoPrefix | HaskellGADT | HaskellLexical
                   | HaskellConcrete | HaskellVariants
  deriving (Show,Eq,Ord)

data Warning = WarnMissingLincat
  deriving (Show,Eq,Ord)

newtype Dump = Dump Pass deriving (Show,Eq,Ord)
data Pass = Source | Rebuild | Extend | Rename | TypeCheck | Refresh | Optimize | Canon
  deriving (Show,Eq,Ord)

data Recomp = AlwaysRecomp | RecompIfNewer | NeverRecomp
  deriving (Show,Eq,Ord)

data Flags = Flags {
      optMode            :: Mode,
      optStopAfterPhase  :: Phase,
      optVerbosity       :: Verbosity,
      optShowCPUTime     :: Bool,
      optOutputFormats   :: [OutputFormat],
      optSISR            :: Maybe SISRFormat,
      optHaskellOptions  :: Set HaskellOption,
      optLexicalCats     :: Set String,
      optLiteralCats     :: Set Ident,
      optGFODir          :: Maybe FilePath,
      optOutputDir       :: Maybe FilePath,
      optGFLibPath       :: Maybe FilePath,
      optDocumentRoot    :: Maybe FilePath, -- For --server mode
      optRecomp          :: Recomp,
      optProbsFile       :: Maybe FilePath,
      optRetainResource  :: Bool,
      optName            :: Maybe String,
      optPreprocessors   :: [String],
      optEncoding        :: Maybe String,
      optPMCFG           :: Bool,
      optOptimizations   :: Set Optimization,
      optOptimizePGF     :: Bool,
      optSplitPGF        :: Bool,
      optCFGTransforms   :: Set CFGTransform,
      optLibraryPath     :: [FilePath],
      optStartCat        :: Maybe String,
      optSpeechLanguage  :: Maybe String,
      optLexer           :: Maybe String,
      optUnlexer         :: Maybe String,
      optWarnings        :: [Warning],
      optDump            :: [Dump],
      optTagsOnly        :: Bool,
      optHeuristicFactor :: Maybe Double,
      optCaseSensitive   :: Bool,
      optPlusAsBind      :: Bool,
      optJobs            :: Maybe (Maybe Int),
      optTrace           :: Bool
    }
  deriving (Show)

newtype Options = Options (Flags -> Flags)

instance Show Options where
    show (Options o) = show (o defaultFlags)

-- Option parsing

parseOptions :: ErrorMonad err =>
                [String]                   -- ^ list of string arguments
             -> err (Options, [FilePath])
parseOptions args 
  | not (null errs) = errors errs
  | otherwise       = do opts <- concatOptions `fmap` liftErr (sequence optss)
                         return (opts, files)
  where
    (optss, files, errs) = getOpt RequireOrder optDescr args

parseModuleOptions :: ErrorMonad err =>
                      [String]                   -- ^ list of string arguments
                   -> err Options
parseModuleOptions args = do
  (opts,nonopts) <- parseOptions args
  if null nonopts 
    then return opts
    else errors $ map ("Non-option among module options: " ++) nonopts

fixRelativeLibPaths curr_dir lib_dir (Options o) = Options (fixPathFlags . o)
  where
    fixPathFlags f@(Flags{optLibraryPath=path}) = f{optLibraryPath=concatMap (\dir -> [curr_dir </> dir, lib_dir </> dir]) path}

-- Showing options

-- | Pretty-print the options that are preserved in .gfo files.
optionsGFO :: Options -> [(String,Literal)]
optionsGFO opts = optionsPGF opts
      ++ [("coding", LStr (getEncoding opts))]

-- | Pretty-print the options that are preserved in .pgf files.
optionsPGF :: Options -> [(String,Literal)]
optionsPGF opts =
         maybe [] (\x -> [("language",LStr x)]) (flag optSpeechLanguage opts)
      ++ maybe [] (\x -> [("startcat",LStr x)]) (flag optStartCat opts)
      ++ maybe [] (\x -> [("heuristic_search_factor",LFlt x)]) (flag optHeuristicFactor opts)
      ++ (if flag optCaseSensitive opts then [] else [("case_sensitive",LStr "off")])

-- Option manipulation

flag :: (Flags -> a) -> Options -> a
flag f (Options o) = f (o defaultFlags)

addOptions :: Options -> Options -> Options
addOptions (Options o1) (Options o2) = Options (o2 . o1)

noOptions :: Options
noOptions = Options id

concatOptions :: [Options] -> Options
concatOptions = foldr addOptions noOptions

modifyFlags :: (Flags -> Flags) -> Options
modifyFlags = Options

getEncoding :: Options -> String
getEncoding = renameEncoding . maybe defaultEncoding id . flag optEncoding
defaultEncoding = "UTF-8"

-- Default options

defaultFlags :: Flags
defaultFlags = Flags {
      optMode            = ModeInteractive,
      optStopAfterPhase  = Compile,
      optVerbosity       = Normal,
      optShowCPUTime     = False,
      optOutputFormats   = [],
      optSISR            = Nothing,
      optHaskellOptions  = Set.empty,
      optLiteralCats     = Set.fromList [cString,cInt,cFloat,cVar],
      optLexicalCats     = Set.empty,
      optGFODir          = Nothing,
      optOutputDir       = Nothing,
      optGFLibPath       = Nothing,
      optDocumentRoot    = Nothing,
      optRecomp          = RecompIfNewer,
      optProbsFile       = Nothing,
      optRetainResource  = False,

      optName            = Nothing,
      optPreprocessors   = [],
      optEncoding        = Nothing,
      optPMCFG           = True,
      optOptimizations   = Set.fromList [OptStem,OptCSE,OptExpand,OptParametrize],
      optOptimizePGF     = False,
      optSplitPGF        = False,
      optCFGTransforms   = Set.fromList [CFGRemoveCycles, CFGBottomUpFilter, 
                                         CFGTopDownFilter, CFGMergeIdentical],
      optLibraryPath     = [],
      optStartCat        = Nothing,
      optSpeechLanguage  = Nothing,
      optLexer           = Nothing,
      optUnlexer         = Nothing,
      optWarnings        = [],
      optDump            = [],
      optTagsOnly        = False,
      optHeuristicFactor = Nothing,
      optCaseSensitive   = True,
      optPlusAsBind      = False,
      optJobs            = Nothing,
      optTrace           = False
    }

-- | Option descriptions
{-# NOINLINE optDescr #-}
optDescr :: [OptDescr (Err Options)]
optDescr = 
    [
     Option ['?','h'] ["help"] (NoArg (mode ModeHelp)) "Show help message.",
     Option ['V'] ["version"] (NoArg (mode ModeVersion)) "Display GF version number.",
     Option ['v'] ["verbose"] (OptArg verbosity "N") "Set verbosity (default 1). -v alone is the same as -v 2.",
     Option ['q','s'] ["quiet"] (NoArg (verbosity (Just "0"))) "Quiet, same as -v 0.",
     Option [] ["batch"] (NoArg (mode ModeCompiler)) "Run in batch compiler mode.",
     Option ['j'] ["jobs"] (OptArg jobs "N") "Compile N modules in parallel with -batch (default 1).",
     Option [] ["interactive"] (NoArg (mode ModeInteractive)) "Run in interactive mode (default).",
     Option [] ["run"] (NoArg (mode ModeRun)) "Run in interactive mode, showing output only (no other messages).",
     Option [] ["cshell"] (NoArg (mode ModeInteractive2)) "Start the C run-time shell.",
     Option [] ["crun"] (NoArg (mode ModeRun2)) "Start the C run-time shell, showing output only (no other messages).",
     Option [] ["server"] (OptArg modeServer "port") $
       "Run in HTTP server mode on given port (default "++show defaultPort++").",
     Option [] ["document-root"] (ReqArg gfDocuRoot "DIR")
           "Overrides the default document root for --server mode.",
     Option [] ["tags"] (NoArg (set $ \o -> o{optMode = ModeCompiler, optTagsOnly = True})) "Build TAGS file and exit.",
     Option ['E'] [] (NoArg (phase Preproc)) "Stop after preprocessing (with --preproc).",
     Option ['C'] [] (NoArg (phase Convert)) "Stop after conversion to .gf.",
     Option ['c'] [] (NoArg (phase Compile)) "Stop after compiling to .gfo (default) .",
     Option [] ["make"] (NoArg (liftM2 addOptions (mode ModeCompiler) (phase Link))) "Build .pgf file and other output files and exit.",
     Option [] ["cpu"] (NoArg (cpu True)) "Show compilation CPU time statistics.",
     Option [] ["no-cpu"] (NoArg (cpu False)) "Don't show compilation CPU time statistics (default).",
--   Option ['t'] ["trace"] (NoArg (trace True)) "Trace computations",
--   Option [] ["no-trace"] (NoArg (trace False)) "Don't trace computations",
     Option [] ["gfo-dir"] (ReqArg gfoDir "DIR") "Directory to put .gfo files in (default = '.').",
     Option ['f'] ["output-format"] (ReqArg outFmt "FMT") 
        (unlines ["Output format. FMT can be one of:",
                  "Multiple concrete: pgf (default), js, pgf_pretty, prolog, python, ...", -- gar,
                  "Single concrete only: bnf, ebnf, fa, gsl, jsgf, regexp, slf, srgs_xml, srgs_abnf, vxml, ....", -- cf, lbnf,
                  "Abstract only: haskell, ..."]), -- prolog_abs,
     Option [] ["sisr"] (ReqArg sisrFmt "FMT") 
        (unlines ["Include SISR tags in generated speech recognition grammars.",
                  "FMT can be one of: old, 1.0"]),
     Option [] ["haskell"] (ReqArg hsOption "OPTION") 
            ("Turn on an optional feature when generating Haskell data types. OPTION = " 
             ++ concat (intersperse " | " (map fst haskellOptionNames))),
     Option [] ["lexical"] (ReqArg lexicalCat "CAT[,CAT[...]]") 
            "Treat CAT as a lexical category.",
     Option [] ["literal"] (ReqArg literalCat "CAT[,CAT[...]]") 
            "Treat CAT as a literal category.",
     Option ['D'] ["output-dir"] (ReqArg outDir "DIR") 
           "Save output files (other than .gfo files) in DIR.",
     Option [] ["gf-lib-path"] (ReqArg gfLibPath "DIR") 
           "Overrides the value of GF_LIB_PATH.",
     Option [] ["src","force-recomp"] (NoArg (recomp AlwaysRecomp)) 
                 "Always recompile from source.",
     Option [] ["gfo","recomp-if-newer"] (NoArg (recomp RecompIfNewer)) 
                 "(default) Recompile from source if the source is newer than the .gfo file.",
     Option [] ["gfo","no-recomp"] (NoArg (recomp NeverRecomp)) 
                 "Never recompile from source, if there is already .gfo file.",
     Option [] ["retain"] (NoArg (set $ \o -> o { optRetainResource = True })) "Retain opers.",
     Option [] ["probs"] (ReqArg probsFile "file.probs") "Read probabilities from file.",
     Option ['n'] ["name"] (ReqArg name "NAME") 
           (unlines ["Use NAME as the name of the output. This is used in the output file names, ",
                     "with suffixes depending on the formats, and, when relevant, ",
                     "internally in the output."]),
     Option ['i'] [] (ReqArg addLibDir "DIR") "Add DIR to the library search path.",
     Option [] ["path"] (ReqArg setLibPath "DIR:DIR:...") "Set the library search path.",
     Option [] ["preproc"] (ReqArg preproc "CMD") 
                 (unlines ["Use CMD to preprocess input files.",
                           "Multiple preprocessors can be used by giving this option multiple times."]),
     Option [] ["coding"] (ReqArg coding "ENCODING") 
                ("Character encoding of the source grammar, ENCODING = utf8, latin1, cp1251, ..."),
     Option [] ["startcat"] (ReqArg startcat "CAT") "Grammar start category.",
     Option [] ["language"] (ReqArg language "LANG") "Set the speech language flag to LANG in the generated grammar.",
     Option [] ["lexer"] (ReqArg lexer "LEXER") "Use lexer LEXER.",
     Option [] ["unlexer"] (ReqArg unlexer "UNLEXER") "Use unlexer UNLEXER.",
     Option [] ["pmcfg"] (NoArg (pmcfg True)) "Generate PMCFG (default).",
     Option [] ["no-pmcfg"] (NoArg (pmcfg False)) "Don't generate PMCFG (useful for libraries).",
     Option [] ["optimize"] (ReqArg optimize "OPT") 
                "Select an optimization package. OPT = all | values | parametrize | none",
     Option [] ["optimize-pgf"] (NoArg (optimize_pgf True))
                "Enable or disable global grammar optimization. This could significantly reduce the size of the final PGF file",
     Option [] ["split-pgf"] (NoArg (splitPGF True))
                "Split the PGF into one file per language. This allows the runtime to load only individual languages",
     Option [] ["stem"] (onOff (toggleOptimize OptStem) True) "Perform stem-suffix analysis (default on).",
     Option [] ["cse"] (onOff (toggleOptimize OptCSE) True) "Perform common sub-expression elimination (default on).",
     Option [] ["cfg"] (ReqArg cfgTransform "TRANS") "Enable or disable specific CFG transformations. TRANS = merge, no-merge, bottomup, no-bottomup, ...",
     Option [] ["heuristic_search_factor"] (ReqArg (readDouble (\d o -> o { optHeuristicFactor = Just d })) "FACTOR") "Set the heuristic search factor for statistical parsing",
     Option [] ["case_sensitive"] (onOff (\v -> set $ \o -> o{optCaseSensitive=v}) True) "Set the parser in case-sensitive/insensitive mode [sensitive by default]",
     Option [] ["plus-as-bind"] (NoArg (set $ \o -> o{optPlusAsBind=True})) "Uses of (+) with runtime variables automatically generate BIND (experimental feature).",
     dumpOption "source" Source,
     dumpOption "rebuild" Rebuild,
     dumpOption "extend" Extend,
     dumpOption "rename" Rename,
     dumpOption "tc" TypeCheck,
     dumpOption "refresh" Refresh,
     dumpOption "opt" Optimize,
     dumpOption "canon" Canon
    ]
 where phase       x = set $ \o -> o { optStopAfterPhase = x }
       mode        x = set $ \o -> o { optMode = x }
       defaultPort   = 41296
       modeServer    = maybe (ms defaultPort) readPort
         where
           ms = mode . ModeServer
           readPort p = maybe err ms (readMaybe p)
                 where err = fail $ "Bad server port: "++p

       jobs          = maybe (setjobs Nothing) number
           where
             number s = maybe err (setjobs . Just) (readMaybe s)
               where err = fail $ "Bad number of jobs: " ++ s
             setjobs j = set $ \ o -> o { optJobs = Just j }

       verbosity mv  = case mv of
                           Nothing -> set $ \o -> o { optVerbosity = Verbose }
                           Just v  -> case readMaybe v >>= toEnumBounded of
                                        Just i  -> set $ \o -> o { optVerbosity = i }
                                        Nothing -> fail $ "Bad verbosity: " ++ show v
       cpu         x = set $ \o -> o { optShowCPUTime = x }
--     trace       x = set $ \o -> o { optTrace = x }
       gfoDir      x = set $ \o -> o { optGFODir = Just x }
       outFmt      x = readOutputFormat x >>= \f ->
                         set $ \o -> o { optOutputFormats = optOutputFormats o ++ [f] }
       sisrFmt     x = case x of
                         "old" -> set $ \o -> o { optSISR = Just SISR_WD20030401 }
                         "1.0" -> set $ \o -> o { optSISR = Just SISR_1_0 }
                         _     -> fail $ "Unknown SISR format: " ++ show x
       hsOption    x = case lookup x haskellOptionNames of
                         Just p  -> set $ \o -> o { optHaskellOptions = Set.insert p (optHaskellOptions o) }
                         Nothing -> fail $ "Unknown Haskell option: " ++ x
                                            ++ " Known: " ++ show (map fst haskellOptionNames)
       literalCat  x = set $ \o -> o { optLiteralCats = foldr Set.insert (optLiteralCats o) ((map identS . splitBy (==',')) x) }
       lexicalCat  x = set $ \o -> o { optLexicalCats = foldr Set.insert (optLexicalCats o) (splitBy (==',') x) }
       outDir      x = set $ \o -> o { optOutputDir = Just x }
       gfLibPath   x = set $ \o -> o { optGFLibPath = Just x }
       gfDocuRoot  x = set $ \o -> o { optDocumentRoot = Just x }
       recomp      x = set $ \o -> o { optRecomp = x }
       probsFile   x = set $ \o -> o { optProbsFile = Just x }

       name        x = set $ \o -> o { optName = Just x }
       addLibDir   x = set $ \o -> o { optLibraryPath = x:optLibraryPath o }
       setLibPath  x = set $ \o -> o { optLibraryPath = splitInModuleSearchPath x }
       preproc     x = set $ \o -> o { optPreprocessors = optPreprocessors o ++ [x] }
       coding      x = set $ \o -> o { optEncoding = Just x }
       startcat    x = set $ \o -> o { optStartCat = Just x }
       language    x = set $ \o -> o { optSpeechLanguage = Just x }
       lexer       x = set $ \o -> o { optLexer = Just x }
       unlexer     x = set $ \o -> o { optUnlexer = Just x }

       pmcfg       x = set $ \o -> o { optPMCFG = x }

       optimize    x = case lookup x optimizationPackages of
                         Just p  -> set $ \o -> o { optOptimizations = p }
                         Nothing -> fail $ "Unknown optimization package: " ++ x
                         
       optimize_pgf x = set $ \o -> o { optOptimizePGF = x }
       splitPGF x = set $ \o -> o { optSplitPGF = x }

       toggleOptimize x b = set $ setOptimization' x b

       cfgTransform x = let (x', b) = case x of
                                        'n':'o':'-':rest -> (rest, False)
                                        _                -> (x, True)
                         in case lookup x' cfgTransformNames of
                              Just t  -> set $ setCFGTransform' t b
                              Nothing -> fail $ "Unknown CFG transformation: " ++ x'
                                                ++ " Known: " ++ show (map fst cfgTransformNames)

       readDouble f x = case reads x of
                          [(d,"")] -> set $ f d
                          _        -> fail "A floating point number is expected"

       dumpOption s d = Option [] ["dump-"++s] (NoArg (set $ \o -> o { optDump = Dump d:optDump o})) ("Dump output of the " ++ s ++ " phase.")

       set = return . Options

outputFormats :: [(String,OutputFormat)]
outputFormats = map fst outputFormatsExpl

outputFormatsExpl :: [((String,OutputFormat),String)]
outputFormatsExpl = 
    [(("pgf_pretty",   FmtPGFPretty),"human-readable pgf"),
     (("js",           FmtJavaScript),"JavaScript (whole grammar)"),
     (("python",       FmtPython),"Python (whole grammar)"),
     (("haskell",      FmtHaskell),"Haskell (abstract syntax)"),
     (("java",         FmtJava),"Java (abstract syntax)"),
     (("prolog",       FmtProlog),"Prolog (whole grammar)"),
     (("bnf",          FmtBNF),"BNF (context-free grammar)"),
     (("ebnf",         FmtEBNF),"Extended BNF"),
     (("regular",      FmtRegular),"* regular grammar"),
     (("nolr",         FmtNoLR),"* context-free with no left recursion"),
     (("srgs_xml",     FmtSRGS_XML),"SRGS speech recognition format in XML"),
     (("srgs_xml_nonrec",     FmtSRGS_XML_NonRec),"SRGS XML, recursion eliminated"),
     (("srgs_abnf",    FmtSRGS_ABNF),"SRGS speech recognition format in ABNF"),
     (("srgs_abnf_nonrec",    FmtSRGS_ABNF_NonRec),"SRGS ABNF, recursion eliminated"),
     (("jsgf",         FmtJSGF),"JSGF speech recognition format"),
     (("gsl",          FmtGSL),"Nuance speech recognition format"),
     (("vxml",         FmtVoiceXML),"Voice XML based on abstract syntax"),
     (("slf",          FmtSLF),"SLF speech recognition format"),
     (("regexp",       FmtRegExp),"regular expression"),
     (("fa",           FmtFA),"finite automaton in graphviz format")
     ]

instance Show OutputFormat where
    show = lookupShow outputFormats

instance Read OutputFormat where
    readsPrec = lookupReadsPrec outputFormats

optimizationPackages :: [(String, Set Optimization)]
optimizationPackages = 
    [("all",         Set.fromList [OptStem,OptCSE,OptExpand,OptParametrize]),
     ("values",      Set.fromList [OptStem,OptCSE,OptExpand]),
     ("noexpand",    Set.fromList [OptStem,OptCSE]),
     
     -- deprecated
     ("all_subs",    Set.fromList [OptStem,OptCSE,OptExpand,OptParametrize]),
     ("parametrize", Set.fromList [OptStem,OptCSE,OptExpand,OptParametrize]),
     ("none",        Set.fromList [OptStem,OptCSE,OptExpand])
    ]

cfgTransformNames :: [(String, CFGTransform)]
cfgTransformNames = 
    [("nolr",         CFGNoLR),
     ("regular",      CFGRegular),
     ("topdown",      CFGTopDownFilter),
     ("bottomup",     CFGBottomUpFilter),
     ("startcatonly", CFGStartCatOnly),
     ("merge",        CFGMergeIdentical),
     ("removecycles", CFGRemoveCycles)]

haskellOptionNames :: [(String, HaskellOption)]
haskellOptionNames =
    [("noprefix", HaskellNoPrefix),
     ("gadt",     HaskellGADT),
     ("lexical",  HaskellLexical),
     ("concrete", HaskellConcrete),
     ("variants", HaskellVariants)]

-- | This is for bacward compatibility. Since GHC 6.12 we
-- started using the native Unicode support in GHC but it
-- uses different names for the code pages.
renameEncoding :: String -> String
renameEncoding "utf8"                      = "UTF-8"
renameEncoding "latin1"                    = "CP1252"
renameEncoding ('c':'p':s) | all isDigit s = 'C':'P':s
renameEncoding s                           = s

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
dump opts d = flag ((d `elem`) . optDump) opts

cfgTransform :: Options -> CFGTransform -> Bool
cfgTransform opts t = Set.member t (flag optCFGTransforms opts)

haskellOption :: Options -> HaskellOption -> Bool
haskellOption opts o = Set.member o (flag optHaskellOptions opts)

isLiteralCat :: Options -> Ident -> Bool
isLiteralCat opts c = Set.member c (flag optLiteralCats opts)

isLexicalCat :: Options -> String -> Bool
isLexicalCat opts c = Set.member c (flag optLexicalCats opts)

-- 
-- * Convenience functions for setting options
--

setOptimization :: Optimization -> Bool -> Options
setOptimization o b = modifyFlags (setOptimization' o b)

setOptimization' :: Optimization -> Bool -> Flags -> Flags
setOptimization' o b f = f { optOptimizations = toggle o b (optOptimizations f)}

setCFGTransform :: CFGTransform -> Bool -> Options
setCFGTransform t b = modifyFlags (setCFGTransform' t b)

setCFGTransform' :: CFGTransform -> Bool -> Flags -> Flags
setCFGTransform' t b f = f { optCFGTransforms = toggle t b (optCFGTransforms f) }

toggle :: Ord a => a -> Bool -> Set a -> Set a
toggle o True  = Set.insert o
toggle o False = Set.delete o

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

splitBy :: (a -> Bool) -> [a] -> [[a]]
splitBy _ [] = []
splitBy p s = case break p s of
                (l, _ : t@(_ : _)) -> l : splitBy p t
                (l, _) -> [l]

instance Functor OptDescr where
    fmap f (Option cs ss d s) = Option cs ss (fmap f d) s

instance Functor ArgDescr where
    fmap f (NoArg x)    = NoArg (f x)
    fmap f (ReqArg g s) = ReqArg (f . g) s
    fmap f (OptArg g s) = OptArg (f . g) s
