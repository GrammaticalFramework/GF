----------------------------------------------------------------------
-- |
-- Module      : Custom
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/16 10:21:21 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.85 $
--
-- A database for customizable GF shell commands. 
--
-- databases for customizable commands. AR 21\/11\/2001.
-- for:  grammar parsers, grammar printers, term commands, string commands.
-- idea: items added here are usable throughout GF; nothing else need be edited.
-- they are often usable through the API: hence API cannot be imported here!
--
-- Major redesign 3\/4\/2002: the first entry in each database is DEFAULT.
-- If no other value is given, the default is selected.
-- Because of this, two invariants have to be preserved:
--
--  - no databases may be empty
--
--  - additions are made to the end of the database
-----------------------------------------------------------------------------

module GF.UseGrammar.Custom where

import GF.Data.Operations
import GF.Text.Text
import GF.UseGrammar.Tokenize
import GF.Grammar.Values
import qualified GF.Grammar.Grammar as G
import qualified GF.Canon.AbsGFC as A
import qualified GF.Canon.GFC as C
import qualified GF.Canon.CanonToGFCC as GFCC
import qualified GF.Canon.CanonToJS as JS (prCanon2js)
import qualified GF.Source.AbsGF as GF
import qualified GF.Grammar.MMacros as MM
import GF.FCFG.ToFCFG
import GF.Grammar.AbsCompute
import GF.Grammar.TypeCheck
import GF.UseGrammar.Generate
import GF.UseGrammar.MatchTerm
import GF.UseGrammar.Linear (unoptimizeCanon)
------import Compile
import GF.Compile.ShellState
import GF.UseGrammar.Editing
import GF.UseGrammar.Paraphrases
import GF.Infra.Option
import GF.CF.CF
import GF.CF.CFIdent

import GF.Canon.CanonToGrammar
import GF.CF.PPrCF
import GF.CF.PrLBNF
import GF.Grammar.PrGrammar
import GF.Compile.PrOld
import GF.Canon.MkGFC
import GF.Speech.PrGSL (gslPrinter)
import GF.Speech.PrJSGF (jsgfPrinter)
import GF.Speech.PrSRGS
import GF.Speech.PrSRGS_ABNF
import qualified GF.Speech.SISR as SISR
import GF.Speech.PrSLF
import GF.Speech.PrFA (faGraphvizPrinter,regularPrinter,faCPrinter)
import GF.Speech.PrRegExp (regexpPrinter)
import GF.Speech.GrammarToVoiceXML (grammar2vxml)

import GF.Data.Zipper

import GF.UseGrammar.Statistics
import GF.UseGrammar.Morphology
import GF.UseGrammar.Information
import GF.API.GrammarToHaskell
import GF.API.GrammarToTransfer
-----import GrammarToCanon (showCanon, showCanonOpt)
-----import qualified GrammarToGFC as GFC
import GF.Probabilistic.Probabilistic (prProbs)

-- the cf parsing algorithms
import GF.CF.ChartParser -- OBSOLETE
import qualified GF.Parsing.CF as PCF
import qualified GF.OldParsing.ParseCF as PCFOld -- OBSOLETE

-- grammar conversions -- peb 19/4-04
-- see also customGrammarPrinter
import qualified GF.OldParsing.ConvertGrammar as CnvOld -- OBSOLETE
import qualified GF.Printing.PrintParser as PrtOld -- OBSOLETE
import qualified GF.Infra.Print as Prt
import qualified GF.Conversion.GFC as Cnv
import qualified GF.Conversion.Types as CnvTypes
import qualified GF.Conversion.Haskell as CnvHaskell
import qualified GF.Conversion.Prolog as CnvProlog
import qualified GF.Conversion.TypeGraph as CnvTypeGraph
import GF.Canon.Unparametrize
import GF.Canon.Subexpressions
import GF.Canon.AbsToBNF

import GF.Canon.GFC
import qualified GF.Canon.MkGFC as MC
import GF.CFGM.PrintCFGrammar (prCanonAsCFGM)
import GF.Visualization.VisualizeGrammar (visualizeCanonGrammar, visualizeSourceGrammar)

import GF.API.MyParser

import GF.Infra.UseIO

import Control.Monad
import Data.Char
import Data.Maybe (fromMaybe)

-- character codings
import GF.Text.Unicode
import GF.Text.UTF8 (decodeUTF8)
import GF.Text.Greek (mkGreek)
import GF.Text.Arabic (mkArabic)
import GF.Text.Hebrew (mkHebrew)
import GF.Text.Russian (mkRussian, mkRusKOI8)
import GF.Text.Ethiopic (mkEthiopic)
import GF.Text.Tamil (mkTamil)
import GF.Text.OCSCyrillic (mkOCSCyrillic)
import GF.Text.LatinASupplement (mkLatinASupplement)
import GF.Text.Devanagari (mkDevanagari)
import GF.Text.Hiragana (mkJapanese)
import GF.Text.ExtendedArabic (mkArabic0600)
import GF.Text.ExtendedArabic (mkExtendedArabic)
import GF.Text.ExtraDiacritics (mkExtraDiacritics)

-- minimal version also used in Hugs. AR 2/12/2002. 

-- databases for customizable commands. AR 21/11/2001
-- for:  grammar parsers, grammar printers, term commands, string commands
-- idea: items added here are usable throughout GF; nothing else need be edited
-- they are often usable through the API: hence API cannot be imported here!

-- Major redesign 3/4/2002: the first entry in each database is DEFAULT.
-- If no other value is given, the default is selected.
-- Because of this, two invariants have to be preserved:
--  - no databases may be empty
--  - additions are made to the end of the database

-- * these are the databases; the comment gives the name of the flag

-- | grammarFormat, \"-format=x\" or file suffix
customGrammarParser :: CustomData (FilePath -> IOE C.CanonGrammar) 

-- | grammarPrinter, \"-printer=x\"
customGrammarPrinter :: CustomData (Options -> StateGrammar -> String)             

-- | multiGrammarPrinter, \"-printer=x\"
customMultiGrammarPrinter :: CustomData (Options -> CanonGrammar -> String)    

-- | syntaxPrinter, \"-printer=x\"
customSyntaxPrinter  :: CustomData (GF.Grammar -> String)        

-- | termPrinter, \"-printer=x\"
customTermPrinter  :: CustomData (StateGrammar -> Tree -> String)

-- | termCommand, \"-transform=x\"
customTermCommand    :: CustomData (StateGrammar -> Tree -> [Tree])

-- | editCommand, \"-edit=x\"
customEditCommand    :: CustomData (StateGrammar -> Action)

-- | filterString, \"-filter=x\"
customStringCommand  :: CustomData (StateGrammar -> String -> String)

-- | useParser, \"-parser=x\"
customParser         :: CustomData (StateGrammar -> CFCat -> CFParser)

-- | useTokenizer, \"-lexer=x\"
customTokenizer      :: CustomData (StateGrammar -> String -> [[CFTok]])  

-- | useUntokenizer, \"-unlexer=x\" --- should be from token list to string
customUntokenizer    :: CustomData (StateGrammar -> String -> String)  

-- | uniCoding, \"-coding=x\"
--
-- contains conversions from different codings to the internal
-- unicode coding
customUniCoding :: CustomData (String -> String)

-- | this is the way of selecting an item
customOrDefault :: Options -> OptFun -> CustomData a -> a
customOrDefault opts optfun db = maybe (defaultCustomVal db) id $ 
                                   customAsOptVal opts optfun db

-- | to produce menus of custom operations
customInfo :: CustomData a -> (String, [String])
customInfo c = (titleCustomData c, map (ciStr . fst) (dbCustomData c))

-------------------------------
-- * types and stuff 

type CommandId = String

strCI :: String -> CommandId
strCI = id

ciStr :: CommandId -> String
ciStr = id

ciOpt :: CommandId -> Option
ciOpt = iOpt

newtype CustomData a = CustomData (String, [(CommandId,a)])

customData :: String -> [(CommandId, a)] -> CustomData a
customData title db = CustomData (title,db)

dbCustomData :: CustomData a -> [(CommandId, a)]
dbCustomData (CustomData (_,db)) = db

titleCustomData :: CustomData a -> String
titleCustomData (CustomData (t,_)) = t

lookupCustom :: CustomData a -> CommandId -> Maybe a
lookupCustom = flip lookup . dbCustomData

customAsOptVal :: Options -> OptFun -> CustomData a -> Maybe a
customAsOptVal opts optfun db = do
  arg <- getOptVal opts optfun
  lookupCustom db (strCI arg)

-- | take the first entry from the database
defaultCustomVal :: CustomData a -> a
defaultCustomVal (CustomData (s,db)) = 
  ifNull (error ("empty database:" +++ s)) (snd . head) db

-------------------------------------------------------------------------
-- * and here's the customizable part:

-- grammar parsers: the ID is also used as file name suffix
customGrammarParser = 
  customData "Grammar parsers, selected by file name suffix" $
  [
------   (strCI "gf",  compileModule noOptions) -- DEFAULT
-- add your own grammar parsers here
  ] 


customGrammarPrinter = 
  customData "Grammar printers, selected by option -printer=x" $
  [
   (strCI "gfc",     \_ -> prCanon . stateGrammarST) -- DEFAULT
  ,(strCI "gf",      \_ -> err id prGrammar . canon2sourceGrammar . stateGrammarST)
  ,(strCI "cf",      \_ -> prCF . stateCF)
  ,(strCI "old",     \_ -> printGrammarOld . stateGrammarST)
  ,(strCI "gsl",     gslPrinter)
  ,(strCI "jsgf",    jsgfPrinter Nothing)
  ,(strCI "jsgf_sisr_old", jsgfPrinter (Just SISR.SISROld))
  ,(strCI "srgs_xml",           srgsXmlPrinter Nothing False)
  ,(strCI "srgs_xml_prob",      srgsXmlPrinter Nothing True)
  ,(strCI "srgs_xml_sisr_old",  srgsXmlPrinter (Just SISR.SISROld) False)
  ,(strCI "srgs_abnf",          srgsAbnfPrinter Nothing False)
  ,(strCI "srgs_abnf_sisr_old", srgsAbnfPrinter (Just SISR.SISROld) False)
  ,(strCI "vxml", grammar2vxml)
  ,(strCI "slf",  slfPrinter)
  ,(strCI "slf_graphviz", slfGraphvizPrinter)
  ,(strCI "slf_sub", slfSubPrinter)
  ,(strCI "slf_sub_graphviz", slfSubGraphvizPrinter)
  ,(strCI "fa_graphviz", faGraphvizPrinter)
  ,(strCI "fa_c",  faCPrinter)
  ,(strCI "regexp", regexpPrinter)
  ,(strCI "regular", regularPrinter)
  ,(strCI "plbnf",   \_ -> prLBNF True)
  ,(strCI "lbnf",    \_ -> prLBNF False)
  ,(strCI "bnf",     \_ -> prBNF False)
  ,(strCI "absbnf",  \_ -> abstract2bnf . stateGrammarST)
  ,(strCI "haskell", \_ -> grammar2haskell . stateGrammarST)
  ,(strCI "haskell_gadt", \_ -> grammar2haskellGADT . stateGrammarST)
  ,(strCI "transfer", \_ -> grammar2transfer . stateGrammarST)
  ,(strCI "morpho",  \_ -> prMorpho . stateMorpho)
  ,(strCI "fullform",\_ -> prFullForm . stateMorpho)
  ,(strCI "opts",    \_ -> prOpts . stateOptions)
  ,(strCI "words",   \_ -> unwords . stateGrammarWords)
  ,(strCI "printnames", \_ -> C.prPrintnamesGrammar . stateGrammarST)
  ,(strCI "stat",    \_ -> prStatistics . stateGrammarST)
  ,(strCI "probs",   \_ -> prProbs . stateProbs)
  ,(strCI "unpar",   \_ -> prCanon . unparametrizeCanon . stateGrammarST)
  ,(strCI "subs",    \_ -> prSubtermStat . stateGrammarST)

{- ----
   (strCI "gf",      prt  . st2grammar . stateGrammarST)  -- DEFAULT
  ,(strCI "canon",   showCanon "Lang" . stateGrammarST)
  ,(strCI "gfc",     GFC.showGFC . stateGrammarST)
  ,(strCI "canonOpt",showCanonOpt "Lang" . stateGrammarST)
-}

-- add your own grammar printers here

-- grammar conversions:
  ,(strCI "mcfg",     \_ -> Prt.prt . stateMCFG)
  ,(strCI "fcfg",     \_ -> Prt.prt . stateFCFG)
  ,(strCI "bfcfg",    \_ -> printFGrammar . stateFCFG)
  ,(strCI "mcfg2fcfg",\_ -> Prt.prt . Cnv.mcfg2fcfg . stateMCFG)
  ,(strCI "cfg",      \_ -> Prt.prt . stateCFG)
  ,(strCI "pinfo",    \_ -> Prt.prt . statePInfo)
  ,(strCI "abstract", \_ -> Prt.prtAfter "\n" . Cnv.gfc2abstract . stateGrammarLang)

  ,(strCI "functiongraph",\_ -> CnvTypeGraph.prtFunctionGraph . Cnv.gfc2simple noOptions . stateGrammarLang)
  ,(strCI "typegraph",    \_ -> CnvTypeGraph.prtTypeGraph . Cnv.gfc2simple noOptions . stateGrammarLang)

  ,(strCI "gfc-haskell",  \_ -> CnvHaskell.prtSGrammar . uncurry Cnv.gfc2simple . stateGrammarLangOpts)
  ,(strCI "mcfg-haskell", \_ -> CnvHaskell.prtMGrammar . stateMCFG)
  ,(strCI "cfg-haskell",  \_ -> CnvHaskell.prtCGrammar . stateCFG)
  ,(strCI "gfc-prolog",   \_ -> CnvProlog.prtSGrammar . uncurry Cnv.gfc2simple . stateGrammarLangOpts)
  ,(strCI "mcfg-prolog",  \_ -> CnvProlog.prtMGrammar . stateMCFG)
  ,(strCI "cfg-prolog",   \_ -> CnvProlog.prtCGrammar . stateCFG)

-- obsolete, or only for testing:
  ,(strCI "abs-skvatt", \_ -> Cnv.abstract2skvatt . Cnv.gfc2abstract . stateGrammarLang)
  ,(strCI "cfg-skvatt", \_ -> Cnv.cfg2skvatt . stateCFG)
  ,(strCI "simple",   \_ -> Prt.prt . uncurry Cnv.gfc2simple . stateGrammarLangOpts)
  ,(strCI "mcfg-erasing", \_ -> Prt.prt . fst . snd . uncurry Cnv.convertGFC . stateGrammarLangOpts)
--  ,(strCI "mcfg-old", PrtOld.prt . CnvOld.mcfg . statePInfoOld)
--  ,(strCI "cfg-old",  PrtOld.prt . CnvOld.cfg . statePInfoOld)
  ] 
  where stateGrammarLangOpts s = (stateOptions s, stateGrammarLang s)

customMultiGrammarPrinter = 
  customData "Printers for multiple grammars, selected by option -printer=x" $
  [
   (strCI "gfcm", const MC.prCanon)
  ,(strCI "gfcc", const GFCC.prCanon2gfcc)
  ,(strCI "js", const JS.prCanon2js)
  ,(strCI "header", const (MC.prCanonMGr . unoptimizeCanon))
  ,(strCI "cfgm", prCanonAsCFGM)
  ,(strCI "graph", visualizeCanonGrammar)
  ,(strCI "missing", const missingLinCanonGrammar)

-- to prolog format:
  ,(strCI "gfc-prolog", CnvProlog.prtSMulti)
  ,(strCI "mcfg-prolog", CnvProlog.prtMMulti)
  ,(strCI "cfg-prolog", CnvProlog.prtCMulti)
  ]


customSyntaxPrinter = 
  customData "Syntax printers, selected by option -printer=x" $
  [ 
-- add your own grammar printers here
  ] 


customTermPrinter = 
  customData "Term printers, selected by option -printer=x" $
  [ 
    (strCI "gf",     const prt) -- DEFAULT
-- add your own term printers here
  ]

customTermCommand = 
  customData "Term transformers, selected by option -transform=x" $
  [
   (strCI "identity",   \_ t -> [t]) -- DEFAULT
  ,(strCI "compute",    \g t -> let gr = grammar g in
                                  err (const [t]) return 
                                    (exp2termCommand gr (computeAbsTerm gr) t))
  ,(strCI "nodup",      \_ t -> if (hasDupIdent $ tree2exp t) then [] else [t])
  ,(strCI "nodupatom",  \_ t -> if (hasDupAtom  $ tree2exp t) then [] else [t])
  ,(strCI "paraphrase", \g t -> let gr = grammar g in
                                  exp2termlistCommand gr (mkParaphrases gr) t)

  ,(strCI "generate",   \g t -> let gr = grammar g
                                    cat = actCat $ tree2loc t --- not needed
                                in
                         [tr | t <- generateTrees noOptions gr cat 2 Nothing (Just t), 
                               Ok tr <- [annotate gr $ MM.qualifTerm (absId g) t]])
  ,(strCI "typecheck",   \g t -> err (const []) (return . loc2tree)
                                    (reCheckStateReject (grammar g) (tree2loc t)))
  ,(strCI "solve",      \g t -> err (const []) (return . loc2tree)
                                   (solveAll (grammar g) (tree2loc t)
                                      >>= rejectUnsolvable))
  ,(strCI "context",    \g t -> err (const [t]) (return . loc2tree)
                                   (contextRefinements (grammar g) (tree2loc t)))
  ,(strCI "reindex",    \g t -> let gr = grammar g in
                                  err (const [t]) return 
                                    (exp2termCommand gr (return . MM.reindexTerm) t))
---  ,(strCI "delete",     \g t -> [MM.mExp0])
-- add your own term commands here
  ]

customEditCommand = 
  customData "Editor state transformers, selected by option -edit=x" $
  [
   (strCI "identity",   const return) -- DEFAULT
  ,(strCI "typecheck",  \g -> reCheckState (grammar g))
  ,(strCI "solve",      \g -> solveAll (grammar g))
  ,(strCI "context",    \g -> contextRefinements (grammar g))
  ,(strCI "compute",    \g -> computeSubTree (grammar g))
  ,(strCI "paraphrase", const return) --- done ad hoc on top level
  ,(strCI "generate",   const return) --- done ad hoc on top level
  ,(strCI "transfer",   const return) --- done ad hoc on top level
-- add your own edit commands here
  ]

customStringCommand = 
  customData "String filters, selected by option -filter=x" $
  [
   (strCI "identity",  const $ id)   -- DEFAULT
  ,(strCI "erase",     const $ const "")
  ,(strCI "take100",   const $ take 100)
  ,(strCI "text",      const $ formatAsText)
  ,(strCI "code",      const $ formatAsCode)
----  ,(strCI "latexfile", const $ mkLatexFile)
  ,(strCI "length",    const $ show . length)
-- add your own string commands here
  ]

customParser = 
  customData "Parsers, selected by option -parser=x" $
  [
   (strCI "chart",  PCFOld.parse "ibn" . stateCF) -- DEPRECATED
  ,(strCI "bottomup",  PCF.parse "gb" . stateCF)
  ,(strCI "topdown",  PCF.parse "gt" . stateCF)
-- commented for now, since there's a bug in the incremental algorithm:
--   ,(strCI "incremental",  PCF.parse "ib" . stateCF)
--   ,(strCI "incremental-bottomup",  PCF.parse "ib" . stateCF)
--   ,(strCI "incremental-topdown",  PCF.parse "it" . stateCF)
  ,(strCI "old",    chartParser . stateCF) -- DEPRECATED
  ,(strCI "myparser", myParser)
-- add your own parsers here
  ]

customTokenizer =
  let sg = singleton in 
  customData "Tokenizers, selected by option -lexer=x" $
  [
   (strCI "words",     const $ sg . tokWords)
  ,(strCI "literals",  const $ sg . tokLits)
  ,(strCI "vars",      const $ sg . tokVars)
  ,(strCI "chars",     const $ sg . map (tS . singleton))
  ,(strCI "code",      const $ sg . lexHaskell)
  ,(strCI "codevars",  \gr -> sg . (lexHaskellVar $ stateIsWord gr))
  ,(strCI "textvars",  \gr -> sg . (lexTextVar $ stateIsWord gr))
  ,(strCI "text",      const $ sg . lexText)
  ,(strCI "unglue",    \gr -> sg . map tS . decomposeWords (stateMorpho gr))
  ,(strCI "codelit",   \gr -> sg . (lexHaskellLiteral $ stateIsWord gr))
  ,(strCI "textlit",   \gr -> sg . (lexTextLiteral $ stateIsWord gr))
  ,(strCI "codeC",     const $ sg . lexC2M)
  ,(strCI "ignore",    \gr -> sg . lexIgnore (stateIsWord gr) . tokLits)
  ,(strCI "subseqs",   \gr -> subSequences . lexIgnore (stateIsWord gr) . tokLits)
  ,(strCI "codeCHigh", const $ sg . lexC2M' True)
-- add your own tokenizers here
  ]

customUntokenizer = 
  customData "Untokenizers, selected by option -unlexer=x" $
  [
   (strCI "unwords",   const $ id)   -- DEFAULT
  ,(strCI "text",      const $ formatAsText)
  ,(strCI "html",      const $ formatAsHTML)
  ,(strCI "latex",     const $ formatAsLatex)
  ,(strCI "code",      const $ formatAsCode)
  ,(strCI "concat",    const $ filter (not . isSpace))
  ,(strCI "textlit",   const $ formatAsTextLit)
  ,(strCI "codelit",   const $ formatAsCodeLit)
  ,(strCI "concat",    const $ concatRemSpace)
  ,(strCI "glue",      const $ performBinds)
  ,(strCI "finnish",   const $ performBindsFinnish)
  ,(strCI "reverse",   const $ reverse)
  ,(strCI "bind",      const $ performBinds) -- backward compat
-- add your own untokenizers here
  ]

customUniCoding = 
  customData "Alphabet codings, selected by option -coding=x" $
  [
   (strCI "latin1",           id) -- DEFAULT
  ,(strCI "utf8",             decodeUTF8)
  ,(strCI "greek",            treat [] mkGreek)
  ,(strCI "hebrew",           mkHebrew)
  ,(strCI "arabic",           mkArabic)
  ,(strCI "russian",          treat [] mkRussian)
  ,(strCI "russianKOI8",      mkRusKOI8)
  ,(strCI "ethiopic",         mkEthiopic)
  ,(strCI "tamil",            mkTamil)
  ,(strCI "OCScyrillic",      mkOCSCyrillic)
  ,(strCI "devanagari",       mkDevanagari)
  ,(strCI "latinasupplement", mkLatinASupplement)
  ,(strCI "japanese",         mkJapanese)
  ,(strCI "arabic0600",       mkArabic0600)
  ,(strCI "extendedarabic",   mkExtendedArabic)
  ,(strCI "extradiacritics",  mkExtraDiacritics)
  ]
