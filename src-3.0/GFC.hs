module GFC (mainGFC) where
-- module Main where

import PGF
import PGF.CId
import PGF.Data
import PGF.Raw.Parse
import PGF.Raw.Convert
import GF.Compile
import GF.Compile.Export
import GF.Infra.UseIO
import GF.Infra.Option
import GF.Data.ErrM

import Data.Maybe
import System.FilePath


mainGFC :: Options -> [FilePath] -> IOE ()
mainGFC opts fs = 
    do gr <- batchCompile opts fs
       let cnc = justModuleName (last fs)
       if flag optStopAfterPhase opts == Compile 
         then return ()
         else do pgf <- link opts cnc gr
                 writeOutputs opts pgf

writeOutputs :: Options -> PGF -> IOE ()
writeOutputs opts pgf = mapM_ (\fmt -> writeOutput opts fmt pgf) (flag optOutputFormats opts)

writeOutput :: Options -> OutputFormat-> PGF -> IOE ()
writeOutput opts fmt pgf =
    do let name = fromMaybe (prCId (absname pgf)) (moduleFlag optName opts)
           path = outputFilePath opts fmt name
           s = prPGF fmt pgf name
       writeOutputFile path s

outputFilePath :: Options -> OutputFormat -> String -> FilePath
outputFilePath opts fmt name0 = addDir name <.> fmtExtension fmt
  where name = fromMaybe name0 (moduleFlag optName opts)
        addDir = maybe id (</>) (flag optOutputDir opts)

fmtExtension :: OutputFormat -> String
fmtExtension FmtPGF         = "pgf"
fmtExtension FmtJavaScript  = "js"
fmtExtension FmtHaskell     = "hs"
fmtExtension FmtHaskellGADT = "hs"

writeOutputFile :: FilePath -> String -> IOE ()
writeOutputFile outfile output = ioeIO $
      do writeFile outfile output
         putStrLn $ "wrote file " ++ outfile
