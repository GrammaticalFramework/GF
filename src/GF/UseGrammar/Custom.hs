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

import Zipper

import Morphology
-----import GrammarToHaskell
-----import GrammarToCanon (showCanon, showCanonOpt)
-----import qualified GrammarToGFC as GFC

-- the cf parsing algorithms
import ChartParser -- or some other CF Parser

-- grammar conversions -- peb 19/4-04
-- see also customGrammarPrinter
import ConvertGrammar

import MoreCustom -- either small/ or big/. The one in Small is empty.

import UseIO

import Monad

-- minimal version also used in Hugs. AR 2/12/2002. 

-- databases for customizable commands. AR 21/11/2001
-- for:  grammar parsers, grammar printers, term commands, string commands
-- idea: items added here are usable throughout GF; nothing else need be edited
-- they are often usable through the API: hence API cannot be imported here!

-- Major redesign 3/4/2002: the first entry in each database is DEFAULT.
-- If no other value is given, the default is selected.
-- Because of this, two invariants have to be preserved:
-- ** no databases may be empty
-- ** additions are made to the end of the database

-- these are the databases; the comment gives the name of the flag

-- grammarFormat, "-format=x" or file suffix
customGrammarParser :: CustomData (FilePath -> IOE C.CanonGrammar) 

-- grammarPrinter, "-printer=x"
customGrammarPrinter :: CustomData (StateGrammar -> String)             

-- syntaxPrinter, "-printer=x"
customSyntaxPrinter  :: CustomData (GF.Grammar -> String)        

-- termPrinter, "-printer=x"
customTermPrinter  :: CustomData (StateGrammar -> Tree -> String)

-- termCommand, "-transform=x"
customTermCommand    :: CustomData (StateGrammar -> Tree -> [Tree])

-- editCommand, "-edit=x"
customEditCommand    :: CustomData (StateGrammar -> Action)

-- filterString, "-filter=x"
customStringCommand  :: CustomData (StateGrammar -> String -> String)

-- useParser, "-parser=x"
customParser         :: CustomData (StateGrammar -> CFCat -> CFParser)

-- useTokenizer, "-lexer=x"
customTokenizer      :: CustomData (StateGrammar -> String -> [CFTok])  

-- useUntokenizer, "-unlexer=x" --- should be from token list to string
customUntokenizer    :: CustomData (StateGrammar -> String -> String)  


-- this is the way of selecting an item
customOrDefault :: Options -> OptFun -> CustomData a -> a
customOrDefault opts optfun db = maybe (defaultCustomVal db) id $ 
                                   customAsOptVal opts optfun db

-- to produce menus of custom operations
customInfo :: CustomData a -> (String, [String])
customInfo c = (titleCustomData c, map (ciStr . fst) (dbCustomData c))

-------------------------------

type CommandId = String

strCI :: String -> CommandId
strCI = id

ciStr :: CommandId -> String
ciStr = id

ciOpt :: CommandId -> Option
ciOpt = iOpt

newtype CustomData a = CustomData (String, [(CommandId,a)])
customData title db = CustomData (title,db)
dbCustomData (CustomData (_,db)) = db
titleCustomData (CustomData (t,_)) = t

lookupCustom :: CustomData a -> CommandId -> Maybe a
lookupCustom = flip lookup . dbCustomData

customAsOptVal :: Options -> OptFun -> CustomData a -> Maybe a
customAsOptVal opts optfun db = do
  arg <- getOptVal opts optfun
  lookupCustom db (strCI arg)

-- take the first entry from the database
defaultCustomVal :: CustomData a -> a
defaultCustomVal (CustomData (s,db)) = 
  ifNull (error ("empty database:" +++ s)) (snd . head) db

-------------------------------------------------------------------------
-- and here's the customizable part:

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
  ,(strCI "lbnf",    prLBNF . stateCF)
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
  ,(strCI "gfc_raw",    prRaw . stateGrammarST)
  ,(strCI "tnf",        prCanon . convertCanonToTNF . stateGrammarST)
  ,(strCI "mcfg",       prMCFG . convertCanonToMCFG . stateGrammarST)
  ,(strCI "mcfg_cf",    prCF . convertCanonToCF . stateGrammarST)
  ,(strCI "mcfg_canon", prCanon . convertCanonToMCFG . stateGrammarST)
  ,(strCI "mcfg_raw",   prRaw . convertCanonToMCFG . stateGrammarST)
--- also include printing via grammar2syntax!
  ] 
  ++ moreCustomGrammarPrinter

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
                                  tree2termlistCommand gr
                                    (generateTrees gr cat 2
                                      Nothing . Just) t)

  ,(strCI "typecheck",  \g t -> let gr = grammar g in
                                  err (const []) (return . const t)
                                    (checkIfValidExp gr (tree2exp t)))
  ,(strCI "solve",      \g t -> err (const [t]) (return . loc2tree)
                                   (uniqueRefinements (grammar g) (tree2loc t)))
  ,(strCI "context",    \g t -> err (const [t]) (return . loc2tree)
                                   (contextRefinements (grammar g) (tree2loc t)))
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
-- add your own parsers here
  ]
  ++ moreCustomParser

customTokenizer = 
  customData "Tokenizers, selected by option -lexer=x" $
  [
   (strCI "words",     const $ tokWords)
  ,(strCI "literals",  const $ tokLits)
  ,(strCI "vars",      const $ tokVars)
  ,(strCI "chars",     const $ map (tS . singleton))
  ,(strCI "code",      const $ lexHaskell)
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
  ,(strCI "textlit",   const $ formatAsTextLit)
  ,(strCI "codelit",   const $ formatAsCodeLit)
  ,(strCI "concat",    const $ concat . words)
  ,(strCI "glue",      const $ performBinds)
  ,(strCI "bind",      const $ performBinds) -- backward compat
-- add your own untokenizers here
  ]
  ++ moreCustomUntokenizer
