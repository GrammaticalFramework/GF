module GF.Devel.Options where

import System.Console.GetOpt

{-

Usage: gfc [OPTIONS] [FILE [...]]

How each FILE is handled depends on the file name suffix:

.gf Normal or old GF source, will be compiled.
.gfc Compiled GF source, will be loaded as is.
.gfe Example-based GF source, will be converted to .gf and compiled.
.ebnf Extended BNF format, will be converted to .gf and compiled.
.cf Context-free (BNF) format, will be converted to .gf and compiled.

If multiple FILES are given, they must be normal GF source, .gfc or .gfe files.
For the other input formats, only one file can be given.


== Compilation mode ==

-E
Stop after preprocessing (with --preproc).

-C 
Stop after converting to .gf (for .gfe, .ebnf and .cf).

-c
Stop after generating .gfc (do not link).


== Help and verbosity options ==

-V, --version
Display GF version

-v N
Set verbosity
-q 
Same as -v 0
-v
Same as -v 3

-?, -h, --help
Show help message

--cpu
Show compilation CPU time statistics


== GFC file handling ==

--gfc-dir=DIR
Directory to put .gfc files in.

--no-emit-gfc
Do not create .gfc files.

--emit-gfc
Create .gfc files (default)


== Output options ==

-f, --output-format=FORMAT
Output format. FORMAT can be one of:
Multiple concrete: gfcc (default), gar, js, ...
Single concrete only: cf, bnf, lbnf, gsl, srgs_xml, srgs_abnf, ...
Abstract only: haskell, ...

-o FILE
Save output in FILE. Default is out.X, where X depends on the value of -f.


== Finding libaries ==

-i DIR
Add DIR to the library search path.

--path=DIR:DIR:...
Set the library search path.

--package=PACKAGE
Get libraries from PACKAGE. FIXME: not sure about how this should work.


== Recompilation checking ==

--src, --force-recomp
Always recompile from source, i.e. disable recompilation checking.


== Preprocessing ==

--preproc=COMMAND
Use COMMAND to preprocess input files.


== Optimization ==

-O OPTIMIZATION
Perform the named optimization. 
Available optimizations: share, parametrize, values, all, none, subs
The default is share for concrete, none for resource modules.
Several -O flags can be given.


== Probabilistic grammars ==

--prob
Read probabilities from "--# prob" pragmas.


== Grammar flags ==

--startcat=CAT
Use CAT at the start category in the generated grammar.

--language=LANG
Set the speech language flag to LANG in the generated grammar.

-}

data Phase = Preproc | Convert | Compile | Link

data Options = Options {
                        optStopAfterPhase :: Phase,
                        optVerbosity :: Int,
                        optShowCPUTime :: Bool
                       }

defaultOptions :: Options
defaultOptions = Options {
                          optStopAfterPhase = Link,
                          optVerbosity = 1,
                          optShowCPUTime = False
                         }

optDescr :: [OptDescr (Options -> Options)]
optDescr = 
    [
     Option ['E'] [] (phase Preproc) "Stop after preprocessing (with --preproc)"
    ]
 where phase p = NoArg (\o -> o { optStopAfterPhase = p })
