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
         else do gfcc <- link opts cnc gr
                 writeOutputs opts gfcc

writeOutputs :: Options -> GFCC -> IOE ()
writeOutputs opts gfcc = mapM_ (\fmt -> writeOutput opts fmt gfcc) (flag optOutputFormats opts)

writeOutput :: Options -> OutputFormat-> GFCC -> IOE ()
writeOutput opts fmt gfcc =
    do let path = outputFilePath opts fmt (prCId (absname gfcc))
           s = prGFCC fmt gfcc
       writeOutputFile path s

outputFilePath :: Options -> OutputFormat -> String -> FilePath
outputFilePath opts fmt name0 = addDir name <.> fmtExtension fmt
  where name = fromMaybe name0 (moduleFlag optName opts)
        addDir = maybe id (</>) (flag optOutputDir opts)

fmtExtension :: OutputFormat -> String
fmtExtension FmtGFCC        = "gfcc"
fmtExtension FmtJavaScript  = "js"
fmtExtension FmtHaskell     = "hs"
fmtExtension FmtHaskellGADT = "hs"

writeOutputFile :: FilePath -> String -> IOE ()
writeOutputFile outfile output = ioeIO $
      do writeFile outfile output
         putStrLn $ "wrote file " ++ outfile
