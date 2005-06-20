----------------------------------------------------------------------
-- |
-- Module      : PShell
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/20 16:14:20 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.25 $
--
-- parsing GF shell commands. AR 11\/11\/2001
-----------------------------------------------------------------------------

module GF.Shell.PShell where

import GF.Data.Operations
import GF.Infra.UseIO
import GF.Compile.ShellState
import GF.Shell.ShellCommands
import GF.Shell
import GF.Infra.Option
import GF.Compile.PGrammar (pzIdent, pTrm) --- (string2formsAndTerm)
import GF.API
import GF.System.Arch (fetchCommand)

import Data.Char (isDigit, isSpace)
import System.IO.Error

-- parsing GF shell commands. AR 11/11/2001

-- | getting a sequence of command lines as input
getCommandLines :: IO (String,[CommandLine])
getCommandLines = do
  s <- fetchCommand "> "
  return (s,pCommandLines s)

getCommandLinesBatch :: IO (String,[CommandLine])
getCommandLinesBatch = do
  s <- catch getLine (\e -> if isEOFError e then return "q" else ioError e)
  return $ (s,pCommandLines s)

pCommandLines :: String -> [CommandLine]
pCommandLines = map pCommandLine . concatMap (chunks ";;" . wordsLits) . lines

-- | Like 'words', but does not split on whitespace inside
--   double quotes.
wordsLits :: String -> [String]
wordsLits [] = []
wordsLits (c:cs) | isSpace c = wordsLits (dropWhile isSpace cs)
		 | c == '\'' || c == '"' 
		     = let (l,rs) = break (==c) cs
			   rs' = drop 1 rs
			   in ([c]++l++[c]):wordsLits rs'
		 | otherwise = let (w,rs) = break isSpace cs
				   in (c:w):wordsLits rs

-- | Remove single or double quotes around a string
unquote :: String -> String
unquote (x:xs@(_:_)) | x `elem` "\"'" && x == last xs = init xs
unquote s = s

pCommandLine :: [String] -> CommandLine
pCommandLine s = pFirst (chks s) where
  pFirst cos = case cos of
    (c,os,[a]) : cs -> ((c,os), a, pCont cs)
    _               -> ((CVoid,noOptions), AError "no parse", [])
  pCont cos = case cos of
    (c,os,_)   : cs -> (c,os) : pCont cs
    _               -> []
  chks = map pCommandOpt . chunks "|"

pCommandOpt :: [String] -> (Command, Options, [CommandArg])
pCommandOpt (w:ws) = let 
  (os, co)     = getOptions "-" ws
  (comm, args) = pCommand (abbrevCommand w:co)
  in
  (comm, os, args)
pCommandOpt s = (CVoid, noOptions, [AError "no parse"])

pInputString :: String -> [CommandArg]
pInputString s = case s of
  ('"':_:_) -> [AString (init (tail s))]
  _         -> [AError "illegal string"]

-- | command @rl@ can be written @remove_language@ etc.
abbrevCommand :: String -> String
abbrevCommand = hds . words . map u2sp where
  u2sp c = if c=='_' then ' ' else c
  hds s = case s of
    [w@[_,_]] -> w
    _ -> map head s

pCommand :: [String] -> (Command, [CommandArg])
pCommand ws = case ws of

  "i"  : f : [] -> aUnit   (CImport (unquote f))
  "rl" : l : [] -> aUnit   (CRemoveLanguage (language l))
  "e"  : []     -> aUnit   CEmptyState
  "cm" : a : [] -> aUnit   (CChangeMain (Just (pzIdent a)))
  "cm" : []     -> aUnit   (CChangeMain Nothing)
  "s"  : []     -> aUnit   CStripState
  "tg" : f : [] -> aUnit   (CTransformGrammar f)
  "cl" : f : [] -> aUnit   (CConvertLatex f)

  "ph" : []     -> aUnit   CPrintHistory

  "l"  : s      -> aTermLi CLinearize s

  "p"  : s      -> aString CParse s
  "t"  : i:o: s -> aString (CTranslate (language i) (language o)) s
  "gr" : []     -> aUnit   CGenerateRandom
  "gr" : t      -> aTerm   CGenerateRandom t
  "gt" : []     -> aUnit   CGenerateTrees
  "gt" : t      -> aTerm   CGenerateTrees t
  "pt" : s      -> aTerm   CPutTerm s
  "wt" : f : s  -> aTerm   (CWrapTerm (pzIdent f)) s
  "ma" : s      -> aString CMorphoAnalyse s
  "tt" : s      -> aString CTestTokenizer s
  "cc" : s      -> aUnit   $ CComputeConcrete $ unwords s
  "so" : s      -> aUnit   $ CShowOpers $ unwords s

  "tq" : i:o:[] -> aUnit   (CTranslationQuiz (language i) (language o))
  "tl":i:o:[]   -> aUnit   (CTranslationList (language i) (language o))
  "mq" : []     -> aUnit   CMorphoQuiz
  "ml" : []     -> aUnit   CMorphoList

  "wf" : f : s  -> aString (CWriteFile (unquote f)) s
  "af" : f : s  -> aString (CAppendFile (unquote f)) s
  "rf" : f : [] -> aUnit   (CReadFile (unquote f))
  "sa" : s      -> aString CSpeakAloud s
  "ps" : s      -> aString CPutString s
  "st" : s      -> aTerm   CShowTerm s
  "!"  : s      -> aUnit   (CSystemCommand (unwords s))
  "sc" : s      -> aUnit   (CSystemCommand (unwords s))
  
  "sf" : l : [] -> aUnit (CSetLocalFlag (language l))
  "sf" : []     -> aUnit CSetFlag

  "pg" : []     -> aUnit CPrintGrammar
  "pi" : c : [] -> aUnit $ CPrintInformation (pzIdent c)

  "pj"  : []     -> aUnit CPrintGramlet
  "pxs" : []     -> aUnit CPrintCanonXMLStruct
  "px"  : []     -> aUnit CPrintCanonXML
  "pm"  : []     -> aUnit CPrintMultiGrammar
  "vg"  : []     -> aUnit CShowGrammarGraph
  "vt"  : s      -> aTerm CShowTreeGraph s
  "sg"  : []     -> aUnit CPrintSourceGrammar
  "po"  : []     -> aUnit CPrintGlobalOptions
  "pl"  : []     -> aUnit CPrintLanguages
  "h"   : c : [] -> aUnit $ CHelp (Just (abbrevCommand c))
  "h"   : []     -> aUnit $ CHelp Nothing

  "q"  : []     -> aImpure ICQuit
  "eh" : f : [] -> aImpure (ICExecuteHistory f)
  n    : [] | all isDigit n -> aImpure (ICEarlierCommand (readIntArg n))

  "es" : []     -> aImpure ICEditSession
  "ts" : []     -> aImpure ICTranslateSession

  _             -> (CVoid, [])

 where
   aString c ss = (c, pInputString (unwords ss))
   aTerm c ss   = (c, [ASTrm $ unwords ss]) ---- [ASTrms [s2t (unwords ss)]])
   aUnit c      = (c, [AUnit])
   aImpure      = aUnit . CImpure

   aTermLi c ss = (c [], [ASTrm $ unwords ss])
   ---- (c forms, [ASTrms [term]]) where
   ----  (forms,term) = ([], s2t (unwords ss)) ---- string2formsAndTerm (unwords ss)
