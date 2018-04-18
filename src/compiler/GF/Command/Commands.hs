{-# LANGUAGE FlexibleInstances, UndecidableInstances #-}
module GF.Command.Commands (
  PGFEnv,HasPGFEnv(..),pgf,mos,pgfEnv,pgfCommands,
  options,flags,
  ) where
import Prelude hiding (putStrLn,(<>)) -- GHC 8.4.1 clash with Text.PrettyPrint

import PGF

import PGF.Internal(lookStartCat,functionsToCat,lookValCat,restrictPGF,hasLin)
import PGF.Internal(abstract,funs,cats,Expr(EFun)) ----
import PGF.Internal(ppFun,ppCat)
import PGF.Internal(optimizePGF)

import GF.Compile.Export
import GF.Compile.ToAPI
import GF.Compile.ExampleBased
import GF.Infra.Option (noOptions, readOutputFormat, outputFormatsExpl)
import GF.Infra.UseIO(writeUTF8File)
import GF.Infra.SIO
import GF.Command.Abstract
import GF.Command.CommandInfo
import GF.Command.CommonCommands
import GF.Text.Clitics
import GF.Quiz

import GF.Command.TreeOperations ---- temporary place for typecheck and compute

import GF.Data.Operations

import PGF.Internal (encodeFile)
import Data.List(intersperse,nub)
import Data.Maybe
import qualified Data.Map as Map
import GF.Text.Pretty
import Data.List (sort)
--import Debug.Trace


data PGFEnv = Env {pgf::PGF,mos::Map.Map Language Morpho}

pgfEnv pgf = Env pgf mos
  where mos = Map.fromList [(la,buildMorpho pgf la) | la <- languages pgf]

class (Functor m,Monad m,MonadSIO m) => HasPGFEnv m where getPGFEnv :: m PGFEnv

instance (Monad m,HasPGFEnv m) => TypeCheckArg m where
  typeCheckArg e = (either (fail . render . ppTcError) (return . fst)
                    . flip inferExpr e . pgf) =<< getPGFEnv

pgfCommands :: HasPGFEnv m => Map.Map String (CommandInfo m)
pgfCommands = Map.fromList [
  ("aw", emptyCommandInfo {
     longname = "align_words",
     synopsis = "show word alignments between languages graphically",
     explanation = unlines [
       "Prints a set of strings in the .dot format (the graphviz format).",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by 'dot' (graphviz) and displayed by the program indicated",
       "by the view flag. The target format is png, unless overridden by the",
       "flag -format. Results from multiple trees are combined to pdf with convert (ImageMagick)."
       ],
     exec = getEnv $ \ opts arg (Env pgf mos) -> do
         let es = toExprs arg
         let langs = optLangs pgf opts
         if isOpt "giza" opts
           then do
             let giz = map (gizaAlignment pgf (head $ langs, head $ tail $ langs)) es
             let lsrc = unlines $ map (\(x,_,_) -> x) giz
             let ltrg = unlines $ map (\(_,x,_) -> x) giz
             let align = unlines $ map (\(_,_,x) -> x) giz
             let grph = if null es then [] else lsrc ++ "\n--end_source--\n\n"++ltrg++"\n-end_target--\n\n"++align
             return $ fromString grph
           else do
             let grphs = map (graphvizAlignment pgf langs) es
             if isFlag "view" opts || isFlag "format" opts
               then do
                 let view = optViewGraph opts
                 let format = optViewFormat opts
                 viewGraphviz view format "_grpha_" grphs
               else return $ fromString $ unlines grphs,
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
  ("ca", emptyCommandInfo {
     longname = "clitic_analyse",
     synopsis = "print the analyses of all words into stems and clitics",
     explanation = unlines [
       "Analyses all words into all possible combinations of stem + clitics.",
       "The analysis is returned in the format stem &+ clitic1 &+ clitic2 ...",
       "which is hence the inverse of 'pt -bind'. The list of clitics is give",
       "by the flag '-clitics'. The list of stems is given as the list of words",
       "of the language given by the '-lang' flag."
       ],
     exec  = getEnv $ \opts ts env -> case opts of
               _ | isOpt "raw" opts ->
                    return . fromString .
                    unlines . map (unwords . map (concat . intersperse "+")) .
                    map (getClitics (isInMorpho (optMorpho env opts)) (optClitics opts)) .
                    concatMap words $ toStrings ts
               _ ->
                    return . fromStrings .
                    getCliticsText (isInMorpho (optMorpho env opts)) (optClitics opts) .
                    concatMap words $ toStrings ts,
     flags = [
       ("clitics","the list of possible clitics (comma-separated, no spaces)"),
       ("lang",   "the language of analysis")
       ],
     options = [
       ("raw", "analyse each word separately (not suitable input for parser)")
       ],
     examples = [
       mkEx "ca -lang=Fin -clitics=ko,ni \"nukkuuko minun vaimoni\" | p  -- to parse Finnish"
       ]
     }),

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
     exec = getEnv $ \ opts _ env@(Env pgf mos) -> do
       let file = optFile opts
       pgf <- optProbs opts pgf
       let printer = if (isOpt "api" opts) then exprToAPI else (showExpr [])
       let conf = configureExBased pgf (optMorpho env opts) (optLang pgf opts) printer
       (file',ws) <- restricted $ parseExamplesInGrammar conf file
       if null ws then return () else putStrLn ("unknown words: " ++ unwords ws)
       return (fromString ("wrote " ++ file')),
     needsTypeCheck = False
     }),
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
     exec = getEnv $ \ opts arg (Env pgf mos) -> do
       pgf <- optProbs opts (optRestricted opts pgf)
       gen <- newStdGen
       let dp = valIntOpts "depth" 4 opts
       let ts  = case mexp (toExprs arg) of
                   Just ex -> generateRandomFromDepth gen pgf ex (Just dp)
                   Nothing -> generateRandomDepth     gen pgf (optType pgf opts) (Just dp)
       returnFromExprs $ take (optNum opts) ts
     }),
  ("gt", emptyCommandInfo {
     longname = "generate_trees",
     synopsis = "generates a list of trees, by default exhaustive",
     explanation = unlines [
       "Generates all trees of a given category. By default, ",
       "the depth is limited to 4, but this can be changed by a flag.",
       "If a Tree argument is given, the command completes the Tree with values",
       "to all metavariables in the tree."
       ],
     flags = [
       ("cat","the generation category"),
       ("depth","the maximum generation depth"),
       ("lang","excludes functions that have no linearization in this language"),
       ("number","the number of trees generated")
       ],
     examples = [
       mkEx "gt                     -- all trees in the startcat, to depth 4",
       mkEx "gt -cat=NP -number=16  -- 16 trees in the category NP",
       mkEx "gt -cat=NP -depth=2    -- trees in the category NP to depth 2",
       mkEx "gt (AdjCN ? (UseN ?))  -- trees of form (AdjCN ? (UseN ?))"
       ],
     exec = getEnv $ \ opts arg (Env pgf mos) -> do
       let pgfr = optRestricted opts pgf
       let dp = valIntOpts "depth" 4 opts
       let ts = case mexp (toExprs arg) of
                  Just ex -> generateFromDepth pgfr ex (Just dp)
                  Nothing -> generateAllDepth pgfr (optType pgf opts) (Just dp)
       returnFromExprs $ take (optNumInf opts) ts
     }),
  ("i", emptyCommandInfo {
     longname = "import",
     synopsis = "import a grammar from source code or compiled .pgf file",
     explanation = unlines [
       "Reads a grammar from File and compiles it into a GF runtime grammar.",
       "If its abstract is different from current state, old modules are discarded.",
       "If its abstract is the same and a concrete with the same name is already in the state",
       "it is overwritten - but only if compilation succeeds.",
       "The grammar parser depends on the file name suffix:",
       "  .cf    context-free (labelled BNF) source",
       "  .ebnf  extended BNF source",
       "  .gfm   multi-module GF source",
       "  .gf    normal GF source",
       "  .gfo   compiled GF source",
       "  .pgf   precompiled grammar in Portable Grammar Format"
       ],
     flags = [
       ("probs","file with biased probabilities for generation")
       ],
     options = [
       -- ["gfo", "src", "no-cpu", "cpu", "quiet", "verbose"]
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
       mkEx "l -lang=LangSwe,LangNor no_Utt   -- linearize tree to LangSwe and LangNor",
       mkEx "gr -lang=LangHin -cat=Cl | l -table -to_devanagari -- hindi table",
       mkEx "l -unlexer=\"LangAra=to_arabic LangHin=to_devanagari\" -- different unlexers"
       ],
     exec = getEnv $ \ opts ts (Env pgf mos) -> return . fromStrings . optLins pgf opts $ toExprs ts,
     options = [
       ("all",    "show all forms and variants, one by line (cf. l -list)"),
       ("bracket","show tree structure with brackets and paths to nodes"),
       ("groups", "all languages, grouped by lang, remove duplicate strings"),
       ("list","show all forms and variants, comma-separated on one line (cf. l -all)"),
       ("multi","linearize to all languages (default)"),
       ("table","show all forms labelled by parameters"),
       ("tabtreebank","show the tree and its linearizations on a tab-separated line"),
       ("treebank","show the tree and tag linearizations with language names")
       ] ++ stringOpOptions,
     flags = [
       ("lang","the languages of linearization (comma-separated, no spaces)"),
       ("unlexer","set unlexers separately to each language (space-separated)")
       ]
     }),
  ("lc", emptyCommandInfo {
     longname = "linearize_chunks",
     synopsis = "linearize a tree that has metavariables in maximal chunks without them",
     explanation = unlines [
       "A hopefully temporary command, intended to work around the type checker that fails",
       "trees where a function node is a metavariable."
       ],
     examples = [
       mkEx "l -lang=LangSwe,LangNor -chunks ? a b (? c d)"
       ],
     exec = getEnv $ \ opts ts (Env pgf mos) -> return . fromStrings $ optLins pgf (opts ++ [OOpt "chunks"]) (toExprs ts),
     options = [
       ("treebank","show the tree and tag linearizations with language names")
       ] ++ stringOpOptions,
     flags = [
       ("lang","the languages of linearization (comma-separated, no spaces)")
       ],
     needsTypeCheck = False
     }),
  ("ma", emptyCommandInfo {
     longname = "morpho_analyse",
     synopsis = "print the morphological analyses of all words in the string",
     explanation = unlines [
       "Prints all the analyses of space-separated words in the input string,",
       "using the morphological analyser of the actual grammar (see command pg)"
       ],
     exec  = getEnv $ \opts ts env -> case opts of
               _ | isOpt "missing" opts ->
                    return . fromString . unwords .
                    morphoMissing (optMorpho env opts) .
                    concatMap words $ toStrings ts
               _ | isOpt "known" opts ->
                    return . fromString . unwords .
                    morphoKnown (optMorpho env opts) .
                    concatMap words $ toStrings ts
               _ -> return . fromString . unlines .
                    map prMorphoAnalysis . concatMap (morphos env opts) .
                    concatMap words $ toStrings ts,
     flags = [
       ("lang","the languages of analysis (comma-separated, no spaces)")
       ],
     options = [
       ("known",  "return only the known words, in order of appearance"),
       ("missing","show the list of unknown words, in order of appearance")
       ]
     }),

  ("mq", emptyCommandInfo {
     longname = "morpho_quiz",
     synopsis = "start a morphology quiz",
     syntax   = "mq (-cat=CAT)? (-probs=FILE)? TREE?",
     exec = getEnv $ \ opts arg (Env pgf mos) -> do
         let lang = optLang pgf opts
         let typ  = optType pgf opts
         pgf <- optProbs opts pgf
         let mt = mexp (toExprs arg)
         restricted $ morphologyQuiz mt pgf lang typ
         return void,
     flags = [
       ("lang","language of the quiz"),
       ("cat","category of the quiz"),
       ("number","maximum number of questions"),
       ("probs","file with biased probabilities for generation")
       ]
     }),

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
     exec = getEnv $ \ opts ts (Env pgf mos) ->
              return $ fromParse opts (concat [map ((,) s) (par pgf opts s) | s <- toStrings ts]),
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
       "N.B.2 Another way to produce different formats is to use 'gf -make',",
       "the batch compiler. The following values are available both for",
       "the batch compiler (flag -output-format) and the print_grammar",
       "command (flag -printer):",
       ""
       ] ++ unlines (sort [
        " " ++ opt ++ "\t\t" ++ expl |
           ((opt,_),expl) <- outputFormatsExpl, take 1 expl /= "*"
       ]),
     exec  = getEnv $ \opts _ env -> prGrammar env opts,
     flags = [
       --"cat",
       ("file",   "set the file name when printing with -pgf option"),
       ("lang",   "select languages for the some options (default all languages)"),
       ("printer","select the printing format (see flag values above)")
       ],
     options = [
       ("cats",   "show just the names of abstract syntax categories"),
       ("fullform", "print the fullform lexicon"),
       ("funs",   "show just the names and types of abstract syntax functions"),
       ("langs",  "show just the names of top concrete syntax modules"),
       ("lexc", "print the lexicon in Xerox LEXC format"),
       ("missing","show just the names of functions that have no linearization"),
       ("opt",    "optimize the generated pgf"),
       ("pgf",    "write current pgf image in file"),
       ("words", "print the list of words")
       ],
     examples = [
       mkEx ("pg -funs | ? grep \" S ;\"  -- show functions with value cat S")
       ]
     }),
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
       mkEx "pt -compute (plus one two)                               -- compute value"
       ],
     exec = getEnv $ \ opts arg (Env pgf mos) ->
            returnFromExprs . takeOptNum opts . treeOps pgf opts $ toExprs arg,
     options = treeOpOptions undefined{-pgf-},
     flags = [("number","take at most this many trees")] ++ treeOpFlags undefined{-pgf-}
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
     exec = getEnv $ \ opts _ (Env pgf mos) -> do
       let file = valStrOpts "file" "_gftmp" opts
       let exprs []         = ([],empty)
           exprs ((n,s):ls) | null s
                            = exprs ls
           exprs ((n,s):ls) = case readExpr s of
                                Just e  -> let (es,err) = exprs ls
                                           in case inferExpr pgf e of
                                                Right (e,t) -> (e:es,err)
                                                Left tcerr  -> (es,"on line" <+> n <> ':' $$ nest 2 (ppTcError tcerr) $$ err)
                                Nothing -> let (es,err) = exprs ls
                                           in (es,"on line" <+> n <> ':' <+> "parse error" $$ err)
           returnFromLines ls = case exprs ls of
                                  (es, err) | null es   -> return $ pipeMessage $ render (err $$ "no trees found")
                                            | otherwise -> return $ pipeWithMessage es (render err)

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
  ("rt", emptyCommandInfo {
     longname = "rank_trees",
     synopsis = "show trees in an order of decreasing probability",
     explanation = unlines [
       "Order trees from the most to the least probable, using either",
       "even distribution in each category (default) or biased as specified",
       "by the file given by flag -probs=FILE, where each line has the form",
       "'function probability', e.g. 'youPol_Pron  0.01'."
       ],
     exec = getEnv $ \ opts arg (Env pgf mos) -> do
         let ts = toExprs arg
         pgf <- optProbs opts pgf
         let tds = rankTreesByProbs pgf ts
         if isOpt "v" opts
           then putStrLn $
                  unlines [showExpr []  t ++ "\t--" ++ show d | (t,d) <- tds]
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
     exec = getEnv $ \ opts arg (Env pgf mos) -> do
         let from = optLangFlag "from" pgf opts
         let to   = optLangFlag "to" pgf opts
         let typ  = optType pgf opts
         let mt   = mexp (toExprs arg)
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
       "or LaTeX (flag -output=latex)",
       "or the CoNLL/MaltParser format (flag -output=conll for training, malt_input",
       "for unanalysed input).",
       "By default, the last argument is the head of every abstract syntax",
       "function; moreover, the head depends on the head of the function above.",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by dot (graphviz) and displayed by the program indicated",
       "by the view flag. The target format is png, unless overridden by the",
       "flag -format. Results from multiple trees are combined to pdf with convert (ImageMagick).",
       "See also 'vp -showdep' for another visualization of dependencies." 
       ],
     exec = getEnv $ \ opts arg (Env pgf mos) -> do
         let absname = abstractName pgf
         let es = toExprs arg
         let debug = isOpt "v" opts
         let abslabels = valStrOpts "abslabels" (valStrOpts "file" "" opts) opts
         let cnclabels = valStrOpts "cnclabels" "" opts
         let outp = valStrOpts "output" "dot" opts
         mlab <- case abslabels of
           "" -> return Nothing
           _  -> (Just . getDepLabels) `fmap` restricted (readFile abslabels)
         mclab <- case cnclabels of
           "" -> return Nothing
           _  -> (Just . getCncDepLabels) `fmap` restricted (readFile cnclabels)
         let lang = optLang pgf opts
         let grphs = map (graphvizDependencyTree outp debug mlab mclab pgf lang) es
         if isOpt "conll2latex" opts
           then return $ fromString $ conlls2latexDoc $ stanzas $ unlines $ toStrings arg
           else if isFlag "view" opts && valStrOpts "output" "" opts == "latex"
             then do
               let view = optViewGraph opts
               viewLatex view "_grphd_" grphs
             else if isFlag "view" opts || isFlag "format" opts
               then do
                 let view = optViewGraph opts
                 let format = optViewFormat opts
                 viewGraphviz view format "_grphd_" grphs
               else return $ fromString $ unlines $ intersperse "" grphs,
     examples = [
       mkEx "gr | vd              -- generate a tree and show dependency tree in .dot",
       mkEx "gr | vd -view=open   -- generate a tree and display dependency tree on with Mac's 'open'",
       mkEx "gr | vd -view=open -output=latex   -- generate a tree and display latex dependency tree with Mac's 'open'",
       mkEx "gr -number=1000 | vd -abslabels=Lang.labels -cnclabels=LangSwe.labels -output=conll  -- generate a random treebank",
       mkEx "rf -file=ex.conll | vd -conll2latex | wf -file=ex.tex   -- convert conll file to latex"
       ],
     options = [
       ("v","show extra information"),
       ("conll2latex", "convert conll to latex")
       ],
     flags = [
       ("abslabels","abstract configuration file for labels, format per line 'fun label*'"),
       ("cnclabels","concrete configuration file for labels, format per line 'fun {words|*} pos label head'"),
       ("file",     "same as abslabels (abstract configuration file)"),
       ("format",   "format of the visualization file using dot (default \"png\")"),
       ("output",   "output format of graph source (latex, conll, dot (default but deprecated))"),
       ("view",     "program to open the resulting graph file (default \"open\")"),
       ("lang",     "the language of analysis")
       ]
    }),


  ("vp", emptyCommandInfo {
     longname = "visualize_parse",
     synopsis = "show parse tree graphically",
     explanation = unlines [
       "Prints a parse tree in the .dot format (the graphviz format).",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by dot (graphviz) and displayed by the program indicated",
       "by the view flag. The target format is png, unless overridden by the",
       "flag -format. Results from multiple trees are combined to pdf with convert (ImageMagick)."
       ],
     exec = getEnv $ \ opts arg (Env pgf mos) -> do
         let es = toExprs arg
         let lang = optLang pgf opts
         let gvOptions = GraphvizOptions {noLeaves = isOpt "noleaves" opts && not (isOpt "showleaves" opts),
                                          noFun = isOpt "nofun" opts || not (isOpt "showfun" opts),
                                          noCat = isOpt "nocat" opts && not (isOpt "showcat" opts),
                                          noDep = not (isOpt "showdep" opts),
                                          nodeFont = valStrOpts "nodefont" "" opts,
                                          leafFont = valStrOpts "leaffont" "" opts,
                                          nodeColor = valStrOpts "nodecolor" "" opts,
                                          leafColor = valStrOpts "leafcolor" "" opts,
                                          nodeEdgeStyle = valStrOpts "nodeedgestyle" "solid" opts,
                                          leafEdgeStyle = valStrOpts "leafedgestyle" "dashed" opts
                                         }
         let depfile = valStrOpts "file" "" opts
         mlab <- case depfile of
           "" -> return Nothing
           _  -> (Just . getDepLabels) `fmap` restricted (readFile depfile)
         let grphs = map (graphvizParseTreeDep mlab pgf lang gvOptions) es
         if isFlag "view" opts || isFlag "format" opts
           then do
             let view = optViewGraph opts
             let format = optViewFormat opts
             viewGraphviz view format "_grphp_" grphs
           else return $ fromString $ unlines grphs,
     examples = [
       mkEx "p \"John walks\" | vp  -- generate a tree and show parse tree as .dot script",
       mkEx "gr | vp -view=open -- generate a tree and display parse tree on a Mac",
       mkEx "p \"she loves us\" | vp -view=open -showdep -file=uddeps.labels -nocat  -- show a visual variant of a dependency tree"
       ],
     options = [
       ("showcat","show categories in the tree nodes (default)"),
       ("nocat","don't show categories"),
       ("showdep","show dependency labels"),
       ("showfun","show function names in the tree nodes"),
       ("nofun","don't show function names (default)"),
       ("showleaves","show the leaves of the tree (default)"),
       ("noleaves","don't show the leaves of the tree (i.e., only the abstract tree)")
       ],
     flags = [
       ("lang","the language to visualize"),
       ("file","configuration file for dependency labels with -deps, format per line 'fun label*'"),
       ("format","format of the visualization file (default \"png\")"),
       ("view","program to open the resulting file (default \"open\")"),
       ("nodefont","font for tree nodes (default: Times -- graphviz standard font)"),
       ("leaffont","font for tree leaves (default: nodefont)"),
       ("nodecolor","color for tree nodes (default: black -- graphviz standard color)"),
       ("leafcolor","color for tree leaves (default: nodecolor)"),
       ("nodeedgestyle","edge style between tree nodes (solid/dashed/dotted/bold, default: solid)"),
       ("leafedgestyle","edge style for links to leaves (solid/dashed/dotted/bold, default: dashed)")
       ]
    }),


  ("vt", emptyCommandInfo {
     longname = "visualize_tree",
     synopsis = "show a set of trees graphically",
     explanation = unlines [
       "Prints a set of trees in the .dot format (the graphviz format).",
       "The graph can be saved in a file by the wf command as usual.",
       "If the -view flag is defined, the graph is saved in a temporary file",
       "which is processed by dot (graphviz) and displayed by the command indicated",
       "by the view flag. The target format is postscript, unless overridden by the",
       "flag -format. Results from multiple trees are combined to pdf with convert (ImageMagick).",
       "With option -mk, use for showing library style function names of form 'mkC'."
       ],
     exec = getEnv $ \ opts arg (Env pgf mos) ->
      let es = toExprs arg in
       if isOpt "mk" opts
       then return $ fromString $ unlines $ map (tree2mk pgf) es
       else if isOpt "api" opts
       then do
         let ss = map exprToAPI es
         mapM_ putStrLn ss
         return void
       else do
         let funs = not (isOpt "nofun" opts)
         let cats = not (isOpt "nocat" opts)
         let grphs = map (graphvizAbstractTree pgf (funs,cats)) es
         if isFlag "view" opts || isFlag "format" opts
           then do
             let view = optViewGraph opts
             let format = optViewFormat opts
             viewGraphviz view format "_grpht_" grphs
           else return $ fromString $ unlines grphs,
     examples = [
       mkEx "p \"hello\" | vt              -- parse a string and show trees as graph script",
       mkEx "p \"hello\" | vt -view=\"open\" -- parse a string and display trees on a Mac"
       ],
     options = [
       ("api", "show the tree with function names converted to 'mkC' with value cats C"),
       ("mk",  "similar to -api, deprecated"),
       ("nofun","don't show functions but only categories"),
       ("nocat","don't show categories but only functions")
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
       "If the argument is a function then ?its type is printed out.",
       "If it is a category then the category definition is printed.",
       "If a whole expression is given it prints the expression with refined",
       "metavariables and the type of the expression."
       ],
     exec = getEnv $ \ opts arg (Env pgf mos) -> do
       case toExprs arg of
         [EFun id] -> case Map.lookup id (funs (abstract pgf)) of
                        Just fd -> do putStrLn $ render (ppFun id fd)
                                      let (_,_,_,prob) = fd
                                      putStrLn ("Probability: "++show prob)
                                      return void
                        Nothing -> case Map.lookup id (cats (abstract pgf)) of
                                     Just cd   -> do putStrLn $
                                                        render (ppCat id cd $$
                                                                if null (functionsToCat pgf id)
                                                                  then empty
                                                                  else ' ' $$
                                                                       vcat [ppFun fid (ty,0,Just ([],[]),0) | (fid,ty) <- functionsToCat pgf id] $$
                                                                       ' ')
                                                     let (_,_,prob) = cd
                                                     putStrLn ("Probability: "++show prob)
                                                     return void
                                     Nothing   -> do putStrLn ("unknown category of function identifier "++show id)
                                                     return void
         [e]         -> case inferExpr pgf e of
                          Left tcErr   -> error $ render (ppTcError tcErr)
                          Right (e,ty) -> do putStrLn ("Expression:  "++showExpr [] e)
                                             putStrLn ("Type:        "++showType [] ty)
                                             putStrLn ("Probability: "++show (probTree pgf e))
                                             return void
         _           -> do putStrLn "a single identifier or expression is expected from the command"
                           return void,
     needsTypeCheck = False
     })
  ]
 where
   getEnv exec opts ts = liftSIO . exec opts ts =<< getPGFEnv

   par pgf opts s = case optOpenTypes opts of
                  []        -> [parse_ pgf lang (optType pgf opts) (Just dp) s | lang <- optLangs pgf opts]
                  open_typs -> [parseWithRecovery pgf lang (optType pgf opts) open_typs (Just dp) s | lang <- optLangs pgf opts]
     where
       dp = valIntOpts "depth" 4 opts

   fromParse opts = foldr (joinPiped . fromParse1 opts) void

   joinPiped (Piped (es1,ms1)) (Piped (es2,ms2)) = Piped (jA es1 es2,ms1+++-ms2)
     where
       jA (Exprs es1) (Exprs es2) = Exprs (es1++es2)
       -- ^ fromParse1 always output Exprs

   fromParse1 opts (s,(po,bs))
     | isOpt "bracket" opts = pipeMessage (showBracketedString bs)
     | otherwise            =
         case po of
           ParseOk ts      -> fromExprs ts
           ParseFailed i   -> pipeMessage $ "The parser failed at token "
                                             ++ show i ++": "
                                             ++ show (words s !! max 0 (i-1))
                                          -- ++ " in " ++ show s
           ParseIncomplete -> pipeMessage "The sentence is not complete"
           TypeError errs  ->
             pipeMessage . render $
               "The parsing is successful but the type checking failed with error(s):"
               $$ nest 2 (vcat (map (ppTcError . snd) errs))

   optLins pgf opts ts = case opts of
     _ | isOpt "groups" opts ->
       concatMap snd $ groupResults
         [[(lang, s) | lang <- optLangs pgf opts,s <- linear pgf opts lang t] | t <- ts]
     _ -> concatMap (optLin pgf opts) ts
   optLin pgf opts t =
     case opts of
       _ | isOpt "treebank" opts && isOpt "chunks" opts ->
         (showCId (abstractName pgf) ++ ": " ++ showExpr [] t) :
         [showCId lang ++ ": " ++ li | (lang,li) <- linChunks pgf opts t] --linear pgf opts lang t | lang <- optLangs pgf opts]
       _ | isOpt "treebank" opts ->
         (showCId (abstractName pgf) ++ ": " ++ showExpr [] t) :
         [showCId lang ++ ": " ++ s | lang <- optLangs pgf opts, s<-linear pgf opts lang t]
       _ | isOpt "tabtreebank" opts ->
         return $ concat $ intersperse "\t" $ (showExpr [] t) :
                   [s | lang <- optLangs pgf opts, s <- linear pgf opts lang t]
       _ | isOpt "chunks" opts -> map snd $ linChunks pgf opts t   
       _ -> [s | lang <- optLangs pgf opts, s<-linear pgf opts lang t]
   linChunks pgf opts t = 
     [(lang, unwords (intersperse "<+>" (map (unlines . linear pgf opts lang) (treeChunks t)))) | lang <- optLangs pgf opts]

   linear :: PGF -> [Option] -> CId -> Expr -> [String]
   linear pgf opts lang = let unl = unlex opts lang in case opts of
       _ | isOpt "all"     opts -> concat . -- intersperse [[]] .
                                   map (map (unl . snd)) . tabularLinearizes pgf lang
       _ | isOpt "list"    opts -> (:[]) . commaList . concat .
                                   map (map (unl . snd)) . tabularLinearizes pgf lang
       _ | isOpt "table"   opts -> concat . -- intersperse [[]] .
                    map (map (\(p,v) -> p+++":"+++unl v)) . tabularLinearizes pgf lang
       _ | isOpt "bracket" opts -> (:[]) . unwords . map showBracketedString . bracketedLinearize pgf lang
       _                        -> (:[]) . unl . linearize pgf lang

   -- replace each non-atomic constructor with mkC, where C is the val cat
   tree2mk pgf = showExpr [] . t2m where
     t2m t = case unApp t of
       Just (cid,ts@(_:_)) -> mkApp (mk cid) (map t2m ts)
       _ -> t
     mk = mkCId . ("mk" ++) . showCId . lookValCat (abstract pgf)

   unlex opts lang = stringOps Nothing (getUnlex opts lang ++ map prOpt opts) ----

   getUnlex opts lang = case words (valStrOpts "unlexer" "" opts) of
     lexs -> case lookup lang
               [(mkCId la,tail le) | lex <- lexs, let (la,le) = span (/='=') lex, not (null le)] of
       Just le -> chunks ',' le
       _ -> []

   commaList [] = []
   commaList ws = concat $ head ws : map (", " ++) (tail ws)

-- Proposed logic of coding in unlexing:
--   - If lang has no coding flag, or -to_utf8 is not in opts, just opts are used.
--   - If lang has flag coding=utf8, -to_utf8 is ignored.
--   - If lang has coding=other, and -to_utf8 is in opts, from_other is applied first.
-- THIS DOES NOT WORK UNFORTUNATELY - can't use the grammar flag properly
{-
   unlexx pgf opts lang = {- trace (unwords optsC) $ -} stringOps Nothing optsC where ----
     optsC = case lookConcrFlag pgf (mkCId lang) (mkCId "coding") of
       Just (LStr "utf8") -> filter (/="to_utf8") $ map prOpt opts
       Just (LStr other) | isOpt "to_utf8" opts ->
                      let cod = ("from_" ++ other)
                      in cod : filter (/=cod) (map prOpt opts)
       _ -> map prOpt opts
-}
   optRestricted opts pgf =
     restrictPGF (\f -> and [hasLin pgf la f | la <- optLangs pgf opts]) pgf

   optLang  = optLangFlag "lang"
   optLangs = optLangsFlag "lang"

   optLangsFlag f pgf opts = case valStrOpts f "" opts of
     "" -> languages pgf
     lang -> map (completeLang pgf) (chunks ',' lang)
   completeLang pgf la = let cla = (mkCId la) in
     if elem cla (languages pgf)
       then cla
       else (mkCId (showCId (abstractName pgf) ++ la))

   optLangFlag f pgf opts = head $ optLangsFlag f pgf opts ++ [wildCId]

   optOpenTypes opts = case valStrOpts "openclass" "" opts of
     ""   -> []
     cats -> mapMaybe readType (chunks ',' cats)

   optProbs opts pgf = case valStrOpts "probs" "" opts of
     ""   -> return pgf
     file -> do
       probs <- restricted $ readProbabilitiesFromFile file pgf
       return (setProbabilities probs pgf)

   optFile opts = valStrOpts "file" "_gftmp" opts

   optType pgf opts =
     let str = valStrOpts "cat" (showCId $ lookStartCat pgf) opts
     in case readType str of
          Just ty -> case checkType pgf ty of
                       Left tcErr -> error $ render (ppTcError tcErr)
                       Right ty   -> ty
          Nothing -> error ("Can't parse '"++str++"' as a type")
   optViewFormat opts = valStrOpts "format" "png" opts
   optViewGraph opts = valStrOpts "view" "open" opts
   optNum opts = valIntOpts "number" 1 opts
   optNumInf opts = valIntOpts "number" 1000000000 opts ---- 10^9
   takeOptNum opts = take (optNumInf opts)

   returnFromExprs es = return $ case es of
     [] -> pipeMessage "no trees found"
     _  -> fromExprs es

   prGrammar (Env pgf mos) opts
     | isOpt "pgf"      opts = do
          let pgf1 = if isOpt "opt" opts then optimizePGF pgf else pgf
          let outfile = valStrOpts "file" (showCId (abstractName pgf) ++ ".pgf") opts
          restricted $ encodeFile outfile pgf1
          putStrLn $ "wrote file " ++ outfile
          return void
     | isOpt "cats"     opts = return $ fromString $ unwords $ map showCId $ categories pgf
     | isOpt "funs"     opts = return $ fromString $ unlines $ map showFun $ funsigs pgf
     | isOpt "fullform" opts = return $ fromString $ concatMap (morpho mos "" prFullFormLexicon) $ optLangs pgf opts
     | isOpt "langs"    opts = return $ fromString $ unwords $ map showCId $ languages pgf

     | isOpt "lexc"     opts = return $ fromString $ concatMap (morpho mos "" prLexcLexicon) $ optLangs pgf opts
     | isOpt "missing"  opts = return $ fromString $ unlines $ [unwords (showCId la:":": map showCId cs) |
                                                                  la <- optLangs pgf opts, let cs = missingLins pgf la]
     | isOpt "words" opts = return $ fromString $ concatMap (morpho mos "" prAllWords) $ optLangs pgf opts
     | otherwise             = do fmt <- readOutputFormat (valStrOpts "printer" "pgf_pretty" opts)
                                  return $ fromString $ concatMap snd $ exportPGF noOptions fmt pgf

   funsigs pgf = [(f,ty) | (f,(ty,_,_,_)) <- Map.assocs (funs (abstract pgf))]
   showFun (f,ty) = showCId f ++ " : " ++ showType [] ty ++ " ;"

   morphos (Env pgf mos) opts s =
     [(s,morpho mos [] (\mo -> lookupMorpho mo s) la) | la <- optLangs pgf opts]

   morpho mos z f la = maybe z f $ Map.lookup la mos

   optMorpho (Env pgf mos) opts = morpho mos (error "no morpho") id (head (optLangs pgf opts))

   optClitics opts = case valStrOpts "clitics" "" opts of
     "" -> []
     cs -> map reverse $ chunks ',' cs

   mexp xs = case xs of
     t:_ -> Just t
     _   -> Nothing

   -- ps -f -g s returns g (f s)
   treeOps pgf opts s = foldr app s (reverse opts) where
     app (OOpt  op)         | Just (Left  f) <- treeOp pgf op = f
     app (OFlag op (VId x)) | Just (Right f) <- treeOp pgf op = f (mkCId x)
     app _                                                    = id

treeOpOptions pgf = [(op,expl) | (op,(expl,Left  _)) <- allTreeOps pgf]
treeOpFlags   pgf = [(op,expl) | (op,(expl,Right _)) <- allTreeOps pgf]

translationQuiz :: Maybe Expr -> PGF -> Language -> Language -> Type -> IO ()
translationQuiz mex pgf ig og typ = do
  tts <- translationList mex pgf ig og typ infinity
  mkQuiz "Welcome to GF Translation Quiz." tts

morphologyQuiz :: Maybe Expr -> PGF -> Language -> Type -> IO ()
morphologyQuiz mex pgf ig typ = do
  tts <- morphologyList mex pgf ig typ infinity
  mkQuiz "Welcome to GF Morphology Quiz." tts

-- | the maximal number of precompiled quiz problems
infinity :: Int
infinity = 256

prLexcLexicon :: Morpho -> String
prLexcLexicon mo =
  unlines $ "Multichar_Symbols":multichars:"":"LEXICON Root" : [prLexc l p ++ ":" ++ w  ++ " # ;" | (w,lps) <- morpho, (l,p) <- lps] ++ ["END"]
 where
  morpho = fullFormLexicon mo
  prLexc l p = showCId l ++ concat (mkTags (words p))
  mkTags p = case p of
    "s":ws -> mkTags ws   --- remove record field
    ws -> map ('+':) ws

  multichars = unwords $ nub $ concat [mkTags (words p) | (w,lps) <- morpho, (l,p) <- lps]
  -- thick_A+(AAdj+Posit+Gen):thick's # ;

prFullFormLexicon :: Morpho -> String
prFullFormLexicon mo =
  unlines (map prMorphoAnalysis (fullFormLexicon mo))

prAllWords :: Morpho -> String
prAllWords mo =
  unwords [w | (w,_) <- fullFormLexicon mo]

prMorphoAnalysis :: (String,[(Lemma,Analysis)]) -> String
prMorphoAnalysis (w,lps) =
  unlines (w:[showCId l ++ " : " ++ p | (l,p) <- lps])

viewGraphviz :: String -> String -> String -> [String] -> SIO CommandOutput
viewGraphviz view format name grphs = do
           let file i s = name ++ i ++ "." ++ s
           mapM_ (\ (grph,i) -> restricted $ writeUTF8File (file (show i) "dot") grph) (zip grphs [1..])
           mapM_ (\i -> restrictedSystem $ "dot -T" ++ format ++ " " ++ file (show i) "dot" ++ " > " ++ file (show i) format) [1..length grphs]
           if length grphs > 1
             then do
               let files = unwords [file (show i) format | i <- [1..length grphs]]
               restrictedSystem $ "convert " ++ files ++ " " ++ file "all" "pdf"
               restrictedSystem $ view ++ " " ++ file "all" "pdf"
             else restrictedSystem $ view ++ " " ++ file "1" format
---           restrictedSystem $ "rm " ++ file "*" format  --- removing temporary files
---           restrictedSystem $ "rm " ++ file "*" "dot"
---           restrictedSystem $ "rm " ++ file "all" "pdf"
           return void

viewLatex :: String -> String -> [String] -> SIO CommandOutput
viewLatex view name grphs = do
  let texfile = name ++ ".tex"
  let pdffile = name ++ ".pdf"
  restricted $ writeUTF8File texfile (latexDoc grphs)
  restrictedSystem $ "pdflatex " ++ texfile
  restrictedSystem $ view ++ " " ++ pdffile
  return void
  
---- copied from VisualizeTree ; not sure about proper place AR Nov 2015
latexDoc :: [String] -> String
latexDoc body = unlines $
    "\\batchmode"
  : "\\documentclass{article}"
  : "\\usepackage[utf8]{inputenc}"  
  : "\\begin{document}"
  : spaces body
  ++ ["\\end{document}"]
 where
   spaces = intersperse "\\vspace{6mm}"
   ---- also reduce the size for long sentences

stanzas :: String -> [String]
stanzas = map unlines . chop . lines where
  chop ls = case break (=="") ls of
    (ls1,[])  -> [ls1]
    (ls1,_:ls2) -> ls1 : chop ls2
