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
writeOutputs opts pgf =
    sequence_ [writeOutput opts name str 
                   | fmt <- flag optOutputFormats opts, 
                     (name,str) <- exportPGF opts fmt pgf]

writeOutput :: Options -> FilePath-> String -> IOE ()
writeOutput opts file str =
    do let path = case flag optOutputDir opts of
                    Nothing  -> file
                    Just dir -> dir </> file
       writeOutputFile path str

writeOutputFile :: FilePath -> String -> IOE ()
writeOutputFile outfile output = ioeIO $
      do writeFile outfile output
         putStrLn $ "wrote file " ++ outfile
