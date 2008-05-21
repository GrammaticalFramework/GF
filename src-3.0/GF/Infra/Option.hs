----------------------------------------------------------------------
-- |
-- Module      : Option
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/14 16:03:41 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.34 $
--
-- Options and flags used in GF shell commands and files.
--
-- The types 'Option' and 'Options' should be kept abstract, but:
--
--   - The constructor 'Opt' is used in "ShellCommands" and "GrammarToSource"
--
--   - The constructor 'Opts' us udes in "API", "Shell" and "ShellCommands"
-----------------------------------------------------------------------------

module GF.Infra.Option where

import Data.List (partition)
import Data.Char (isDigit)

-- * all kinds of options, to be kept abstract

newtype Option = Opt (String,[String]) deriving (Eq,Show,Read)
newtype Options = Opts [Option] deriving (Eq,Show,Read)

noOptions :: Options
noOptions = Opts []

-- | simple option -o
iOpt :: String -> Option
iOpt o = Opt (o,[])   

-- | option with argument -o=a
aOpt :: String -> String -> Option
aOpt o a = Opt (o,[a])  

iOpts :: [Option] -> Options
iOpts = Opts

-- | value of option argument
oArg :: String -> String
oArg s = s 

oElem :: Option -> Options -> Bool
oElem o (Opts os) = elem o os

eqOpt :: String -> Option -> Bool
eqOpt s (Opt (o, [])) = s == o
eqOpt s _ = False

type OptFun = String -> Option
type OptFunId = String

getOptVal :: Options -> OptFun -> Maybe String
getOptVal (Opts os) fopt = 
  case [a | opt@(Opt (o,[a])) <- os, opt == fopt a] of
    a:_ -> Just a
    _ -> Nothing

isSetFlag :: Options -> OptFun -> Bool
isSetFlag (Opts os) fopt = 
  case [a | opt@(Opt (o,[a])) <- os, opt == fopt a] of
    a:_ -> True
    _ -> False

getOptInt :: Options -> OptFun -> Maybe Int
getOptInt opts f = do
  s <- getOptVal opts f
  if (not (null s) && all isDigit s) then return (read s) else Nothing 

optIntOrAll :: Options -> OptFun -> [a] -> [a]
optIntOrAll opts f = case getOptInt opts f of
  Just i -> take i
  _ -> id

optIntOrN :: Options -> OptFun -> Int -> Int
optIntOrN opts f n = case getOptInt opts f of
  Just i -> i
  _ -> n

optIntOrOne :: Options -> OptFun -> Int
optIntOrOne opts f = optIntOrN opts f 1

changeOptVal :: Options -> OptFun -> String -> Options
changeOptVal os f x = 
  addOption (f x) $ maybe os (\y -> removeOption (f y) os) $ getOptVal os f

addOption :: Option -> Options -> Options
addOption o (Opts os) = iOpts (o:os)

addOptions :: Options -> Options -> Options
addOptions (Opts os) os0 = foldr addOption os0 os

concatOptions :: [Options] -> Options
concatOptions = foldr addOptions noOptions

removeOption :: Option -> Options -> Options
removeOption o (Opts os) = iOpts (filter (/=o) os)

removeOptions :: Options -> Options -> Options
removeOptions (Opts os) os0 = foldr removeOption os0 os

options :: [Option] -> Options
options = foldr addOption noOptions

unionOptions :: Options -> Options -> Options
unionOptions (Opts os) (Opts os') = Opts (os ++ os')

-- * parsing options, with prefix pre (e.g. \"-\")

getOptions :: String -> [String] -> (Options, [String])
getOptions pre inp = let
  (os,rest) = span (isOption pre) inp -- options before args
  in
  (Opts (map (pOption pre) os), rest)

pOption :: String -> String -> Option
pOption pre s = case span (/= '=') (drop (length pre) s) of
  (f,_:a) -> aOpt f a
  (o,[])  -> iOpt o

isOption :: String -> String -> Bool
isOption pre = (==pre) . take (length pre)

-- * printing options, without prefix

prOpt :: Option -> String
prOpt (Opt (s,[])) = s
prOpt (Opt (s,xs)) = s ++ "=" ++ concat xs

prOpts :: Options -> String
prOpts (Opts os) = unwords $ map prOpt os

-- * a suggestion for option names

-- ** parsing

strictParse, forgiveParse, ignoreParse, literalParse, rawParse, firstParse :: Option
-- | parse as term instead of string
dontParse :: Option

strictParse  = iOpt "strict"
forgiveParse = iOpt "n"
ignoreParse  = iOpt "ign"
literalParse = iOpt "lit"
rawParse     = iOpt "raw"
firstParse   = iOpt "1"
dontParse    = iOpt "read" 

newParser, newerParser, newCParser, newMParser :: Option
newParser   = iOpt "new"
newerParser = iOpt "newer"
newCParser  = iOpt "cfg"
newMParser  = iOpt "mcfg"
newFParser  = iOpt "fcfg"

{-
useParserMCFG, useParserMCFGviaCFG, useParserCFG, useParserCF :: Option

useParserMCFG = iOpt "mcfg"
useParserMCFGviaCFG = iOpt "mcfg-via-cfg"
useParserCFG = iOpt "cfg"
useParserCF = iOpt "cf"
-}

-- ** grammar formats

showAbstr, showXML, showOld, showLatex, showFullForm,
  showEBNF, showCF, showWords, showOpts,
  isCompiled, isHaskell, noCompOpers, retainOpers,
  noCF, checkCirc, noCheckCirc, lexerByNeed, useUTF8id :: Option
defaultGrOpts :: [Option]

showAbstr   = iOpt "abs"
showXML     = iOpt "xml"
showOld     = iOpt "old"
showLatex   = iOpt "latex"
showFullForm = iOpt "fullform" 
showEBNF    = iOpt "ebnf"
showCF      = iOpt "cf"
showWords   = iOpt "ws"
showOpts    = iOpt "opts"
-- showOptim   = iOpt "opt"
isCompiled  = iOpt "gfc"
isHaskell   = iOpt "gfhs"
noCompOpers = iOpt "nocomp"
retainOpers = iOpt "retain"
defaultGrOpts = []
noCF        = iOpt "nocf"
checkCirc   = iOpt "nocirc"
noCheckCirc = iOpt "nocheckcirc"
lexerByNeed = iOpt "cflexer"
useUTF8id   = iOpt "utf8id"
elimSubs    = iOpt "subs"

-- ** linearization

allLin, firstLin, distinctLin, dontLin,
  showRecord, showStruct, xmlLin, latexLin,
  tableLin, useUTF8, showLang, withMetas :: Option
defaultLinOpts :: [Option]

allLin      = iOpt "all"
firstLin    = iOpt "one"
distinctLin = iOpt "nub"
dontLin     = iOpt "show"
showRecord  = iOpt "record"
showStruct  = iOpt "structured"
xmlLin      = showXML
latexLin    = showLatex
tableLin    = iOpt "table"
defaultLinOpts = [firstLin]
useUTF8     = iOpt "utf8"
showLang    = iOpt "lang"
showDefs    = iOpt "defs"
withMetas   = iOpt "metas"

-- ** other

beVerbose, showInfo, beSilent, emitCode, getHelp,
  doMake, doBatch, notEmitCode, makeMulti, beShort,
  wholeGrammar, makeFudget, byLines, byWords, analMorpho,
  doTrace, noCPU, doCompute, optimizeCanon, optimizeValues,
  stripQualif, nostripQualif, showAll, fromSource :: Option

beVerbose    = iOpt "v"
invertGrep   = iOpt "v" --- same letter in unix
showInfo     = iOpt "i"
beSilent     = iOpt "s"
emitCode     = iOpt "o"
getHelp      = iOpt "help"
doMake       = iOpt "make"
doBatch      = iOpt "batch"
notEmitCode  = iOpt "noemit"
makeMulti    = iOpt "multi"
beShort      = iOpt "short"
wholeGrammar = iOpt "w"
makeFudget   = iOpt "f"
byLines      = iOpt "lines"
byWords      = iOpt "words"
analMorpho   = iOpt "morpho"
doTrace      = iOpt "tr"
noCPU        = iOpt "nocpu"
doCompute    = iOpt "c"
optimizeCanon = iOpt "opt"
optimizeValues = iOpt "val"
stripQualif   = iOpt "strip"
nostripQualif = iOpt "nostrip"
showAll      = iOpt "all"
showFields   = iOpt "fields"
showMulti    = iOpt "multi"
fromSource   = iOpt "src"
makeConcrete = iOpt "examples"
fromExamples = iOpt "ex"
openEditor   = iOpt "edit"
getTrees     = iOpt "trees"

-- ** mainly for stand-alone

useUnicode, optCompute, optCheck, optParaphrase, forJava :: Option

useUnicode    = iOpt "unicode"
optCompute    = iOpt "compute"
optCheck      = iOpt "typecheck"
optParaphrase = iOpt "paraphrase"
forJava       = iOpt "java"

-- ** for edit session

allLangs, absView :: Option

allLangs  = iOpt "All"
absView   = iOpt "Abs"

-- ** options that take arguments

useTokenizer, useUntokenizer, useParser, withFun, 
  useLanguage, useResource, speechLanguage, useFont,
  grammarFormat, grammarPrinter, filterString, termCommand,
  transferFun, forForms, menuDisplay, sizeDisplay, typeDisplay,
  noDepTypes, extractGr, pathList, uniCoding :: String -> Option
-- | used on command line
firstCat :: String -> Option
-- | used in grammar, to avoid clash w res word
gStartCat :: String -> Option

useTokenizer   = aOpt "lexer"
useUntokenizer = aOpt "unlexer"
useParser      = aOpt "parser"
-- useStrategy    = aOpt "strategy" -- parsing strategy
withFun        = aOpt "fun"
firstCat       = aOpt "cat"      
gStartCat      = aOpt "startcat" 
useLanguage    = aOpt "lang"
useResource    = aOpt "res"
speechLanguage = aOpt "language"
useFont        = aOpt "font"
grammarFormat  = aOpt "format"
grammarPrinter = aOpt "printer"
filterString   = aOpt "filter"
termCommand    = aOpt "transform"
transferFun    = aOpt "transfer"
forForms       = aOpt "forms"
menuDisplay    = aOpt "menu"
sizeDisplay    = aOpt "size"
typeDisplay    = aOpt "types"
noDepTypes     = aOpt "nodeptypes"
extractGr      = aOpt "extract"
pathList       = aOpt "path"
uniCoding      = aOpt "coding"
probFile       = aOpt "probs"
noparseFile    = aOpt "noparse"
usePreprocessor = aOpt "preproc"

-- peb 16/3-05:
gfcConversion :: String -> Option
gfcConversion  = aOpt "conversion"

useName, useAbsName, useCncName, useResName, 
  useFile, useOptimizer :: String -> Option

useName        = aOpt "name"
useAbsName     = aOpt "abs"
useCncName     = aOpt "cnc"
useResName     = aOpt "res"
useFile        = aOpt "file"
useOptimizer   = aOpt "optimize"

markLin :: String -> Option
markOptXML, markOptJava, markOptStruct, markOptFocus :: String

markLin        = aOpt "mark"
markOptXML     = oArg "xml"
markOptJava    = oArg "java"
markOptStruct  = oArg "struct"
markOptFocus   = oArg "focus"


-- ** refinement order

nextRefine :: String -> Option
firstRefine, lastRefine :: String

nextRefine  = aOpt "nextrefine"
firstRefine = oArg "first"
lastRefine  = oArg "last"

-- ** Boolean flags

flagYes, flagNo :: String

flagYes = oArg "yes"
flagNo  = oArg "no"

-- ** integer flags

flagDepth, flagAlts, flagLength, flagNumber, flagRawtrees :: String -> Option

flagDepth  = aOpt "depth"
flagAlts   = aOpt "alts"
flagLength = aOpt "length"
flagNumber = aOpt "number"
flagRawtrees = aOpt "rawtrees"

caseYesNo :: Options -> OptFun -> Maybe Bool
caseYesNo opts f = do
  v <- getOptVal opts f
  if v == flagYes   then return True
     else if v == flagNo then return False
     else Nothing
