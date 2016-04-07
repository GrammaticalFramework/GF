-- | Commands that work in any type of environment, either because they don't
-- use the PGF, or because they are just documented here and implemented
-- elsewhere
module GF.Command.CommonCommands where
import Data.List(sort)
import GF.Command.CommandInfo
import qualified Data.Map as Map
import GF.Infra.SIO
import GF.Infra.UseIO(writeUTF8File)
import GF.Infra.Option(renameEncoding)
import GF.System.Console(changeConsoleEncoding)
import GF.System.Process
import GF.Command.Abstract --(isOpt,valStrOpts,prOpt)
import GF.Text.Pretty
import GF.Text.Transliterations
import GF.Text.Lexing(stringOp,opInEnv)

import qualified PGF as H(showCId,showExpr,toATree,toTrie,Trie(..))

extend old new = Map.union (Map.fromList new) old -- Map.union is left-biased

commonCommands :: (Monad m,MonadSIO m) => Map.Map String (CommandInfo m)
commonCommands = fmap (mapCommandExec liftSIO) $ Map.fromList [
  ("!", emptyCommandInfo {
     synopsis = "system command: escape to system shell",
     syntax   = "! SYSTEMCOMMAND",
     examples = [
       ("! ls *.gf",  "list all GF files in the working directory")
       ]
     }),
  ("?", emptyCommandInfo {
     synopsis = "system pipe: send value from previous command to a system command",
     syntax   = "? SYSTEMCOMMAND",
     examples = [
       ("gt | l | ? wc",  "generate, linearize, word-count")
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
       mkEx ("dt ex \"hello world\"                    -- define ex as string"),
       mkEx ("dt ex UseN man_N                         -- define ex as string"),
       mkEx ("dt ex < p -cat=NP \"the man in the car\" -- define ex as parse result"),
       mkEx ("l -lang=LangSwe %ex | ps -to_utf8        -- linearize the tree ex")
       ]
     }),
  ("e",  emptyCommandInfo {
     longname = "empty",
     synopsis = "empty the environment"
     }),
  ("eh",  emptyCommandInfo {
     longname = "execute_history",
     syntax = "eh FILE",
     synopsis = "read commands from a file and execute them"
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
      mkEx "ph | wf -file=foo.gfs  -- save the history into a file"
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
--       mkEx "l (EAdd 3 4) | ps -code         -- linearize code-like output",
       mkEx "l (EAdd 3 4) | ps -unlexcode    -- linearize code-like output",
--       mkEx "ps -lexer=code | p -cat=Exp     -- parse code-like input",
       mkEx "ps -lexcode | p -cat=Exp        -- parse code-like input",
       mkEx "gr -cat=QCl | l | ps -bind      -- linearization output from LangFin",
       mkEx "ps -to_devanagari \"A-p\"         -- show Devanagari in UTF8 terminal",
       mkEx "rf -file=Hin.gf | ps -env=quotes -to_devanagari -- convert translit to UTF8",
       mkEx "rf -file=Ara.gf | ps -from_utf8 -env=quotes -from_arabic -- convert UTF8 to transliteration",
       mkEx "ps -to=chinese.trans \"abc\"      -- apply transliteration defined in file chinese.trans",
       mkEx "ps -lexgreek \"a)gavoi` a)'nvrwpoi' tines*\" -- normalize ancient greek accentuation"
       ],
     exec = \opts x-> do
               let (os,fs) = optsAndFlags opts
               trans <- optTranslit opts

               if isOpt "lines" opts 
                  then return $ fromStrings $ map (trans . stringOps (envFlag fs) (map prOpt os)) $ toStrings x
                  else return ((fromString . trans . stringOps (envFlag fs) (map prOpt os) . toString) x),
     options = [
       ("lines","apply the operation separately to each input line, returning a list of lines")
       ] ++
       stringOpOptions,
     flags = [
       ("env","apply in this environment only"),
       ("from","backward-apply transliteration defined in this file (format 'unicode translit' per line)"),
       ("to",  "forward-apply transliteration defined in this file")
       ]
     }),
  ("q",  emptyCommandInfo {
     longname = "quit",
     synopsis = "exit GF interpreter"
     }),
  ("r",  emptyCommandInfo {
     longname = "reload",
     synopsis = "repeat the latest import command"
     }),

  ("se", emptyCommandInfo {
     longname = "set_encoding",
     synopsis = "set the encoding used in current terminal",
     syntax   = "se ID",
     examples = [
      mkEx "se cp1251 -- set encoding to cp1521",
      mkEx "se utf8   -- set encoding to utf8 (default)"
      ],
     needsTypeCheck = False,
     exec = \ opts ts ->
       case words (toString ts) of
         [c] -> do let cod = renameEncoding c
                   restricted $ changeConsoleEncoding cod
                   return void
         _ -> return (pipeMessage "se command not parsed")
    }),
  ("sp", emptyCommandInfo {
     longname = "system_pipe",
     synopsis = "send argument to a system command",
     syntax   = "sp -command=\"SYSTEMCOMMAND\", alt. ? SYSTEMCOMMAND",
     exec = \opts arg -> do
       let syst = optComm opts  -- ++ " " ++ tmpi
       {-
       let tmpi = "_tmpi" ---
       let tmpo = "_tmpo"
       restricted $ writeFile tmpi $ toString arg
       restrictedSystem $ syst ++ " <" ++ tmpi ++ " >" ++ tmpo
       fmap fromString $ restricted $ readFile tmpo,
       -}
       fmap fromString . restricted . readShellProcess syst $ toString arg,
     flags = [
       ("command","the system command applied to the argument")
       ],
     examples = [
       mkEx "gt | l | ? wc  -- generate trees, linearize, and count words"
       ]
     }),
  ("tt", emptyCommandInfo {
     longname = "to_trie",
     syntax = "to_trie",
     synopsis = "combine a list of trees into a trie",
     exec = \ _ -> return . fromString . trie . toExprs
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
  ("wf", emptyCommandInfo {
     longname = "write_file",
     synopsis = "send string or tree to a file",
     exec = \opts arg-> do
         let file = valStrOpts "file" "_gftmp" opts
         if isOpt "append" opts
           then restricted $ appendFile file (toLines arg)
           else restricted $ writeUTF8File file (toLines arg)
         return void,
     options = [
       ("append","append to file, instead of overwriting it")
       ],
     flags = [("file","the output filename")]
     })
  ]
 where
   optComm opts = valStrOpts "command" "" opts

   optTranslit opts = case (valStrOpts "to" "" opts, valStrOpts "from" "" opts) of
     ("","")  -> return id
     (file,"") -> do
       src <- restricted $ readFile file
       return $ transliterateWithFile file src False
     (_,file) -> do
       src <- restricted $ readFile file
       return $ transliterateWithFile file src True

stringOps menv opts s = foldr (menvop . app) s (reverse opts)
  where
    app f = maybe id id (stringOp f)
    menvop op = maybe op (\ (b,e) -> opInEnv b e op) menv

envFlag fs =
  case valStrOpts "env" "global" fs of
    "quotes" -> Just ("\"","\"")
    _ -> Nothing

stringOpOptions = sort $ [
       ("bind","bind tokens separated by Prelude.BIND, i.e. &+"),
       ("chars","lexer that makes every non-space character a token"),
       ("from_cp1251","decode from cp1251 (Cyrillic used in Bulgarian resource)"),
       ("from_utf8","decode from utf8 (default)"),
       ("lextext","text-like lexer"),
       ("lexcode","code-like lexer"),
       ("lexmixed","mixture of text and code, as in LaTeX (code between $...$, \\(...)\\, \\[...\\])"),
       ("lexgreek","lexer normalizing ancient Greek accentuation"),
       ("lexgreek2","lexer normalizing ancient Greek accentuation for text with vowel length annotations"),
       ("to_cp1251","encode to cp1251 (Cyrillic used in Bulgarian resource)"),
       ("to_html","wrap in a html file with linebreaks"),
       ("to_utf8","encode to utf8 (default)"),
       ("unlextext","text-like unlexer"),
       ("unlexcode","code-like unlexer"),
       ("unlexmixed","mixture of text and code (code between $...$, \\(...)\\, \\[...\\])"),
       ("unchars","unlexer that puts no spaces between tokens"),
       ("unlexgreek","unlexer de-normalizing ancient Greek accentuation"),
       ("unwords","unlexer that puts a single space between tokens (default)"),
       ("words","lexer that assumes tokens separated by spaces (default)")
       ] ++
      concat [
       [("from_" ++ p, "from unicode to GF " ++ n ++ " transliteration"),
        ("to_"   ++ p, "from GF " ++ n ++ " transliteration to unicode")] |
                                    (p,n) <- transliterationPrintNames]

trie = render . pptss . H.toTrie . map H.toATree
  where
    pptss [ts] = "*"<+>nest 2 (ppts ts)
    pptss tss  = vcat [i<+>nest 2 (ppts ts)|(i,ts)<-zip [(1::Int)..] tss]

    ppts = vcat . map ppt

    ppt t =
      case t of
        H.Oth e     -> pp (H.showExpr [] e)
        H.Ap f [[]] -> pp (H.showCId f)
        H.Ap f tss  -> H.showCId f $$ nest 2 (pptss tss)

-- ** Converting command input
toString  = unwords . toStrings
toLines = unlines . toStrings
