module PShell where

import Operations
import UseIO
import ShellState
import Shell
import Option
import PGrammar (pzIdent, pTrm) --- (string2formsAndTerm)
import API
import Arch(fetchCommand)
import Char (isDigit)

-- parsing GF shell commands. AR 11/11/2001

-- getting a sequence of command lines as input

getCommandLines :: IO (String,[CommandLine])
getCommandLines = do
  s <- fetchCommand "> "
  return (s,pCommandLines s)

pCommandLines :: String -> [CommandLine]
pCommandLines = map pCommandLine . concatMap (chunks ";;" . words) . lines

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

-- command rl can be written remove_language etc.

abbrevCommand :: String -> String
abbrevCommand = hds . words . map u2sp where
  u2sp c = if c=='_' then ' ' else c
  hds s = case s of
    [w@[_,_]] -> w
    _ -> map head s

pCommand :: [String] -> (Command, [CommandArg])
pCommand ws = case ws of

  "i"  : f : [] -> aUnit   (CImport f)
  "rl" : l : [] -> aUnit   (CRemoveLanguage (language l))
  "e"  : []     -> aUnit   CEmptyState
  "s"  : []     -> aUnit   CStripState
  "tg" : f : [] -> aUnit   (CTransformGrammar f)
  "cl" : f : [] -> aUnit   (CConvertLatex f)

  "ph" : []     -> aUnit   CPrintHistory

  "l"  : s      -> aTermLi CLinearize s

  "p"  : s      -> aString CParse s
  "t"  : i:o: s -> aString (CTranslate (language i) (language o)) s
  "gr" : []     -> aUnit   (CGenerateRandom 1)
  "gt" : t      -> aTerm   (CGenerateRandom 1) t
---  "gr" : n : [] -> aUnit   (CGenerateRandom (readIntArg n)) -- deprecated 12/5/2001
  "pt" : s      -> aTerm   CPutTerm s
-----  "wt" : f : s  -> aTerm   (CWrapTerm (string2id f)) s
  "ma" : s      -> aString CMorphoAnalyse s
  "tt" : s      -> aString CTestTokenizer s
  "cc" : s      -> aUnit   $ CComputeConcrete $ unwords s

  "tq" : i:o:[] -> aUnit   (CTranslationQuiz (language i) (language o))
  "tl":i:o:n:[] -> aUnit   (CTranslationList (language i) (language o) (readIntArg n))
  "mq" : []     -> aUnit   CMorphoQuiz
  "ml" : n : [] -> aUnit   (CMorphoList (readIntArg n))

  "wf" : f : s  -> aString (CWriteFile f) s
  "af" : f : s  -> aString (CAppendFile f) s
  "rf" : f : [] -> aUnit   (CReadFile f)
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
