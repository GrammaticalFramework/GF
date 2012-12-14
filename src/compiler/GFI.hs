{-# LANGUAGE ScopedTypeVariables, CPP #-}
-- | GF interactive mode
module GFI (mainGFI,mainRunGFI,mainServerGFI) where
import Prelude hiding (putStrLn,print)
import qualified Prelude as P(putStrLn)
import GF.Command.Interpreter(CommandEnv(..),commands,mkCommandEnv,emptyCommandEnv,interpretCommandLine)
--import GF.Command.Importing(importSource,importGrammar)
import GF.Command.Commands(flags,options)
import GF.Command.Abstract
import GF.Command.Parse(readCommandLine,pCommand)
import GF.Data.ErrM
import GF.Data.Operations (chunks,err)
import GF.Grammar hiding (Ident)
import GF.Grammar.Analyse
import GF.Grammar.Parser (runP, pExp)
import GF.Grammar.Printer (ppGrammar, ppModule)
import GF.Grammar.ShowTerm
import GF.Grammar.Lookup (allOpers,allOpersTo)
import GF.Compile.Rename(renameSourceTerm)
import GF.Compile.Compute.Concrete (computeConcrete,checkPredefError)
import qualified GF.Compile.Compute.ConcreteNew as CN(normalForm,resourceValues)
import GF.Compile.TypeCheck.Concrete (inferLType,ppType)
import GF.Infra.Dependencies(depGraph)
import GF.Infra.CheckM
import GF.Infra.UseIO(ioErrorText)
import GF.Infra.SIO
import GF.Infra.Option
import GF.Infra.Ident (showIdent)
import qualified System.Console.Haskeline as Haskeline
import GF.Text.Coding(decodeUnicode,encodeUnicode)

import GF.Compile.Coding(codeTerm)

import PGF
import PGF.Data
import PGF.Macros

import Data.Char
import Data.Maybe
import Data.List(nub,isPrefixOf,isInfixOf,partition)
import qualified Data.Map as Map
import qualified Data.ByteString.Char8 as BS
import qualified Text.ParserCombinators.ReadP as RP
import System.IO(utf8)
--import System.CPUTime(getCPUTime)
import System.Directory({-getCurrentDirectory,-}getAppUserDataDirectory)
import Control.Exception(SomeException,fromException,evaluate,try)
import Control.Monad
import Text.PrettyPrint (render)
import qualified GF.System.Signal as IO(runInterruptibly)
#ifdef SERVER_MODE
import GFServer(server)
#endif
import GF.System.Console(changeConsoleEncoding)

import GF.Infra.BuildInfo(buildInfo)
import Data.Version(showVersion)
import Paths_gf(version)

mainRunGFI :: Options -> [FilePath] -> IO ()
mainRunGFI opts files = shell (beQuiet opts) files

beQuiet = addOptions (modifyFlags (\f -> f{optVerbosity=Quiet}))

mainGFI :: Options -> [FilePath] -> IO ()
mainGFI opts files = do
  P.putStrLn welcome
  shell opts files

shell opts files = loop opts =<< runSIO (importInEnv emptyGFEnv opts files)

#ifdef SERVER_MODE
mainServerGFI opts0 port files =
    server port root (execute1 opts)
      =<< runSIO (importInEnv emptyGFEnv opts files)
  where
    root = flag optDocumentRoot opts
    opts = beQuiet opts0
#else
mainServerGFI opts files =
  error "GF has not been compiled with server mode support"
#endif

-- | Read end execute commands until it is time to quit
loop :: Options -> GFEnv -> IO ()
loop opts gfenv = maybe (return ()) (loop opts) =<< readAndExecute1 opts gfenv

-- | Read and execute one command, returning Just an updated environment for
-- | the next command, or Nothing when it is time to quit
readAndExecute1 :: Options -> GFEnv -> IO (Maybe GFEnv)
readAndExecute1 opts gfenv =
    runSIO . execute1 opts gfenv =<< readCommand opts gfenv

-- | Read a command
readCommand :: Options -> GFEnv -> IO String
readCommand opts gfenv0 =
    case flag optMode opts of
      ModeRun -> tryGetLine
      _       -> fetchCommand gfenv0

-- | Optionally show how much CPU time was used to run an IO action
optionallyShowCPUTime :: Options -> SIO a -> SIO a
optionallyShowCPUTime opts act 
  | not (verbAtLeast opts Normal) = act
  | otherwise = do t0 <- getCPUTime
                   r <- act
                   t1 <- getCPUTime
                   let dt = t1-t0
                   putStrLnFlush $ show (dt `div` 1000000000) ++ " msec"
                   return r

{-
loopOptNewCPU opts gfenv' 
 | not (verbAtLeast opts Normal) = return gfenv'
 | otherwise = do 
     cpu' <- getCPUTime
     putStrLnFlush (show ((cpu' - cputime gfenv') `div` 1000000000) ++ " msec")
     return $ gfenv' {cputime = cpu'}
-}

-- | Execute a given command, returning Just an updated environment for
-- | the next command, or Nothing when it is time to quit
execute1 :: Options -> GFEnv -> String -> SIO (Maybe GFEnv)
execute1 opts gfenv0 s0 =
  interruptible $ optionallyShowCPUTime opts $
  case pwords s0 of
 -- special commands, requiring source grammar in env
  {-"eh":w:_ -> do
             cs <- readFile w >>= return . map words . lines
             gfenv' <- foldM (flip (process False benv)) gfenv cs
             loopNewCPU gfenv' -}
    "q" :_   -> quit
    "!" :ws  -> system_command ws
    "cc":ws  -> compute_concrete ws
    "sd":ws  -> show_deps ws
    "so":ws  -> show_operations ws
    "ss":ws  -> show_source ws
    "dg":ws  -> dependency_graph ws
    "eh":ws  -> eh ws
    "i" :ws  -> import_ ws
 -- other special commands, working on GFEnv
    "e" :_   -> empty
    "dc":ws  -> define_command ws
    "dt":ws  -> define_tree ws
    "ph":_   -> print_history
    "r" :_   -> reload_last
    "se":ws  -> set_encoding ws
 -- ordinary commands, working on CommandEnv
    _        -> do interpretCommandLine env s0
                   continue gfenv
  where
--  loopNewCPU = fmap Just . loopOptNewCPU opts
    continue = return . Just
    stop = return Nothing
    env = commandenv gfenv0
    sgr = sourcegrammar gfenv0
    gfenv = gfenv0 {history = s0 : history gfenv0}
    pwords s = case words s of
                 w:ws -> getCommandOp w :ws
                 ws -> ws

    interruptible act =
      either (\e -> printException e >> return (Just gfenv)) return
        =<< runInterruptibly act 

  -- Special commands:

    quit = do when (verbAtLeast opts Normal) $ putStrLn "See you."
              stop

    system_command ws = do restrictedSystem $ unwords ws ; continue gfenv

    compute_concrete ws = do
      let
        pOpts style q ("-table"  :ws) = pOpts TermPrintTable   q           ws
        pOpts style q ("-all"    :ws) = pOpts TermPrintAll     q           ws
        pOpts style q ("-list"   :ws) = pOpts TermPrintList    q           ws
        pOpts style q ("-one"    :ws) = pOpts TermPrintOne     q           ws
        pOpts style q ("-default":ws) = pOpts TermPrintDefault q           ws
        pOpts style q ("-unqual" :ws) = pOpts style            Unqualified ws
        pOpts style q ("-qual"   :ws) = pOpts style            Qualified   ws
        pOpts style q             ws  = (style,q,unwords ws)

        (style,q,s) = pOpts TermPrintDefault Qualified ws'
        (new,ws') = case ws of
                      "-new":ws' -> (True,ws')
                      "-old":ws' -> (False,ws')
                      _ -> (flag optNewComp opts,ws)

      case runP pExp (encodeUnicode utf8 s) of
        Left (_,msg) -> putStrLn msg
        Right t      -> putStrLn . err id (showTerm sgr style q)
                                 . checkComputeTerm' new sgr
                                 $ codeTerm (decodeUnicode utf8 . BS.pack) t
      continue gfenv

    show_deps ws = do
          let (os,xs) = partition (isPrefixOf "-") ws
          ops <- case xs of
             _:_ -> do
               let ts = [t | Right t <- map (runP pExp . encodeUnicode utf8) xs]
               err error (return . nub . concat) $ mapM (constantDepsTerm sgr) ts
             _   -> error "expected one or more qualified constants as argument"
          let prTerm = showTerm sgr TermPrintDefault Qualified
          let size = sizeConstant sgr
          let printed 
                | elem "-size" os =
                    let sz = map size ops in 
                    unlines $ ("total: " ++ show (sum sz)) : 
                              [prTerm f ++ "\t" ++ show s | (f,s) <- zip ops sz]
                | otherwise = unwords $ map prTerm ops
          putStrLn $ printed
          continue gfenv

    show_operations ws =
      case greatestResource sgr of
        Nothing -> putStrLn "no source grammar in scope; did you import with -retain?" >> continue gfenv
        Just mo -> do
          let (os,ts) = partition (isPrefixOf "-") ws
          let greps = [drop 6 o | o <- os, take 6 o == "-grep="]
          let isRaw = elem "-raw" os 
          ops <- case ts of
             _:_ -> do
               let Right t = runP pExp (encodeUnicode utf8 (unwords ts))
               ty <- err error return $ checkComputeTerm sgr t
               return $ allOpersTo sgr ty
             _   -> return $ allOpers sgr 
          let sigs = [(op,ty) | ((mo,op),ty,pos) <- ops]
          let printer = if isRaw 
                          then showTerm sgr TermPrintDefault Qualified
                          else (render . GF.Compile.TypeCheck.Concrete.ppType)
          let printed = [unwords [showIdent op, ":", printer ty] | (op,ty) <- sigs]
          mapM_ putStrLn [l | l <- printed, all (flip isInfixOf l) greps]
          continue gfenv

    show_source ws = do
      let (os,ts) = partition (isPrefixOf "-") ws
      let strip = if elem "-strip" os then stripSourceGrammar else id
      let mygr = strip $ case ts of
            _:_ -> mGrammar [(i,m) | (i,m) <- modules sgr, elem (showIdent i) ts] 
            [] -> sgr
      case 0 of
        _ | elem "-detailedsize" os -> putStrLn (printSizesGrammar mygr)
        _ | elem "-size" os -> do
               let sz = sizesGrammar mygr
               putStrLn $ unlines $
                 ("total\t" ++ show (fst sz)): 
                 [showIdent j ++ "\t" ++ show (fst k) | (j,k) <- snd sz]
        _ | elem "-save" os -> mapM_ 
                 (\ m@(i,_) -> let file = (showIdent i ++ ".gfh") in 
                    restricted $ writeFile file (render (ppModule Qualified m)) >> P.putStrLn ("wrote " ++ file))
                 (modules mygr)  
        _ -> putStrLn $ render $ ppGrammar mygr
      continue gfenv

    dependency_graph ws =
      do let stop = case ws of
               ('-':'o':'n':'l':'y':'=':fs):_ -> Just $ chunks ',' fs
               _ -> Nothing
         restricted $ writeFile "_gfdepgraph.dot" (depGraph stop sgr)
         putStrLn "wrote graph in file _gfdepgraph.dot"
         continue gfenv

    eh [w] = -- Ehhh? Reads commands from a file, but does not execute them
      do cs <- restricted (readFile w) >>= return . map (interpretCommandLine env) . lines
         continue gfenv
    eh _   = do putStrLn "eh command not parsed"
                continue gfenv

    import_ args = 
      do gfenv' <- case parseOptions args of
                     Ok (opts',files) -> do
                       curr_dir <- getCurrentDirectory
                       lib_dir  <- getLibraryDirectory (addOptions opts opts')
                       importInEnv gfenv (addOptions opts (fixRelativeLibPaths curr_dir lib_dir opts')) files
                     Bad err -> do 
                       putStrLn $ "Command parse error: " ++ err
                       return gfenv
         continue gfenv'

    empty = continue $ gfenv {
              commandenv=emptyCommandEnv, sourcegrammar = emptySourceGrammar
             }

    define_command (f:ws) =
        case readCommandLine (unwords ws) of
           Just comm -> continue $ gfenv {
             commandenv = env {
               commandmacros = Map.insert f comm (commandmacros env)
               }
             }
           _ -> dc_not_parsed
    define_command _ = dc_not_parsed

    dc_not_parsed = putStrLn "command definition not parsed" >> continue gfenv

    define_tree (f:ws) =
        case readExpr (unwords ws) of
          Just exp -> continue $ gfenv {
            commandenv = env {
              expmacros = Map.insert f exp (expmacros env)
              }
            }
          _ -> dt_not_parsed
    define_tree _ = dt_not_parsed

    dt_not_parsed = putStrLn "value definition not parsed" >> continue gfenv

    print_history = mapM_ putStrLn (reverse (history gfenv0))>> continue gfenv

    reload_last = do
      let imports = [(s,ws) | s <- history gfenv0, ("i":ws) <- [pwords s]]
      case imports of
        (s,ws):_ -> do
          putStrLn $ "repeating latest import: " ++ s
          import_ ws
        _ -> do
          putStrLn $ "no import in history"  
          continue gfenv

    set_encoding [c] =
      do let cod = renameEncoding c
         restricted $ changeConsoleEncoding cod
         continue gfenv
    set_encoding _ = putStrLn "se command not parsed" >> continue gfenv


printException e = maybe (print e) (putStrLn . ioErrorText) (fromException e)

checkComputeTerm = checkComputeTerm' False
checkComputeTerm' new sgr t = do
                 mo <- maybe (Bad "no source grammar in scope") return $ greatestResource sgr
                 ((t,_),_) <- runCheck $ do t <- renameSourceTerm sgr mo t
                                            inferLType sgr [] t
                 t1 <- if new
                       then return (CN.normalForm (CN.resourceValues sgr) (L NoLoc IW) t)
                       else computeConcrete sgr t
                 checkPredefError sgr t1

fetchCommand :: GFEnv -> IO String
fetchCommand gfenv = do
  path <- getAppUserDataDirectory "gf_history"
  let settings =
        Haskeline.Settings {
          Haskeline.complete = wordCompletion gfenv,
          Haskeline.historyFile = Just path,
          Haskeline.autoAddHistory = True
        }
  res <- IO.runInterruptibly $ Haskeline.runInputT settings (Haskeline.getInputLine (prompt (commandenv gfenv)))
  case res of
    Left  _        -> return ""
    Right Nothing  -> return "q"
    Right (Just s) -> return s

importInEnv :: GFEnv -> Options -> [FilePath] -> SIO GFEnv
importInEnv gfenv opts files
    | flag optRetainResource opts =
        do src <- importSource (sourcegrammar gfenv) opts files
           return $ gfenv {sourcegrammar = src}
    | otherwise =
        do let opts' = addOptions (setOptimization OptCSE False) opts
               pgf0 = multigrammar (commandenv gfenv)
           pgf1 <- importGrammar pgf0 opts' files
           if (verbAtLeast opts Normal)
             then putStrLnFlush $ unwords $ "\nLanguages:" : map showCId (languages pgf1)
             else return ()
           return $ gfenv { commandenv = mkCommandEnv pgf1 }

tryGetLine = do
  res <- try getLine
  case res of
   Left (e :: SomeException) -> return "q"
   Right l -> return l

welcome = unlines [
  "                              ",
  "         *  *  *              ",
  "      *           *           ",
  "    *               *         ",
  "   *                          ",
  "   *                          ",
  "   *        * * * * * *       ",
  "   *        *         *       ",
  "    *       * * * *  *        ",
  "      *     *      *          ",
  "         *  *  *              ",
  "                              ",
  "This is GF version "++showVersion version++". ",
  buildInfo,
  "License: see help -license.   ",
  "Bug reports: http://code.google.com/p/grammatical-framework/issues/list"
  ]

prompt env 
  | abs == wildCId = "> "
  | otherwise      = showCId abs ++ "> "
  where
    abs = abstractName (multigrammar env)

data GFEnv = GFEnv {
  sourcegrammar :: SourceGrammar, -- gfo grammar -retain
  commandenv :: CommandEnv,
  history    :: [String]
  }

emptyGFEnv :: GFEnv
emptyGFEnv =
  GFEnv emptySourceGrammar (mkCommandEnv emptyPGF) [] {-0-}

wordCompletion gfenv (left,right) = do
  case wc_type (reverse left) of
    CmplCmd pref
      -> ret (length pref) [Haskeline.simpleCompletion name | name <- Map.keys (commands cmdEnv), isPrefixOf pref name]
    CmplStr (Just (Command _ opts _)) s0
      -> do mb_state0 <- try (evaluate (initState pgf (optLang opts) (optType opts)))
            case mb_state0 of
              Right state0 -> let (rprefix,rs) = break isSpace (reverse s0)
                                  s            = reverse rs
                                  prefix       = reverse rprefix
                                  ws           = words s
                              in case loop state0 ws of
                                   Nothing    -> ret 0 []
                                   Just state -> let compls = getCompletions state prefix
                                                 in ret (length prefix) (map (\x -> Haskeline.simpleCompletion x) (Map.keys compls))
              Left (_ :: SomeException) -> ret 0 []
    CmplOpt (Just (Command n _ _)) pref
      -> case Map.lookup n (commands cmdEnv) of
           Just inf -> do let flg_compls = [Haskeline.Completion ('-':flg++"=") ('-':flg) False | (flg,_) <- flags   inf, isPrefixOf pref flg]
                              opt_compls = [Haskeline.Completion ('-':opt)      ('-':opt) True | (opt,_) <- options inf, isPrefixOf pref opt]
                          ret (length pref+1)
                              (flg_compls++opt_compls)
           Nothing  -> ret (length pref) []
    CmplIdent (Just (Command "i" _ _)) _        -- HACK: file name completion for command i
      -> Haskeline.completeFilename (left,right)
    CmplIdent _ pref
      -> do mb_abs <- try (evaluate (abstract pgf))
            case mb_abs of
              Right abs -> ret (length pref) [Haskeline.simpleCompletion name | cid <- Map.keys (funs abs), let name = showCId cid, isPrefixOf pref name]
              Left (_ :: SomeException) -> ret (length pref) []
    _ -> ret 0 []
  where
    pgf    = multigrammar cmdEnv
    cmdEnv = commandenv gfenv
    optLang opts = valCIdOpts "lang" (head (languages pgf)) opts
    optType opts = 
      let str = valStrOpts "cat" (showCId $ lookStartCat pgf) opts
      in case readType str of
           Just ty -> ty
           Nothing -> error ("Can't parse '"++str++"' as type")

    loop ps []     = Just ps
    loop ps (t:ts) = case nextState ps (simpleParseInput t) of
                       Left  es -> Nothing
                       Right ps -> loop ps ts

    ret len xs  = return (drop len left,xs)


data CompletionType
  = CmplCmd                   Ident
  | CmplStr   (Maybe Command) String
  | CmplOpt   (Maybe Command) Ident
  | CmplIdent (Maybe Command) Ident
  deriving Show

wc_type :: String -> CompletionType
wc_type = cmd_name
  where
    cmd_name cs =
      let cs1 = dropWhile isSpace cs
      in go cs1 cs1
      where
        go x []       = CmplCmd x
        go x (c:cs)
          | isIdent c = go x cs
          | otherwise = cmd x cs

    cmd x []       = ret CmplIdent x "" 0
    cmd _ ('|':cs) = cmd_name cs
    cmd _ (';':cs) = cmd_name cs
    cmd x ('"':cs) = str x cs cs
    cmd x ('-':cs) = option x cs cs
    cmd x (c  :cs)
      | isIdent c  = ident x (c:cs) cs
      | otherwise  = cmd x cs

    option x y []       = ret CmplOpt x y 1
    option x y ('=':cs) = optValue x y cs
    option x y (c  :cs)
      | isIdent c       = option x y cs
      | otherwise       = cmd x cs
      
    optValue x y ('"':cs) = str x y cs
    optValue x y cs       = cmd x cs

    ident x y []     = ret CmplIdent x y 0
    ident x y (c:cs)
      | isIdent c    = ident x y cs
      | otherwise    = cmd x cs

    str x y []          = ret CmplStr x y 1
    str x y ('\"':cs)   = cmd x cs
    str x y ('\\':c:cs) = str x y cs
    str x y (c:cs)      = str x y cs

    ret f x y d = f cmd y
      where
        x1 = take (length x - length y - d) x
        x2 = takeWhile (\c -> isIdent c || isSpace c || c == '-' || c == '=' || c == '"') x1
        
        cmd = case [x | (x,cs) <- RP.readP_to_S pCommand x2, all isSpace cs] of
	        [x] -> Just x
                _   -> Nothing

    isIdent c = c == '_' || c == '\'' || isAlphaNum c
