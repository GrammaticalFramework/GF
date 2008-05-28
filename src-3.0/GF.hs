module Main where

import GFC
import GFI
import GF.Data.ErrM
import GF.Infra.Option
import GF.Infra.UseIO
import Paths_gf

import Data.Version
import System.Environment (getArgs)
import System.Exit
import System.IO

main :: IO ()
main = 
    do args <- getArgs
       case parseOptions args of
         Ok (opts,files) -> mainOpts opts files
         Bad err         -> do hPutStrLn stderr err
                               hPutStrLn stderr "You may want to try --help."
                               exitFailure

mainOpts :: Options -> [FilePath] -> IO ()
mainOpts opts files = 
    case flag optMode opts of
      ModeVersion     -> putStrLn $ "Grammatical Framework (GF) version " ++ showVersion version
      ModeHelp        -> putStrLn helpMessage
      ModeInteractive -> mainGFI opts files
      ModeCompiler    -> dieIOE (mainGFC opts files)

