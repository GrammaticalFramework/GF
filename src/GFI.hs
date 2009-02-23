{-# OPTIONS -cpp #-}
module GFI (mainGFI,mainRunGFI) where

import GF.Command.Interpreter
import GF.Command.Importing
import GF.Command.Commands
import GF.Command.Abstract
import GF.Command.Parse
import GF.Data.ErrM
import GF.Grammar.API  -- for cc command
import GF.Infra.Dependencies
import GF.Infra.UseIO
import GF.Infra.Option
import GF.System.Readline

import GF.Text.Coding

import PGF
import PGF.Data
import PGF.Macros
import PGF.Expr (readTree)

import Data.Char
import Data.Maybe
import Data.List(isPrefixOf)
import qualified Data.Map as Map
import qualified Text.ParserCombinators.ReadP as RP
import System.Cmd
import System.CPUTime
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
  setCompletionFunction (Just (wordCompletion gfenv0))
  let fetch = case flag optMode opts of
        ModeRun -> tryGetLine
        _ -> fetchCommand (prompt env)
  s0 <- fetch 
  let gfenv = gfenv0 {history = s0 : history gfenv0}
  let 
    enc = encode gfenv
    s = decode gfenv s0
    pwords = case words s of
      w:ws -> getCommandOp w :ws
      ws -> ws
  
  -- special commands, requiring source grammar in env

  case pwords of

      "q":_  -> ifv (putStrLn "See you.") >> return gfenv

      _ -> do
        r <- runInterruptibly $ case pwords of

          "!":ws -> do
             system $ unwords ws
             loopNewCPU gfenv
          "cc":ws -> do
             let 
               (style,term) = case ws of 
                 ('-':w):ws2 -> (pTermPrintStyle w, ws2)
                 _ -> (TermPrintDefault, ws)
             case pTerm (unwords term) >>= checkTerm sgr >>= computeTerm sgr of
               Ok  x -> putStrLn $ enc (showTerm style x)
               Bad s -> putStrLn $ enc s
             loopNewCPU gfenv
          "dg":ws -> do
             writeFile "_gfdepgraph.dot" (depGraph sgr)
             putStrLn "wrote graph in file _gfdepgraph.dot"
             loopNewCPU gfenv
          "i":args -> do
              gfenv' <- case parseOptions args of
                          Ok (opts',files) -> 
                            importInEnv gfenv (addOptions opts opts') files
                          Bad err -> do 
                            putStrLn $ "Command parse error: " ++ err
                            return gfenv
              loopNewCPU gfenv'

  -- other special commands, working on GFEnv
          "e":_ -> loopNewCPU $ gfenv {
             commandenv=emptyCommandEnv, sourcegrammar = emptyGrammar
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
             case readTree (unwords ws) of
               Just exp -> loopNewCPU $ gfenv {
                 commandenv = env {
                   expmacros = Map.insert f exp (expmacros env)
                   }
                 }
               _ -> putStrLn "value definition not parsed" >> loopNewCPU gfenv

          "ph":_ -> 
            mapM_ (putStrLn . enc) (reverse (history gfenv0)) >> loopNewCPU gfenv
          "se":c:_ -> 
             case lookup c encodings of
               Just cod -> do
#ifdef mingw32_HOST_OS
                              case c of
                                'c':'p':c -> case reads c of
                                               [(cp,"")] -> setConsoleCP cp >> setConsoleOutputCP cp
                                               _         -> return ()
                                _         -> return ()
#endif
                              loopNewCPU $ gfenv {coding = cod}
               Nothing  -> do putStrLn "unknown encoding"
                              loopNewCPU gfenv

  -- ordinary commands, working on CommandEnv
          _ -> do
            interpretCommandLine enc env s
            loopNewCPU gfenv
--        gfenv' <- return $ either (const gfenv) id r
        gfenv' <- either (\e -> (print e >> return gfenv)) return r
        loop opts gfenv'

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
             then putStrLnFlush $ unwords $ "\nLanguages:" : map prCId (languages pgf1)
             else return ()
           return $ gfenv { commandenv = mkCommandEnv (coding gfenv) pgf1 }

tryGetLine = do
  res <- try getLine
  case res of
   Left e -> return "q"
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
  "Bug reports: http://trac.haskell.org/gf/"
  ]

prompt env 
  | abs == wildCId = "> "
  | otherwise      = prCId abs ++ "> "
  where
    abs = abstractName (multigrammar env)

data GFEnv = GFEnv {
  sourcegrammar :: Grammar, -- gfo grammar -retain
  commandenv :: CommandEnv,
  history    :: [String],
  cputime    :: Integer,
  coding     :: Encoding
  }

emptyGFEnv :: IO GFEnv
emptyGFEnv = do
#ifdef mingw32_HOST_OS
  codepage <- getACP
  let coding = fromMaybe UTF_8 (lookup ("cp"++show codepage) encodings)
#else
  let coding = UTF_8
#endif
  return $ GFEnv emptyGrammar (mkCommandEnv coding emptyPGF) [] 0 coding

encode = encodeUnicode . coding 
decode = decodeUnicode . coding

wordCompletion gfenv line0 prefix0 p =
  case wc_type (take p line) of
    CmplCmd pref
      -> ret ' ' [name | name <- Map.keys (commands cmdEnv), isPrefixOf pref name]
    CmplStr (Just (Command _ opts _)) s
      -> do mb_state0 <- try (evaluate (initState pgf (optLang opts) (optType opts)))
            case mb_state0 of
              Right state0 -> let ws     = words (take (length s - length prefix) s)
                              in case foldM nextState state0 ws of
                                   Nothing    -> ret ' ' []
                                   Just state -> let compls = getCompletions state prefix
                                                 in ret ' ' (map (encode gfenv) (Map.keys compls))
              Left  _      -> ret ' ' []
    CmplOpt (Just (Command n _ _)) pref
      -> case Map.lookup n (commands cmdEnv) of
           Just inf -> do let flg_compls = ['-':flg | (flg,_) <- flags   inf, isPrefixOf pref flg]
                              opt_compls = ['-':opt | (opt,_) <- options inf, isPrefixOf pref opt]
                          ret (if null flg_compls then ' ' else '=')
                              (flg_compls++opt_compls)
           Nothing  -> ret ' ' []
    CmplIdent (Just (Command "i" _ _)) _        -- HACK: file name completion for command i
      -> filenameCompletionFunction prefix
    CmplIdent _ pref
      -> do mb_abs <- try (evaluate (abstract pgf))
            case mb_abs of
              Right abs -> ret ' ' [name | cid <- Map.keys (funs abs), let name = prCId cid, isPrefixOf pref name]
              Left  _   -> ret ' ' []
    _ -> ret ' ' []
  where
    line   = decode gfenv line0
    prefix = decode gfenv prefix0

    pgf    = multigrammar cmdEnv
    cmdEnv = commandenv gfenv
    optLang opts = valCIdOpts "lang" (head (languages pgf)) opts
    optType opts = 
      let str = valStrOpts "cat" (prCId $ lookStartCat pgf) opts
      in case readType str of
           Just ty -> ty
           Nothing -> error ("Can't parse '"++str++"' as type")

    
    ret c [x] = return [x++[c]]
    ret _ xs  = return xs


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
