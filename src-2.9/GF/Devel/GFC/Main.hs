module GF.Devel.GFC.Main where

import GF.Devel.GFC.Options

import System.Environment
import System.Exit
import System.IO


version = "X.X"

main :: IO ()
main = 
    do args <- getArgs
       case parseOptions args of
         Ok (opts, files) -> 
             case optMode opts of
               Version  -> putStrLn $ "GF, version " ++ version
               Help     -> putStr helpMessage
               Compiler -> gfcMain opts files
         Errors errs -> 
             do mapM_ (hPutStrLn stderr) errs
                exitFailure

gfcMain :: Options -> [FilePath] -> IO ()
gfcMain opts files = return ()


