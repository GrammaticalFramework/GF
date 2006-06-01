----------------------------------------------------------------------
-- |
-- Module      : ShellCommands
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/14 16:03:41 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.46 $
--
-- The datatype of shell commands and the list of their options.
-----------------------------------------------------------------------------

module GF.Shell.ShellCommands where

import qualified GF.Infra.Ident as I
import GF.Compile.ShellState
import GF.UseGrammar.Custom
import GF.Grammar.PrGrammar

import GF.Infra.Option
import GF.Data.Operations
import GF.Infra.Modules

import Data.Char (isDigit)
import Control.Monad (mplus)

-- shell commands and their options
-- moved to separate module and added option check: AR 27/5/2004
--- TODO: single source for 
---   (1) command interpreter (2) option check (3) help file

data Command =
   CImport FilePath
 | CRemoveLanguage Language
 | CEmptyState
 | CChangeMain (Maybe I.Ident)
 | CStripState
 | CTransformGrammar FilePath
 | CConvertLatex FilePath

 | CDefineCommand String [String]
 | CDefineTerm String

 | CLinearize [()] ---- parameters
 | CParse
 | CTranslate Language Language
 | CGenerateRandom
 | CGenerateTrees
 | CTreeBank
 | CPutTerm
 | CWrapTerm I.Ident
 | CApplyTransfer (Maybe I.Ident, I.Ident)
 | CMorphoAnalyse
 | CTestTokenizer
 | CComputeConcrete String
 | CShowOpers String

 | CLookupTreebank

 | CTranslationQuiz Language Language
 | CTranslationList Language Language
 | CMorphoQuiz
 | CMorphoList

 | CReadFile   FilePath
 | CWriteFile  FilePath
 | CAppendFile FilePath
 | CSpeakAloud
 | CSpeechInput
 | CPutString
 | CShowTerm
 | CSystemCommand String
 | CGrep String

 | CSetFlag
 | CSetLocalFlag Language

 | CPrintGrammar
 | CPrintGlobalOptions
 | CPrintLanguages
 | CPrintInformation I.Ident
 | CPrintMultiGrammar
 | CPrintSourceGrammar
 | CShowGrammarGraph
 | CShowTreeGraph
 | CPrintGramlet 
 | CPrintCanonXML
 | CPrintCanonXMLStruct 
 | CPrintHistory
 | CHelp (Maybe String)

 | CImpure ImpureCommand

 | CVoid

-- to isolate the commands that are executed on top level
data ImpureCommand = 
    ICQuit 
  | ICExecuteHistory FilePath 
  | ICEarlierCommand Int
  | ICEditSession 
  | ICTranslateSession
  | ICReload

type CommandOpt = (Command, Options)

-- the top-level option warning action

checkOptions :: ShellState -> (Command,Options) -> IO ()
checkOptions sh (co, Opts opts) = do
  let (_,s) = errVal ([],"option check failed") $ mapErr check opts
  if (null s) then return () 
    else putStr "WARNING: " >> putStrLn s
 where 
   check = isValidOption sh co

isValidOption :: ShellState -> Command -> Option -> Err ()
isValidOption st co op = case op of
     Opt (o,[])  -> 
       testErr (elem o $ optsOf co) ("invalid option:" +++ prOpt op)
     Opt (o,[x]) -> do
       testErr (elem o (flagsOf co)) ("invalid flag:" +++ o) 
       testValidFlag st co o x
     _ -> Bad $ "impossible option" +++ prOpt op
  where
   optsOf  co = ("tr" :) $ fst $ optionsOfCommand co
   flagsOf co = snd $ optionsOfCommand co

testValidFlag :: ShellState -> Command -> OptFunId -> String -> Err ()
testValidFlag st co f x = case f of
  "cat"     -> testIn (map prQIdent_ (allCategories st))
  "lang"    -> testIn (map prt (allLanguages st))
  "transfer" -> testIn (map prt (allTransfers st))
  "res"     -> testIn (map prt (allResources (srcModules st)))
  "number"  -> testN
  "printer" -> case co of
		       CPrintGrammar -> testInc customGrammarPrinter
		       CPrintMultiGrammar -> testInc customMultiGrammarPrinter
		       CSetFlag -> testInc customGrammarPrinter `mplus` 
				   testInc customMultiGrammarPrinter
  "lexer"   -> testInc customTokenizer
  "unlexer" -> testInc customUntokenizer
  "depth"   -> testN
  "rawtrees"-> testN
  "parser"  -> testInc customParser 
	       -- hack for the -newer parsers: (to be changed in the future)
	       -- `mplus` testIn (words "mcfg mcfg-bottomup mcfg-topdown cfg cfg-bottomup cfg-topdown bottomup topdown")
	       -- if not(null x) && head x `elem` "mc" then return () else Bad ""
  "alts"    -> testN
  "transform" -> testInc customTermCommand
  "filter"  -> testInc customStringCommand
  "length"  -> testN
  "optimize"-> testIn $ words "parametrize values all share none"
  "conversion" -> testIn $ words "strict nondet finite finite2 finite3 singletons finite-strict finite-singletons"
  _ -> return ()
 where
   testInc ci = 
     let vs = snd (customInfo ci) in testIn vs 
   testIn vs =
     if elem x vs
        then return ()
        else Bad ("flag:" +++ f +++ "invalid value:" +++ x ++++
                  "possible values:" +++ unwords vs)
   testN = 
     if all isDigit x
        then return ()
        else Bad ("flag:" +++ f +++ "invalid value:" +++ x ++++
                  "expected integer")


optionsOfCommand :: Command -> ([String],[String])
optionsOfCommand co = case co of
  CSetFlag -> 
    both "utf8 table struct record all multi"
	 "cat lang lexer parser number depth rawtrees unlexer optimize path conversion printer"
  CImport _ -> 
    both "old v s src make gfc retain nocf nocheckcirc cflexer noemit o make ex prob treebank"
         "abs cnc res path optimize conversion cat preproc probs noparse"
  CRemoveLanguage _ -> none
  CEmptyState -> none
  CStripState -> none
  CTransformGrammar _ -> flags "printer"
  CConvertLatex _ -> none
  CLinearize _ -> both "utf8 table struct record all multi" "lang number unlexer mark"
  CParse -> both "ambiguous fail cut new newer cfg mcfg fcfg n ign raw v lines all prob" 
                 "cat lang lexer parser number rawtrees"
  CTranslate _ _ -> opts "cat lexer parser"
  CGenerateRandom -> both "cf prob" "cat lang number depth atoms noexpand doexpand"
  CGenerateTrees -> both "metas" "atoms depth alts cat lang number noexpand doexpand"
  CPutTerm -> flags "transform number"
  CTreeBank -> opts "c xml trees all table record"
  CLookupTreebank -> both "assocs raw strings trees" "treebank"
  CWrapTerm _ -> opts "c"
  CApplyTransfer _ -> flags "lang transfer"
  CMorphoAnalyse -> both "short" "lang"
  CTestTokenizer -> flags "lexer"
  CComputeConcrete _ -> flags "res"
  CShowOpers _ -> flags "res"

  CTranslationQuiz _ _ -> flags "cat"
  CTranslationList _ _ ->  flags "cat number"
  CMorphoQuiz -> flags "cat lang"
  CMorphoList -> flags "cat lang number"

  CReadFile _  -> none
  CWriteFile  _ -> none
  CAppendFile _ -> none
  CSpeakAloud -> flags "language"
  CSpeechInput -> flags "lang cat language number"

  CPutString -> both "utf8" "filter length"
  CShowTerm -> flags "printer"
  CShowTreeGraph -> opts "c f g o"
  CSystemCommand _ -> none
  CGrep _ -> opts "v"

  CPrintGrammar -> both "utf8" "printer lang startcat"
  CPrintMultiGrammar -> both "utf8 utf8id" "printer"
  CPrintSourceGrammar -> both "utf8" "printer"

  CHelp _ -> opts "all alts atoms coding defs filter length lexer unlexer printer probs transform depth number cat"

  CImpure ICEditSession -> both "f" "file"
  CImpure ICTranslateSession -> both "f langs" "cat"

  _ -> none

{-
  CSetLocalFlag Language
  CPrintGlobalOptions
  CPrintLanguages
  CPrintInformation I.Ident
  CPrintGramlet 
  CPrintCanonXML
  CPrintCanonXMLStruct 
  CPrintHistory
  CVoid
-}
 where
   flags fs = ([],words fs)
   opts fs = (words fs,[])
   both os fs = (words os,words fs)
   none = ([],[])
