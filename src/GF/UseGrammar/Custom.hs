----------------------------------------------------------------------
-- |
-- Module      : Custom
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 14:17:45 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.46 $
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

module Custom where

import Operations
import Text
import Tokenize
import Values
import qualified Grammar as G
import qualified AbsGFC as A
import qualified GFC as C
import qualified AbsGF as GF
import qualified MMacros as MM
import AbsCompute
import TypeCheck
import Generate
------import Compile
import ShellState
import Editing
import Paraphrases
import Option
import CF
import CFIdent

import CanonToGrammar
import PPrCF
import PrLBNF
import PrGrammar
import PrOld
import MkGFC
import CFtoSRG
import PrGSL (gslPrinter)
import PrJSGF (jsgfPrinter)

import Zipper

import Morphology
import GrammarToHaskell
-----import GrammarToCanon (showCanon, showCanonOpt)
-----import qualified GrammarToGFC as GFC

-- the cf parsing algorithms
import ChartParser -- or some other CF Parser
import qualified GF.Parsing.ParseCF as PCF
--import qualified ParseGFCviaCFG as PGFC
--import NewChartParser
--import NewerChartParser

-- grammar conversions -- peb 19/4-04
-- see also customGrammarPrinter
import qualified GF.Conversion.ConvertGrammar as Cnv
import qualified GF.Printing.PrintParser as Prt

import GFC
import qualified MkGFC as MC
import PrintCFGrammar (prCanonAsCFGM)
import VisualizeGrammar (visualizeCanonGrammar, visualizeSourceGrammar)

import MyParser

import MoreCustom -- either small/ or big/. The one in Small is empty.

import UseIO

import Monad
import Char

-- character codings
import Unicode
import UTF8 (decodeUTF8)
import Greek (mkGreek)
import Arabic (mkArabic)
import Hebrew (mkHebrew)
import Russian (mkRussian, mkRusKOI8)
import Ethiopic (mkEthiopic)
import Tamil (mkTamil)
import OCSCyrillic (mkOCSCyrillic)
import LatinASupplement (mkLatinASupplement)
import Devanagari (mkDevanagari)
import Hiragana (mkJapanese)
import ExtendedArabic (mkArabic0600)
import ExtendedArabic (mkExtendedArabic)
import ExtraDiacritics (mkExtraDiacritics)

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
customGrammarPrinter :: CustomData (StateGrammar -> String)             

-- | multiGrammarPrinter, \"-printer=x\"
customMultiGrammarPrinter :: CustomData (CanonGrammar -> String)    

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
customTokenizer      :: CustomData (StateGrammar -> String -> [CFTok])  

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
  ++ moreCustomGrammarParser


customGrammarPrinter = 
  customData "Grammar printers, selected by option -printer=x" $
  [
   (strCI "gfc",     prCanon . stateGrammarST) -- DEFAULT
  ,(strCI "gf",      err id prGrammar . canon2sourceGrammar . stateGrammarST)
  ,(strCI "cf",      prCF . stateCF)
  ,(strCI "old",     printGrammarOld . stateGrammarST)
  ,(strCI "srg",     prSRG . stateCF)
  ,(strCI "gsl",     \s -> let opts = stateOptions s
                               name = cncId s
                            in gslPrinter name opts $ Cnv.cfg $ statePInfo s)
  ,(strCI "jsgf",    \s -> let opts = stateOptions s
                               name = cncId s
                            in jsgfPrinter name opts $ Cnv.cfg $ statePInfo s)
  ,(strCI "plbnf",   prLBNF True)
  ,(strCI "lbnf",    prLBNF False)
  ,(strCI "bnf",     prBNF False)
  ,(strCI "haskell", grammar2haskell . stateGrammarST)
  ,(strCI "morpho",  prMorpho . stateMorpho)
  ,(strCI "fullform",prFullForm . stateMorpho)
  ,(strCI "opts",    prOpts . stateOptions)
  ,(strCI "words",   unwords . stateGrammarWords)
{- ----
   (strCI "gf",      prt  . st2grammar . stateGrammarST)  -- DEFAULT
  ,(strCI "canon",   showCanon "Lang" . stateGrammarST)
  ,(strCI "gfc",     GFC.showGFC . stateGrammarST)
  ,(strCI "canonOpt",showCanonOpt "Lang" . stateGrammarST)
-}
-- add your own grammar printers here
-- grammar conversions, (peb) 
  ,(strCI "gfc_show",   show . grammar2canon . stateGrammarST)
  ,(strCI "mcfg",       Prt.prt . Cnv.mcfg . statePInfo)
  ,(strCI "cfg",        Prt.prt . Cnv.cfg . statePInfo)
  ,(strCI "mcfg_show",  show . Cnv.mcfg . statePInfo)
  ,(strCI "cfg_show",   show . Cnv.cfg . statePInfo)
--- also include printing via grammar2syntax!
  ] 
  ++ moreCustomGrammarPrinter

customMultiGrammarPrinter = 
  customData "Printers for multiple grammars, selected by option -printer=x" $
  [
   (strCI "gfcm", MC.prCanon)
  ,(strCI "header", MC.prCanonMGr)
  ,(strCI "cfgm", prCanonAsCFGM)
  ,(strCI "graph", visualizeCanonGrammar)
  ]
  ++ moreCustomMultiGrammarPrinter


customSyntaxPrinter = 
  customData "Syntax printers, selected by option -printer=x" $
  [ 
-- add your own grammar printers here
  ] 
  ++ moreCustomSyntaxPrinter


customTermPrinter = 
  customData "Term printers, selected by option -printer=x" $
  [ 
    (strCI "gf",     const prt) -- DEFAULT
-- add your own term printers here
  ]
  ++ moreCustomTermPrinter

customTermCommand = 
  customData "Term transformers, selected by option -transform=x" $
  [
   (strCI "identity",   \_ t -> [t]) -- DEFAULT
  ,(strCI "compute",    \g t -> let gr = grammar g in
                                  err (const [t]) return 
                                    (exp2termCommand gr (computeAbsTerm gr) t))
  ,(strCI "paraphrase", \g t -> let gr = grammar g in
                                  exp2termlistCommand gr (mkParaphrases gr) t)

  ,(strCI "generate",   \g t -> let gr = grammar g
                                    cat = actCat $ tree2loc t --- not needed
                                in
                         [tr | t <- generateTrees gr False cat 2 Nothing (Just t), 
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
  ++ moreCustomTermCommand

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
  ++ moreCustomEditCommand

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
  ++ moreCustomStringCommand

customParser = 
  customData "Parsers, selected by option -parser=x" $
  [
   (strCI "chart",    chartParser . stateCF)
  ,(strCI "myparser", myParser)
-- add your own parsers here
  ]
  -- 31/5-04, peb:
  ++ [ (strCI ("new"++name), PCF.parse descr . stateCF) |
       (descr, names) <- PCF.alternatives, name <- names ]
  -- 21/5-04, peb:
  -- ++ [ (strCI ("new"++name), newChartParser descr . stateCF) |
  --      (descr, names) <- newChartParserAlternatives, name <- names ]
  -- ++ [ (strCI ("newer"++name), newerChartParser descr . stateParserInfo) |
  --      (descr, names) <- newerChartParserAlternatives, name <- names ]
  ++ moreCustomParser

customTokenizer = 
  customData "Tokenizers, selected by option -lexer=x" $
  [
   (strCI "words",     const $ tokWords)
  ,(strCI "literals",  const $ tokLits)
  ,(strCI "vars",      const $ tokVars)
  ,(strCI "chars",     const $ map (tS . singleton))
  ,(strCI "code",      const $ lexHaskell)
  ,(strCI "codevars",  lexHaskellVar . stateIsWord)
  ,(strCI "text",      const $ lexText)
  ,(strCI "unglue",    \gr -> map tS . decomposeWords (stateMorpho gr))
  ,(strCI "codelit",   lexHaskellLiteral . stateIsWord)
  ,(strCI "textlit",   lexTextLiteral . stateIsWord)
  ,(strCI "codeC",     const $ lexC2M)
  ,(strCI "codeCHigh", const $ lexC2M' True)
-- add your own tokenizers here
  ]
  ++ moreCustomTokenizer

customUntokenizer = 
  customData "Untokenizers, selected by option -unlexer=x" $
  [
   (strCI "unwords",   const $ id)   -- DEFAULT
  ,(strCI "text",      const $ formatAsText)
  ,(strCI "code",      const $ formatAsCode)
  ,(strCI "concat",    const $ filter (not . isSpace))
  ,(strCI "textlit",   const $ formatAsTextLit)
  ,(strCI "codelit",   const $ formatAsCodeLit)
  ,(strCI "concat",    const $ concatRemSpace)
  ,(strCI "glue",      const $ performBinds)
  ,(strCI "reverse",   const $ reverse)
  ,(strCI "bind",      const $ performBinds) -- backward compat
-- add your own untokenizers here
  ]
  ++ moreCustomUntokenizer

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
  ++ moreCustomUniCoding
