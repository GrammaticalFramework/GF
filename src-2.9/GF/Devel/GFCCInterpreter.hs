module Main where

import GF.Command.Interpreter
import GF.Command.Commands
import GF.GFCC.API
import System (getArgs)
import Data.Char (isDigit)

-- Simple translation application built on GFCC. AR 7/9/2006 -- 19/9/2007

main :: IO ()
main = do
  file:_  <- getArgs
  grammar <- file2grammar file
  let env = CommandEnv grammar (allCommands grammar)
  printHelp grammar
  loop env

loop :: CommandEnv -> IO ()
loop env = do
  s <- getLine
  if s == "q" then return () else do
    interpretCommandLine env s
    loop env

printHelp grammar = do
  putStrLn $ "languages:  " ++ unwords (languages grammar)
  putStrLn $ "categories: " ++ unwords (categories grammar)
