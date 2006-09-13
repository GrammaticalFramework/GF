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

getPath :: IO [String]
getPath = do env <- getEnvironment
             return $ case lookup "TRANSFER_PATH" env of
                        Nothing -> []
                        Just p  -> splitBy (==':') p

-- Modified version of a function which is originally
-- Copyright Bryn Keller
splitBy :: (a -> Bool) -> [a] -> [[a]]
splitBy _ [] = []
splitBy f list = first : splitBy f (dropWhile f rest)
   where (first, rest) = break f list

main :: IO ()
main = do 
       args <- getArgs
       let (flags,files) = partition ("-" `isPrefixOf`) args
           argPath = [ p | ('-':'i':p) <- flags ]
       envPath <- getPath
       case files of
         [f] -> do
                cf <- compileFile (argPath ++ envPath) f
                putStrLn $ "Wrote " ++ cf
                return ()
         _   -> die "Usage: transferc [-i<path> [-i<path> ... ]] <file>"
