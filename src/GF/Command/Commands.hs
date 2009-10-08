{-# LANGUAGE PatternGuards #-}

module GF.Command.Commands (
  allCommands,
  lookCommand,
  exec,
  isOpt,
  options,
  flags,
  needsTypeCheck,
  CommandInfo,
  CommandOutput
  ) where

import PGF
import PGF.CId
import PGF.ShowLinearize
import PGF.Macros
import PGF.Data ----
import PGF.Morphology
import PGF.VisualizeTree
import GF.Compile.Export
import GF.Infra.Option (noOptions, readOutputFormat, Encoding(..))
import GF.Infra.UseIO
import GF.Data.ErrM ----
import GF.Command.Abstract
import GF.Command.Messages
import GF.Text.Lexing
import GF.Text.Transliterations
import GF.Quiz

import GF.Command.TreeOperations ---- temporary place for typecheck and compute

import GF.Data.Operations
import GF.Text.Coding

import Data.List
import Data.Maybe
import qualified Data.Map as Map
import System.Cmd
import Text.PrettyPrint
import Data.List (sort)
import Debug.Trace

type CommandOutput = ([Expr],String) ---- errors, etc

data CommandInfo = CommandInfo {
  exec     :: [Option] -> [Expr] -> IO CommandOutput,
  synopsis :: String,
  syntax   :: String,
  explanation :: String,
  longname :: String,
  options  :: [(String,String)],
  flags    :: [(String,String)],
  examples :: [String],
  needsTypeCheck :: Bool
  }

emptyCommandInfo :: CommandInfo
emptyCommandInfo = CommandInfo {
  exec = \_ ts -> return (ts,[]), ----
  synopsis = "",
  syntax = "",
  explanation = "",
  longname = "",
  options = [],
  flags = [],
  examples = [],
  needsTypeCheck = True
  }

lookCommand :: String -> Map.Map String CommandInfo -> Maybe CommandInfo
lookCommand = Map.lookup

commandHelpAll :: Encoding -> PGFEnv -> [Option] -> String
commandHelpAll cod pgf opts = unlines
  [commandHelp (isOpt "full" opts) (co,info)
    | (co,info) <- Map.assocs (allCommands cod pgf)]

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

-- for printing with txt2tags formatting

commandHelpTags :: Bool -> (String,CommandInfo) -> String
commandHelpTags full (co,info) = unlines $ [
  "#VSPACE","","#NOINDENT",
  lit co ++ " = " ++ lit (longname info) ++ ": " ++
  "//" ++ synopsis info ++ ".//"] ++ if full then [
  "","#TINY","",
  explanation info,
  "- Syntax: ``" ++ syntax info ++ "``",
  "- Options:\n" ++++ 
   unlines [" | ``-" ++ o ++ "`` | " ++ e | (o,e) <- options info],
  "- Flags:\n" ++++ 
   unlines [" | ``-" ++ o ++ "`` | " ++ e | (o,e) <- flags info],
  "- Examples:\n```" ++++ 
   unlines ["  " ++ s | s <- examples info],
  "```",
  "", "#NORMAL", ""
  ] else []
 where
   lit s = "``" ++ s ++ "``"

type PGFEnv = (PGF, Map.Map Language Morpho)

-- this list must no more be kept sorted by the command name
allCommands :: Encoding -> PGFEnv -> Map.Map String CommandInfo
allCommands cod env@(pgf, mos) = Map.fromList [
  ("!", emptyCommandInfo {
     synopsis = "system command: escape to system shell",
     syntax   = "! SYSTEMCOMMAND",
     examples = [
       "! ls *.gf   -- list all GF files in the working directory"
       ],
     needsTypeCheck = False
     }),
  ("?", emptyCommandInfo {
     synopsis = "system pipe: send value from previous command to a system command",
     syntax   = "? SYSTEMCOMMAND",
     examples = [
       "gt | l | ? wc  -- generate, linearize, word-count"
       ],
     needsTypeCheck = False
     }),

  ("aw", emptyCommandInfo {
     longname = "align_words",
     synopsis = "show word alignments between languages graphically",
     explanation = unlines [
       "Prints a set of strings in the .dot format (the graphviz format).",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by graphviz and displayed by the program indicated",
       "by the flag. The target format is postscript, unless overridden by the",
       "flag -format."
       ],
     exec = \opts es -> do
         let grph = if null es then [] else alignLinearize pgf (head es)
         if isFlag "view" opts || isFlag "format" opts then do
           let file s = "_grph." ++ s
           let view = optViewGraph opts ++ " "
           let format = optViewFormat opts 
           writeFile (file "dot") (enc grph)
           system $ "dot -T" ++ format ++ " " ++ file "dot" ++ " > " ++ file format ++ 
                    " ; " ++ view ++ file format
           return void
          else return $ fromString grph,
     examples = [
       "gr | aw              -- generate a tree and show word alignment as graph script",
       "gr | vt -view=\"open\" -- generate a tree and display alignment on a Mac"
       ],
     options = [
       ],
     flags = [
       ("format","format of the visualization file (default \"png\")"),
       ("view","program to open the resulting file (default \"open\")")
       ] 
    }),

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
       ],
     needsTypeCheck = False
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
       ],
     needsTypeCheck = False
     }),
  ("dt",  emptyCommandInfo {
     longname = "define_tree",
     syntax = "dt IDENT (TREE | STRING | \"<\" COMMANDLINE)",
     synopsis = "define a tree or string macro",
     explanation = unlines [
       "Defines IDENT as macro for TREE or STRING, until IDENT gets redefined.",
       "The defining value can also come from a command, preceded by \"<\".",
       "If the command gives many values, the first one is selected.",
       "A use of the macro has the form %IDENT. Currently this use cannot be",
       "a subtree of another tree. This command must be a line of its own",
       "and thus cannot be a part of a pipe."
       ],
     examples = [
       ("dt ex \"hello world\"                    -- define ex as string"),
       ("dt ex UseN man_N                         -- define ex as string"),
       ("dt ex < p -cat=NP \"the man in the car\" -- define ex as parse result"),
       ("l -lang=LangSwe %ex | ps -to_utf8        -- linearize the tree ex")
       ],
     needsTypeCheck = False
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
       "gr -cat=NP -number=16  -- 16 trees in the category NP",
       "gr -lang=LangHin,LangTha -cat=Cl  -- Cl, both in LangHin and LangTha"
       ],
     explanation = unlines [
       "Generates a list of random trees, by default one tree."
----       "If a tree argument is given, the command completes the Tree with values to",
----       "the metavariables in the tree."
       ],
     flags = [
       ("cat","generation category"),
       ("lang","uses only functions that have linearizations in all these languages"),
       ("number","number of trees generated")
       ],
     exec = \opts _ -> do
       let pgfr = optRestricted opts
       ts <- generateRandom pgfr (optType opts)
       returnFromExprs $ take (optNum opts) ts
     }),
  ("gt", emptyCommandInfo {
     longname = "generate_trees",
     synopsis = "generates a list of trees, by default exhaustive",
     explanation = unlines [
       "Generates all trees of a given category, with increasing depth.",
       "By default, the depth is 4, but this can be changed by a flag."
       ---- "If a Tree argument is given, the command completes the Tree with values",
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
       let dp = return $ valIntOpts "depth" 4 opts
       let ts = generateAllDepth pgfr (optType opts) dp
       returnFromExprs $ take (optNumInf opts) ts
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
       ("changes","give a summary of changes from GF 2.9"),
       ("coding","give advice on character encoding"),
       ("full","give full information of the commands"),
       ("license","show copyright and license information")
       ],
     exec = \opts ts -> 
       let
        msg = case ts of
          _ | isOpt "changes" opts -> changesMsg
          _ | isOpt "coding" opts -> codingMsg
          _ | isOpt "license" opts -> licenseMsg
          [t] -> let co = getCommandOp (showExpr [] t) in 
                 case lookCommand co (allCommands cod env) of   ---- new map ??!!
                   Just info -> commandHelp True (co,info)
                   _ -> "command not found"
          _ -> commandHelpAll cod env opts
       in return (fromString msg),
     needsTypeCheck = False
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
       ],
     needsTypeCheck = False
     }),
  ("l", emptyCommandInfo {
     longname = "linearize",
     synopsis = "convert an abstract syntax expression to string",
     explanation = unlines [
       "Shows the linearization of a Tree by the grammars in scope.",
       "The -lang flag can be used to restrict this to fewer languages.",
       "A sequence of string operations (see command ps) can be given",
       "as options, and works then like a pipe to the ps command, except",
       "that it only affect the strings, not e.g. the table labels.",
       "These can be given separately to each language with the unlexer flag",
       "whose results are prepended to the other lexer flags. The value of the",
       "unlexer flag is a space-separated list of comma-separated string operation",
       "sequences; see example."
       ],
     examples = [
       "l -langs=LangSwe,LangNor no_Utt   -- linearize tree to LangSwe and LangNor",
       "gr -lang=LangHin -cat=Cl | l -table -to_devanagari -to_utf8 -- hindi table",
       "l -unlexer=\"LangSwe=to_utf8 LangHin=to_devanagari,to_utf8\" -- different lexers"
       ],
     exec = \opts -> return . fromStrings . map (optLin opts),
     options = [
       ("all","show all forms and variants"),
       ("bracket","show tree structure with brackets and paths to nodes"),
       ("multi","linearize to all languages (default)"),
       ("record","show source-code-like record"),
       ("table","show all forms labelled by parameters"),
       ("term", "show PGF term"),
       ("treebank","show the tree and tag linearizations with language names")
       ] ++ stringOpOptions,
     flags = [
       ("lang","the languages of linearization (comma-separated, no spaces)"),
       ("unlexer","set unlexers separately to each language (space-separated)")
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
         let typ  = optType opts
         morphologyQuiz cod pgf lang typ
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
     exec = \opts -> returnFromExprs . concatMap (par opts) . toStrings,
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
     exec  = \opts _ -> prGrammar opts,
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
       "l (EAdd 3 4) | ps -code         -- linearize code-like output",
       "ps -lexer=code | p -cat=Exp     -- parse code-like input",
       "gr -cat=QCl | l | ps -bind      -- linearization output from LangFin", 
       "ps -to_devanagari \"A-p\"         -- show Devanagari in UTF8 terminal",
       "rf -file=Hin.gf | ps -env=quotes -to_devanagari -- convert translit to UTF8",
       "rf -file=Ara.gf | ps -from_utf8 -env=quotes -from_arabic -- convert UTF8 to transliteration"
       ],
     exec = \opts -> 
               let (os,fs) = optsAndFlags opts in
               return . fromString . stringOps (envFlag fs) (map prOpt os) . toString,
     options = stringOpOptions,
     flags = [
       ("env","apply in this environment only")
       ]
     }),
  ("pt", emptyCommandInfo {
     longname = "put_tree",
     syntax = "ps OPT? TREE",
     synopsis = "return a tree, possibly processed with a function",
     explanation = unlines [
       "Returns a tree obtained from its argument tree by applying",
       "tree processing functions in the order given in the command line",
       "option list. Thus 'pt -f -g s' returns g (f s). Typical tree processors",
       "are type checking and semantic computation."
       ], 
     examples = [
       "pt -compute (plus one two)   -- compute value"
       ],
     exec = \opts -> returnFromExprs . treeOps opts,
     options = treeOpOptions pgf,
     flags = treeOpFlags pgf
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
     exec = \opts _ -> do 
       let file = valStrOpts "file" "_gftmp" opts
       s <- readFile file
       case opts of
         _ | isOpt "lines" opts && isOpt "tree" opts ->
               returnFromExprs [e | l <- lines s, Just e0 <- [readExpr l], Right (e,t) <- [inferExpr pgf e0]]
         _ | isOpt "tree" opts -> 
               returnFromExprs [e | Just e0 <- [readExpr s], Right (e,t) <- [inferExpr pgf e0]] 
         _ | isOpt "lines" opts -> return (fromStrings $ lines s)
         _ -> return (fromString s),
     flags = [("file","the input file name")] 
     }),
  ("tq", emptyCommandInfo {
     longname = "translation_quiz",
     synopsis = "start a translation quiz",
     exec = \opts _ -> do
         let from = valCIdOpts "from" (optLang opts) opts
         let to   = valCIdOpts "to"   (optLang opts) opts
         let typ  = optType opts
         translationQuiz cod pgf from to typ
         return void,
     flags = [
       ("from","translate from this language"),
       ("to","translate to this language"),
       ("cat","translate in this category"),
       ("number","the maximum number of questions")
       ] 
     }),
  ("se", emptyCommandInfo {
     longname = "set_encoding",
     synopsis = "set the encoding used in current terminal",
     syntax   = "se ID",
     examples = [
      "se cp1251 -- set encoding to cp1521",
      "se utf8   -- set encoding to utf8 (default)"
      ],
     needsTypeCheck = False
    }),
  ("sp", emptyCommandInfo {
     longname = "system_pipe",
     synopsis = "send argument to a system command",
     syntax   = "sp -command=\"SYSTEMCOMMAND\", alt. ? SYSTEMCOMMAND",
     exec = \opts arg -> do
       let tmpi = "_tmpi" ---
       let tmpo = "_tmpo"
       writeFile tmpi $ enc $ toString arg
       let syst = optComm opts ++ " " ++ tmpi
       system $ syst ++ " <" ++ tmpi ++ " >" ++ tmpo 
       s <- readFile tmpo
       return $ fromString s,
     flags = [
       ("command","the system command applied to the argument")
       ],
     examples = [
       "sp -command=\"wc\" \"foo\"",
       "gt | l | sp -command=\"grep \\\"who\\\"\" | sp -command=\"wc\""
       ]
     }),
  ("ut", emptyCommandInfo {
     longname = "unicode_table",
     synopsis = "show a transliteration table for a unicode character set",
     exec = \opts _ -> do
         let t = concatMap prOpt (take 1 opts)
         let out = maybe "no such transliteration" characterTable $ transliteration t
         return $ fromString out,
     options = transliterationPrintNames
     }),

  ("vd", emptyCommandInfo {
     longname = "visualize_dependency",
     synopsis = "show word dependency tree graphically",
     explanation = unlines [
       "Prints a dependency tree the .dot format (the graphviz format).",
       "By default, the last argument is the head of every abstract syntax",
       "function; moreover, the head depends on the head of the function above.",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by graphviz and displayed by the program indicated",
       "by the flag. The target format is png, unless overridden by the",
       "flag -format."
       ],
     exec = \opts es -> do
         let lang = optLang opts
         let grph = if null es then [] else dependencyTree Nothing pgf lang (head es)
         if isFlag "view" opts || isFlag "format" opts then do
           let file s = "_grph." ++ s
           let view = optViewGraph opts ++ " "
           let format = optViewFormat opts 
           writeFile (file "dot") (enc grph)
           system $ "dot -T" ++ format ++ " " ++ file "dot" ++ " > " ++ file format ++ 
                    " ; " ++ view ++ file format
           return void
          else return $ fromString grph,
     examples = [
       "gr | aw              -- generate a tree and show word alignment as graph script",
       "gr | vt -view=\"open\" -- generate a tree and display alignment on a Mac"
       ],
     options = [
       ],
     flags = [
       ("format","format of the visualization file (default \"png\")"),
       ("view","program to open the resulting file (default \"open\")")
       ] 
    }),


  ("vp", emptyCommandInfo {
     longname = "visualize_parse",
     synopsis = "show parse tree graphically",
     explanation = unlines [
       "Prints a parse tree the .dot format (the graphviz format).",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by graphviz and displayed by the program indicated",
       "by the flag. The target format is png, unless overridden by the",
       "flag -format."
       ],
     exec = \opts es -> do
         let lang = optLang opts
         let grph = if null es then [] else parseTree Nothing pgf lang (head es)
         if isFlag "view" opts || isFlag "format" opts then do
           let file s = "_grph." ++ s
           let view = optViewGraph opts ++ " "
           let format = optViewFormat opts 
           writeFile (file "dot") (enc grph)
           system $ "dot -T" ++ format ++ " " ++ file "dot" ++ " > " ++ file format ++ 
                    " ; " ++ view ++ file format
           return void
          else return $ fromString grph,
     examples = [
       "gr | aw              -- generate a tree and show word alignment as graph script",
       "gr | vt -view=\"open\" -- generate a tree and display alignment on a Mac"
       ],
     options = [
       ],
     flags = [
       ("format","format of the visualization file (default \"png\")"),
       ("view","program to open the resulting file (default \"open\")")
       ] 
    }),

  ("vt", emptyCommandInfo {
     longname = "visualize_tree",
     synopsis = "show a set of trees graphically",
     explanation = unlines [
       "Prints a set of trees in the .dot format (the graphviz format).",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by graphviz and displayed by the program indicated",
       "by the flag. The target format is postscript, unless overridden by the",
       "flag -format."
       ],
     exec = \opts es -> do
         let funs = not (isOpt "nofun" opts)
         let cats = not (isOpt "nocat" opts)
         let grph = visualizeTrees pgf (funs,cats) es -- True=digraph
         if isFlag "view" opts || isFlag "format" opts then do
           let file s = "_grph." ++ s
           let view = optViewGraph opts ++ " "
           let format = optViewFormat opts 
           writeFile (file "dot") (enc grph)
           system $ "dot -T" ++ format ++ " " ++ file "dot" ++ " > " ++ file format ++ 
                    " ; " ++ view ++ file format
           return void
          else return $ fromString grph,
     examples = [
       "p \"hello\" | vt              -- parse a string and show trees as graph script",
       "p \"hello\" | vt -view=\"open\" -- parse a string and display trees on a Mac"
       ],
     options = [
       ("nofun","don't show functions but only categories"),
       ("nocat","don't show categories but only functions")
       ],
     flags = [
       ("format","format of the visualization file (default \"png\")"),
       ("view","program to open the resulting file (default \"open\")")
       ] 
     }),
  ("wf", emptyCommandInfo {
     longname = "write_file",
     synopsis = "send string or tree to a file",
     exec = \opts arg -> do
         let file = valStrOpts "file" "_gftmp" opts
         if isOpt "append" opts 
           then appendFile file (enc (toString arg))
           else writeFile file (enc (toString arg))
         return void,
     options = [
       ("append","append to file, instead of overwriting it")
       ],
     flags = [("file","the output filename")] 
     }),
  ("ai", emptyCommandInfo {
     longname = "abstract_info",
     syntax = "ai IDENTIFIER  or  ai EXPR",
     synopsis = "Provides an information about a function, an expression or a category from the abstract syntax",
     explanation = unlines [
       "The command has one argument which is either function, expression or",
       "a category defined in the abstract syntax of the current grammar. ",
       "If the argument is a function then ?its type is printed out.",
       "If it is a category then the category definition is printed.",
       "If a whole expression is given it prints the expression with refined",
       "metavariables and the type of the expression."
       ],
     exec = \opts arg -> do
       case arg of
         [EFun id] -> case Map.lookup id (funs (abstract pgf)) of
                        Just (ty,_,eqs) -> return $ fromString $
                                              render (text "fun" <+> ppCId id <+> colon <+> ppType 0 [] ty $$
                                                      if null eqs
                                                        then empty
                                                        else text "def" <+> vcat [let (scope,ds) = mapAccumL (ppPatt 9) [] patts
                                                                                  in ppCId id <+> hsep ds <+> char '=' <+> ppExpr 0 scope res | Equ patts res <- eqs])
                        Nothing         -> case Map.lookup id (cats (abstract pgf)) of
                                             Just hyps -> do return $ fromString $
                                                                render (text "cat" <+> ppCId id <+> hsep (snd (mapAccumL ppHypo [] hyps)) $$
                                                                        if null (functionsToCat pgf id)
                                                                          then empty
                                                                          else space $$
                                                                               text "fun" <+> vcat [ppCId fid <+> colon <+> ppType 0 [] ty 
                                                                                                       | (fid,ty) <- functionsToCat pgf id])
                                             Nothing   -> do putStrLn ("unknown category of function identifier "++show id)
                                                             return void
         [e]         -> case inferExpr pgf e of
                          Left tcErr   -> error $ render (ppTcError tcErr)
                          Right (e,ty) -> do putStrLn ("Expression: "++showExpr [] e)
                                             putStrLn ("Type:       "++showType [] ty)
                                             return void
         _           -> do putStrLn "a single identifier or expression is expected from the command"
                           return void,
     needsTypeCheck = False
     })
  ]
 where
   enc = encodeUnicode cod
   par opts s = concat  [parse pgf lang (optType opts) s | lang <- optLangs opts, canParse pgf lang]
 
   void = ([],[])

   optLin opts t = unlines $ 
     case opts of 
       _ | isOpt "treebank" opts -> (showCId (abstractName pgf) ++ ": " ++ showExpr [] t) :
                                    [showCId lang ++ ": " ++ linear opts lang t | lang <- optLangs opts]
       _                         -> [linear opts lang t | lang <- optLangs opts] 
    
   linear :: [Option] -> CId -> Expr -> String
   linear opts lang = let unl = unlex opts lang in case opts of
       _ | isOpt "all"     opts -> allLinearize unl pgf lang
       _ | isOpt "table"   opts -> tableLinearize unl pgf lang
       _ | isOpt "term"    opts -> termLinearize pgf lang
       _ | isOpt "record"  opts -> recordLinearize pgf lang
       _ | isOpt "bracket" opts -> markLinearize pgf lang
       _                        -> unl . linearize pgf lang

   unlex opts lang = stringOps Nothing (getUnlex opts lang ++ map prOpt opts) ----

   getUnlex opts lang = case words (valStrOpts "unlexer" "" opts) of
     lexs -> case lookup lang 
               [(mkCId la,tail le) | lex <- lexs, let (la,le) = span (/='=') lex, not (null le)] of
       Just le -> chunks ',' le
       _ -> []

-- Proposed logic of coding in unlexing:
--   - If lang has no coding flag, or -to_utf8 is not in opts, just opts are used.
--   - If lang has flag coding=utf8, -to_utf8 is ignored.
--   - If lang has coding=other, and -to_utf8 is in opts, from_other is applied first.
-- THIS DOES NOT WORK UNFORTUNATELY - can't use the grammar flag properly
   unlexx opts lang = {- trace (unwords optsC) $ -} stringOps Nothing optsC where ----
     optsC = case lookFlag pgf lang "coding" of
       Just "utf8" -> filter (/="to_utf8") $ map prOpt opts
       Just other | isOpt "to_utf8" opts -> 
                      let cod = ("from_" ++ other) 
                      in cod : filter (/=cod) (map prOpt opts)
       _ -> map prOpt opts

   optRestricted opts = 
     restrictPGF (\f -> and [hasLin pgf la f | la <- optLangs opts]) pgf

   optLangs opts = case valStrOpts "lang" "" opts of
     "" -> languages pgf
     lang -> map mkCId (chunks ',' lang)
   optLang opts = head $ optLangs opts ++ [wildCId]
   optType opts = 
     let str = valStrOpts "cat" (showCId $ lookStartCat pgf) opts
     in case readType str of
          Just ty -> case checkType pgf ty of
                       Left tcErr -> error $ render (ppTcError tcErr)
                       Right ty   -> ty
          Nothing -> error ("Can't parse '"++str++"' as type")
   optComm opts = valStrOpts "command" "" opts
   optViewFormat opts = valStrOpts "format" "png" opts
   optViewGraph opts = valStrOpts "view" "open" opts
   optNum opts = valIntOpts "number" 1 opts
   optNumInf opts = valIntOpts "number" 1000000000 opts ---- 10^9
   
   fromExprs   es = (es,unlines (map (showExpr []) es))
   fromStrings ss = (map (ELit . LStr) ss, unlines ss)
   fromString  s  = ([ELit (LStr s)], s)
   toStrings = map showAsString 
   toString = unwords . toStrings

   returnFromExprs es = return $ case es of
     [] -> ([], "no trees found")
     _  -> fromExprs es

   prGrammar opts
     | isOpt "cats"     opts = return $ fromString $ unwords $ map (showType []) $ categories pgf
     | isOpt "fullform" opts = return $ fromString $ concatMap (morpho "" prFullFormLexicon) $ optLangs opts
     | isOpt "missing"  opts = return $ fromString $ unlines $ [unwords (showCId la:":": map showCId cs) | 
                                                                  la <- optLangs opts, let cs = missingLins pgf la]
     | otherwise             = do fmt <- readOutputFormat (valStrOpts "printer" "pgf_pretty" opts)
                                  return $ fromString $ concatMap snd $ exportPGF noOptions fmt pgf

   morphos opts s = 
     [morpho [] (\mo -> lookupMorpho mo s) la | la <- optLangs opts]

   morpho z f la = maybe z f $ Map.lookup la mos

   -- ps -f -g s returns g (f s)
   stringOps menv opts s = foldr (menvop . app) s (reverse opts) where
     app f = maybe id id (stringOp f) 
     menvop op = maybe op (\ (b,e) -> opInEnv b e op) menv

   envFlag fs = case valStrOpts "env" "global" fs of
     "quotes" -> Just ("\"","\"")
     _ -> Nothing

   treeOps opts s = foldr app s (reverse opts) where
     app (OOpt  op)         | Just (Left  f) <- treeOp pgf op = f
     app (OFlag op (VId x)) | Just (Right f) <- treeOp pgf op = f (mkCId x)
     app _                                                    = id

   showAsString t = case t of
     ELit (LStr s) -> s
     _ -> "\n" ++ showExpr [] t  --- newline needed in other cases than the first

stringOpOptions = sort $ [
       ("bind","bind tokens separated by Prelude.BIND, i.e. &+"),
       ("chars","lexer that makes every non-space character a token"),
       ("from_cp1251","decode from cp1251 (Cyrillic used in Bulgarian resource)"),
       ("from_utf8","decode from utf8 (default)"),
       ("lextext","text-like lexer"),
       ("lexcode","code-like lexer"),
       ("lexmixed","mixture of text and code (code between $...$)"), 
       ("to_cp1251","encode to cp1251 (Cyrillic used in Bulgarian resource)"),
       ("to_html","wrap in a html file with linebreaks"),
       ("to_utf8","encode to utf8 (default)"),
       ("unlextext","text-like unlexer"),
       ("unlexcode","code-like unlexer"),
       ("unlexmixed","mixture of text and code (code between $...$)"), 
       ("unchars","unlexer that puts no spaces between tokens"),
       ("unwords","unlexer that puts a single space between tokens (default)"),
       ("words","lexer that assumes tokens separated by spaces (default)")
       ] ++
      concat [
       [("from_" ++ p, "from unicode to GF " ++ n ++ " transliteration"),
        ("to_"   ++ p, "from GF " ++ n ++ " transliteration to unicode")] |
                                    (p,n) <- transliterationPrintNames]

treeOpOptions pgf = [(op,expl) | (op,(expl,Left  _)) <- allTreeOps pgf]
treeOpFlags   pgf = [(op,expl) | (op,(expl,Right _)) <- allTreeOps pgf]

translationQuiz :: Encoding -> PGF -> Language -> Language -> Type -> IO ()
translationQuiz cod pgf ig og typ = do
  tts <- translationList pgf ig og typ infinity
  mkQuiz cod "Welcome to GF Translation Quiz." tts

morphologyQuiz :: Encoding -> PGF -> Language -> Type -> IO ()
morphologyQuiz cod pgf ig typ = do
  tts <- morphologyList pgf ig typ infinity
  mkQuiz cod "Welcome to GF Morphology Quiz." tts

-- | the maximal number of precompiled quiz problems
infinity :: Int
infinity = 256

lookFlag :: PGF -> String -> String -> Maybe String
lookFlag pgf lang flag = lookConcrFlag pgf (mkCId lang) (mkCId flag)

prFullFormLexicon :: Morpho -> String
prFullFormLexicon mo = 
  unlines [w ++ " : " ++ prMorphoAnalysis ts | (w,ts) <- fullFormLexicon mo]

prMorphoAnalysis :: [(Lemma,Analysis)] -> String
prMorphoAnalysis lps = unlines [showCId l ++ " " ++ p | (l,p) <- lps]

