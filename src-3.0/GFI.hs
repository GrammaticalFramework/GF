module GFI (mainGFI) where

import GF.Command.Interpreter
import GF.Command.Importing
import GF.Command.Commands
import GF.GFCC.API

import GF.Grammar.API  -- for cc command

import GF.Infra.UseIO
import GF.Infra.Option ---- Haskell's option lib
import GF.System.Readline (fetchCommand)

import System.CPUTime

import Data.Version
import Paths_gf


mainGFI :: [String] -> IO ()
mainGFI xx = do
  putStrLn welcome
  env <- importInEnv emptyMultiGrammar xx
  loop (GFEnv emptyGrammar env [] 0)
  return ()

loop :: GFEnv -> IO GFEnv
loop gfenv0 = do
  let env = commandenv gfenv0
  let sgr = sourcegrammar gfenv0
  s <- fetchCommand (prompt env)
  let gfenv = gfenv0 {history = s : history gfenv0}
  case words s of

  -- special commands, requiring source grammar in env
    "cc":ws -> do
       let (opts,term) = getOptions "-" ws
       let t = pTerm (unwords term) >>= checkTerm sgr >>= computeTerm sgr
       err putStrLn (putStrLn . showTerm opts) t ---- make pipable
       loopNewCPU gfenv

    "i":args -> do
      let (opts,files) = getOptions "-" args
      case opts of
        _ | oElem (iOpt "retain") opts -> do
          src <- importSource sgr opts files
          loopNewCPU $ gfenv {sourcegrammar = src}

  -- other special commands, working on GFEnv
        _  -> do
          env1 <- importInEnv (multigrammar env) args
          loopNewCPU $ gfenv {commandenv = env1}
    "e":_ -> loopNewCPU $ gfenv {commandenv=env{multigrammar=emptyMultiGrammar}}
    "ph":_ -> mapM_ putStrLn (reverse (history gfenv0)) >> loopNewCPU gfenv
    "q":_  -> putStrLn "See you." >> return gfenv

  -- ordinary commands, working on CommandEnv
    _ -> do
      interpretCommandLine env s
      loopNewCPU gfenv

loopNewCPU gfenv = do
  cpu' <- getCPUTime
  putStrLn (show ((cpu' - cputime gfenv) `div` 1000000000) ++ " msec")
  loop $ gfenv {cputime = cpu'}

importInEnv mgr0 xx = do
  let (opts,files) = getOptions "-" xx
  mgr1 <- case files of
    [] -> return mgr0
    _  -> importGrammar mgr0 opts files
  let env = CommandEnv mgr1 (allCommands mgr1)
  putStrLn $ unwords $ "\nLanguages:" : languages mgr1
  return env

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
  cputime    :: Integer
  }
