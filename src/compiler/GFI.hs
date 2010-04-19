{-# LANGUAGE ScopedTypeVariables, CPP #-}
module GFI (mainGFI,mainRunGFI) where

import GF.Command.Interpreter
import GF.Command.Importing
import GF.Command.Commands
import GF.Command.Abstract
import GF.Command.Parse
import GF.Data.ErrM
import GF.Data.Operations (chunks)
import GF.Grammar hiding (Ident)
import GF.Grammar.Parser (runP, pExp)
import GF.Grammar.ShowTerm
import GF.Compile.Rename
import GF.Compile.Concrete.Compute (computeConcrete)
import GF.Compile.Concrete.TypeCheck (inferLType)
import GF.Infra.Dependencies
import GF.Infra.CheckM
import GF.Infra.UseIO
import GF.Infra.Option
import GF.Infra.Modules (greatestResource, modules, emptyModInfo)
import qualified System.Console.Haskeline as Haskeline
import GF.Text.Coding

import GF.Compile.Coding

import PGF
import PGF.Data
import PGF.Macros

import Data.Char
import Data.Maybe
import Data.List(isPrefixOf)
import qualified Data.Map as Map
import qualified Data.ByteString.Char8 as BS
import qualified Text.ParserCombinators.ReadP as RP
import System.IO
import System.Cmd
import System.CPUTime
import System.Directory
import Control.Exception
import Control.Monad
import Data.Version
import GF.System.Signal
--import System.IO.Error (try)
#ifdef mingw32_HOST_OS
import System.Win32.Console
import System.Win32.NLS
#endif

import Paths_gf

mainRunGFI :: Options -> [FilePath] -> IO ()
mainRunGFI opts files = do
  let opts1 = addOptions (modifyFlags (\f -> f{optVerbosity=Quiet})) opts
  gfenv <- emptyGFEnv
  gfenv <- importInEnv gfenv opts1 files
  loop opts1 gfenv
  return ()

mainGFI :: Options -> [FilePath] -> IO ()
mainGFI opts files = do
  putStrLn welcome
  gfenv <- emptyGFEnv
  gfenv <- importInEnv gfenv opts files
  loop opts gfenv
  return ()

loopOptNewCPU opts gfenv' 
 | not (verbAtLeast opts Normal) = return gfenv'
 | otherwise = do 
     cpu' <- getCPUTime
     putStrLnFlush (show ((cpu' - cputime gfenv') `div` 1000000000) ++ " msec")
     return $ gfenv' {cputime = cpu'}

loop :: Options -> GFEnv -> IO GFEnv
loop opts gfenv0 = do
  let loopNewCPU = loopOptNewCPU opts
  let isv = verbAtLeast opts Normal
  let ifv act = if isv then act else return ()
  let env = commandenv gfenv0
  let sgr = sourcegrammar gfenv0
  s0 <- case flag optMode opts of
          ModeRun -> tryGetLine
          _       -> fetchCommand gfenv0
  let gfenv = gfenv0 {history = s0 : history gfenv0}
  let 
    pwords = case words s0 of
      w:ws -> getCommandOp w :ws
      ws -> ws
  
  -- special commands, requiring source grammar in env

  case pwords of
{-
    "eh":w:_ -> do
             cs <- readFile w >>= return . map words . lines
             gfenv' <- foldM (flip (process False benv)) gfenv cs
             loopNewCPU gfenv'
-}

      "q":_  -> ifv (putStrLn "See you.") >> return gfenv

      _ -> do
        r <- runInterruptibly $ case pwords of

          "!":ws -> do
             system $ unwords ws
             loopNewCPU gfenv
          "cc":ws -> do
             let
               pOpts style q ("-table"  :ws) = pOpts TermPrintTable   q           ws
               pOpts style q ("-all"    :ws) = pOpts TermPrintAll     q           ws
               pOpts style q ("-default":ws) = pOpts TermPrintDefault q           ws
               pOpts style q ("-unqual" :ws) = pOpts style            Unqualified ws
               pOpts style q ("-qual"   :ws) = pOpts style            Qualified   ws
               pOpts style q             ws  = (style,q,unwords ws)
               
               (style,q,s) = pOpts TermPrintDefault Qualified (tail (words s0))

               checkComputeTerm gr (L _ t) = do
                 mo <- maybe (Bad "no source grammar in scope") return $ greatestResource gr
                 ((t,_),_) <- runCheck $ do t <- renameSourceTerm gr mo t
                                            inferLType gr [] t
                 computeConcrete sgr t

             case runP pExp (encodeUnicode utf8 s) of
               Left (_,msg) -> putStrLn msg
               Right t      -> case checkComputeTerm sgr (codeTerm (decodeUnicode utf8 . BS.pack) (L (0,0) t)) of
                                 Ok  x -> putStrLn $ showTerm sgr style q x
                                 Bad s -> putStrLn $ s
             loopNewCPU gfenv
          "dg":ws -> do
             let stop = case ws of
                   ('-':'o':'n':'l':'y':'=':fs):_ -> Just $ chunks ',' fs
                   _ -> Nothing
             writeFile "_gfdepgraph.dot" (depGraph stop sgr)
             putStrLn "wrote graph in file _gfdepgraph.dot"
             loopNewCPU gfenv
          "eh":w:_ -> do
             cs <- readFile w >>= return . map (interpretCommandLine env) . lines
             loopNewCPU gfenv

          "i":args -> do
              gfenv' <- case parseOptions args of
                          Ok (opts',files) -> do
                            curr_dir <- getCurrentDirectory
                            lib_dir  <- getLibraryDirectory (addOptions opts opts')
                            importInEnv gfenv (addOptions opts (fixRelativeLibPaths curr_dir lib_dir opts')) files
                          Bad err -> do 
                            putStrLn $ "Command parse error: " ++ err
                            return gfenv
              loopNewCPU gfenv'

  -- other special commands, working on GFEnv
          "e":_ -> loopNewCPU $ gfenv {
             commandenv=emptyCommandEnv, sourcegrammar = emptySourceGrammar
             }

          "dc":f:ws -> do
             case readCommandLine (unwords ws) of
               Just comm -> loopNewCPU $ gfenv {
                 commandenv = env {
                   commandmacros = Map.insert f comm (commandmacros env)
                   }
                 }
               _ -> putStrLn "command definition not parsed" >> loopNewCPU gfenv

          "dt":f:ws -> do
             case readExpr (unwords ws) of
               Just exp -> loopNewCPU $ gfenv {
                 commandenv = env {
                   expmacros = Map.insert f exp (expmacros env)
                   }
                 }
               _ -> putStrLn "value definition not parsed" >> loopNewCPU gfenv

          "ph":_ -> 
            mapM_ putStrLn (reverse (history gfenv0)) >> loopNewCPU gfenv
          "se":c:_ -> do
             let cod = renameEncoding c
#ifdef mingw32_HOST_OS
             case cod of
               'C':'P':c -> case reads c of
                              [(cp,"")] -> do setConsoleCP cp
                                              setConsoleOutputCP cp
                              _         -> return ()
               "UTF-8"   -> do setConsoleCP 65001
                               setConsoleOutputCP 65001
               _         -> return ()
#endif
             enc <- mkTextEncoding cod
             hSetEncoding stdin  enc
             hSetEncoding stdout enc
             hSetEncoding stderr enc
             loopNewCPU gfenv

  -- ordinary commands, working on CommandEnv
          _ -> do
            interpretCommandLine env s0
            loopNewCPU gfenv
--        gfenv' <- return $ either (const gfenv) id r
        gfenv' <- either (\e -> (print e >> return gfenv)) return r
        loop opts gfenv'

fetchCommand :: GFEnv -> IO String
fetchCommand gfenv = do
  path <- getAppUserDataDirectory "gf_history"
  let settings =
        Haskeline.Settings {
          Haskeline.complete = wordCompletion gfenv,
          Haskeline.historyFile = Just path,
          Haskeline.autoAddHistory = True
        }
  res <- Haskeline.runInputT settings (Haskeline.getInputLine (prompt (commandenv gfenv)))
  case res of
    Nothing -> return "q"
    Just s  -> return s

importInEnv :: GFEnv -> Options -> [FilePath] -> IO GFEnv
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
  "License: see help -license.   ",
  "Differences from GF 2.9: see help -changes.",
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
  history    :: [String],
  cputime    :: Integer
  }

emptyGFEnv :: IO GFEnv
emptyGFEnv = do
  return $ GFEnv emptySourceGrammar{modules=[(identW,emptyModInfo)]} (mkCommandEnv emptyPGF) [] 0

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
    loop ps (t:ts) = case nextState ps t of
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
