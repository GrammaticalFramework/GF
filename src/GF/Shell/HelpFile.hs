----------------------------------------------------------------------
-- |
-- Module      : GF.Shell.HelpFile
-- Maintainer  : Aarne Ranta
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/12 10:03:34 $
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.9 $
--
-- Help on shell commands. Generated from HelpFile by 'make help'.
-- PLEASE DON'T EDIT THIS FILE.
-----------------------------------------------------------------------------


module GF.Shell.HelpFile where

import GF.Data.Operations

txtHelpFileSummary =
  unlines $ map (concat . take 1 . lines) $ paragraphs txtHelpFile

txtHelpCommand c =
  case lookup c [(takeWhile (/=',') p,p) | p <- paragraphs txtHelpFile] of
    Just s -> s
    _ -> "Command not found."

txtHelpFile =
  "\n-- GF help file updated for GF 2.2, 17/5/2005." ++
  "\n-- *: Commands and options marked with * are not yet implemented." ++
  "\n--" ++
  "\n-- Each command has a long and a short name, options, and zero or more" ++
  "\n-- arguments. Commands are sorted by functionality. The short name is" ++
  "\n-- given first." ++
  "\n" ++
  "\n-- Type \"h -all\" for full help file, \"h <CommandName>\" for full help on a command.  " ++
  "\n" ++
  "\n-- commands that change the state" ++
  "\n" ++
  "\ni,  import: i File" ++
  "\n      Reads a grammar from File and compiles it into a GF runtime grammar." ++
  "\n      Files \"include\"d in File are read recursively, nubbing repetitions." ++
  "\n      If a grammar with the same language name is already in the state," ++
  "\n      it is overwritten - but only if compilation succeeds. " ++
  "\n      The grammar parser depends on the file name suffix:" ++
  "\n        .gf    normal GF source" ++
  "\n        .gfc   canonical GF" ++
  "\n        .gfr   precompiled GF resource  " ++
  "\n        .gfcm  multilingual canonical GF" ++
  "\n        .gfe   example-based grammar files (only with the -ex option)" ++
  "\n        .ebnf  Extended BNF format" ++
  "\n        .cf    Context-free (BNF) format" ++
  "\n        .trc   TransferCore format" ++
  "\n  options:" ++
  "\n      -old          old: parse in GF<2.0 format (not necessary)" ++
  "\n      -v            verbose: give lots of messages " ++
  "\n      -s            silent: don't give error messages" ++
  "\n      -src          source: ignore precompiled gfc and gfr files" ++
  "\n      -retain       retain operations: read resource modules (needed in comm cc) " ++
  "\n      -nocf         don't build context-free grammar (thus no parser)" ++
  "\n      -nocheckcirc  don't eliminate circular rules from CF " ++
  "\n      -cflexer      build an optimized parser with separate lexer trie" ++
  "\n      -noemit       do not emit code (default with old grammar format)" ++
  "\n      -o            do emit code (default with new grammar format)" ++
  "\n      -ex           preprocess .gfe files if needed" ++
  "\n      -prob         read probabilities from top grammar file  (format --# prob Fun Double)" ++
  "\n  flags:" ++
  "\n      -abs          set the name used for abstract syntax (with -old option)" ++
  "\n      -cnc          set the name used for concrete syntax (with -old option)" ++
  "\n      -res          set the name used for resource (with -old option)" ++
  "\n      -path         use the (colon-separated) search path to find modules" ++
  "\n      -optimize     select an optimization to override file-defined flags" ++
  "\n      -conversion   select parsing method (values strict|nondet)" ++
  "\n      -probs        read probabilities from file (format (--# prob) Fun Double)" ++
  "\n      -noparse      read nonparsable functions from file (format --# noparse Funs) " ++
  "\n  examples:" ++
  "\n      i English.gf                      -- ordinary import of Concrete" ++
  "\n      i -retain german/ParadigmsGer.gf  -- import of Resource to test" ++
  "\n      " ++
  "\n* rl, remove_language: rl Language" ++
  "\n      Takes away the language from the state." ++
  "\n" ++
  "\ne,  empty: e" ++
  "\n      Takes away all languages and resets all global flags." ++
  "\n" ++
  "\nsf, set_flags: sf Flag*" ++
  "\n      The values of the Flags are set for Language. If no language" ++
  "\n      is specified, the flags are set globally." ++
  "\n  examples:" ++
  "\n      sf -nocpu     -- stop showing CPU time" ++
  "\n      sf -lang=Swe  -- make Swe the default concrete" ++
  "\n" ++
  "\ns,  strip: s" ++
  "\n      Prune the state by removing source and resource modules." ++
  "\n" ++
  "\ndc, define_command Name Anything" ++
  "\n      Add a new defined command. The Name must star with '%'. Later," ++
  "\n      if 'Name X' is used, it is replaced by Anything where #1 is replaced" ++
  "\n      by X. " ++
  "\n      Restrictions: Currently at most one argument is possible, and a defined" ++
  "\n      command cannot appear in a pipe.     " ++
  "\n      To see what definitions are in scope, use help -defs." ++
  "\n  examples:" ++
  "\n      dc %tnp p -cat=NP -lang=Eng #1 | l -lang=Swe    -- translate NPs" ++
  "\n      %tnp \"this man\"                                 -- translate and parse" ++
  "\n" ++
  "\ndt, define_term Name Tree" ++
  "\n      Add a constant for a tree. The constant can later be called by" ++
  "\n      prefixing it with '$'. " ++
  "\n      Restriction: These terms are not yet usable as a subterm. " ++
  "\n      To see what definitions are in scope, use help -defs." ++
  "\n  examples:" ++
  "\n      p -cat=NP \"this man\" | dt tm    -- define tm as parse result" ++
  "\n      l -all $tm                      -- linearize tm in all forms" ++
  "\n" ++
  "\n-- commands that give information about the state" ++
  "\n" ++
  "\npg, print_grammar: pg" ++
  "\n      Prints the actual grammar (overridden by the -lang=X flag)." ++
  "\n      The -printer=X flag sets the format in which the grammar is" ++
  "\n      written." ++
  "\n      N.B. since grammars are compiled when imported, this command" ++
  "\n      generally does not show the grammar in the same format as the" ++
  "\n      source. In particular, the -printer=latex is not supported. " ++
  "\n      Use the command tg -printer=latex File to print the source " ++
  "\n      grammar in LaTeX." ++
  "\n  options:" ++
  "\n      -utf8  apply UTF8-encoding to the grammar" ++
  "\n  flags: " ++
  "\n      -printer" ++
  "\n      -lang" ++
  "\n  examples:" ++
  "\n      pg -printer=cf  -- show the context-free skeleton" ++
  "\n" ++
  "\npm, print_multigrammar: pm" ++
  "\n      Prints the current multilingual grammar in .gfcm form." ++
  "\n      (Automatically executes the strip command (s) before doing this.)" ++
  "\n  options:" ++
  "\n      -utf8  apply UTF8 encoding to the tokens in the grammar" ++
  "\n      -utf8id apply UTF8 encoding to the identifiers in the grammar" ++
  "\n  examples:" ++
  "\n      pm | wf Letter.gfcm  -- print the grammar into the file Letter.gfcm" ++
  "\n      pm -printer=graph | wf D.dot  -- then do 'dot -Tps D.dot > D.ps'" ++
  "\n" ++
  "\nvg, visualize_graph: vg" ++
  "\n     Show the dependency graph of multilingual grammar via dot and gv." ++
  "\n" ++
  "\npo, print_options: po" ++
  "\n      Print what modules there are in the state. Also" ++
  "\n      prints those flag values in the current state that differ from defaults." ++
  "\n" ++
  "\npl, print_languages: pl" ++
  "\n      Prints the names of currently available languages." ++
  "\n" ++
  "\npi, print_info: pi Ident" ++
  "\n      Prints information on the identifier." ++
  "\n" ++
  "\n-- commands that execute and show the session history" ++
  "\n" ++
  "\neh, execute_history: eh File" ++
  "\n      Executes commands in the file." ++
  "\n" ++
  "\nph, print_history; ph" ++
  "\n      Prints the commands issued during the GF session." ++
  "\n      The result is readable by the eh command." ++
  "\n  examples:" ++
  "\n      ph | wf foo.hist\"  -- save the history into a file" ++
  "\n" ++
  "\n-- linearization, parsing, translation, and computation" ++
  "\n" ++
  "\nl,  linearize: l PattList? Tree" ++
  "\n      Shows all linearization forms of Tree by the actual grammar" ++
  "\n      (which is overridden by the -lang flag). " ++
  "\n      The pattern list has the form [P, ... ,Q] where P,...,Q follow GF " ++
  "\n      syntax for patterns. All those forms are generated that match with the" ++
  "\n      pattern list. Too short lists are filled with variables in the end." ++
  "\n      Only the -table flag is available if a pattern list is specified." ++
  "\n      HINT: see GF language specification for the syntax of Pattern and Term." ++
  "\n      You can also copy and past parsing results." ++
  "\n  options:  " ++
  "\n      -table   show parameters" ++
  "\n      -struct  bracketed form" ++
  "\n      -record  record, i.e. explicit GF concrete syntax term" ++
  "\n      -all     show all forms and variants" ++
  "\n      -multi   linearize to all languages (the other options don't work)" ++
  "\n  flags:" ++
  "\n      -lang    linearize in this grammar" ++
  "\n      -number  give this number of forms at most" ++
  "\n      -unlexer filter output through unlexer" ++
  "\n  examples:" ++
  "\n      l -lang=Swe -table  -- show full inflection table in Swe" ++
  "\n" ++
  "\np,  parse: p String" ++
  "\n      Shows all Trees returned for String by the actual" ++
  "\n      grammar (overridden by the -lang flag), in the category S (overridden" ++
  "\n      by the -cat flag)." ++
  "\n  options for batch input:" ++
  "\n      -lines   parse each line of input separately, ignoring empty lines" ++
  "\n      -all     as -lines, but also parse empty lines" ++
  "\n      -prob    rank results by probability" ++
  "\n      -cut     stop after first lexing result leading to parser success" ++
  "\n  options for selecting parsing method:" ++
  "\n      (default)parse using an overgenerating CFG" ++
  "\n      -cfg     parse using a much less overgenerating CFG" ++
  "\n      -mcfg    parse using an even less overgenerating MCFG" ++
  "\n      Note:    the first time parsing with -cfg or -mcfg might take a long time" ++
  "\n  options that only work for the default parsing method:" ++
  "\n      -n       non-strict: tolerates morphological errors" ++
  "\n      -ign     ignore unknown words when parsing" ++
  "\n      -raw     return context-free terms in raw form" ++
  "\n      -v       verbose: give more information if parsing fails" ++
  "\n  flags:" ++
  "\n      -cat     parse in this category" ++
  "\n      -lang    parse in this grammar" ++
  "\n      -lexer   filter input through this lexer" ++
  "\n      -parser  use this parsing strategy" ++
  "\n      -number  return this many results at most" ++
  "\n  examples:" ++
  "\n      p -cat=S -mcfg \"jag är gammal\"   -- parse an S with the MCFG" ++
  "\n      rf examples.txt | p -lines      -- parse each non-empty line of the file" ++
  "\n" ++
  "\nat, apply_transfer: at (Module.Fun | Fun)" ++
  "\n      Transfer a term using Fun from Module, or the topmost transfer" ++
  "\n      module. Transfer modules are given in the .trc format. They are" ++
  "\n      shown by the 'po' command." ++
  "\n  flags:" ++
  "\n     -lang     typecheck the result in this lang instead of default lang" ++
  "\n  examples:" ++
  "\n     p -lang=Cncdecimal \"123\" | at num2bin | l   -- convert dec to bin" ++
  "\n" ++
  "\ntt, test_tokenizer: tt String" ++
  "\n      Show the token list sent to the parser when String is parsed." ++
  "\n      HINT: can be useful when debugging the parser." ++
  "\n  flags: " ++
  "\n     -lexer    use this lexer" ++
  "\n  examples:" ++
  "\n     tt -lexer=codelit \"2*(x + 3)\"  -- a favourite lexer for program code" ++
  "\n" ++
  "\ng, grep: g String1 String2" ++
  "\n      Grep the String1 in the String2. String2 is read line by line," ++
  "\n      and only those lines that contain String1 are returned." ++
  "\n  flags:" ++
  "\n     -v  return those lines that do not contain String1." ++
  "\n  examples:" ++
  "\n     pg -printer=cf | grep \"mother\"  -- show cf rules with word mother" ++
  "\n" ++
  "\ncc, compute_concrete: cc Term" ++
  "\n      Compute a term by concrete syntax definitions. Uses the topmost" ++
  "\n      resource module (the last in listing by command po) to resolve " ++
  "\n      constant names. " ++
  "\n      N.B. You need the flag -retain when importing the grammar, if you want " ++
  "\n      the oper definitions to be retained after compilation; otherwise this" ++
  "\n      command does not expand oper constants." ++
  "\n      N.B.' The resulting Term is not a term in the sense of abstract syntax," ++
  "\n      and hence not a valid input to a Tree-demanding command." ++
  "\n  flags:" ++
  "\n     -res      use another module than the topmost one" ++
  "\n  examples:" ++
  "\n     cc -res=ParadigmsFin (nLukko \"hyppy\")   -- inflect \"hyppy\" with nLukko" ++
  "\n" ++
  "\nso, show_operations: so Type" ++
  "\n      Show oper operations with the given value type. Uses the topmost " ++
  "\n      resource module to resolve constant names. " ++
  "\n      N.B. You need the flag -retain when importing the grammar, if you want " ++
  "\n      the oper definitions to be retained after compilation; otherwise this" ++
  "\n      command does not find any oper constants." ++
  "\n      N.B.' The value type may not be defined in a supermodule of the" ++
  "\n      topmost resource. In that case, use appropriate qualified name." ++
  "\n  flags:" ++
  "\n     -res      use another module than the topmost one" ++
  "\n  examples:" ++
  "\n     so -res=ParadigmsFin ResourceFin.N  -- show N-paradigms in ParadigmsFin" ++
  "\n" ++
  "\nt,  translate: t Lang Lang String" ++
  "\n      Parses String in Lang1 and linearizes the resulting Trees in Lang2." ++
  "\n  flags:" ++
  "\n      -cat" ++
  "\n      -lexer" ++
  "\n      -parser" ++
  "\n  examples:" ++
  "\n      t Eng Swe -cat=S \"every number is even or odd\"" ++
  "\n" ++
  "\ngr, generate_random: gr Tree?" ++
  "\n      Generates a random Tree of a given category. If a Tree" ++
  "\n      argument is given, the command completes the Tree with values to" ++
  "\n      the metavariables in the tree. " ++
  "\n  options:" ++
  "\n      -prob    use probabilities (works for nondep types only)" ++
  "\n      -cf      use a very fast method (works for nondep types only)" ++
  "\n  flags:" ++
  "\n      -cat     generate in this category" ++
  "\n      -lang    use the abstract syntax of this grammar" ++
  "\n      -number  generate this number of trees (not impl. with Tree argument)" ++
  "\n      -depth   use this number of search steps at most" ++
  "\n  examples:" ++
  "\n      gr -cat=Query            -- generate in category Query" ++
  "\n      gr (PredVP ? (NegVG ?))  -- generate a random tree of this form" ++
  "\n      gr -cat=S -tr | l        -- gererate and linearize" ++
  "\n" ++
  "\ngt, generate_trees: gt Tree?" ++
  "\n      Generates all trees up to a given depth. If the depth is large," ++
  "\n      a small -alts is recommended. If a Tree argument is given, the" ++
  "\n      command completes the Tree with values to the metavariables in" ++
  "\n      the tree." ++
  "\n  options:" ++
  "\n      -metas   also return trees that include metavariables" ++
  "\n  flags:" ++
  "\n      -depth   generate to this depth (default 3)" ++
  "\n      -atoms   take this number of atomic rules of each category (default unlimited)" ++
  "\n      -alts    take this number of alternatives at each branch (default unlimited)" ++
  "\n      -cat     generate in this category" ++
  "\n      -lang    use the abstract syntax of this grammar" ++
  "\n      -number  generate (at most) this number of trees" ++
  "\n  examples:" ++
  "\n      gt -depth=10 -cat=NP     -- generate all NP's to depth 10 " ++
  "\n      gt (PredVP ? (NegVG ?))  -- generate all trees of this form" ++
  "\n      gt -cat=S -tr | l        -- gererate and linearize" ++
  "\n" ++
  "\nma, morphologically_analyse: ma String" ++
  "\n      Runs morphological analysis on each word in String and displays" ++
  "\n      the results line by line." ++
  "\n  options:" ++
  "\n      -short   show analyses in bracketed words, instead of separate lines" ++
  "\n  flags:" ++
  "\n      -lang" ++
  "\n  examples:" ++
  "\n      wf Bible.txt | ma -short | wf Bible.tagged  -- analyse the Bible" ++
  "\n" ++
  "\n" ++
  "\n-- elementary generation of Strings and Trees" ++
  "\n" ++
  "\nps, put_string: ps String" ++
  "\n      Returns its argument String, like Unix echo." ++
  "\n      HINT. The strength of ps comes from the possibility to receive the " ++
  "\n      argument from a pipeline, and altering it by the -filter flag." ++
  "\n  flags:" ++
  "\n      -filter  filter the result through this string processor " ++
  "\n      -length  cut the string after this number of characters" ++
  "\n  examples:" ++
  "\n      gr -cat=Letter | l | ps -filter=text -- random letter as text" ++
  "\n" ++
  "\npt, put_tree: pt Tree" ++
  "\n      Returns its argument Tree, like a specialized Unix echo." ++
  "\n      HINT. The strength of pt comes from the possibility to receive " ++
  "\n      the argument from a pipeline, and altering it by the -transform flag." ++
  "\n  flags:" ++
  "\n      -transform   transform the result by this term processor" ++
  "\n      -number      generate this number of terms at most" ++
  "\n  examples:" ++
  "\n      p \"zero is even\" | pt -transform=solve  -- solve ?'s in parse result" ++
  "\n" ++
  "\n* st, show_tree: st Tree" ++
  "\n      Prints the tree as a string. Unlike pt, this command cannot be" ++
  "\n      used in a pipe to produce a tree, since its output is a string." ++
  "\n  flags:" ++
  "\n      -printer     show the tree in a special format (-printer=xml supported)" ++
  "\n" ++
  "\nwt, wrap_tree: wt Fun" ++
  "\n      Wraps the tree as the sole argument of Fun." ++
  "\n  flags:" ++
  "\n      -c           compute the resulting new tree to normal form" ++
  "\n" ++
  "\nvt, visualize_tree: vt Tree" ++
  "\n      Shows the abstract syntax tree via dot and gv (via temporary files" ++
  "\n      grphtmp.dot, grphtmp.ps)." ++
  "\n  flags:" ++
  "\n      -c           show categories only (no functions)" ++
  "\n      -f           show functions only (no categories)" ++
  "\n      -g           show as graph (sharing uses of the same function)" ++
  "\n      -o           just generate the .dot file" ++
  "\n  examples:" ++
  "\n    p \"hello world\" | vt -o | wf my.dot ;; ! open -a GraphViz my.dot" ++
  "\n    -- This writes the parse tree into my.dot and opens the .dot file" ++
  "\n    -- with another application without generating .ps." ++
  "\n" ++
  "\n-- subshells" ++
  "\n" ++
  "\nes, editing_session: es" ++
  "\n      Opens an interactive editing session." ++
  "\n      N.B. Exit from a Fudget session is to the Unix shell, not to GF. " ++
  "\n  options:" ++
  "\n      -f Fudget GUI (necessary for Unicode; only available in X Window System)" ++
  "\n" ++
  "\nts, translation_session: ts" ++
  "\n      Translates input lines from any of the actual languages to all other ones." ++
  "\n      To exit, type a full stop (.) alone on a line." ++
  "\n      N.B. Exit from a Fudget session is to the Unix shell, not to GF. " ++
  "\n      HINT: Set -parser and -lexer locally in each grammar." ++
  "\n  options:" ++
  "\n      -f    Fudget GUI (necessary for Unicode; only available in X Windows)" ++
  "\n      -lang prepend translation results with language names" ++
  "\n  flags:" ++
  "\n      -cat    the parser category" ++
  "\n  examples:" ++
  "\n      ts -cat=Numeral -lang  -- translate numerals, show language names" ++
  "\n" ++
  "\ntq, translation_quiz: tq Lang Lang" ++
  "\n      Random-generates translation exercises from Lang1 to Lang2," ++
  "\n      keeping score of success." ++
  "\n      To interrupt, type a full stop (.) alone on a line." ++
  "\n      HINT: Set -parser and -lexer locally in each grammar." ++
  "\n  flags:" ++
  "\n      -cat" ++
  "\n  examples:" ++
  "\n      tq -cat=NP TestResourceEng TestResourceSwe  -- quiz for NPs" ++
  "\n" ++
  "\ntl, translation_list: tl Lang Lang" ++
  "\n      Random-generates a list of ten translation exercises from Lang1" ++
  "\n      to Lang2. The number can be changed by a flag." ++
  "\n      HINT: use wf to save the exercises in a file." ++
  "\n  flags:" ++
  "\n      -cat" ++
  "\n      -number" ++
  "\n  examples:" ++
  "\n      tl -cat=NP TestResourceEng TestResourceSwe  -- quiz list for NPs" ++
  "\n" ++
  "\nmq, morphology_quiz: mq" ++
  "\n      Random-generates morphological exercises," ++
  "\n      keeping score of success." ++
  "\n      To interrupt, type a full stop (.) alone on a line." ++
  "\n      HINT: use printname judgements in your grammar to" ++
  "\n      produce nice expressions for desired forms." ++
  "\n  flags:" ++
  "\n      -cat" ++
  "\n      -lang" ++
  "\n  examples:" ++
  "\n      mq -cat=N -lang=TestResourceSwe  -- quiz for Swedish nouns" ++
  "\n" ++
  "\nml, morphology_list: ml" ++
  "\n      Random-generates a list of ten morphological exercises," ++
  "\n      keeping score of success. The number can be changed with a flag." ++
  "\n      HINT: use wf to save the exercises in a file." ++
  "\n  flags:" ++
  "\n      -cat" ++
  "\n      -lang" ++
  "\n      -number" ++
  "\n  examples:" ++
  "\n      ml -cat=N -lang=TestResourceSwe  -- quiz list for Swedish nouns" ++
  "\n" ++
  "\n" ++
  "\n-- IO related commands" ++
  "\n" ++
  "\nrf, read_file: rf File" ++
  "\n      Returns the contents of File as a String; error if File does not exist." ++
  "\n" ++
  "\nwf, write_file: wf File String" ++
  "\n      Writes String into File; File is created if it does not exist." ++
  "\n      N.B. the command overwrites File without a warning." ++
  "\n" ++
  "\naf, append_file: af File" ++
  "\n      Writes String into the end of File; File is created if it does not exist." ++
  "\n" ++
  "\n* tg, transform_grammar: tg File" ++
  "\n      Reads File, parses as a grammar, " ++
  "\n      but instead of compiling further, prints it. " ++
  "\n      The environment is not changed. When parsing the grammar, the same file" ++
  "\n      name suffixes are supported as in the i command." ++
  "\n      HINT: use this command to print the grammar in " ++
  "\n      another format (the -printer flag); pipe it to wf to save this format." ++
  "\n  flags:" ++
  "\n      -printer  (only -printer=latex supported currently)" ++
  "\n" ++
  "\n* cl, convert_latex: cl File" ++
  "\n      Reads File, which is expected to be in LaTeX form." ++
  "\n      Three environments are treated in special ways:" ++
  "\n        \\begGF    - \\end{verbatim}, which contains GF judgements," ++
  "\n        \\begTGF   - \\end{verbatim}, which contains a GF expression (displayed)" ++
  "\n        \\begInTGF - \\end{verbatim}, which contains a GF expressions (inlined)." ++
  "\n      Moreover, certain macros should be included in the file; you can" ++
  "\n      get those macros by applying 'tg -printer=latex foo.gf' to any grammar" ++
  "\n      foo.gf. Notice that the same File can be imported as a GF grammar," ++
  "\n      consisting of all the judgements in \\begGF environments." ++
  "\n      HINT: pipe with 'wf Foo.tex' to generate a new Latex file." ++
  "\n" ++
  "\nsa, speak_aloud: sa String" ++
  "\n      Uses the Flite speech generator to produce speech for String." ++
  "\n      Works for American English spelling. " ++
  "\n  examples:" ++
  "\n    h | sa              -- listen to the list of commands" ++
  "\n    gr -cat=S | l | sa  -- generate a random sentence and speak it aloud" ++
  "\n" ++
  "\nsi, speech_input: si" ++
  "\n      Uses an ATK speech recognizer to get speech input. " ++
  "\n  flags:" ++
  "\n      -lang: The grammar to use with the speech recognizer." ++
  "\n      -cat: The grammar category to get input in." ++
  "\n      -language: Use acoustic model and dictionary for this language." ++
  "\n      -number: The number of utterances to recognize." ++
  "\n" ++
  "\nh, help: h Command?" ++
  "\n      Displays the paragraph concerning the command from this help file." ++
  "\n      Without the argument, shows the first lines of all paragraphs." ++
  "\n  options" ++
  "\n       -all   show the whole help file" ++
  "\n       -defs  show user-defined commands and terms" ++
  "\n  examples:" ++
  "\n       h print_grammar  -- show all information on the pg command" ++
  "\n" ++
  "\nq, quit: q" ++
  "\n      Exits GF." ++
  "\n      HINT: you can use 'ph | wf history' to save your session." ++
  "\n" ++
  "\n!, system_command: ! String" ++
  "\n      Issues a system command. No value is returned to GF." ++
  "\n   example:" ++
  "\n      ! ls" ++
  "\n" ++
  "\n?, system_command: ? String" ++
  "\n      Issues a system command that receives its arguments from GF pipe" ++
  "\n      and returns a value to GF." ++
  "\n   example:" ++
  "\n      h | ? 'wc -l' | p -cat=Num" ++
  "\n" ++
  "\n" ++
  "\n-- Flags. The availability of flags is defined separately for each command." ++
  "\n" ++
  "\n-cat, category in which parsing is performed." ++
  "\n      The default is S." ++
  "\n" ++
  "\n-depth, the search depth in e.g. random generation." ++
  "\n      The default depends on application." ++
  "\n" ++
  "\n-filter, operation performed on a string. The default is identity." ++
  "\n    -filter=identity     no change" ++
  "\n    -filter=erase        erase the text" ++
  "\n    -filter=take100      show the first 100 characters" ++
  "\n    -filter=length       show the length of the string" ++
  "\n    -filter=text         format as text (punctuation, capitalization)" ++
  "\n    -filter=code         format as code (spacing, indentation)" ++
  "\n" ++
  "\n-lang, grammar used when executing a grammar-dependent command." ++
  "\n       The default is the last-imported grammar." ++
  "\n" ++
  "\n-language, voice used by Festival as its --language flag in the sa command. " ++
  "\n       The default is system-dependent. " ++
  "\n" ++
  "\n-length, the maximum number of characters shown of a string. " ++
  "\n       The default is unlimited." ++
  "\n" ++
  "\n-lexer, tokenization transforming a string into lexical units for a parser." ++
  "\n       The default is words." ++
  "\n    -lexer=words         tokens are separated by spaces or newlines" ++
  "\n    -lexer=literals      like words, but GF integer and string literals recognized" ++
  "\n    -lexer=vars          like words, but \"x\",\"x_...\",\"$...$\" as vars, \"?...\" as meta" ++
  "\n    -lexer=chars         each character is a token" ++
  "\n    -lexer=code          use Haskell's lex" ++
  "\n    -lexer=codevars      like code, but treat unknown words as variables, ?? as meta " ++
  "\n    -lexer=text          with conventions on punctuation and capital letters" ++
  "\n    -lexer=codelit       like code, but treat unknown words as string literals" ++
  "\n    -lexer=textlit       like text, but treat unknown words as string literals" ++
  "\n    -lexer=codeC         use a C-like lexer" ++
  "\n    -lexer=ignore        like literals, but ignore unknown words" ++
  "\n    -lexer=subseqs       like ignore, but then try all subsequences from longest" ++
  "\n" ++
  "\n-number, the maximum number of generated items in a list. " ++
  "\n       The default is unlimited." ++
  "\n" ++
  "\n-optimize, optimization on generated code." ++
  "\n       The default is share for concrete, none for resource modules." ++
  "\n       Each of the flags can have the suffix _subs, which performs" ++
  "\n       common subexpression elimination after the main optimization." ++
  "\n       Thus, -optimize=all_subs is the most aggressive one." ++
  "\n    -optimize=share        share common branches in tables" ++
  "\n    -optimize=parametrize  first try parametrize then do share with the rest" ++
  "\n    -optimize=values       represent tables as courses-of-values" ++
  "\n    -optimize=all          first try parametrize then do values with the rest" ++
  "\n    -optimize=none         no optimization" ++
  "\n" ++
  "\n-parser, parsing strategy. The default is chart. If -cfg or -mcfg are" ++
  "\n       selected, only bottomup and topdown are recognized." ++
  "\n    -parser=chart          bottom-up chart parsing" ++
  "\n    -parser=bottomup       a more up to date bottom-up strategy" ++
  "\n    -parser=topdown        top-down strategy" ++
  "\n    -parser=old            an old bottom-up chart parser" ++
  "\n" ++
  "\n-printer, format in which the grammar is printed. The default is" ++
  "\n       gfc. Those marked with M are (only) available for pm, the rest" ++
  "\n       for pg." ++
  "\n    -printer=gfc            GFC grammar" ++
  "\n    -printer=gf             GF grammar" ++
  "\n    -printer=old            old GF grammar" ++
  "\n    -printer=cf             context-free grammar, with profiles" ++
  "\n    -printer=bnf            context-free grammar, without profiles" ++
  "\n    -printer=lbnf           labelled context-free grammar for BNF Converter" ++
  "\n    -printer=plbnf          grammar for BNF Converter, with precedence levels" ++
  "\n   *-printer=happy          source file for Happy parser generator (use lbnf!)" ++
  "\n    -printer=srg            speech recognition grammar" ++
  "\n    -printer=haskell        abstract syntax in Haskell, with transl to/from GF" ++
  "\n    -printer=morpho         full-form lexicon, long format" ++
  "\n   *-printer=latex          LaTeX file (for the tg command)" ++
  "\n    -printer=fullform       full-form lexicon, short format" ++
  "\n   *-printer=xml            XML: DTD for the pg command, object for st" ++
  "\n    -printer=old            old GF: file readable by GF 1.2" ++
  "\n    -printer=stat           show some statistics of generated GFC" ++
  "\n    -printer=probs          show probabilities of all functions" ++
  "\n    -printer=gsl            Nuance GSL speech recognition grammar" ++
  "\n    -printer=jsgf           Java Speech Grammar Format" ++
  "\n    -printer=srgs_xml       SRGS XML format" ++
  "\n    -printer=srgs_xml_prob  SRGS XML format, with weights" ++
  "\n    -printer=slf            a finite automaton in the HTK SLF format" ++
  "\n    -printer=slf_graphviz   the same automaton as in SLF, but in Graphviz format" ++
  "\n    -printer=fa_graphviz    a finite automaton with labelled edges" ++
  "\n    -printer=regular        a regular grammar in a simple BNF" ++
  "\n    -printer=unpar          a gfc grammar with parameters eliminated" ++
  "\n    -printer=functiongraph  abstract syntax functions in 'dot' format" ++
  "\n    -printer=typegraph      abstract syntax categories in 'dot' format" ++
  "\n    -printer=transfer       Transfer language datatype (.tr file format)" ++
  "\n    -printer=gfcm        M  gfcm file (default for pm)" ++
  "\n    -printer=header      M  gfcm file with header (for GF embedded in Java)" ++
  "\n    -printer=graph       M  module dependency graph in 'dot' (graphviz) format" ++
  "\n    -printer=missing     M  the missing linearizations of each concrete" ++
  "\n    -printer=gfc-prolog  M  gfc in prolog format (also pg)" ++
  "\n    -printer=mcfg-prolog M  mcfg in prolog format (also pg)" ++
  "\n    -printer=cfg-prolog  M  cfg in prolog format (also pg)" ++
  "\n" ++
  "\n-startcat, like -cat, but used in grammars (to avoid clash with keyword cat)" ++
  "\n" ++
  "\n-transform, transformation performed on a syntax tree. The default is identity." ++
  "\n    -transform=identity  no change" ++
  "\n    -transform=compute   compute by using definitions in the grammar" ++
  "\n    -transform=typecheck return the term only if it is type-correct" ++
  "\n    -transform=solve     solve metavariables as derived refinements" ++
  "\n    -transform=context   solve metavariables by unique refinements as variables" ++
  "\n    -transform=delete    replace the term by metavariable" ++
  "\n" ++
  "\n-unlexer, untokenization transforming linearization output into a string." ++
  "\n       The default is unwords." ++
  "\n    -unlexer=unwords     space-separated token list (like unwords)" ++
  "\n    -unlexer=text        format as text: punctuation, capitals, paragraph <p>" ++
  "\n    -unlexer=code        format as code (spacing, indentation)" ++
  "\n    -unlexer=textlit     like text, but remove string literal quotes" ++
  "\n    -unlexer=codelit     like code, but remove string literal quotes" ++
  "\n    -unlexer=concat      remove all spaces" ++
  "\n    -unlexer=bind        like identity, but bind at \"&+\"" ++
  "\n" ++
  "\n-coding, Some grammars are in UTF-8, some in isolatin-1." ++
  "\n    If the letters ä (a-umlaut) and ö (u-umlaut) look strange, either" ++
  "\n    change your terminal to isolatin-1, or rewrite the grammar with" ++
  "\n    'pg -utf8'." ++
  "\n" ++
  "\n-- *: Commands and options marked with * are not currently implemented." ++
  []