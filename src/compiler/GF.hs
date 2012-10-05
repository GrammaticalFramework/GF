module Main where

import GFC
import GFI
import GF.Data.ErrM
import GF.Infra.Option
import GF.Infra.UseIO
import GF.Infra.BuildInfo (buildInfo)
import Paths_gf

import Data.Version
import System.Directory
import System.Environment (getArgs)
import System.Exit
import System.IO
import GF.System.Console (setConsoleEncoding)

main :: IO ()
main = do
  setConsoleEncoding
  args <- getArgs
  case parseOptions args of
    Ok (opts,files) -> do curr_dir <- getCurrentDirectory
                          lib_dir  <- getLibraryDirectory opts
                          mainOpts (fixRelativeLibPaths curr_dir lib_dir opts) files
    Bad err         -> do hPutStrLn stderr err
                          hPutStrLn stderr "You may want to try --help."
                          exitFailure

mainOpts :: Options -> [FilePath] -> IO ()
mainOpts opts files = 
    case flag optMode opts of
      ModeVersion     -> putStrLn $ "Grammatical Framework (GF) version " ++ showVersion version ++ "\n" ++ buildInfo
      ModeHelp        -> putStrLn helpMessage
      ModeInteractive -> mainGFI opts files
      ModeRun         -> mainRunGFI opts files
      ModeServer port -> mainServerGFI opts port files
      ModeCompiler    -> mainGFC opts files
