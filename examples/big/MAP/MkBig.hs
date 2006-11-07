module Main where

import TransBig

import IO ( stdin, hGetContents )
import System ( getArgs, getProgName )

import LexLisp
import ParLisp
import SkelLisp
import PrintLisp
import AbsLisp
import ErrM

type ParseFun a = [Token] -> Err a

myLLexer = myLexer

type Verbosity = Int

putStrV :: Verbosity -> String -> IO ()
putStrV v s = if v > 1 then putStrLn s else return ()

runFile :: Verbosity -> ParseFun Prog -> FilePath -> IO ()
runFile v p f = putStrLn f >> readFile f >>= run v p

run :: Verbosity -> ParseFun Prog -> String -> IO ()
run v p s = let ts = myLLexer s in case p ts of
           Bad s    -> do putStrLn "\nParse              Failed...\n"
                          putStrV v "Tokens:"
                          putStrV v $ show ts
                          putStrLn s
           Ok  tree -> do putStrLn "\nParse Successful!"
                          transTree tree



main :: IO ()
main = do 
  runFile 0 pProg infile

infile = "bigwordlist.en"
