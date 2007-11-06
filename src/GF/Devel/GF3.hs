module Main where

import GF.Command.Interpreter
import GF.Command.Importing
import GF.Command.Commands
import GF.GFCC.API

import GF.Devel.UseIO
import GF.Devel.Arch
import GF.Infra.Option ---- Haskell's option lib

import System (getArgs)

main :: IO ()
main = do
  putStrLn welcome
  xx <- getArgs
  env <- importInEnv emptyMultiGrammar xx
  loop (GFEnv env [] 0)
  return ()

loop :: GFEnv -> IO GFEnv
loop gfenv0 = do
  let env = commandenv gfenv0
  putStrFlush (prompt env)
  s <- getLine
  let gfenv = gfenv0 {history = s : history gfenv0}
  case words s of
    "q":_ -> return gfenv
    "i":args -> do
      env1 <- importInEnv (multigrammar env) args
      loopNewCPU $ gfenv {commandenv = env1}
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
  "This is GF version 3.0 alpha.",
  "Some things may work."
  ]

prompt env = abstractName (multigrammar env) ++ "> "

data GFEnv = GFEnv {
  commandenv :: CommandEnv,
  history    :: [String],
  cputime    :: Integer
  }
