module Main where

import GF.Command.Interpreter
import GF.Command.Importing
import GF.Command.Commands
import GF.GFCC.API

import GF.Infra.Option ---- Haskell's option lib

import System (getArgs)

main :: IO ()
main = do
  putStrLn welcome
  xx <- getArgs
  env <- importInEnv emptyMultiGrammar xx
  loop env
  return ()

loop :: CommandEnv -> IO CommandEnv
loop env = do
  s <- getLine
  case words s of
    "q":_ -> return env
    "i":args -> do
      env1 <- importInEnv (multigrammar env) args
      loop env1
    _ -> do
      interpretCommandLine env s
      loop env

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
