module GFI (mainGFI) where

import GF.Command.Interpreter
import GF.Command.Importing
import GF.Command.Commands
import GF.Command.Abstract
import GF.Command.Parse
import GF.Data.ErrM
import GF.Grammar.API  -- for cc command
import GF.Infra.UseIO
import GF.Infra.Option
import GF.System.Readline

import GF.Text.UTF8 ----

import PGF
import PGF.Data
import PGF.Macros
import PGF.Expr (readTree)

import Data.Char
import Data.List(isPrefixOf)
import qualified Data.Map as Map
import qualified Text.ParserCombinators.ReadP as RP
import System.Cmd
import System.CPUTime
import Control.Exception
import Data.Version
import GF.System.Signal


import Paths_gf

mainGFI :: Options -> [FilePath] -> IO ()
mainGFI opts files = do
  putStrLn welcome
  gfenv <- importInEnv emptyGFEnv opts files
  loop opts gfenv
  return ()

loop :: Options -> GFEnv -> IO GFEnv
loop opts gfenv0 = do
  let env = commandenv gfenv0
  let sgr = sourcegrammar gfenv0
  setCompletionFunction (Just (wordCompletion (commandenv gfenv0)))
  s0 <- fetchCommand (prompt env)
  let gfenv = gfenv0 {history = s0 : history gfenv0}
  let loopNewCPU gfenv' = do 
        cpu' <- getCPUTime
        putStrLnFlush (show ((cpu' - cputime gfenv') `div` 1000000000) ++ " msec")
        return $ gfenv' {cputime = cpu'}
  let 
    enc = encode gfenv
    s = decode gfenv s0
    pwords = case words s of
      w:ws -> getCommandOp w :ws
      ws -> ws
  
  -- special commands, requiring source grammar in env

  case pwords of

      "q":_  -> putStrLn "See you." >> return gfenv

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
          "se":c -> loopNewCPU $ gfenv {coding = s}

  -- ordinary commands, working on CommandEnv
          _ -> do
            interpretCommandLine enc env s
            loopNewCPU gfenv
        gfenv' <- return $ either (const gfenv) id r
        e <- loopNewCPU gfenv'
        loop opts e

importInEnv :: GFEnv -> Options -> [FilePath] -> IO GFEnv
importInEnv gfenv opts files
    | flag optRetainResource opts =
        do src <- importSource (sourcegrammar gfenv) opts files
           return $ gfenv {sourcegrammar = src}
    | otherwise =
        do let opts' = addOptions (setOptimization OptCSE False) opts
               pgf0 = multigrammar (commandenv gfenv)
           pgf1 <- importGrammar pgf0 opts' files
           putStrLnFlush $ unwords $ "\nLanguages:" : languages pgf1
           return $ gfenv { commandenv = mkCommandEnv (encode gfenv) pgf1 }

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
  "Some things may work.         "
  ]

prompt env = absname ++ "> " where
  absname = case abstractName (multigrammar env) of
    "_" -> ""  --- created by new Ident handling 22/5/2008
    n   -> n

data GFEnv = GFEnv {
  sourcegrammar :: Grammar, -- gfo grammar -retain
  commandenv :: CommandEnv,
  history    :: [String],
  cputime    :: Integer,
  coding     :: String
  }

emptyGFEnv :: GFEnv
emptyGFEnv = GFEnv emptyGrammar (mkCommandEnv encodeUTF8 emptyPGF) [] 0 "utf8"

encode env = case coding env of
  "utf8" -> encodeUTF8
  _ -> id

decode env = case coding env of
  "utf8" -> decodeUTF8
  _ -> id



wordCompletion cmdEnv line prefix p =
  case wc_type (take p line) of
    CmplCmd pref
      -> ret ' ' [name | name <- Map.keys (commands cmdEnv), isPrefixOf pref name]
    CmplStr (Just (Command _ opts _)) s
      -> do mb_state0 <- try (evaluate (initState pgf (optLang opts) (optCat  opts)))
            case mb_state0 of
              Right state0 -> let ws     = words (take (length s - length prefix) s)
                                  state  = foldl nextState state0 ws
                                  compls = getCompletions state prefix
                              in ret ' ' (Map.keys compls)
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
    pgf = multigrammar cmdEnv
    optLang opts = valIdOpts "lang" (head (languages pgf)) opts
    optCat  opts = valIdOpts "cat"  (lookStartCat pgf)     opts
    
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

    option x y []     = ret CmplOpt x y 1
    option x y (c:cs)
      | isIdent c     = option x y cs
      | otherwise     = cmd x cs

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
        x2 = takeWhile (\c -> isIdent c || isSpace c || c == '-' || c == '=') x1
        
        cmd = case [x | (x,cs) <- RP.readP_to_S pCommand x2, all isSpace cs] of
	        [x] -> Just x
                _   -> Nothing

    isIdent c = c == '_' || c == '\'' || isAlphaNum c
