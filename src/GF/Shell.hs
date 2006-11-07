----------------------------------------------------------------------
-- |
-- Module      : Shell
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/07 20:15:05 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.50 $
--
-- GF shell command interpreter.
-----------------------------------------------------------------------------

module GF.Shell where

--- abstract away from these?
import GF.Data.Str
import qualified GF.Grammar.Grammar as G
import qualified GF.Infra.Ident as I
import qualified GF.Grammar.Compute as Co
import qualified GF.Compile.CheckGrammar as Ch
import qualified GF.Grammar.Lookup as L
import qualified GF.Canon.GFC as GFC
import qualified GF.Canon.Look as Look
import qualified GF.Canon.CMacros as CMacros
import qualified GF.Grammar.MMacros as MMacros
import qualified GF.Compile.GrammarToCanon as GrammarToCanon
import GF.Grammar.Values
import GF.UseGrammar.GetTree
import GF.UseGrammar.Generate (generateAll) ---- should be in API
import GF.UseGrammar.Treebank

import GF.Shell.ShellCommands

import GF.Visualization.VisualizeGrammar (visualizeCanonGrammar, visualizeSourceGrammar)
import GF.Visualization.VisualizeTree (visualizeTrees)
import GF.API
import GF.API.IOGrammar
import GF.Compile.Compile
---- import GFTex
import GF.Shell.TeachYourself -- also a subshell

import GF.UseGrammar.Randomized ---
import GF.UseGrammar.Editing (goFirstMeta) ---

import GF.Probabilistic.Probabilistic

import GF.Compile.ShellState
import GF.Infra.Option
import GF.UseGrammar.Information
import GF.Shell.HelpFile
import GF.Compile.PrOld
import GF.Compile.Wordlist
import GF.Grammar.PrGrammar

import Control.Monad (foldM,liftM)
import System (system)
import System.IO (hPutStrLn, stderr)
import System.Random (newStdGen) ----
import Data.List (nub,isPrefixOf)
import GF.Data.Zipper ----

import GF.Data.Operations
import GF.Infra.UseIO
import GF.Text.UTF8 (encodeUTF8)
import Data.Char (isDigit)
import Data.Maybe (fromMaybe)

import GF.System.Signal (runInterruptibly)
import System.Exit (exitFailure)

---- import qualified GrammarToGramlet as Gr
---- import qualified GrammarToCanonXML2 as Canon

-- AR 18/4/2000 - 7/11/2001

-- data Command moved to ShellCommands. AR 27/5/2004

type CommandLine = (CommandOpt, CommandArg,  [CommandOpt])

-- | term as returned by the command parser
type SrcTerm = G.Term 

-- | history & CPU
type HState  = (ShellState,([String],Integer,ShMacros,ShTerms)) 

type ShMacros = [(String,[String])] -- dc %c = ... #1 ... #2 ...
type ShTerms  = [(String,Tree)]     -- dt $e = f ...

type ShellIO = (HState, CommandArg) -> IO (HState, CommandArg)

initHState :: ShellState -> HState
initHState st = (st,([],0,[],[]))

cpuHState :: HState -> Integer
cpuHState (_,(_,i,_,_)) = i

optsHState :: HState -> Options
optsHState (st,_) = globalOptions st

putHStateCPU :: Integer -> HState -> HState
putHStateCPU cpu (st,(h,_,c,t)) = (st,(h,cpu,c,t))

updateHistory :: String -> HState -> HState
updateHistory s (st,(h,cpu,c,t)) = (st,(s:h,cpu,c,t))

addShMacro :: (String,[String]) -> HState -> HState
addShMacro m (st,(h,cpu,c,t)) = (st,(h,cpu,m:c,t))

addShTerm :: (String,Tree) -> HState -> HState
addShTerm m (st,(h,cpu,c,t)) = (st,(h,cpu,c,m:t))

resolveShMacro :: HState -> String -> [String] -> [String]
resolveShMacro st@(_,(_,_,cs,_)) c args = case lookup c cs of
  Just def -> map subst def
  _ -> [] ----
 where
   subst s = case s of
     "#1" -> unwords args
     _ -> s
 --- so far only one arg allowed - how to determine arg boundaries?
{-
   subst s = case s of
     '#':d@(_:_) | all isDigit d -> 
        let i = read d in if i > lg then s else args !! (i-1) -- #1 is first
     _ -> s
   lg = length args
-}

lookupShTerm :: HState -> String -> Maybe Tree
lookupShTerm st@(_,(_,_,_,ts)) c = lookup c ts

txtHelpMacros :: HState -> String
txtHelpMacros (_,(_,_,cs,ts)) = unlines $
  ["Defined commands:",""] ++
  [c +++ "=" +++ unwords def | (c,def) <- cs] ++
  ["","Defined terms:",""] ++
  [c +++ "=" +++ prt_ def | (c,def) <- ts]

-- | empty command if index over
earlierCommandH :: HState -> Int -> String
earlierCommandH (_,(h,_,_,_)) = ((h ++ repeat "") !!) 

execLinesH :: String -> [CommandLine] -> HState -> IO HState
execLinesH s cs hst@(st, (h,_,_,_)) = do
  (_,st') <- execLinesI True cs hst
  cpu     <- prOptCPU (optsHState st') (cpuHState hst)
  return $ putHStateCPU cpu $ updateHistory s st'

-- | Like 'execLines', but can be interrupted by SIGINT.
execLinesI :: Bool -> [CommandLine] -> HState -> IO ([String],HState)
execLinesI put cs st = 
    do
    x <- runInterruptibly (execLines put cs st)
    case x of
           Left ex -> do hPutStrLn stderr ""
                         hPutStrLn stderr $ show ex
                         return ([],st)
           Right y -> return y

ifImpure :: [CommandLine] -> Maybe (ImpureCommand,Options)
ifImpure cls = foldr (const . Just) Nothing [(c,os) | ((CImpure c,os),_,_) <- cls]

-- | the main function: execution of commands. 'put :: Bool' forces immediate output
--
-- command line with consecutive (;) commands: no value transmitted
execLines :: Bool -> [CommandLine] -> HState -> IO ([String],HState)
execLines put cs st = foldM (flip (execLine put)) ([],st) cs

-- | command line with piped (|) commands: no value returned
execLine :: Bool -> CommandLine -> ([String],HState) -> IO ([String],HState)
execLine put (c@(co, os), arg, cs) (outps,st) = do
  (st',val) <- execC c (st, arg)
  let tr = oElem doTrace os || null cs    -- option -tr leaves trace in pipe
      make = oElem (iOpt "make") os
      isErr = case arg of 
                AError _ -> True
                _ -> False
      utf = if (oElem useUTF8 os) then encodeUTF8 else id 
      outp = if tr then [utf (prCommandArg val)] else []
  if put then mapM_ putStrLnFlush outp else return ()
  if make && isErr
    then exitFailure
    else execs cs val (if put then [] else outps ++ outp, st')
 where
    execs []     arg st = return st
    execs (c:cs) arg st = execLine put (c, arg, cs) st

-- | individual commands possibly piped: value returned; this is not a state monad
execC :: CommandOpt -> ShellIO
execC co@(comm, opts0) sa@(sh@(st,(h,_,_,_)),a) = checkOptions st co >> case comm of

  CImport file | fileSuffix file == "gfwl" -> do
    fs <- mkWordlist file
    foldM (\x y -> execC (CImport y, opts) x) sa fs

  CImport file | oElem fromExamples opts -> do
    es <- liftM nub $ getGFEFiles opts file
    system $ "gf -examples" +++ unlines es
    execC (comm, removeOption fromExamples opts) sa
  CImport file -> useIOE sa $ do
    st1 <- shellStateFromFiles opts st file
    ioeIO $ changeState (const st1) sa --- \ ((_,h),a) -> ((st,h), a))

  CEmptyState    -> changeState reinitShellState sa
  CChangeMain ma -> changeStateErr (changeMain ma) sa
  CStripState    -> changeState purgeShellState sa

  CRemoveLanguage lan -> changeState (removeLang lan) sa
{-
  CTransformGrammar file -> do
    s <- transformGrammarFile opts file
    returnArg (AString s) sa
  CConvertLatex file -> do
    s <- readFileIf file
    returnArg (AString (convertGFTex s)) sa 
-}
  CPrintHistory -> (returnArg $ AString $ unlines $ reverse h) sa
  -- good to have here for piping; eh and ec must be done on outer level

  CDefineCommand c args -> return (addShMacro (c,args) sh, AUnit)
  CDefineTerm c -> do 
    let 
      a' = case a of
        ASTrm _ -> s2t a
        AString _ -> s2t a
        _ -> a
    case a' of
      ATrms [trm] -> return (addShTerm (c,trm) sh, AUnit) 
      _ ->  returnArg (AError "illegal term definition") sa

  CLinearize [] 
    | oElem showMulti opts -> 

       changeArg (opTS2CommandArg (
         unlines . 
         (\t -> [optLinearizeTreeVal opts gr t | gr <- allStateGrammars st])) . s2t) sa

    | otherwise -> changeArg (opTS2CommandArg (optLinearizeTreeVal opts gro) . s2t) sa
----  CLinearize m -> changeArg (opTS2CommandArg (optLinearizeArgForm opts gro m)) sa

  CParse 
----    | oElem showMulti opts -> do
    | oElem byLines opts -> do
        let ss = (if oElem showAll opts then id else filter (not . null)) $ 
                     lines $ prCommandArg a
        mts <- mapM parse ss
        let mark s ts = case ts of
              [] -> [MMacros.uTree] -- to leave a trace of unparsed line
              _  -> ts
        let a' = ATrms [t | (s,(_,ATrms ts)) <- zip ss mts, t <- mark s ts]
        changeArg (const a') sa
    | otherwise -> parse $ prCommandArg a
   where 
      parse x = do
       warnDiscont opts 
       let p = optParseArgErrMsg opts gro x
       case p of
         Ok (ts,msg) 
           | oElem (iOpt "fail") opts && null ts -> do
                putStrLnFlush ("#FAIL:" +++ x) >> changeArg (const $ ATrms ts) sa
           | oElem (iOpt "ambiguous") opts && length ts > 1 -> do
                putStrLnFlush ("#AMBIGUOUS:" +++ x) >> changeArg (const $ ATrms ts) sa
           | oElem (iOpt "prob") opts -> do
                let probs = stateProbs gro 
                let tps = rankByScore [(t,computeProbTree probs t) | t <- ts]
                putStrLnFlush msg
                mapM_ putStrLnFlush [show p | (t,p) <- tps]
                changeArg (const $ ATrms (map fst tps)) sa
           | otherwise -> putStrLnFlush msg >> changeArg (const $ ATrms ts) sa
         Bad msg -> changeArg (const $ AError (msg +++ "input" +++ x)) sa

  CTranslate il ol -> do
    let a' = opST2CommandArg (optParseArgErr opts (sgr il)) a
    returnArg (opTS2CommandArg (optLinearizeTreeVal opts (sgr ol)) a') sa

  CGenerateRandom | oElem showCF opts || oElem (iOpt "prob") opts -> do
    let probs = stateProbs gro 
    let cat = firstAbsCat opts gro
    let n = optIntOrN opts flagNumber 1
    gen    <- newStdGen
    let ts = take n $ generateRandomTreesProb opts gen cgr probs cat
    returnArg (ATrms (map (term2tree gro) ts)) sa

  CGenerateRandom -> do
    let 
      a' = case a of
        ASTrm _ -> s2t a
        AString _ -> s2t a
        _ -> a
    case a' of
      ATrms (trm:_) -> case tree2exp trm of
        G.EInt _ -> do
          putStrLn "Warning: Number argument deprecated, use gr -number=n instead"
          ts <- randomTreesIO opts gro (optIntOrN opts flagNumber 1)
          returnArg (ATrms ts) sa
        _ -> do
            g    <- newStdGen
            case (goFirstMeta (tree2loc trm) >>= refineRandom g 41 cgr) of
              Ok trm' -> returnArg (ATrms [loc2tree trm']) sa
              Bad s   -> returnArg (AError s) sa
      _ -> do
        ts <- randomTreesIO opts gro (optIntOrN opts flagNumber 1)
        returnArg (ATrms ts) sa

  CGenerateTrees | oElem showAll opts -> do
    let 
      cat = firstAbsCat opts gro
      outp 
       | oElem (iOpt "lin") opts = optLinearizeTreeVal opts gro . term2tree gro
       | otherwise = prt_
    justOutput opts (generateAll opts (putStrLn . outp) cgr cat) sa
  CGenerateTrees -> do
    let 
      a' = case a of
        ASTrm _ -> s2t a
        AString _ -> s2t a
        _ -> a
      mt = case a' of
        ATrms (tr:_) -> Just tr
        _ -> Nothing
    returnArg (ATrms $ generateTrees opts gro mt) sa

  CTreeBank | oElem doCompute opts -> do -- -c
    let bank = prCommandArg a
    returnArg (AString $ unlines $ testMultiTreebank opts st bank) sa
  CTreeBank | oElem getTrees opts -> do -- -trees
    let bank  = prCommandArg a
        tes   = map (string2treeErr gro) $ treesTreebank opts bank
        terms = [t | Ok t <- tes] 
    returnArg (ATrms terms) sa
  CTreeBank -> do
    let ts = strees $ s2t $ snd sa
        comm = "command" ----
    returnArg (AString $ unlines $ mkMultiTreebank opts st comm ts) sa

  CLookupTreebank -> do
    let tbs = treebanks st
    let s   = prCommandArg a
    if null tbs 
      then returnArg (AError "no treebank") sa
      else do
        let tbi = maybe (fst $ head tbs) I.identC (getOptVal opts (aOpt "treebank"))
        case lookup tbi tbs of
          Nothing -> returnArg (AError ("no treebank" +++ prt tbi)) sa
          Just tb -> case () of
            _ | oElem (iOpt "strings") opts -> do
              returnArg (AString $ unlines $ map fst $ assocsTreebank tb) sa
            _ | oElem (iOpt "raw") opts -> do
              returnArg (AString $ unlines $ lookupTreebank tb s) sa
            _ | oElem (iOpt "assocs") opts -> do
              returnArg (AString $ unlines $ map printAssoc $ assocsTreebank tb) sa
            _ | oElem (iOpt "trees") opts -> do
              returnArg (ATrms $ str2trees $ concatMap snd $ assocsTreebank tb) sa
            _ -> do            
              let tes = map (string2treeErr gro) $ lookupTreebank tb s
                  terms = [t | Ok t <- tes]
              returnArg (ATrms terms) sa

  CShowTreeGraph | oElem emitCode opts -> do -- -o
    returnArg (AString $ visualizeTrees opts $ strees $ s2t a) sa
  CShowTreeGraph  -> do
    let g0 = writeFile "grphtmp.dot" $ visualizeTrees opts $ strees $ s2t a
        g1 = system "dot -Tps grphtmp.dot >grphtmp.ps" 
        g2 = system "gv grphtmp.ps &" 
        g3 = return () ---- system "rm -f grphtmp.*"
    justOutput opts (g0 >> g1 >> g2 >> g3 >> return ()) sa

  CPutTerm -> changeArg (opTT2CommandArg (return . optTermCommand opts gro) . s2t) sa

  CWrapTerm f -> changeArg (opTT2CommandArg (return . return . wrapByFun opts gro f) . s2t) sa
  CApplyTransfer f -> changeArg (opTT2CommandArg (applyTransfer opts gro transfs f) . s2t) sa
  CMorphoAnalyse -> changeArg (AString . morphoAnalyse opts gro . prCommandArg) sa
  CTestTokenizer -> changeArg (AString . optTokenizer opts gro . prCommandArg) sa

  CComputeConcrete t -> do
    m <- return $
         maybe (I.identC "?") id $  -- meaningful if no opers in t 
           maybe (resourceOfShellState st) (return . I.identC) $ -- topmost res
             getOptVal opts useResource             -- flag -res=m
    justOutput opts (putStrLn (err id (prt . stripTerm) (
                string2srcTerm src m t >>= 
                Ch.justCheckLTerm src  >>=
                Co.computeConcrete src))) sa
---                Co.computeConcreteRec src))) sa
  CShowOpers t -> do
    m <- return $
         maybe (I.identC "?") id $  -- meaningful if no opers in t 
           maybe (resourceOfShellState st) (return . I.identC) $ -- topmost res
             getOptVal opts useResource             -- flag -res=m
    justOutput opts (putStrLn (err id (unlines . map prOperSignature) (
                string2srcTerm src m t >>= (\t' -> 
                Co.computeConcrete src t' >>=  (\v -> 
                return (L.opersForType src t' v)))))) sa


  CTranslationQuiz il ol -> do
    warnDiscont opts 
    justOutput opts (teachTranslation opts (sgr il) (sgr ol)) sa
  CTranslationList il ol -> do
    warnDiscont opts
    let n = optIntOrN opts flagNumber 10 
    qs <- transTrainList opts (sgr il) (sgr ol) (toInteger n)
    let hdr = unlines ["# From: " ++ prIdent il,
                       "# To: " ++ prIdent ol]
    returnArg (AString $ hdr ++++ foldr (+++++) [] [unlines (s:ss) | (s,ss) <- qs]) sa

  CMorphoQuiz -> do
    warnDiscont opts 
    justOutput opts (teachMorpho opts gro) sa
  CMorphoList -> do
    let n = optIntOrN opts flagNumber 10  
    warnDiscont opts 
    qs <- useIOE [] $ morphoTrainList opts gro (toInteger n)
    returnArg (AString $ foldr (+++++) [] [unlines (s:ss) | (s,ss) <- qs]) sa

  CReadFile file   -> returnArgIO   (readFileIf file >>= return . AString) sa
  CWriteFile file  -> justOutputArg opts (writeFile file) sa
  CAppendFile file -> justOutputArg opts (appendFile file) sa
  CSpeakAloud      -> justOutputArg opts (speechGenerate opts) sa
  CSpeechInput     -> returnArgIO (speechInput opts gro >>= return . AString . unlines) sa
  CSystemCommand s -> case a of
    AUnit -> justOutput opts (system s >> return ()) sa
    _     -> systemArg  opts a s sa 
  CPutString       -> changeArg    (opSS2CommandArg (optStringCommand opts gro)) sa
-----  CShowTerm        -> changeArg  (opTS2CommandArg (optPrintTerm opts gro) . s2t) sa
  CGrep ms -> changeArg (AString . unlines . filter (grep ms) . lines . prCommandArg) sa


  CSetFlag           -> changeState (addGlobalOptions opts0) sa
---- deprec!  CSetLocalFlag lang -> changeState (addLocalOptions lang opts0) sa

  CHelp (Just c) -> returnArg   (AString (txtHelpCommand c)) sa
  CHelp _ -> case opts0 of
    Opts [o] | o == showAll  -> returnArg   (AString txtHelpFile) sa
    Opts [o] | o == showDefs -> returnArg   (AString (txtHelpMacros sh)) sa
    Opts [o]        -> returnArg   (AString (txtHelpCommand ('-':prOpt o))) sa
    _               -> returnArg   (AString txtHelpFileSummary) sa

  CPrintGrammar       -> returnArg (AString (optPrintGrammar opts gro)) sa
  CPrintGlobalOptions -> justOutput opts (putStrLn  $ prShellStateInfo st) sa
  CPrintInformation c -> justOutput opts (useIOE () $ showInformation opts st c) sa
  CPrintLanguages     -> justOutput opts 
                         (putStrLn $ unwords $ map prLanguage $ allLanguages st) sa
  CPrintMultiGrammar  -> do
    let cgr' = canModules $ purgeShellState st
    returnArg (AString (optPrintMultiGrammar opts cgr')) sa
  CShowGrammarGraph  -> do
    ---- sa' <- changeState purgeShellState sa
    let g0 = writeFile "grphtmp.dot" $ visualizeCanonGrammar opts cgr
        g1 = system "dot -Tps grphtmp.dot >grphtmp.ps" 
        g2 = system "gv grphtmp.ps &" 
        g3 = return () ---- system "rm -f grphtmp.*"
    justOutput opts (g0 >> g1 >> g2 >> g3 >> return ()) sa
  CPrintSourceGrammar -> 
      returnArg (AString (visualizeSourceGrammar src)) sa

----  CPrintGramlet       -> returnArg (AString (Gr.prGramlet st)) sa
----  CPrintCanonXML      -> returnArg (AString (Canon.prCanonXML st False)) sa
----  CPrintCanonXMLStruct -> returnArg (AString (Canon.prCanonXML st True)) sa
  _ -> justOutput opts (putStrLn "command not understood") sa

 where
   sgr = stateGrammarOfLang st
   gro = grammarOfOptState opts st
   opts = addOptions opts0 (globalOptions st)
   src = srcModules st
   cgr = canModules st

   transfs = transfers st

   s2t a = case a of
     ASTrm ('$':c) -> maybe (AError "undefined term") (ATrms . return) $ lookupShTerm sh c
     ASTrm s  -> err AError (ATrms . return) $ string2treeErr gro s
     AString s  -> err AError (ATrms . return) $ string2treeErr gro s
     _ -> a

   str2trees ts = [t | Ok t <- map (string2treeErr gro) ts]

   strees a = case a of
     ATrms ts -> ts
     _ -> [] 

   warnDiscont os = err putStrLn id $ do
     let c0 = firstAbsCat os gro
     c <- GrammarToCanon.redQIdent c0
     lang <- maybeErr "no concrete" $ languageOfOptState os st
     t <- return $ errVal CMacros.defLinType $ Look.lookupLincat cgr $ CMacros.redirectIdent lang c
     return $ if CMacros.isDiscontinuousCType t 
       then (putStrLn ("Warning: discontinuous category" +++ prt_ c))
       else (return ())

   grep ms s = (if oElem invertGrep opts then not else id) $ grepv ms s --- -v
   grepv ms s = case s of
     _:cs -> isPrefixOf ms s || grepv ms cs
     _ -> isPrefixOf ms s

-- commands either change the state or process the argument, but not both
-- some commands just do output

changeState :: ShellStateOper -> ShellIO
changeState f ((st,h),a) = return ((f st,h), a)

changeStateErr :: ShellStateOperErr -> ShellIO
changeStateErr f ((st,h),a) = case f st of
  Ok st' -> return ((st',h), a)
  Bad s  -> return ((st, h),AError s)

changeArg :: (CommandArg -> CommandArg) -> ShellIO
changeArg f (st,a) = return (st, f a)

changeArgMsg :: (CommandArg -> (CommandArg,String)) -> ShellIO
changeArgMsg f (st,a) = do
  let (b,msg) = f a
  putStrLnFlush msg
  return (st, b)

returnArg :: CommandArg -> ShellIO
returnArg = changeArg . const

returnArgIO :: IO CommandArg -> ShellIO
returnArgIO io (st,_) = io >>= (\a -> return (st,a))

justOutputArg :: Options -> (String -> IO ()) -> ShellIO
justOutputArg opts f sa@(st,a) = f (utf (prCommandArg a)) >> return (st, AUnit) 
 where
   utf = if (oElem useUTF8 opts) then encodeUTF8 else id

justOutput :: Options -> IO () -> ShellIO
justOutput opts = justOutputArg opts . const

systemArg :: Options -> CommandArg -> String -> ShellIO
systemArg _ cont syst sa = do
  writeFile tmpi $ prCommandArg cont
  system $ syst ++ " <" ++ tmpi ++ " >" ++ tmpo 
  s <- readFile tmpo
  returnArg (AString s) sa
 where
   tmpi = "_tmpi" ---
   tmpo = "_tmpo"

-- | type system for command arguments; instead of plain strings...
data CommandArg = 
   AError  String 
 | ATrms   [Tree] 
 | ASTrm   String   -- ^ to receive from parser 
 | AStrs   [Str] 
 | AString String 
 | AUnit 
  deriving (Eq, Show)

prCommandArg :: CommandArg -> String
prCommandArg arg = case arg of
  AError s   -> s
  AStrs ss   -> sstrV ss
  AString s  -> s
  ATrms []   -> "no tree found"
  ATrms tt   -> unlines $ map prt_Tree tt
  ASTrm s    -> s
  AUnit      -> ""

opSS2CommandArg :: (String -> String) -> CommandArg -> CommandArg
opSS2CommandArg f = AString . f . prCommandArg

opST2CommandArg :: (String -> Err [Tree]) -> CommandArg -> CommandArg
opST2CommandArg f = err AError ATrms . f . prCommandArg

opTS2CommandArg :: (Tree -> String) -> CommandArg -> CommandArg
opTS2CommandArg f (ATrms ts) = AString $ unlines $ map f ts
opTS2CommandArg _ (AError s) = AError ("expected term, but got error:" ++++ s)
opTS2CommandArg _ a = AError ("expected term, but got:" ++++ prCommandArg a)

opTT2CommandArg :: (Tree -> Err [Tree]) -> CommandArg -> CommandArg
opTT2CommandArg f (ATrms ts) = err AError (ATrms . concat) $ mapM f ts
opTT2CommandArg _ (AError s) = AError ("expected term, but got error:" ++++ s)
opTT2CommandArg _ a = AError ("expected term, but got:" ++++ prCommandArg a)
