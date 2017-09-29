{-# LANGUAGE CPP, ScopedTypeVariables, FlexibleInstances #-}
-- | GF interactive mode
module GF.Interactive (mainGFI,mainRunGFI,mainServerGFI) where
import Prelude hiding (putStrLn,print)
import qualified Prelude as P(putStrLn)
import GF.Command.Interpreter(CommandEnv(..),mkCommandEnv,interpretCommandLine)
--import GF.Command.Importing(importSource,importGrammar)
import GF.Command.Commands(PGFEnv,HasPGFEnv(..),pgf,pgfEnv,pgfCommands)
import GF.Command.CommonCommands(commonCommands,extend)
import GF.Command.SourceCommands
import GF.Command.CommandInfo
import GF.Command.Help(helpCommand)
import GF.Command.Abstract
import GF.Command.Parse(readCommandLine,pCommand)
import GF.Data.Operations (Err(..),done)
import GF.Data.Utilities(whenM,repeatM)
import GF.Grammar hiding (Ident,isPrefixOf)
import GF.Infra.UseIO(ioErrorText,putStrLnE)
import GF.Infra.SIO
import GF.Infra.Option
import qualified System.Console.Haskeline as Haskeline
--import GF.Text.Coding(decodeUnicode,encodeUnicode)

--import GF.Compile.Coding(codeTerm)

import PGF
-- import PGF.Internal(abstract,funs,lookStartCat,emptyPGF)

import Data.Char
import Data.List(isPrefixOf)
import qualified Data.Map as Map
import qualified Text.ParserCombinators.ReadP as RP
--import System.IO(utf8)
--import System.CPUTime(getCPUTime)
import System.Directory({-getCurrentDirectory,-}getAppUserDataDirectory)
import Control.Exception(SomeException,fromException,evaluate,try)
import Control.Monad.State hiding (void)
import qualified GF.System.Signal as IO(runInterruptibly)
#ifdef SERVER_MODE
import GF.Server(server)
#endif

import GF.Command.Messages(welcome)

-- | Run the GF Shell in quiet mode (@gf -run@).
mainRunGFI :: Options -> [FilePath] -> IO ()
mainRunGFI opts files = shell (beQuiet opts) files

beQuiet = addOptions (modifyFlags (\f -> f{optVerbosity=Quiet}))

-- | Run the interactive GF Shell
mainGFI :: Options -> [FilePath] -> IO ()
mainGFI opts files = do
  P.putStrLn welcome
  shell opts files

shell opts files = flip evalStateT (emptyGFEnv opts) $
                   do mapStateT runSIO $ importInEnv opts files
                      loop

#ifdef SERVER_MODE
-- | Run the GF Server (@gf -server@).
-- The 'Int' argument is the port number for the HTTP service.
mainServerGFI opts0 port files =
    server jobs port root execute1' . snd
      =<< runSIO (runStateT (importInEnv opts files) (emptyGFEnv opts))
  where
    root = flag optDocumentRoot opts
    opts = beQuiet opts0
    jobs = join (flag optJobs opts)

    execute1' gfenv0 cmd =
       do (continue,gfenv) <- runStateT (execute1 cmd) gfenv0
          return $ if continue then Just gfenv else Nothing
#else
mainServerGFI opts port files =
  error "GF has not been compiled with server mode support"
#endif

-- | Read end execute commands until it is time to quit
loop :: StateT GFEnv IO ()
loop = repeatM readAndExecute1

-- | Read and execute one command, returning 'True' to continue execution,
-- | 'False' when it is time to quit
readAndExecute1 :: StateT GFEnv IO Bool
readAndExecute1 = mapStateT runSIO . execute1 =<< readCommand

-- | Read a command
readCommand :: StateT GFEnv IO String
readCommand =
  do opts <- gets startOpts
     case flag optMode opts of
       ModeRun -> lift tryGetLine
       _       -> lift . fetchCommand =<< get

timeIt act =
  do t1 <- liftSIO $ getCPUTime
     a <-  act
     t2 <- liftSIO $ getCPUTime
     return (t2-t1,a)

-- | Optionally show how much CPU time was used to run an IO action
optionallyShowCPUTime :: (Monad m,MonadSIO m) => Options -> m a -> m a
optionallyShowCPUTime opts act 
  | not (verbAtLeast opts Normal) = act
  | otherwise = do (dt,r) <- timeIt act
                   liftSIO $ putStrLnFlush $ show (dt `div` 1000000000) ++ " msec"
                   return r


type ShellM = StateT GFEnv SIO

-- | Execute a given command line, returning 'True' to continue execution,
-- | 'False' when it is time to quit
execute1, execute1' :: String -> ShellM Bool
execute1 s0 =
  do modify $ \ gfenv0 -> gfenv0 {history = s0 : history gfenv0}
     execute1' s0

-- | Execute a given command line, without adding it to the history
execute1' s0 =
  do opts <- gets startOpts
     interruptible $ optionallyShowCPUTime opts $
       case pwords s0 of
      -- cc, sd, so, ss and dg are now in GF.Commands.SourceCommands
      -- special commands
         "q" :_   -> quit
         "!" :ws  -> system_command ws
         "eh":ws  -> execute_history ws
         "i" :ws  -> do import_ ws; continue
      -- other special commands, working on GFEnv
         "dc":ws  -> define_command ws
         "dt":ws  -> define_tree ws
      -- ordinary commands
         _        -> do env <- gets commandenv
                        interpretCommandLine env s0
                        continue
  where
    continue,stop :: ShellM Bool
    continue = return True
    stop = return False

    interruptible :: ShellM Bool -> ShellM Bool
    interruptible act =
      do gfenv <- get
         mapStateT (
           either (\e -> printException e >> return (True,gfenv)) return
             <=< runInterruptibly) act

  -- Special commands:

    quit = do opts <- gets startOpts
              when (verbAtLeast opts Normal) $ putStrLnE "See you."
              stop

    system_command ws = do lift $ restrictedSystem $ unwords ws ; continue


       {-"eh":w:_ -> do
                  cs <- readFile w >>= return . map words . lines
                  gfenv' <- foldM (flip (process False benv)) gfenv cs
                  loopNewCPU gfenv' -}
    execute_history [w] =
      do execute . lines =<< lift (restricted (readFile w))
         continue
      where
        execute [] = done
        execute (line:lines) = whenM (execute1' line) (execute lines)

    execute_history _   =
       do putStrLnE "eh command not parsed"
          continue

    define_command (f:ws) =
        case readCommandLine (unwords ws) of
           Just comm ->
             do modify $
                  \ gfenv ->
                    let env = commandenv gfenv
                    in gfenv {
                         commandenv = env {
                           commandmacros = Map.insert f comm (commandmacros env)
                         }
                       }
                continue
           _ -> dc_not_parsed
    define_command _ = dc_not_parsed

    dc_not_parsed = putStrLnE "command definition not parsed" >> continue

    define_tree (f:ws) =
        case readExpr (unwords ws) of
          Just exp ->
           do modify $
                \ gfenv ->
                  let env = commandenv gfenv
                  in gfenv { commandenv = env {
                               expmacros = Map.insert f exp (expmacros env) } }
              continue
          _ -> dt_not_parsed
    define_tree _ = dt_not_parsed

    dt_not_parsed = putStrLnE "value definition not parsed" >> continue

pwords s = case words s of
             w:ws -> getCommandOp w :ws
             ws -> ws

import_ args =
  do case parseOptions args of
       Ok (opts',files) -> do
         opts <- gets startOpts
         curr_dir <- lift getCurrentDirectory
         lib_dir  <- lift $ getLibraryDirectory (addOptions opts opts')
         importInEnv (addOptions opts (fixRelativeLibPaths curr_dir lib_dir opts')) files
       Bad err -> putStrLnE $ "Command parse error: " ++ err

-- | Commands that work on 'GFEnv'
moreCommands = [
  ("e",  emptyCommandInfo {
     longname = "empty",
     synopsis = "empty the environment (except the command history)",
     exec = \ _ _ ->
            do modify $ \ gfenv -> (emptyGFEnv (startOpts gfenv))
                                     { history=history gfenv }
               return void
     }),
  ("ph", emptyCommandInfo {
     longname = "print_history",
     synopsis = "print command history",
     explanation = unlines [
       "Prints the commands issued during the GF session.",
       "The result is readable by the eh command.",
       "The result can be used as a script when starting GF."
       ],
     examples = [
      mkEx "ph | wf -file=foo.gfs  -- save the history into a file"
      ],
     exec = \ _ _ ->
            fmap (fromString . unlines . reverse . drop 1 . history) get
     }),
  ("r",  emptyCommandInfo {
     longname = "reload",
     synopsis = "repeat the latest import command",
     exec = \ _ _ ->
       do gfenv0 <- get
          let imports = [(s,ws) | s <- history gfenv0, ("i":ws) <- [pwords s]]
          case imports of
            (s,ws):_ -> do
              putStrLnE $ "repeating latest import: " ++ s
              import_ ws
              return void
            _ -> do putStrLnE $ "no import in history"
                    return void
     })
  ]


printException e = maybe (print e) (putStrLn . ioErrorText) (fromException e)

fetchCommand :: GFEnv -> IO String
fetchCommand gfenv = do
  path <- getAppUserDataDirectory "gf_history"
  let settings =
        Haskeline.Settings {
          Haskeline.complete = wordCompletion gfenv,
          Haskeline.historyFile = Just path,
          Haskeline.autoAddHistory = True
        }
  res <- IO.runInterruptibly $ Haskeline.runInputT settings (Haskeline.getInputLine (prompt gfenv))
  case res of
    Left  _        -> return ""
    Right Nothing  -> return "q"
    Right (Just s) -> return s

importInEnv :: Options -> [FilePath] -> ShellM ()
importInEnv opts files =
  do pgf0 <- gets multigrammar
     if flag optRetainResource opts
      then do src <- lift $ importSource opts files
              pgf <- lift . lazySIO $ importPGF pgf0 -- duplicates some work, better to link src
              modify $ \ gfenv -> gfenv {retain=True, pgfenv = (src,pgfEnv pgf)}
      else do pgf1 <- lift $ importPGF pgf0
              modify $ \ gfenv->gfenv { retain=False,
                                        pgfenv = (emptyGrammar,pgfEnv pgf1) }
  where
    importPGF pgf0 =
      do let opts' = addOptions (setOptimization OptCSE False) opts
         pgf1 <- importGrammar pgf0 opts' files
         if (verbAtLeast opts Normal)
           then putStrLnFlush $
                    unwords $ "\nLanguages:" : map showCId (languages pgf1)
           else done
         return pgf1

tryGetLine = do
  res <- try getLine
  case res of
   Left (e :: SomeException) -> return "q"
   Right l -> return l

prompt env
  | retain env || abs == wildCId = "> "
  | otherwise      = showCId abs ++ "> "
  where
    abs = abstractName (multigrammar env)

type CmdEnv = (Grammar,PGFEnv)

data GFEnv = GFEnv {
    startOpts :: Options,
    retain :: Bool,  -- grammar was imported with -retain flag
    pgfenv :: CmdEnv,
    commandenv :: CommandEnv ShellM,
    history    :: [String]
  }

emptyGFEnv opts = GFEnv opts False emptyCmdEnv emptyCommandEnv []

emptyCmdEnv = (emptyGrammar,pgfEnv (error "emptyPGF"))

emptyCommandEnv = mkCommandEnv allCommands
multigrammar = pgf . snd . pgfenv

allCommands =
  extend pgfCommands (helpCommand allCommands:moreCommands)
  `Map.union` sourceCommands
  `Map.union` commonCommands

instance HasGrammar ShellM where getGrammar = gets (fst . pgfenv)
instance HasPGFEnv ShellM where getPGFEnv = gets (snd . pgfenv)

wordCompletion gfenv (left,right) = do
  case wc_type (reverse left) of
    CmplCmd pref
      -> ret (length pref) [Haskeline.simpleCompletion name | name <- Map.keys (commands cmdEnv), isPrefixOf pref name]
    CmplStr (Just (Command _ opts _)) s0
      -> do mb_state0 <- try (evaluate (error "initState pgf (optLang opts) (optType opts)"))
            case mb_state0 of
              Right state0 -> let (rprefix,rs) = break isSpace (reverse s0)
                                  s            = reverse rs
                                  prefix       = reverse rprefix
                                  ws           = words s
                              in case loop state0 ws of
                                   Nothing    -> ret 0 []
                                   Just state -> let compls = error "getCompletions state prefix"
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
      -> do mb_abs <- try (evaluate (error "(abstract pgf)"))
            case mb_abs of
              Right abs -> ret (length pref) [Haskeline.simpleCompletion name | cid <- Map.keys (error "funs abs"), let name = showCId cid, isPrefixOf pref name]
              Left (_ :: SomeException) -> ret (length pref) []
    _ -> ret 0 []
  where
    pgf    = multigrammar gfenv
    cmdEnv = commandenv gfenv
    optLang opts = valCIdOpts "lang" (head (languages pgf)) opts
    optType opts = 
      let str = valStrOpts "cat" (showCId $ (error "lookStartCat pgf")) opts
      in case readType str of
           Just ty -> ty
           Nothing -> error ("Can't parse '"++str++"' as type")

    loop ps []     = Just ps
    loop ps (t:ts) = case error "nextState ps (simpleParseInput t)" of
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
