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
  gfenv <- importInEnv emptyGFEnv opts files
  loop opts gfenv
  return ()

loop :: Options -> GFEnv -> IO GFEnv
loop opts gfenv0 = do
  let env = commandenv gfenv0
  let sgr = sourcegrammar gfenv0
  s <- fetchCommand (prompt env)
  let gfenv = gfenv0 {history = s : history gfenv0}
  let loopNewCPU gfenv' = do cpu' <- getCPUTime
                             putStrLn (show ((cpu' - cputime gfenv') `div` 1000000000) ++ " msec")
                             loop opts $ gfenv' {cputime = cpu'}
  case words s of
  -- special commands, requiring source grammar in env
    "cc":ws -> do
       -- FIXME: add options parsing for cc arguments
       let (style,term) = (TermPrintDefault, ws)
       case pTerm (unwords term) >>= checkTerm sgr >>= computeTerm sgr of   ---- make pipable
         Ok  x -> putStrLn (showTerm style x)
         Bad s -> putStrLn s
       loopNewCPU gfenv
    "i":args -> do
        gfenv' <- case parseOptions args of
                    Ok (opts',files) -> importInEnv gfenv (addOptions opts opts') files
                    Bad err -> do putStrLn $ "Command parse error: " ++ err
                                  return gfenv
        loopNewCPU gfenv'

  -- other special commands, working on GFEnv
    "e":_ -> loopNewCPU $ gfenv {commandenv=env{multigrammar=emptyPGF}}
    "ph":_ -> mapM_ putStrLn (reverse (history gfenv0)) >> loopNewCPU gfenv
    "q":_  -> putStrLn "See you." >> return gfenv

  -- ordinary commands, working on CommandEnv
    _ -> do
      interpretCommandLine env s
      loopNewCPU gfenv

importInEnv :: GFEnv -> Options -> [FilePath] -> IO GFEnv
importInEnv gfenv opts files
    | flag optRetainResource opts =
        do src <- importSource (sourcegrammar gfenv) opts files
           return $ gfenv {sourcegrammar = src}
    | otherwise =
        do let opts' = addOptions (setOptimization OptCSE False) opts
               pgf0 = multigrammar (commandenv gfenv)
           pgf1 <- importGrammar pgf0 opts' files
           putStrLn $ unwords $ "\nLanguages:" : languages pgf1
           return $ gfenv { commandenv = mkCommandEnv pgf1 }

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

emptyGFEnv :: GFEnv
emptyGFEnv = GFEnv emptyGrammar (mkCommandEnv emptyPGF) [] 0
