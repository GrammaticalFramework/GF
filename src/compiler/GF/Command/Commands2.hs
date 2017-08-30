{-# LANGUAGE FlexibleInstances, UndecidableInstances #-}
module GF.Command.Commands2 (
  PGFEnv,HasPGFEnv(..),pgf,concs,pgfEnv,emptyPGFEnv,pgfCommands,
  options, flags,
  ) where
import Prelude hiding (putStrLn)

import PGF2
import qualified PGF as H

--import qualified PGF.Internal as H(lookStartCat,functionsToCat,lookValCat,restrictPGF,hasLin)
import qualified PGF.Internal as H(Expr(EFun)) ----abstract,funs,cats,
--import qualified PGF.Internal as H(Literal(LStr),Expr(ELit)) ----
--import qualified PGF.Internal as H(ppFun,ppCat)

--import qualified PGF.Internal as H(optimizePGF)

--import GF.Compile.Export
import GF.Compile.ToAPI(exprToAPI)
--import GF.Compile.ExampleBased
--import GF.Infra.Option (noOptions, readOutputFormat, outputFormatsExpl)
import GF.Infra.UseIO(writeUTF8File)
import GF.Infra.SIO(MonadSIO,liftSIO,putStrLn,restricted,restrictedSystem)
--import GF.Data.ErrM ----
import GF.Command.Abstract
--import GF.Command.Messages
import GF.Command.CommandInfo
--import GF.Text.Lexing
--import GF.Text.Clitics
--import GF.Text.Transliterations
--import GF.Quiz

--import GF.Command.TreeOperations ---- temporary place for typecheck and compute

import GF.Data.Operations

--import PGF.Internal (encodeFile)
import Data.List(intersperse,nub)
import Data.Maybe
import qualified Data.Map as Map
--import System.Cmd(system) -- use GF.Infra.UseIO.restricedSystem instead!
--import GF.System.Process
import GF.Text.Pretty
--import Data.List (sort)
import Control.Monad(mplus)
--import Debug.Trace
--import System.Random (newStdGen) ----


data PGFEnv = Env {pgf::Maybe PGF,concs::Map.Map ConcName Concr}

pgfEnv pgf = Env (Just pgf) (languages pgf)
emptyPGFEnv = Env Nothing Map.empty

class (Monad m,MonadSIO m) => HasPGFEnv m where getPGFEnv :: m PGFEnv

instance Monad m => TypeCheckArg m where
  typeCheckArg = return -- no type checker available !!

pgfCommands :: HasPGFEnv m => Map.Map String (CommandInfo m)
pgfCommands = Map.fromList [
{-
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
     exec = \env@(pgf, mos) opts es -> do
         let langs = optLangs pgf opts
         if isOpt "giza" opts
           then do
             let giz = map (H.gizaAlignment pgf (head $ langs, head $ tail $ langs)) es
             let lsrc = unlines $ map (\(x,_,_) -> x) giz
             let ltrg = unlines $ map (\(_,x,_) -> x) giz
             let align = unlines $ map (\(_,_,x) -> x) giz
             let grph = if null es then [] else lsrc ++ "\n--end_source--\n\n"++ltrg++"\n-end_target--\n\n"++align
             return $ fromString grph
           else do
             let grph = if null es then [] else H.graphvizAlignment pgf langs (head es)
             if isFlag "view" opts || isFlag "format" opts
               then do
                 let file s = "_grph." ++ s
                 let view = optViewGraph opts
                 let format = optViewFormat opts
                 restricted $ writeUTF8File (file "dot") grph
                 restrictedSystem $ "dot -T" ++ format ++ " " ++ file "dot" ++ " > " ++ file format
                 restrictedSystem $ view ++ " " ++ file format
                 return void
               else return $ fromString grph,
     examples = [
       ("gr | aw"                         , "generate a tree and show word alignment as graph script"),
       ("gr | aw -view=\"open\""          , "generate a tree and display alignment on Mac"),
       ("gr | aw -view=\"eog\""           , "generate a tree and display alignment on Ubuntu"),
       ("gt | aw -giza | wf -file=aligns" , "generate trees, send giza alignments to file")
       ],
     options = [
       ("giza",  "show alignments in the Giza format; the first two languages")
       ],
     flags = [
       ("format","format of the visualization file (default \"png\")"),
       ("lang",  "alignments for this list of languages (default: all)"),
       ("view",  "program to open the resulting file")
       ]
    }),
-}
{-
  ("eb", emptyCommandInfo {
     longname = "example_based",
     syntax = "eb (-probs=FILE | -lang=LANG)* -file=FILE.gfe",
     synopsis = "converts .gfe files to .gf files by parsing examples to trees",
     explanation = unlines [
       "Reads FILE.gfe and writes FILE.gf. Each expression of form",
       "'%ex CAT QUOTEDSTRING' in FILE.gfe is replaced by a syntax tree.",
       "This tree is the first one returned by the parser; a biased ranking",
       "can be used to regulate the order. If there are more than one parses",
       "the rest are shown in comments, with probabilities if the order is biased.",
       "The probabilities flag and configuration file is similar to the commands",
       "gr and rt. Notice that the command doesn't change the environment,",
       "but the resulting .gf file must be imported separately."
       ],
     options = [
       ("api","convert trees to overloaded API expressions (using Syntax not Lang)")
       ],
     flags = [
       ("file","the file to be converted (suffix .gfe must be given)"),
       ("lang","the language in which to parse"),
       ("probs","file with probabilities to rank the parses")
       ],
     exec = \env@(pgf, mos) opts _ -> do
       let file = optFile opts
       pgf <- optProbs opts pgf
       let printer = if (isOpt "api" opts) then exprToAPI else (H.showExpr [])
       let conf = configureExBased pgf (optMorpho env opts) (optLang pgf opts) printer
       (file',ws) <- restricted $ parseExamplesInGrammar conf file
       if null ws then return () else putStrLn ("unknown words: " ++ unwords ws)
       return (fromString ("wrote " ++ file')),
     needsTypeCheck = False
     }),
-}
{-
  ("gr", emptyCommandInfo {
     longname = "generate_random",
     synopsis = "generate random trees in the current abstract syntax",
     syntax = "gr [-cat=CAT] [-number=INT]",
     examples = [
       mkEx "gr                     -- one tree in the startcat of the current grammar",
       mkEx "gr -cat=NP -number=16  -- 16 trees in the category NP",
       mkEx "gr -lang=LangHin,LangTha -cat=Cl  -- Cl, both in LangHin and LangTha",
       mkEx "gr -probs=FILE         -- generate with bias",
       mkEx "gr (AdjCN ? (UseN ?))  -- generate trees of form (AdjCN ? (UseN ?))"
       ],
     explanation = unlines [
       "Generates a list of random trees, by default one tree.",
       "If a tree argument is given, the command completes the Tree with values to",
       "all metavariables in the tree. The generation can be biased by probabilities,",
       "given in a file in the -probs flag."
       ],
     flags = [
       ("cat","generation category"),
       ("lang","uses only functions that have linearizations in all these languages"),
       ("number","number of trees generated"),
       ("depth","the maximum generation depth"),
       ("probs", "file with biased probabilities (format 'f 0.4' one by line)")
       ],
     exec = \env@(pgf, mos) opts xs -> do
       pgf <- optProbs opts (optRestricted opts pgf)
       gen <- newStdGen
       let dp = valIntOpts "depth" 4 opts
       let ts  = case mexp xs of
                   Just ex -> H.generateRandomFromDepth gen pgf ex (Just dp)
                   Nothing -> H.generateRandomDepth     gen pgf (optType pgf opts) (Just dp)
       returnFromExprs $ take (optNum opts) ts
     }),
-}
  ("gt", emptyCommandInfo {
     longname = "generate_trees",
     synopsis = "generates a list of trees, by default exhaustive",
     flags = [("cat","the generation category"),
              ("number","the number of trees generated")],
     examples = [
       mkEx "gt                     -- all trees in the startcat",
       mkEx "gt -cat=NP -number=16  -- 16 trees in the category NP"],
     exec = needPGF $ \ opts _ env@(pgf,_) ->
            let ts = map fst (generateAll pgf cat)
                cat = optType pgf opts
            in returnFromCExprs (takeOptNum opts ts),
     needsTypeCheck = False
     }),
  ("i", emptyCommandInfo {
     longname = "import",
     synopsis = "import a grammar from a compiled .pgf file",
     explanation = unlines [
       "Reads a grammar from a compiled .pgf file.",
       "Old modules are discarded.",
{-
       "The grammar parser depends on the file name suffix:",

       "  .cf    context-free (labelled BNF) source",
       "  .ebnf  extended BNF source",
       "  .gfm   multi-module GF source",
       "  .gf    normal GF source",
       "  .gfo   compiled GF source",
-}
       "  .pgf   precompiled grammar in Portable Grammar Format"
       ],
     flags = [
--     ("probs","file with biased probabilities for generation")
       ],
     options = [
       -- ["gfo", "src", "no-cpu", "cpu", "quiet", "verbose"]
--     ("retain","retain operations (used for cc command)"),
--     ("src",   "force compilation from source"),
--     ("v",     "be verbose - show intermediate status information")
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
       mkEx "l -lang=LangSwe,LangNor no_Utt   -- linearize a tree to LangSwe and LangNor",
       mkEx "gr -lang=LangHin -cat=Cl | l -table -to_devanagari -- hindi table",
       mkEx "l -unlexer=\"LangAra=to_arabic LangHin=to_devanagari\" -- different unlexers"
       ],
     exec = needPGF $ \ opts arg env ->
                      return . fromStrings . optLins env opts . map cExpr $ toExprs arg,
     options = [
       ("all",    "show all forms and variants, one by line (cf. l -list)"),
       ("bracket","show tree structure with brackets and paths to nodes"),
       ("groups", "all languages, grouped by lang, remove duplicate strings"),
       ("list","show all forms and variants, comma-separated on one line (cf. l -all)"),
       ("multi","linearize to all languages (default)"),
       ("table","show all forms labelled by parameters"),
       ("treebank","show the tree and tag linearizations with language names")
       ],
     flags = [
       ("lang","the languages of linearization (comma-separated, no spaces)")
       ]
     }),
  ("ma", emptyCommandInfo {
     longname = "morpho_analyse",
     synopsis = "print the morphological analyses of the (multiword) expression in the string",
     explanation = unlines [
       "Prints all the analyses of the (multiword) expression in the input string,",
       "using the morphological analyser of the actual grammar (see command pg)"
       ],
     exec  = needPGF $ \opts args env -> 
               return ((fromString . unlines .
                        map prMorphoAnalysis . concatMap (morphos env opts) . toStrings) args),
     flags = [
       ("lang","the languages of analysis (comma-separated, no spaces)")
       ]
     }),
{-
  ("mq", emptyCommandInfo {
     longname = "morpho_quiz",
     synopsis = "start a morphology quiz",
     syntax   = "mq (-cat=CAT)? (-probs=FILE)? TREE?",
     exec = \env@(pgf, mos) opts xs -> do
         let lang = optLang pgf opts
         let typ  = optType pgf opts
         pgf <- optProbs opts pgf
         let mt = mexp xs
         restricted $ morphologyQuiz mt pgf lang typ
         return void,
     flags = [
       ("lang","language of the quiz"),
       ("cat","category of the quiz"),
       ("number","maximum number of questions"),
       ("probs","file with biased probabilities for generation")
       ]
     }),
-}
  ("p", emptyCommandInfo {
     longname = "parse",
     synopsis = "parse a string to abstract syntax expression",
     explanation = unlines [
       "Shows all trees returned by parsing a string in the grammars in scope.",
       "The -lang flag can be used to restrict this to fewer languages.",
       "The default start category can be overridden by the -cat flag.",
       "See also the ps command for lexing and character encoding."
       ],
     flags = [
       ("cat","target category of parsing"),
       ("lang","the languages of parsing (comma-separated, no spaces)"),
       ("number","maximum number of trees returned")
       ],
     examples = [
         mkEx "p  \"this fish is fresh\" | l -lang=Swe  -- try parsing with all languages and translate the successful parses to Swedish"
       ],
     exec = needPGF $ \ opts ts env -> return . cParse env opts $ toStrings ts
     }),
{-
  ("p", emptyCommandInfo {
     longname = "parse",
     synopsis = "parse a string to abstract syntax expression",
     explanation = unlines [
       "Shows all trees returned by parsing a string in the grammars in scope.",
       "The -lang flag can be used to restrict this to fewer languages.",
       "The default start category can be overridden by the -cat flag.",
       "See also the ps command for lexing and character encoding.",
       "",
       "The -openclass flag is experimental and allows some robustness in ",
       "the parser. For example if -openclass=\"A,N,V\" is given, the parser",
       "will accept unknown adjectives, nouns and verbs with the resource grammar."
       ],
     exec = \env@(pgf, mos) opts ts ->
              return . Piped $ fromParse opts (concat [map ((,) s) (par pgf opts s) | s <- toStrings ts]),
     flags = [
       ("cat","target category of parsing"),
       ("lang","the languages of parsing (comma-separated, no spaces)"),
       ("openclass","list of open-class categories for robust parsing"),
       ("depth","maximal depth for proof search if the abstract syntax tree has meta variables")
       ],
     options = [
       ("bracket","prints the bracketed string from the parser")
       ]
     }),
-}
  ("pg", emptyCommandInfo { -----
     longname = "print_grammar",
     synopsis = "prints different information about the grammar",
     exec  = needPGF $ \opts _ env -> prGrammar env opts,
     options = [
       ("cats",   "show just the names of abstract syntax categories"),
       ("fullform", "print the fullform lexicon"),
       ("funs",   "show just the names and types of abstract syntax functions"),
       ("langs",  "show just the names of top concrete syntax modules"),
       ("lexc", "print the lexicon in Xerox LEXC format"),
       ("missing","show just the names of functions that have no linearization"),
       ("words", "print the list of words")
       ],
     flags = [
       ("lang","the languages that need to be printed")
       ],
     examples = [
       mkEx "pg -langs -- show the names of top concrete syntax modules",
       mkEx "pg -funs | ? grep \" S ;\"  -- show functions with value cat S"
       ]
     }),

{-
  ("pt", emptyCommandInfo {
     longname = "put_tree",
     syntax = "pt OPT? TREE",
     synopsis = "return a tree, possibly processed with a function",
     explanation = unlines [
       "Returns a tree obtained from its argument tree by applying",
       "tree processing functions in the order given in the command line",
       "option list. Thus 'pt -f -g s' returns g (f s). Typical tree processors",
       "are type checking and semantic computation."
       ],
     examples = [
       mkEx "pt -compute (plus one two)                               -- compute value",
       mkEx "p \"4 dogs love 5 cats\" | pt -transfer=digits2numeral | l -- four...five..."
       ],
     exec = \env@(pgf, mos) opts ->
            returnFromExprs . takeOptNum opts . treeOps pgf opts,
     options = treeOpOptions undefined{-pgf-},
     flags = [("number","take at most this many trees")] ++ treeOpFlags undefined{-pgf-}
     }),
-}
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
     exec = needPGF $ \opts _ env@(pgf, mos) -> do
       let file = optFile opts
       let exprs []         = ([],empty)
           exprs ((n,s):ls) | null s
                            = exprs ls
           exprs ((n,s):ls) = case readExpr s of
                                Just e  -> let (es,err) = exprs ls
                                           in case inferExpr pgf e of
                                                Right (e,t) -> (e:es,err)
                                                Left msg    -> (es,"on line" <+> n <> ':' $$ msg $$ err)
                                Nothing -> let (es,err) = exprs ls
                                           in (es,"on line" <+> n <> ':' <+> "parse error" $$ err)
           returnFromLines ls = case exprs ls of
                                  (es, err) | null es   -> return $ pipeMessage $ render (err $$ "no trees found")
                                            | otherwise -> return $ pipeWithMessage (map hsExpr es) (render err)

       s <- restricted $ readFile file
       case opts of
         _ | isOpt "lines" opts && isOpt "tree" opts ->
               returnFromLines (zip [1::Int ..] (lines s))
         _ | isOpt "tree" opts ->
               returnFromLines [(1::Int,s)]
         _ | isOpt "lines" opts -> return (fromStrings $ lines s)
         _ -> return (fromString s),
     flags = [("file","the input file name")]
     }),
{-
  ("rt", emptyCommandInfo {
     longname = "rank_trees",
     synopsis = "show trees in an order of decreasing probability",
     explanation = unlines [
       "Order trees from the most to the least probable, using either",
       "even distribution in each category (default) or biased as specified",
       "by the file given by flag -probs=FILE, where each line has the form",
       "'function probability', e.g. 'youPol_Pron  0.01'."
       ],
     exec = \env@(pgf, mos) opts ts -> do
         pgf <- optProbs opts pgf
         let tds = H.rankTreesByProbs pgf ts
         if isOpt "v" opts
           then putStrLn $
                  unlines [H.showExpr []  t ++ "\t--" ++ show d | (t,d) <- tds]
           else return ()
         returnFromExprs $ map fst tds,
     flags = [
       ("probs","probabilities from this file (format 'f 0.6' per line)")
       ],
     options = [
       ("v","show all trees with their probability scores")
       ],
     examples = [
      mkEx "p \"you are here\" | rt -probs=probs | pt -number=1 -- most probable result"
      ]
     }),

  ("tq", emptyCommandInfo {
     longname = "translation_quiz",
     syntax   = "tq -from=LANG -to=LANG (-cat=CAT)? (-probs=FILE)? TREE?",
     synopsis = "start a translation quiz",
     exec = \env@(pgf, mos) opts xs -> do
         let from = optLangFlag "from" pgf opts
         let to   = optLangFlag "to" pgf opts
         let typ  = optType pgf opts
         let mt   = mexp xs
         pgf <- optProbs opts pgf
         restricted $ translationQuiz mt pgf from to typ
         return void,
     flags = [
       ("from","translate from this language"),
       ("to","translate to this language"),
       ("cat","translate in this category"),
       ("number","the maximum number of questions"),
       ("probs","file with biased probabilities for generation")
       ],
     examples = [
       mkEx ("tq -from=Eng -to=Swe                               -- any trees in startcat"),
       mkEx ("tq -from=Eng -to=Swe (AdjCN (PositA ?2) (UseN ?))  -- only trees of this form")
       ]
     }),
  ("vd", emptyCommandInfo {
     longname = "visualize_dependency",
     synopsis = "show word dependency tree graphically",
     explanation = unlines [
       "Prints a dependency tree in the .dot format (the graphviz format, default)",
       "or the CoNLL/MaltParser format (flag -output=conll for training, malt_input",
       "for unanalysed input).",
       "By default, the last argument is the head of every abstract syntax",
       "function; moreover, the head depends on the head of the function above.",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by graphviz and displayed by the program indicated",
       "by the flag. The target format is png, unless overridden by the",
       "flag -format."
       ],
     exec = \env@(pgf, mos) opts es -> do
         let debug = isOpt "v" opts
         let file = valStrOpts "file" "" opts
         let outp = valStrOpts "output" "dot" opts
         mlab <- case file of
           "" -> return Nothing
           _  -> (Just . H.getDepLabels . lines) `fmap` restricted (readFile file)
         let lang = optLang pgf opts
         let grphs = unlines $ map (H.graphvizDependencyTree outp debug mlab Nothing pgf lang) es
         if isFlag "view" opts || isFlag "format" opts then do
           let file s = "_grphd." ++ s
           let view = optViewGraph opts
           let format = optViewFormat opts
           restricted $ writeUTF8File (file "dot") grphs
           restrictedSystem $ "dot -T" ++ format ++ " " ++ file "dot" ++ " > " ++ file format
           restrictedSystem $ view ++ " " ++ file format
           return void
          else return $ fromString grphs,
     examples = [
       mkEx "gr | vd              -- generate a tree and show dependency tree in .dot",
       mkEx "gr | vd -view=open   -- generate a tree and display dependency tree on a Mac",
       mkEx "gr -number=1000 | vd -file=dep.labels -output=malt      -- generate training treebank",
       mkEx "gr -number=100 | vd -file=dep.labels -output=malt_input -- generate test sentences"
       ],
     options = [
       ("v","show extra information")
       ],
     flags = [
       ("file","configuration file for labels per fun, format 'fun l1 ... label ... l2'"),
       ("format","format of the visualization file (default \"png\")"),
       ("output","output format of graph source (default \"dot\")"),
       ("view","program to open the resulting file (default \"open\")"),
       ("lang","the language of analysis")
       ]
    }),
-}

  ("vp", emptyCommandInfo {
     longname = "visualize_parse",
     synopsis = "show parse tree graphically",
     explanation = unlines [
       "Prints a parse tree in the .dot format (the graphviz format).",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by graphviz and displayed by the program indicated",
       "by the flag. The target format is png, unless overridden by the",
       "flag -format."
       ],
     exec = needPGF $ \opts arg env@(pgf, concs) ->
      do let es = toExprs arg
         let concs = optConcs env opts
{-
         let gvOptions=H.GraphvizOptions {H.noLeaves = isOpt "noleaves" opts && not (isOpt "showleaves" opts),
                                          H.noFun = isOpt "nofun" opts || not (isOpt "showfun" opts),
                                          H.noCat = isOpt "nocat" opts && not (isOpt "showcat" opts),
                                          H.nodeFont = valStrOpts "nodefont" "" opts,
                                          H.leafFont = valStrOpts "leaffont" "" opts,
                                          H.nodeColor = valStrOpts "nodecolor" "" opts,
                                          H.leafColor = valStrOpts "leafcolor" "" opts,
                                          H.nodeEdgeStyle = valStrOpts "nodeedgestyle" "solid" opts,
                                          H.leafEdgeStyle = valStrOpts "leafedgestyle" "dashed" opts
                                         }
-}
         let grph= if null es || null concs
                   then []
                   else graphvizParseTree (snd (head concs)) (cExpr (head es))
         if isFlag "view" opts || isFlag "format" opts then do
           let file s = "_grph." ++ s
           let view = optViewGraph opts
           let format = optViewFormat opts
           restricted $ writeUTF8File (file "dot") grph
           restrictedSystem $ "dot -T" ++ format ++ " " ++ file "dot" ++ " > " ++ file format
           restrictedSystem $ view ++ " " ++ file format
           return void
          else return $ fromString grph,
     examples = [
       mkEx "p -lang=Eng \"John walks\" | vp  -- generate a tree and show parse tree as .dot script"--,
--     mkEx "gr | vp -view=\"open\" -- generate a tree and display parse tree on a Mac"
       ],
     options = [
{-
       ("showcat","show categories in the tree nodes (default)"),
       ("nocat","don't show categories"),
       ("showfun","show function names in the tree nodes"),
       ("nofun","don't show function names (default)"),
       ("showleaves","show the leaves of the tree (default)"),
       ("noleaves","don't show the leaves of the tree (i.e., only the abstract tree)")
-}
       ],
     flags = [
       ("lang","the language to visualize"),
       ("format","format of the visualization file (default \"png\")"),
       ("view","program to open the resulting file (default \"open\")")--,
{-
       ("nodefont","font for tree nodes (default: Times -- graphviz standard font)"),
       ("leaffont","font for tree leaves (default: nodefont)"),
       ("nodecolor","color for tree nodes (default: black -- graphviz standard color)"),
       ("leafcolor","color for tree leaves (default: nodecolor)"),
       ("nodeedgestyle","edge style between tree nodes (solid/dashed/dotted/bold, default: solid)"),
       ("leafedgestyle","edge style for links to leaves (solid/dashed/dotted/bold, default: dashed)")
-}
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
       "flag -format."--,
--     "With option -mk, use for showing library style function names of form 'mkC'."
       ],
     exec = needPGF $ \opts arg env@(pgf, _) ->
       let es = toExprs arg in
       {-if isOpt "mk" opts
       then return $ fromString $ unlines $ map (tree2mk pgf) es
       else -}if isOpt "api" opts
       then do
         let ss = map exprToAPI es
         mapM_ putStrLn ss
         return void
       else do
--       let funs = not (isOpt "nofun" opts)
--       let cats = not (isOpt "nocat" opts)
         let grph = unlines (map (graphvizAbstractTree pgf . cExpr) es)
         if isFlag "view" opts || isFlag "format" opts then do
           let file s = "_grph." ++ s
           let view = optViewGraph opts
           let format = optViewFormat opts
           restricted $ writeUTF8File (file "dot") grph
           restrictedSystem $ "dot -T" ++ format ++ " " ++ file "dot" ++ " > " ++ file format
           restrictedSystem $ view  ++ " " ++ file format
           return void
          else return $ fromString grph,
     examples = [
       mkEx "p \"hello\" | vt              -- parse a string and show trees as graph script",
       mkEx "p \"hello\" | vt -view=\"open\" -- parse a string and display trees on a Mac"
       ],
     options = [
       ("api", "show the tree with function names converted to 'mkC' with value cats C")--,
--     ("mk",  "similar to -api, deprecated"),
--     ("nofun","don't show functions but only categories"),
--     ("nocat","don't show categories but only functions")
       ],
     flags = [
       ("format","format of the visualization file (default \"png\")"),
       ("view","program to open the resulting file (default \"open\")")
       ]
     }),

  ("ai", emptyCommandInfo {
     longname = "abstract_info",
     syntax = "ai IDENTIFIER  or  ai EXPR",
     synopsis = "Provides an information about a function, an expression or a category from the abstract syntax",
     explanation = unlines [
       "The command has one argument which is either function, expression or",
       "a category defined in the abstract syntax of the current grammar. ",
       "If the argument is a function then its type is printed out.",
       "If it is a category then the category definition is printed.",
       "If a whole expression is given it prints the expression with refined",
       "metavariables and the type of the expression."
       ],
     exec = needPGF $ \opts args env@(pgf,cncs) ->
       case map cExpr (toExprs args) of
         [e] -> case unApp e of
                  Just (id,[]) | id `elem` funs -> return (fromString (showFun pgf id))
                               | id `elem` cats -> return (fromString (showCat id))
                               where
                                 funs = functions  pgf
                                 cats = categories pgf

                                 showCat c = "cat "++c -- TODO: show categoryContext
                                             ++"\n\n"++
                                             unlines [showFun' f ty|f<-funs,
                                                                    let ty=functionType pgf f,
                                                                    target ty == c]
                                 target t = case unType t of (_,c,_) -> c
                  _  -> case inferExpr pgf e of
                          Left msg     -> error msg
                          Right (e,ty) -> do putStrLn ("Expression:  "++PGF2.showExpr [] e)
                                             putStrLn ("Type:        "++PGF2.showType [] ty)
                                             -- putStrLn ("Probability: "++show (H.probTree pgf e))
                                             return void
         _           -> do putStrLn "a single function name or category name is expected"
                           return void,
     needsTypeCheck = False
     })
  ]
 where
{-
   par pgf opts s = case optOpenTypes opts of
                  []        -> [H.parse_ pgf lang (optType pgf opts) (Just dp) s | lang <- optLangs pgf opts]
                  open_typs -> [H.parseWithRecovery pgf lang (optType pgf opts) open_typs (Just dp) s | lang <- optLangs pgf opts]
     where
       dp = valIntOpts "depth" 4 opts
-}
   cParse env@(pgf,_) opts ss = 
        parsed [ parse cnc cat s | s<-ss,(lang,cnc)<-cncs]
     where
       cat = optType pgf opts
       cncs = optConcs env opts
       parsed rs = Piped (Exprs ts,unlines msgs)
          where
            ts = [hsExpr t|Right ts<-rs,(t,p)<-takeOptNum opts ts]
            msgs = concatMap (either err ok) rs
            err msg = ["Parse failed: "++msg]
            ok = map (PGF2.showExpr [] . fst).takeOptNum opts

   optLins env opts ts = case opts of
     _ | isOpt "groups" opts ->
       concatMap snd $ groupResults
         [[(lang, s) | (lang,concr) <- optConcs env opts,s <- linear opts lang concr t] | t <- ts]
     _ -> concatMap (optLin env opts) ts
   optLin env@(pgf,_) opts t =
     case opts of
       _ | isOpt "treebank" opts ->
         (abstractName pgf ++ ": " ++ PGF2.showExpr [] t) :
         [lang ++ ": " ++ s | (lang,concr) <- optConcs env opts, s<-linear opts lang concr t]
       _ -> [s | (lang,concr) <- optConcs env opts, s<-linear opts lang concr t]

   linear :: [Option] -> ConcName -> Concr -> PGF2.Expr -> [String]
   linear opts lang concr = case opts of
       _ | isOpt "all"     opts -> concat . map (map snd) . tabularLinearizeAll concr
       _ | isOpt "list"    opts -> (:[]) . commaList .
                                   concatMap (map snd) . tabularLinearizeAll concr
       _ | isOpt "table"   opts -> concatMap (map (\(p,v) -> p+++":"+++v)) . tabularLinearizeAll concr
       _ | isOpt "bracket" opts -> (:[]) . unwords . map showBracketedString . bracketedLinearize concr
       _                        -> (:[]) . linearize concr

   groupResults :: [[(ConcName,String)]] -> [(ConcName,[String])]
   groupResults = Map.toList . foldr more Map.empty . start . concat
     where
       start ls = [(l,[s]) | (l,s) <- ls]
       more (l,s) = 
          Map.insertWith (\ [x] xs -> if elem x xs then xs else (x : xs)) l s

   optConcs = optConcsFlag "lang"

   optConcsFlag f (pgf,cncs) opts =
       case valStrOpts f "" opts of
         "" -> Map.toList cncs
         lang -> mapMaybe pickLang (chunks ',' lang)
     where
       pickLang l = pick l `mplus` pick fl
         where
           fl = abstractName pgf++l
           pick l = (,) l `fmap` Map.lookup l cncs

{-
   -- replace each non-atomic constructor with mkC, where C is the val cat
   tree2mk pgf = H.showExpr [] . t2m where
     t2m t = case H.unApp t of
       Just (cid,ts@(_:_)) -> H.mkApp (mk cid) (map t2m ts)
       _ -> t
     mk = H.mkCId . ("mk" ++) . H.showCId . H.lookValCat (H.abstract pgf)

   unlex opts lang = stringOps Nothing (getUnlex opts lang ++ map prOpt opts) ----

   getUnlex opts lang = case words (valStrOpts "unlexer" "" opts) of
     lexs -> case lookup lang
               [(H.mkCId la,tail le) | lex <- lexs, let (la,le) = span (/='=') lex, not (null le)] of
       Just le -> chunks ',' le
       _ -> []
-}
   commaList [] = []
   commaList ws = concat $ head ws : map (", " ++) (tail ws)

-- Proposed logic of coding in unlexing:
--   - If lang has no coding flag, or -to_utf8 is not in opts, just opts are used.
--   - If lang has flag coding=utf8, -to_utf8 is ignored.
--   - If lang has coding=other, and -to_utf8 is in opts, from_other is applied first.
-- THIS DOES NOT WORK UNFORTUNATELY - can't use the grammar flag properly
{-
   unlexx pgf opts lang = {- trace (unwords optsC) $ -} stringOps Nothing optsC where ----
     optsC = case lookConcrFlag pgf (H.mkCId lang) (H.mkCId "coding") of
       Just (LStr "utf8") -> filter (/="to_utf8") $ map prOpt opts
       Just (LStr other) | isOpt "to_utf8" opts ->
                      let cod = ("from_" ++ other)
                      in cod : filter (/=cod) (map prOpt opts)
       _ -> map prOpt opts

   optRestricted opts pgf =
     H.restrictPGF (\f -> and [H.hasLin pgf la f | la <- optLangs pgf opts]) pgf

   completeLang pgf la = let cla = (H.mkCId la) in
     if elem cla (H.languages pgf)
       then cla
       else (H.mkCId (H.showCId (H.abstractName pgf) ++ la))

   optOpenTypes opts = case valStrOpts "openclass" "" opts of
     ""   -> []
     cats -> mapMaybe H.readType (chunks ',' cats)

   optProbs opts pgf = case valStrOpts "probs" "" opts of
     ""   -> return pgf
     file -> do
       probs <- restricted $ H.readProbabilitiesFromFile file pgf
       return (H.setProbabilities probs pgf)

   optTranslit opts = case (valStrOpts "to" "" opts, valStrOpts "from" "" opts) of
     ("","")  -> return id
     (file,"") -> do
       src <- restricted $ readFile file
       return $ transliterateWithFile file src False
     (_,file) -> do
       src <- restricted $ readFile file
       return $ transliterateWithFile file src True
-}
   optFile opts = valStrOpts "file" "_gftmp" opts

   optType pgf opts =
     case listFlags "cat" opts of
       v:_ -> let str = valueString v
              in case readType str of
                   Just ty -> case checkType pgf ty of
                                Left msg -> error msg
                                Right ty -> ty
                   Nothing -> error ("Can't parse '"++str++"' as a type")
       _   -> startCat pgf

   optViewFormat opts = valStrOpts "format" "png" opts
   optViewGraph opts = valStrOpts "view" "open" opts
{-
   optNum opts = valIntOpts "number" 1 opts
-}
   optNumInf opts = valIntOpts "number" 1000000000 opts ---- 10^9
   takeOptNum opts = take (optNumInf opts)
{-
   fromParse opts []     = ([],[])
   fromParse opts ((s,(po,bs)):ps)
     | isOpt "bracket" opts = (es, H.showBracketedString bs
                                   ++ "\n" ++ msg)
     | otherwise            = case po of
                                H.ParseOk ts     -> let Piped (es',msg') = fromExprs ts
                                                  in (es'++es,msg'++msg)
                                H.TypeError errs -> ([], render ("The parsing is successful but the type checking failed with error(s):" $$
                                                               nest 2 (vcat (map (H.ppTcError . snd) errs)))
                                                       ++ "\n" ++ msg)
                                H.ParseFailed i  -> ([], "The parser failed at token " ++ show (words s !! max 0 (i-1))
                                                       ++ "\n" ++ msg)
                                H.ParseIncomplete-> ([], "The sentence is not complete")
     where
       (es,msg) = fromParse opts ps
-}
   returnFromCExprs = returnFromExprs . map hsExpr
   returnFromExprs es =
      return $ case es of
                 [] -> pipeMessage "no trees found"
                 _  -> fromExprs es

   prGrammar env@(pgf,cncs) opts
     | isOpt "langs" opts = return . fromString . unwords $ (map fst (optConcs env opts))
     | isOpt "cats" opts = return . fromString . unwords $ categories pgf
     | isOpt "funs" opts = return . fromString . unlines . map (showFun pgf) $
                             functions pgf
     | isOpt "missing" opts = return . fromString . unwords $
                                 [f | f <- functions pgf, not (and [hasLinearization concr f | (_,concr) <- optConcs env opts])]
     | isOpt "fullform" opts = return $ fromString $ concatMap (prFullFormLexicon . snd) $ optConcs env opts
     | isOpt "words"    opts = return $ fromString $ concatMap (prAllWords . snd) $ optConcs env opts
     | isOpt "lexc"     opts = return $ fromString $ concatMap (prLexcLexicon . snd) $ optConcs env opts
     | otherwise = return void

   showFun pgf f = showFun' f (functionType pgf f)
   showFun' f ty = "fun "++f++" : "++showType [] ty

   morphos env opts s =
     [(s,lookupMorpho concr s) | (lang,concr) <- optConcs env opts]
{-
   mexp xs = case xs of
     t:_ -> Just t
     _   -> Nothing
-}
   -- ps -f -g s returns g (f s)
{-
   treeOps pgf opts s = foldr app s (reverse opts) where
     app (OOpt  op)         | Just (Left  f) <- treeOp pgf op = f
     app (OFlag op (VId x)) | Just (Right f) <- treeOp pgf op = f (H.mkCId x)
     app _                                                    = id

treeOpOptions pgf = [(op,expl) | (op,(expl,Left  _)) <- allTreeOps pgf]
treeOpFlags   pgf = [(op,expl) | (op,(expl,Right _)) <- allTreeOps pgf]

translationQuiz :: Maybe H.Expr -> H.PGF -> H.Language -> H.Language -> H.Type -> IO ()
translationQuiz mex pgf ig og typ = do
  tts <- translationList mex pgf ig og typ infinity
  mkQuiz "Welcome to GF Translation Quiz." tts

morphologyQuiz :: Maybe H.Expr -> H.PGF -> H.Language -> H.Type -> IO ()
morphologyQuiz mex pgf ig typ = do
  tts <- morphologyList mex pgf ig typ infinity
  mkQuiz "Welcome to GF Morphology Quiz." tts

-- | the maximal number of precompiled quiz problems
infinity :: Int
infinity = 256
-}
prLexcLexicon :: Concr -> String
prLexcLexicon concr =
  unlines $ "Multichar_Symbols":multichars:"":"LEXICON Root" : [prLexc l p ++ ":" ++ w  ++ " # ;" | (w,lps) <- morpho, (l,p,_) <- lps] ++ ["END"]
 where
  morpho = fullFormLexicon concr
  prLexc l p = l ++ concat (mkTags (words p))
  mkTags p = case p of
    "s":ws -> mkTags ws   --- remove record field
    ws -> map ('+':) ws

  multichars = unwords $ nub $ concat [mkTags (words p) | (w,lps) <- morpho, (l,p,_) <- lps]
  -- thick_A+(AAdj+Posit+Gen):thick's # ;

prFullFormLexicon :: Concr -> String
prFullFormLexicon concr =
  unlines (map prMorphoAnalysis (fullFormLexicon concr))

prAllWords :: Concr -> String
prAllWords concr =
  unwords [w | (w,_) <- fullFormLexicon concr]

prMorphoAnalysis :: (String,[MorphoAnalysis]) -> String
prMorphoAnalysis (w,lps) =
  unlines (w:[fun ++ " : " ++ cat | (fun,cat,p) <- lps])

hsExpr c =
  case unApp c of
    Just (f,cs) -> H.mkApp (H.mkCId f) (map hsExpr cs)
    _ -> error "GF.Command.Commands2.hsExpr"

cExpr e =
  case H.unApp e of
    Just (f,es) -> mkApp (H.showCId f) (map cExpr es)
    _ -> error "GF.Command.Commands2.cExpr"

needPGF exec opts ts =
  do Env mb_pgf cncs <- getPGFEnv
     case mb_pgf of
       Just pgf -> liftSIO $ exec opts ts (pgf,cncs)
       _ -> fail "Import a grammar before using this command"
