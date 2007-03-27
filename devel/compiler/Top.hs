module Main where

import IO ( stdin, hGetContents )
import System ( getArgs, getProgName )

import LexSrc
import ParSrc
import SkelSrc
import PrintSrc
import AbsSrc

import Compile
import PrEnv

import ErrM

type ParseFun a = [Token] -> Err a

myLLexer = myLexer

runFile :: ParseFun Grammar -> FilePath -> IO ()
runFile p f = readFile f >>= run p

run :: ParseFun Grammar -> String -> IO ()
run p s = let ts = myLLexer s in case p ts of
           Bad s    -> do putStrLn "Parse Failed...\n"
                          putStrLn s
           Ok  tree -> prEnv $ compile tree

main :: IO ()
main = do args <- getArgs
          case args of
            fs -> mapM_ (runFile pGrammar) fs

