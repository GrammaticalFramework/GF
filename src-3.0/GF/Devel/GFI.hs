module GF.Devel.GFI (mainGFI) where

import GF.Command.Interpreter
import GF.Command.Importing
import GF.Command.Commands
import GF.GFCC.API

import GF.Devel.UseIO
import GF.Devel.Arch
import GF.System.Arch (fetchCommand)
import GF.Infra.Option ---- Haskell's option lib


mainGFI :: [String] -> IO ()
mainGFI xx = do
  putStrLn welcome
  env <- importInEnv emptyMultiGrammar xx
  loop (GFEnv env [] 0)
  return ()

loop :: GFEnv -> IO GFEnv
loop gfenv0 = do
  let env = commandenv gfenv0
  s <- fetchCommand (prompt env)
  let gfenv = gfenv0 {history = s : history gfenv0}
  case words s of

  -- special commands, working on GFEnv
    "i":args -> do
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
  cpu <- prCPU $ cputime gfenv
  loop $ gfenv {cputime = cpu}

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
  "This is GF version 3.0 alpha. ",
  "Some things may work.         "
  ]

prompt env = absname ++ "> " where
  absname = case abstractName (multigrammar env) of
    "_" -> ""  --- created by new Ident handling 22/5/2008
    n   -> n

data GFEnv = GFEnv {
  commandenv :: CommandEnv,
  history    :: [String],
  cputime    :: Integer
  }
