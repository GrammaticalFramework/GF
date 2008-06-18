module GF.Command.Commands (
  allCommands,
  lookCommand,
  exec,
  isOpt,
  options,
  flags,
  CommandInfo,
  CommandOutput
  ) where

import PGF
import PGF.CId
import PGF.ShowLinearize
import PGF.Macros
import PGF.Data ----
import PGF.Morphology
import PGF.Quiz
import GF.Compile.Export
import GF.Infra.Option (noOptions)
import GF.Infra.UseIO
import GF.Data.ErrM ----
import PGF.ExprSyntax (readExp)
import GF.Command.Abstract
import GF.Text.Lexing
import GF.Text.Transliterations

import GF.Data.Operations

import Data.Maybe
import qualified Data.Map as Map

type CommandOutput = ([Exp],String) ---- errors, etc

data CommandInfo = CommandInfo {
  exec     :: [Option] -> [Exp] -> IO CommandOutput,
  synopsis :: String,
  syntax   :: String,
  explanation :: String,
  longname :: String,
  options  :: [(String,String)],
  flags    :: [(String,String)],
  examples :: [String]
  }

emptyCommandInfo :: CommandInfo
emptyCommandInfo = CommandInfo {
  exec = \_ ts -> return (ts,[]), ----
  synopsis = "synopsis",
  syntax = "syntax",
  explanation = "explanation",
  longname = "longname",
  options = [],
  flags = [],
  examples = []
  }

lookCommand :: String -> Map.Map String CommandInfo -> Maybe CommandInfo
lookCommand = Map.lookup

commandHelpAll :: PGF -> [Option] -> String
commandHelpAll pgf opts = unlines
  [commandHelp (isOpt "full" opts) (co,info)
    | (co,info) <- Map.assocs (allCommands pgf)]

commandHelp :: Bool -> (String,CommandInfo) -> String
commandHelp full (co,info) = unlines $ [
  co ++ ", " ++ longname info,
  synopsis info] ++ if full then [
  "",
  "syntax:" ++++ "  " ++ syntax info,
  "",
  explanation info,
  "options:" ++++ unlines [" -" ++ o ++ "\t" ++ e | (o,e) <- options info],
  "flags:" ++++ unlines [" -" ++ o ++ "\t" ++ e | (o,e) <- flags info],
  "examples:" ++++ unlines ["  " ++ s | s <- examples info]
  ] else []

-- this list must no more be kept sorted by the command name
allCommands :: PGF -> Map.Map String CommandInfo
allCommands pgf = Map.fromList [
  ("cc", emptyCommandInfo {
     longname = "compute_concrete",
     syntax = "cc (-all | -table | -unqual)? TERM",
     synopsis = "computes concrete syntax term using a source grammar",
     explanation = unlines [
       "Compute TERM by concrete syntax definitions. Uses the topmost",
       "module (the last one imported) to resolve constant names.",
       "N.B.1 You need the flag -retain when importing the grammar, if you want",
       "the definitions to be retained after compilation.",
       "N.B.2 The resulting term is not a tree in the sense of abstract syntax",
       "and hence not a valid input to a Tree-expecting command.",
       "This command must be a line of its own, and thus cannot be a part",
       "of a pipe."
       ],
     options = [
       ("all","pick all strings (forms and variants) from records and tables"),
       ("table","show all strings labelled by parameters"),
       ("unqual","hide qualifying module names")
       ]
     }),
  ("dc",  emptyCommandInfo {
     longname = "define_command",
     syntax = "dc IDENT COMMANDLINE",
     synopsis = "define a command macro",
     explanation = unlines [
       "Defines IDENT as macro for COMMANDLINE, until IDENT gets redefined.",
       "A call of the command has the form %IDENT. The command may take an", 
       "argument, which in COMMANDLINE is marked as ?0. Both strings and",
       "trees can be arguments. Currently at most one argument is possible.",
       "This command must be a line of its own, and thus cannot be a part",
       "of a pipe."
       ] 
     }),
  ("dt",  emptyCommandInfo {
     longname = "define_tree",
     syntax = "dt IDENT (TREE | STRING)", -- | '<' COMMANDLINE)",
     synopsis = "define a tree or string macro",
     explanation = unlines [
       "Defines IDENT as macro for TREE or STRING, until IDENT gets redefined.",
       -- "The defining value can also come from a command, preceded by '<'.",
       "A use of the macro has the form %IDENT. Currently this use cannot be",
       "a subtree of another tree. This command must be a line of its own",
       "and thus cannot be a part of a pipe."
       ] 
     }),
  ("e",  emptyCommandInfo {
     longname = "empty",
     synopsis = "empty the environment"
     }),
  ("gr", emptyCommandInfo {
     longname = "generate_random",
     synopsis = "generate random trees in the current abstract syntax",
     syntax = "gr [-cat=CAT] [-number=INT]",
     examples = [
       "gr                     -- one tree in the startcat of the current grammar",
       "gr -cat=NP -number=16  -- 16 trees in the category NP"
       ],
     explanation = unlines [
       "Generates a list of random trees, by default one tree."
----       "If a tree argument is given, the command completes the Tree with values to",
----       "the metavariables in the tree."
       ],
     flags = [
       ("cat","generation category"),
       ("lang","excludes functions that have no linearization in this language"),
       ("number","number of trees generated")
       ],
     exec = \opts _ -> do
       let pgfr = optRestricted opts
       ts <- generateRandom pgfr (optCat opts)
       return $ fromTrees $ take (optNum opts) ts
     }),
  ("gt", emptyCommandInfo {
     longname = "generate_trees",
     synopsis = "generates a list of trees, by default exhaustive",
     explanation = unlines [
       "Generates all trees of a given category, with increasing depth.",
       "By default, the depth is inlimited, but this can be changed by a flag."
       ---- "If a Tree argument is given, thecommand completes the Tree with values",
       ---- "to the metavariables in the tree."
       ],
     flags = [
       ("cat","the generation category"),
       ("depth","the maximum generation depth"),
       ("lang","excludes functions that have no linearization in this language"),
       ("number","the number of trees generated")
       ],
     exec = \opts _ -> do
       let pgfr = optRestricted opts
       let dp = return $ valIntOpts "depth" 999999 opts
       let ts = generateAllDepth pgfr (optCat opts) dp
       return $ fromTrees $ take (optNumInf opts) ts
     }),
  ("h", emptyCommandInfo {
     longname = "help",
     syntax = "h (-full)? COMMAND?",
     synopsis = "get description of a command, or a the full list of commands",
     explanation = unlines [
       "Displays information concerning the COMMAND.",
       "Without argument, shows the synopsis of all commands."
       ],
     options = [
       ("full","give full information of the commands")
       ],
     exec = \opts ts -> return ([], case ts of
       [t] -> let co = showExp t in 
              case lookCommand co (allCommands pgf) of   ---- new map ??!!
                Just info -> commandHelp True (co,info)
                _ -> "command not found"
       _ -> commandHelpAll pgf opts)
     }),
  ("i", emptyCommandInfo {
     longname = "import",
     synopsis = "import a grammar from source code or compiled .pgf file",
     explanation = unlines [
       "Reads a grammar from File and compiles it into a GF runtime grammar.",
       "If a grammar with the same concrete name is already in the state",
       "it is overwritten - but only if compilation succeeds.",
       "The grammar parser depends on the file name suffix:",
       "  .gf    normal GF source",
       "  .gfo   compiled GF source",
       "  .pgf   precompiled grammar in Portable Grammar Format"
       ],
     options = [ 
       -- ["prob", "retain", "gfo", "src", "no-cpu", "cpu", "quiet", "verbose"]
       ("retain","retain operations (used for cc command)"),
       ("src",   "force compilation from source"),
       ("v",     "be verbose - show intermediate status information")
       ]
     }),
  ("l", emptyCommandInfo {
     longname = "linearize",
     synopsis = "convert an abstract syntax expression to string",
     explanation = unlines [
       "Shows the linearization of a Tree by the grammars in scope.",
       "The -lang flag can be used to restrict this to fewer languages.",
       "See also the ps command for unlexing and character encoding."
       ],
     examples = [
       "l -langs=LangSwe,LangNor no_Utt   -- linearize to LangSwe and LangNor"
       ],
     exec = \opts -> return . fromStrings . map (optLin opts),
     options = [
       ("all","show all forms and variants"),
       ("record","show source-code-like record"),
       ("table","show all forms labelled by parameters"),
       ("term", "show PGF term"),
       ("treebank","show the tree and tag linearizations with language names")
       ],
     flags = [
       ("lang","the languages of linearization (comma-separated, no spaces)")
       ]
     }),
  ("ma", emptyCommandInfo {
     longname = "morpho_analyse",
     synopsis = "print the morphological analyses of all words in the string",
     explanation = unlines [
       "Prints all the analyses of space-separated words in the input string,",
       "using the morphological analyser of the actual grammar (see command pf)"
       ],
     exec  = \opts ->  
               return . fromString . unlines . 
               map prMorphoAnalysis . concatMap (morphos opts) . 
               concatMap words . toStrings
     }),

  ("mq", emptyCommandInfo {
     longname = "morpho_quiz",
     synopsis = "start a morphology quiz",
     exec = \opts _ -> do
         let lang = optLang opts
         let cat  = optCat opts
         morphologyQuiz pgf lang cat
         return void,
     flags = [
       ("lang","language of the quiz"),
       ("cat","category of the quiz"),
       ("number","maximum number of questions")
       ] 
     }),

  ("p", emptyCommandInfo {
     longname = "parse",
     synopsis = "parse a string to abstract syntax expression",
     explanation = unlines [
       "Shows all trees returned by parsing a string in the grammars in scope.",
       "The -lang flag can be used to restrict this to fewer languages.",
       "The default start category can be overridden by the -cat flag.",
       "See also the ps command for lexing and character encoding."
       ],
     exec = \opts -> return . fromTrees . concatMap (par opts) . toStrings,
     flags = [
       ("cat","target category of parsing"),
       ("lang","the languages of parsing (comma-separated, no spaces)")
       ]
     }),
  ("pg", emptyCommandInfo { -----
     longname = "print_grammar",
     synopsis = "print the actual grammar with the given printer",
     explanation = unlines [
       "Prints the actual grammar, with all involved languages.", 
       "In some printers, this can be restricted to a subset of languages",
       "with the -lang=X,Y flag (comma-separated, no spaces).",
       "The -printer=P flag sets the format in which the grammar is printed.",
       "N.B.1 Since grammars are compiled when imported, this command",
       "generally shows a grammar that looks rather different from the source.",
       "N.B.2 This command is slightly obsolete: to produce different formats",
       "the batch compiler gfc is recommended, and has many more options."
       ],
     exec  = \opts _ -> return $ fromString $ prGrammar opts,
     flags = [
       --"cat",
       ("lang",   "select languages for the some options (default all languages)"),
       ("printer","select the printing format (see gfc --help)")
       ],
     options = [
       ("cats",   "show just the names of abstract syntax categories"),
       ("fullform", "print the fullform lexicon"),
       ("missing","show just the names of functions that have no linearization")
       ]
     }),
  ("ph", emptyCommandInfo {
     longname = "print_history",
     synopsis = "print command history",
     explanation = unlines [
       "Prints the commands issued during the GF session.",
       "The result is readable by the eh command.", 
       "The result can be used as a script when starting GF."
       ],
     examples = [
      "ph | wf -file=foo.gfs  -- save the history into a file"
      ]
     }),
  ("ps", emptyCommandInfo {
     longname = "put_string",
     syntax = "ps OPT? STRING",
     synopsis = "return a string, possibly processed with a function",
     explanation = unlines [
       "Returns a string obtained from its argument string by applying",
       "string processing functions in the order given in the command line",
       "option list. Thus 'ps -f -g s' returns g (f s). Typical string processors",
       "are lexers and unlexers, but also character encoding conversions are possible.",
       "The unlexers preserve the division of their input to lines.",
       "To see transliteration tables, use command ut." 
       ], 
     examples = [
       "l (EAdd 3 4) | ps -code              -- linearize code-like output",
       "ps -lexer=code | p -cat=Exp          -- parse code-like input",
       "gr -cat=QCl | l | ps -bind -to_utf8  -- linearization output from LangFin", 
       "ps -from_utf8 \"jag ?r h?r\" | p       -- parser in LangSwe in UTF8 terminal",
       "ps -to_devanagari -to_utf8 \"A-p\"     -- show Devanagari in UTF8 terminal"
       ],
     exec = \opts -> return . fromString . stringOps opts . toString,
     options = [
       ("bind","bind tokens separated by Prelude.BIND, i.e. &+"),
       ("from_devanagari","from unicode to GF Devanagari transliteration"),
       ("from_thai","from unicode to GF Thai transliteration"),
       ("from_utf8","decode from utf8"),
       ("lextext","text-like lexer"),
       ("lexcode","code-like lexer"),
       ("lexmixed","mixture of text and code (code between $...$)"), 
       ("to_devanagari","from GF Devanagari transliteration to unicode"),
       ("to_thai","from GF Thai transliteration to unicode"),
       ("to_utf8","encode to utf8"),
       ("unlextext","text-like unlexer"),
       ("unlexcode","code-like unlexer"),
       ("unlexmixed","mixture of text and code (code between $...$)"), 
       ("unwords","unlexer that puts a single space between tokens (default)"),
       ("words","lexer that assumes tokens separated by spaces (default)")
       ]
     }),
  ("q",  emptyCommandInfo {
     longname = "quit",
     synopsis = "exit GF interpreter"
     }),
  ("rf",  emptyCommandInfo {
     longname = "read_file",
     synopsis = "read string or tree input from a file",
     explanation = unlines [
       "Reads input from file. The filename must be in double quotes.",
       "The input is interpreted as a string by default, and can hence be",
       "piped e.g. to the parse command. The option -tree interprets the",
       "input as a tree, which can be given e.g. to the linearize command.",
       "The option -lines will result in a list of strings or trees, one by line." 
       ],
     options = [
       ("lines","return the list of lines, instead of the singleton of all contents"),
       ("tree","convert strings into trees")
       ],
     exec = \opts arg -> do 
       let file = valIdOpts "file" "_gftmp" opts
       s <- readFile file
       return $ case opts of
         _ | isOpt "lines" opts && isOpt "tree" opts -> 
               fromTrees [t | l <- lines s, Just t <- [readExp l]] 
         _ | isOpt "tree" opts -> 
               fromTrees [t | Just t <- [readExp s]] 
         _ | isOpt "lines" opts -> fromStrings $ lines s 
         _ -> fromString s,
     flags = [("file","the input file name")] 
     }),
  ("tq", emptyCommandInfo {
     longname = "translation_quiz",
     synopsis = "start a translation quiz",
     exec = \opts _ -> do
         let from = valIdOpts "from" (optLang opts) opts
         let to   = valIdOpts "to"   (optLang opts) opts
         let cat  = optCat opts
         translationQuiz pgf from to cat
         return void,
     flags = [
       ("from","translate from this language"),
       ("to","translate to this language"),
       ("cat","translate in this category"),
       ("number","the maximum number of questions")
       ] 
     }),
  ("ut", emptyCommandInfo {
     longname = "unicode_table",
     synopsis = "show a transliteration table for a unicode character set",
     exec = \opts arg -> do
         let t = concatMap prOpt (take 1 opts)
         let out = maybe "no such transliteration" characterTable $ transliteration t
         return $ fromString out,
     options = [
       ("devanagari","Devanagari"),
       ("thai",      "Thai")
       ] 
     }),
  ("wf", emptyCommandInfo {
     longname = "write_file",
     synopsis = "send string or tree to a file",
     exec = \opts arg -> do
         let file = valIdOpts "file" "_gftmp" opts
         if isOpt "append" opts 
           then appendFile file (toString arg)
           else writeFile file (toString arg)
         return void,
     options = [
       ("append","append to file, instead of overwriting it")
       ],
     flags = [("file","the output filename")] 
     })
  ]
 where
   lin opts t = unlines [linearize pgf lang t    | lang <- optLangs opts]
   par opts s = concat  [parse pgf lang (optCat opts) s | lang <- optLangs opts]
 
   void = ([],[])

   optLin opts t = case opts of 
     _ | isOpt "treebank" opts -> treebank opts t
     _ -> unlines [linear opts lang t | lang <- optLangs opts] 
    
   linear opts lang = case opts of
       _ | isOpt "all"    opts -> allLinearize pgf (mkCId lang)
       _ | isOpt "table"  opts -> tableLinearize pgf (mkCId lang)
       _ | isOpt "term"   opts -> termLinearize pgf (mkCId lang)
       _ | isOpt "record" opts -> recordLinearize pgf (mkCId lang)
       _  -> linearize pgf lang

   treebank opts t = unlines $ 
     (abstractName pgf ++ ": " ++ showExp t) :
     [lang ++ ": " ++ linear opts lang t | lang <- optLangs opts]

   optRestricted opts = restrictPGF (hasLin pgf (mkCId (optLang opts))) pgf

   optLangs opts = case valIdOpts "lang" "" opts of
     "" -> languages pgf
     lang -> chunks ',' lang
   optLang opts = head $ optLangs opts ++ ["#NOLANG"] 
   optCat opts = valIdOpts "cat" (lookStartCat pgf) opts
   optNum opts = valIntOpts "number" 1 opts
   optNumInf opts = valIntOpts "number" 1000000000 opts ---- 10^9

   fromTrees ts = (ts,unlines (map showExp ts))
   fromStrings ss = (map EStr ss, unlines ss)
   fromString  s  = ([EStr s], s)
   toStrings ts = [s | EStr s <- ts] 
   toString ts = unwords [s | EStr s <- ts] 

   prGrammar opts = case opts of
     _ | isOpt "cats" opts -> unwords $ categories pgf
     _ | isOpt "fullform" opts -> concatMap 
          (prFullFormLexicon . buildMorpho pgf . mkCId) $ optLangs opts
     _ | isOpt "missing" opts -> 
           unlines $ [unwords (la:":": map prCId cs) | 
                       la <- optLangs opts, let cs = missingLins pgf (mkCId la)]
     _ -> case valIdOpts "printer" "pgf" opts of
       v -> concatMap snd $ exportPGF noOptions (read v) pgf

   morphos opts s = 
     [lookupMorpho (buildMorpho pgf (mkCId la)) s | la <- optLangs opts]

   -- ps -f -g s returns g (f s)
   stringOps opts s = foldr app s (reverse (map prOpt opts)) where
     app f = maybe id id (stringOp f) 

translationQuiz :: PGF -> Language -> Language -> Category -> IO ()
translationQuiz pgf ig og cat = do
  tts <- translationList pgf ig og cat infinity
  mkQuiz "Welcome to GF Translation Quiz." tts

morphologyQuiz :: PGF -> Language -> Category -> IO ()
morphologyQuiz pgf ig cat = do
  tts <- morphologyList pgf ig cat infinity
  mkQuiz "Welcome to GF Morphology Quiz." tts

-- | the maximal number of precompiled quiz problems
infinity :: Int
infinity = 256

