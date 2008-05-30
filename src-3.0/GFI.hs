module GFI (mainGFI) where

import GF.Command.Interpreter
import GF.Command.Importing
import GF.Command.Commands
import GF.Data.ErrM
import GF.Grammar.API  -- for cc command
import GF.Infra.UseIO
import GF.Infra.Option
import GF.System.Readline (fetchCommand)
import PGF
import PGF.Data

import System.CPUTime

import Data.Version
import Paths_gf


mainGFI :: Options -> [FilePath] -> IO ()
mainGFI opts files = do
  putStrLn welcome
  env <- importInEnv emptyPGF opts files
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
       -- FIXME: add options parsing for cc arguments
       let (opts,term) = (TermPrintDefault, ws)
       case pTerm (unwords term) >>= checkTerm sgr >>= computeTerm sgr of   ---- make pipable
         Ok  x -> putStrLn (showTerm opts x)
         Bad s -> putStrLn s
       loopNewCPU gfenv
    "i":args -> do
      case parseOptions args of
        Ok (opts,files) 
         | flag optRetainResource opts -> 
             do src <- importSource sgr opts files
                loopNewCPU $ gfenv {sourcegrammar = src}
         | otherwise ->
             do env1 <- importInEnv (multigrammar env) opts files
                loopNewCPU $ gfenv {commandenv = env1}
        Bad err -> do putStrLn $ "Command parse error: " ++ err
                      loopNewCPU gfenv

  -- other special commands, working on GFEnv
    "e":_ -> loopNewCPU $ gfenv {commandenv=env{multigrammar=emptyPGF}}
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

importInEnv :: PGF -> Options -> [FilePath] -> IO CommandEnv
importInEnv pgf0 opts files = do
  pgf1 <- case files of
    [] -> return pgf0
    _  -> importGrammar pgf0 opts files
  let env = CommandEnv pgf1 (allCommands pgf1)
  putStrLn $ unwords $ "\nLanguages:" : languages pgf1
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
