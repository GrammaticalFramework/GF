module Shell where

--- abstract away from these?
import Str
import qualified Grammar as G
import qualified Ident as I
import qualified Compute as Co
import qualified GFC
import Values
import GetTree

import API
import IOGrammar
import Compile
---- import GFTex
import TeachYourself -- also a subshell

import ShellState
import Option
import Information
import HelpFile
import PrOld
import PrGrammar

import Monad (foldM)
import System (system)

import Operations
import UseIO
import UTF8 (encodeUTF8)


---- import qualified GrammarToGramlet as Gr
---- import qualified GrammarToCanonXML2 as Canon

-- AR 18/4/2000 - 7/11/2001

type SrcTerm = G.Term -- term as returned by the command parser

data Command =
   CImport FilePath
 | CRemoveLanguage Language
 | CEmptyState
 | CStripState
 | CTransformGrammar FilePath
 | CConvertLatex FilePath

 | CLinearize [()] ---- parameters
 | CParse
 | CTranslate Language Language
 | CGenerateRandom Int
 | CPutTerm
 | CWrapTerm Ident
 | CMorphoAnalyse
 | CTestTokenizer
 | CComputeConcrete String

 | CTranslationQuiz Language Language
 | CTranslationList Language Language Int
 | CMorphoQuiz
 | CMorphoList Int

 | CReadFile   FilePath
 | CWriteFile  FilePath
 | CAppendFile FilePath
 | CSpeakAloud
 | CPutString
 | CShowTerm
 | CSystemCommand String

 | CSetFlag
 | CSetLocalFlag Language

 | CPrintGrammar
 | CPrintGlobalOptions
 | CPrintLanguages
 | CPrintInformation I.Ident
 | CPrintMultiGrammar
 | CPrintGramlet 
 | CPrintCanonXML
 | CPrintCanonXMLStruct 
 | CPrintHistory
 | CHelp (Maybe String)

 | CImpure ImpureCommand

 | CVoid

-- to isolate the commands that are executed on top level
data ImpureCommand = 
    ICQuit | ICExecuteHistory FilePath | ICEarlierCommand Int
  | ICEditSession | ICTranslateSession

type CommandLine = (CommandOpt, CommandArg,  [CommandOpt])

type CommandOpt = (Command, Options)

type HState  = (ShellState,([String],Integer)) -- history & CPU

type ShellIO = (HState, CommandArg) -> IO (HState, CommandArg)

initHState :: ShellState -> HState
initHState st = (st,([],0))

cpuHState (_,(_,i)) = i
optsHState (st,_) = globalOptions st
putHStateCPU cpu (st,(h,_)) = (st,(h,cpu))
updateHistory s (st,(h,cpu)) = (st,(s:h,cpu))
earlierCommandH (_,(h,_)) = ((h ++ repeat "") !!) -- empty command if index over

execLinesH :: String -> [CommandLine] -> HState -> IO HState
execLinesH s cs hst@(st, (h, _)) = do
  (_,st') <- execLines True cs hst
  cpu     <- prOptCPU (optsHState st') (cpuHState hst)
  return $ putHStateCPU cpu $ updateHistory s st'

ifImpure :: [CommandLine] -> Maybe (ImpureCommand,Options)
ifImpure cls = foldr (const . Just) Nothing [(c,os) | ((CImpure c,os),_,_) <- cls]

-- the main function: execution of commands. put :: Bool forces immediate output

-- command line with consecutive (;) commands: no value transmitted
execLines :: Bool -> [CommandLine] -> HState -> IO ([String],HState)
execLines put cs st = foldM (flip (execLine put)) ([],st) cs

-- command line with piped (|) commands: no value returned
execLine :: Bool -> CommandLine -> ([String],HState) -> IO ([String],HState)
execLine put (c@(co, os), arg, cs) (outps,st) = do
  (st',val) <- execC c (st, arg)
  let tr = oElem doTrace os || null cs    -- option -tr leaves trace in pipe
      utf = if (oElem useUTF8 os) then encodeUTF8 else id 
      outp = if tr then [utf (prCommandArg val)] else []
  if put then mapM_ putStrLnFlush outp else return ()
  execs cs val (if put then [] else outps ++ outp, st')
 where
    execs []     arg st = return st
    execs (c:cs) arg st = execLine put (c, arg, cs) st

-- individual commands possibly piped: value returned; this is not a state monad
execC :: CommandOpt -> ShellIO
execC co@(comm, opts0) sa@((st,(h,_)),a) = case comm of

  CImport file -> useIOE sa $ do
    st1 <- shellStateFromFiles opts st file
    ioeIO $ changeState (const st1) sa --- \ ((_,h),a) -> ((st,h), a))
  CEmptyState         -> changeState reinitShellState sa
  CStripState         -> changeState purgeShellState sa

{-
  CRemoveLanguage lan -> changeState (removeLanguage lan) sa
  CTransformGrammar file -> do
    s <- transformGrammarFile opts file
    returnArg (AString s) sa
  CConvertLatex file -> do
    s <- readFileIf file
    returnArg (AString (convertGFTex s)) sa 
-}
  CPrintHistory -> (returnArg $ AString $ unlines $ reverse h) sa
  -- good to have here for piping; eh and ec must be done on outer level

  CLinearize [] -> changeArg (opTS2CommandArg (optLinearizeTreeVal opts gro) . s2t) sa
----  CLinearize m -> changeArg (opTS2CommandArg (optLinearizeArgForm opts gro m)) sa

  CParse     -> case optParseArgErrMsg opts gro (prCommandArg a) of
    Ok (ts,msg) -> putStrLnFlush msg >> changeArg (const $ ATrms ts) sa
    Bad msg -> changeArg (const $ AError msg) sa

  CTranslate il ol -> do
    let a' = opST2CommandArg (optParseArgErr opts (sgr il)) a
    returnArg (opTS2CommandArg (optLinearizeTreeVal opts (sgr ol)) a') sa
  CGenerateRandom n -> do
    ts <- randomTreesIO opts gro (optIntOrN opts flagNumber n)
    returnArg (ATrms ts) sa
  CPutTerm -> changeArg (opTT2CommandArg (optTermCommand opts gro) . s2t) sa
-----  CWrapTerm f -> changeArg (opTT2CommandArg (return . wrapByFun opts gro f)) sa
  CMorphoAnalyse -> changeArg (AString . morphoAnalyse opts gro . prCommandArg) sa
  CTestTokenizer -> changeArg (AString . optTokenizer opts gro . prCommandArg) sa

  CComputeConcrete t -> do
    m <- return $
         maybe (I.identC "?") id $  -- meaningful if no opers in t 
           maybe (resourceOfShellState st) (return . I.identC) $ -- topmost res
             getOptVal opts useResource             -- flag -res=m
    justOutput (putStrLn (err id (prt . stripTerm) (
                string2srcTerm src m t >>= Co.computeConcrete src))) sa

  CTranslationQuiz il ol -> justOutput (teachTranslation opts (sgr il) (sgr ol)) sa
  CTranslationList il ol n -> do 
    qs <- transTrainList opts (sgr il) (sgr ol) (toInteger n)
    returnArg (AString $ foldr (+++++) [] [unlines (s:ss) | (s,ss) <- qs]) sa

  CMorphoQuiz -> justOutput (teachMorpho opts gro) sa
  CMorphoList n -> do 
    qs <- useIOE [] $ morphoTrainList opts gro (toInteger n)
    returnArg (AString $ foldr (+++++) [] [unlines (s:ss) | (s,ss) <- qs]) sa

  CReadFile file   -> returnArgIO   (readFileIf file >>= return . AString) sa
  CWriteFile file  -> justOutputArg (writeFile file) sa
  CAppendFile file -> justOutputArg (appendFile file) sa
  CSpeakAloud      -> justOutputArg (speechGenerate opts) sa
  CSystemCommand s -> justOutput    (system s >> return ()) sa
  CPutString       -> changeArg    (opSS2CommandArg (optStringCommand opts gro)) sa
-----  CShowTerm        -> changeArg  (opTS2CommandArg (optPrintTerm opts gro) . s2t) sa

  CSetFlag           -> changeState (addGlobalOptions opts0) sa
---- deprec!  CSetLocalFlag lang -> changeState (addLocalOptions lang opts0) sa

  CHelp (Just c) -> returnArg   (AString (txtHelpCommand c)) sa
  CHelp _
    | oElem showAll opts  -> returnArg   (AString txtHelpFile) sa
    | otherwise           -> returnArg   (AString txtHelpFileSummary) sa

  CPrintGrammar
    | oElem showOld opts -> returnArg (AString $ printGrammarOld (canModules st)) sa
    | otherwise -> returnArg (AString (optPrintGrammar opts gro)) sa
  CPrintGlobalOptions -> justOutput (putStrLn $ prShellStateInfo st) sa
  CPrintInformation c -> justOutput (useIOE () $ showInformation opts st c) sa
  CPrintLanguages     -> justOutput 
                         (putStrLn $ unwords $ map prLanguage $ allLanguages st) sa
  CPrintMultiGrammar  -> do
    sa' <- changeState purgeShellState sa
    returnArg (AString (prCanonGrammar (canModules st))) sa'

----  CPrintGramlet       -> returnArg (AString (Gr.prGramlet st)) sa
----  CPrintCanonXML      -> returnArg (AString (Canon.prCanonXML st False)) sa
----  CPrintCanonXMLStruct -> returnArg (AString (Canon.prCanonXML st True)) sa
  _ -> justOutput (putStrLn "command not understood") sa

 where
   sgr = stateGrammarOfLang st
   gro = grammarOfOptState opts st
   opts = addOptions opts0 (globalOptions st)
   src = srcModules st

   s2t a = case a of
     ASTrm s  -> err AError (ATrms . return) $ string2treeErr gro s
     _ -> a


-- commands either change the state or process the argument, but not both
-- some commands just do output

changeState :: ShellStateOper -> ShellIO
changeState f ((st,h),a) = return ((f st,h), a)

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

justOutputArg :: (String -> IO ()) -> ShellIO
justOutputArg f sa@(st,a) = f (prCommandArg a) >> return (st, AUnit)

justOutput :: IO () -> ShellIO
justOutput = justOutputArg . const

-- type system for command arguments; instead of plain strings...

data CommandArg = 
   AError  String 
 | ATrms   [Tree] 
 | ASTrm   String   -- to receive from parser 
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

opTT2CommandArg :: (Tree -> [Tree]) -> CommandArg -> CommandArg
opTT2CommandArg f (ATrms ts) = ATrms $ concat $ map f ts
opTT2CommandArg _ (AError s) = AError ("expected term, but got error:" ++++ s)
opTT2CommandArg _ a = AError ("expected term, but got:" ++++ prCommandArg a)
