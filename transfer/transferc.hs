module Main where

import Transfer.CompilerAPI

import Data.List (partition, isPrefixOf)
import System.Environment
import System.Exit
import System.IO

die :: String -> IO a
die s = do
        hPutStrLn stderr s
        exitFailure

main :: IO ()
main = do 
       args <- getArgs
       let (flags,files) = partition ("-" `isPrefixOf`) args
           path = [ p | ('-':'i':p) <- flags ]
       case files of
         [f] -> do
                cf <- compileFile path f
                putStrLn $ "Wrote " ++ cf
                return ()
         _   -> die "Usage: transferc [-i<path> [-i<path> ... ]] <file>"
