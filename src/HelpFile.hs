module HelpFile where

import Operations

txtHelpFileSummary =
  unlines $ map (concat . take 1 . lines) $ paragraphs txtHelpFile

txtHelpCommand c =
  case lookup c [(takeWhile (/=',') p,p) | p <- paragraphs txtHelpFile] of
    Just s -> s
    _ -> "Command not found."

txtHelpFile =
  "\n-- GF help file updated for GF 2.0, 24/3/2004." ++
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
  "\n        .ebnf  Extended BNF format" ++
  "\n        .cf    Context-free (BNF) format" ++
  "\n  options:" ++
  "\n      -old          old: parse in GF<2.0 format (not necessary)" ++
  "\n      -v            verbose: give lots of messages " ++
  "\n      -s            silent: don't give error messages" ++
  "\n      -opt          perform branch-sharing optimization" ++
  "\n      -src          source: ignore precompiled gfc and gfr files" ++
  "\n      -retain       retain operations: read resource modules (needed in comm cc) " ++
  "\n      -nocf         don't build context-free grammar (thus no parser)" ++
  "\n      -nocheckcirc  don't eliminate circular rules from CF " ++
  "\n      -cflexer      build an optimized parser with separate lexer trie" ++
  "\n  flags:" ++
  "\n      -abs          set the name used for abstract syntax (with -old option)" ++
  "\n      -cnc          set the name used for concrete syntax (with -old option)" ++
  "\n      -res          set the name used for resource (with -old option)" ++
  "\n      " ++
  "\n* rl, remove_language: rl Language" ++
  "\n      Takes away the language from the state." ++
  "\n" ++
  "\ne,  empty: e" ++
  "\n      Takes away all languages and resets all global flags." ++
  "\n" ++
  "\nsf, set_flags: sf Language? Flag*" ++
  "\n      The values of the Flags are set for Language. If no language" ++
  "\n      is specified, the flags are set globally." ++
  "\n" ++
  "\ns,  strip: s" ++
  "\n      Prune the state by removing source and resource modules." ++
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
  "\n" ++
  "\npm, print_multigrammar: pm" ++
  "\n      Prints the current multilingual grammar into a .gfcm file." ++
  "\n      (Automatically executes the strip command (s) before doing this.)" ++
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
  "\n      HINT: write \"ph | wf foo.hist\" to save the history." ++
  "\n" ++
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
  "\n  flags:" ++
  "\n      -lang    linearize in this grammar" ++
  "\n      -number  give this number of forms at most" ++
  "\n      -unlexer filter output through unlexer" ++
  "\n" ++
  "\np,  parse: p String" ++
  "\n      Shows all Trees returned for String by the actual" ++
  "\n      grammar (overridden by the -lang flag), in the category S (overridden" ++
  "\n      by the -cat flag)." ++
  "\n  options:" ++
  "\n      -n       non-strict: tolerates morphological errors" ++
  "\n      -ign     ignore unknown words when parsing" ++
  "\n      -raw     return context-free terms in raw form" ++
  "\n      -v       verbose: give more information if parsing fails" ++
  "\n  flags:" ++
  "\n      -cat     parse in this category" ++
  "\n      -lang    parse in this grammar" ++
  "\n      -lexer   filter input through this lexer" ++
  "\n      -parser  use this context-free parsing method" ++
  "\n      -number  return this many results at most" ++
  "\n" ++
  "\ntt, test_tokenizer: tt String" ++
  "\n      Show the token list sent to the parser when String is parsed." ++
  "\n      HINT: can be useful when debugging the parser." ++
  "\n  flags: " ++
  "\n     -lexer    use this lexer" ++
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
  "\n" ++
  "\nt,  translate: t Lang Lang String" ++
  "\n      Parses String in Lang1 and linearizes the resulting Trees in Lang2." ++
  "\n  flags:" ++
  "\n      -cat" ++
  "\n      -lexer" ++
  "\n      -parser" ++
  "\n" ++
  "\ngr, generate_random: gr Tree?" ++
  "\n      Generates a random Tree of a given category. If a Tree" ++
  "\n      argument is given, the command completes the Tree with values to" ++
  "\n      the metavariables in the tree. " ++
  "\n  flags:" ++
  "\n      -cat     generate in this category" ++
  "\n      -lang    use the abstract syntax of this grammar" ++
  "\n      -number  generate this number of trees (not impl. with Tree argument)" ++
  "\n      -depth   use this number of search steps at most" ++
  "\n" ++
  "\ngt, generate_trees: gt Int" ++
  "\n      Generates all trees up to the given depth." ++
  "\n  flags:" ++
  "\n      -cat     generate in this category" ++
  "\n      -lang    use the abstract syntax of this grammar" ++
  "\n      -number  generate (at most) this number of trees" ++
  "\n" ++
  "\nma, morphologically_analyse: ma String" ++
  "\n      Runs morphological analysis on each word in String and displays" ++
  "\n      the results line by line." ++
  "\n  options:" ++
  "\n      -short   show analyses in bracketed words, instead of separate lines" ++
  "\n  flags:" ++
  "\n      -lang" ++
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
  "\n" ++
  "\npt, put_tree: pt Tree" ++
  "\n      Returns its argument Tree, like a specialized Unix echo." ++
  "\n      HINT. The strength of pt comes from the possibility to receive " ++
  "\n      the argument from a pipeline, and altering it by the -transform flag." ++
  "\n  flags:" ++
  "\n      -transform   transform the result by this term processor" ++
  "\n      -number      generate this number of terms at most" ++
  "\n" ++
  "\n* st, show_tree: st Tree" ++
  "\n      Prints the tree as a string. Unlike pt, this command cannot be" ++
  "\n      used in a pipe to produce a tree, since its output is a string." ++
  "\n  flags:" ++
  "\n      -printer     show the tree in a special format (-printer=xml supported)" ++
  "\n" ++
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
  "\n      Translates input lines from any of the actual languages to any other one." ++
  "\n      To exit, type a full stop (.) alone on a line." ++
  "\n      N.B. Exit from a Fudget session is to the Unix shell, not to GF. " ++
  "\n      HINT: Set -parser and -lexer locally in each grammar." ++
  "\n  options:" ++
  "\n      -f Fudget GUI (necessary for Unicode; only available in X Window System)" ++
  "\n  flags:" ++
  "\n      -cat" ++
  "\n" ++
  "\ntq, translation_quiz: tq Lang Lang" ++
  "\n      Random-generates translation exercises from Lang1 to Lang2," ++
  "\n      keeping score of success." ++
  "\n      To interrupt, type a full stop (.) alone on a line." ++
  "\n      HINT: Set -parser and -lexer locally in each grammar." ++
  "\n  flags:" ++
  "\n      -cat" ++
  "\n" ++
  "\ntl, translation_list: tl Lang Lang Int" ++
  "\n      Random-generates a list of Int translation exercises from Lang1 to Lang2." ++
  "\n      HINT: use wf to save the exercises in a file." ++
  "\n  flags:" ++
  "\n      -cat" ++
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
  "\n" ++
  "\nml, morphology_list: ml Int" ++
  "\n      Random-generates a list of Int morphological exercises," ++
  "\n      keeping score of success." ++
  "\n      HINT: use wf to save the exercises in a file." ++
  "\n  flags:" ++
  "\n      -cat" ++
  "\n      -lang" ++
  "\n" ++
  "\n" ++
  "\n-- IO related commands" ++
  "\n" ++
  "\nrf, read_file: rf File" ++
  "\n      Returns the contents of File as a String; error is File does not exist." ++
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
  "\n      Uses the Festival speech generator to produce speech for String." ++
  "\n      The command cupports Festival's language flag, which is sent verbatim" ++
  "\n      to Festival, e.g. -language=spanish. Omitting this flag gives the " ++
  "\n      system-dependent default voice (often British English)." ++
  "\n     flags:" ++
  "\n       -language" ++
  "\n" ++
  "\nh, help: h Command?" ++
  "\n      Displays the paragraph concerning the command from this help file." ++
  "\n      Without the argument, shows the first lines of all paragraphs." ++
  "\n  options" ++
  "\n       -all  show the whole help file" ++
  "\n" ++
  "\nq, quit: q" ++
  "\n      Exits GF." ++
  "\n      HINT: you can use 'ph | wf history' to save your session." ++
  "\n" ++
  "\n!, system_command: ! String" ++
  "\n      Issues a system command. No value is returned to GF." ++
  "\n" ++
  "\n" ++
  "\n" ++
  "\n-- Flags. The availability of flags is defined separately for each command." ++
  "\n" ++
  "\n-cat: category in which parsing is performed." ++
  "\n      The default is S." ++
  "\n" ++
  "\n-depth: the search depth in e.g. random generation." ++
  "\n      The default depends on application." ++
  "\n" ++
  "\n-filter: operation performed on a string. The default is identity." ++
  "\n    -filter=identity     no change" ++
  "\n    -filter=erase        erase the text" ++
  "\n    -filter=take100      show the first 100 characters" ++
  "\n    -filter=length       show the length of the string" ++
  "\n    -filter=text         format as text (punctuation, capitalization)" ++
  "\n    -filter=code         format as code (spacing, indentation)" ++
  "\n    -filter=latexfile    embed in a LaTeX file " ++
  "\n" ++
  "\n-lang: grammar used when executing a grammar-dependent command." ++
  "\n       The default is the last-imported grammar." ++
  "\n" ++
  "\n-language: voice used by Festival as its --language flag in the sa command. " ++
  "\n       The default is system-dependent. " ++
  "\n" ++
  "\n-length: the maximum number of characters shown of a string. " ++
  "\n       The default is unlimited." ++
  "\n" ++
  "\n-lexer: tokenization transforming a string into lexical units for a parser." ++
  "\n       The default is words." ++
  "\n    -lexer=words         tokens are separated by spaces or newlines" ++
  "\n    -lexer=literals      like words, but GF integer and string literals recognized" ++
  "\n    -lexer=vars          like words, but \"x\",\"x_...\",\"$...$\" as vars, \"?...\" as meta" ++
  "\n    -lexer=chars         each character is a token" ++
  "\n    -lexer=code          use Haskell's lex" ++
  "\n    -lexer=text          with conventions on punctuation and capital letters" ++
  "\n    -lexer=codelit       like code, but treat unknown words as string literals" ++
  "\n    -lexer=textlit       like text, but treat unknown words as string literals" ++
  "\n    -lexer=codeC         use a C-like lexer" ++
  "\n" ++
  "\n-number: the maximum number of generated items in a list. " ++
  "\n       The default is unlimited." ++
  "\n" ++
  "\n-parser: Context-free    parsing algorithm. The default is chart." ++
  "\n    -parser=earley       Earley algorithm" ++
  "\n    -parser=chart        bottom-up chart parser" ++
  "\n" ++
  "\n-printer: format in which the grammar is printed. The default is gfc." ++
  "\n    -printer=gfc            GFC grammar" ++
  "\n    -printer=gf             GF grammar" ++
  "\n    -printer=old            old GF grammar" ++
  "\n    -printer=cf             context-free grammar" ++
  "\n   *-printer=happy          source file for Happy parser generator" ++
  "\n    -printer=srg            speech recognition grammar" ++
  "\n   *-printer=haskell        abstract syntax in Haskell, with transl to/from GF" ++
  "\n    -printer=morpho         full-form lexicon, long format" ++
  "\n   *-printer=latex          LaTeX file (for the tg command)" ++
  "\n    -printer=fullform       full-form lexicon, short format" ++
  "\n   *-printer=xml            XML: DTD for the pg command, object for st" ++
  "\n    -printer=old            old GF: file readable by GF 1.2" ++
  "\n" ++
  "\n-startcat: like -cat, but used in grammars (to avoid clash with keyword cat)" ++
  "\n" ++
  "\n-transform: transformation performed on a syntax tree. The default is identity." ++
  "\n    -transform=identity  no change" ++
  "\n    -transform=compute   compute by using definitions in the grammar" ++
  "\n    -transform=typecheck return the term only if it is type-correct" ++
  "\n    -transform=solve     solve metavariables as derived refinements" ++
  "\n    -transform=context   solve metavariables by unique refinements as variables" ++
  "\n    -transform=delete    replace the term by metavariable" ++
  "\n" ++
  "\n-unlexer: untokenization transforming linearization output into a string." ++
  "\n       The default is unwords." ++
  "\n    -unlexer=unwords     space-separated token list (like unwords)" ++
  "\n    -unlexer=text        format as text: punctuation, capitals, paragraph <p>" ++
  "\n    -unlexer=code        format as code (spacing, indentation)" ++
  "\n    -unlexer=textlit     like text, but remove string literal quotes" ++
  "\n    -unlexer=codelit     like code, but remove string literal quotes" ++
  "\n    -unlexer=concat      remove all spaces" ++
  "\n    -unlexer=bind        like identity, but bind at \"&+\"" ++
  "\n" ++
  "\n-- *: Commands and options marked with * are not yet implemented." ++
  []