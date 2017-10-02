-- | GF main program (grammar compiler, interactive shell, http server)
{-# LANGUAGE CPP #-}
module GF.Main where
import GF.Compiler
import GF.Interactive
import GF.Data.ErrM
import GF.Infra.Option
import GF.Infra.UseIO
import GF.Infra.BuildInfo (buildInfo)
import Paths_gf

import Data.Version
import System.Directory
import System.Environment (getArgs)
import System.Exit
import GF.System.Console (setConsoleEncoding)

-- | Run the GF main program, taking arguments from the command line.
-- (It calls 'setConsoleEncoding' and 'getOptions', then 'mainOpts'.)
-- Run @gf --help@ for usage info.
main :: IO ()
main = do
  setConsoleEncoding
  uncurry mainOpts =<< getOptions

-- | Get and parse GF command line arguments. Fix relative paths.
-- Calls 'getArgs' and 'parseOptions'.
getOptions = do
  args <- getArgs
  case parseOptions args of
    Ok (opts,files) -> do curr_dir <- getCurrentDirectory
                          lib_dir  <- getLibraryDirectory opts
                          return (fixRelativeLibPaths curr_dir lib_dir opts, files)
    Bad err         -> do ePutStrLn err
                          ePutStrLn "You may want to try --help."
                          exitFailure


-- | Run the GF main program with the given options and files. Depending on
-- the options it invokes 'mainGFC', 'mainGFI', 'mainRunGFI', 'mainServerGFI',
-- or it just prints version/usage info.
mainOpts :: Options -> [FilePath] -> IO ()
mainOpts opts files = 
    case flag optMode opts of
      ModeVersion     -> putStrLn $ "Grammatical Framework (GF) version " ++ showVersion version ++ "\n" ++ buildInfo
      ModeHelp        -> putStrLn helpMessage
      ModeServer port -> mainServerGFI opts port files
      ModeCompiler    -> mainGFC opts files
      ModeInteractive -> mainGFI opts files
      ModeRun         -> mainRunGFI opts files
