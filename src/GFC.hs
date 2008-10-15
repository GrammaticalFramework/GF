module GFC (mainGFC) where
-- module Main where

import PGF
import PGF.CId
import PGF.Data
import PGF.Raw.Parse
import PGF.Raw.Convert
import GF.Compile
import GF.Compile.Export

import GF.Source.CF ---- should this be on a deeper level? AR 15/10/2008

import GF.Infra.UseIO
import GF.Infra.Option
import GF.Data.ErrM

import Data.Maybe
import System.FilePath


mainGFC :: Options -> [FilePath] -> IOE ()
mainGFC opts fs = 
    case () of
      _ | null fs -> fail $ "No input files."
      _ | all (extensionIs ".cf")  fs -> compileCFFiles opts fs
      _ | all (extensionIs ".gf")  fs -> compileSourceFiles opts fs
      _ | all (extensionIs ".pgf") fs -> unionPGFFiles opts fs
      _ -> fail $ "Don't know what to do with these input files: " ++ show fs
 where extensionIs ext = (== ext) .  takeExtension

compileSourceFiles :: Options -> [FilePath] -> IOE ()
compileSourceFiles opts fs = 
    do gr <- batchCompile opts fs
       let cnc = justModuleName (last fs)
       if flag optStopAfterPhase opts == Compile 
         then return ()
         else do pgf <- link opts cnc gr
                 writeOutputs opts pgf

compileCFFiles :: Options -> [FilePath] -> IOE ()
compileCFFiles opts fs = 
    do s  <- ioeIO $ fmap unlines $ mapM readFile fs 
       let cnc = justModuleName (last fs)
       gf <- ioeErr $ getCF cnc s
       gr <- compileSourceGrammar opts gf
       if flag optStopAfterPhase opts == Compile 
         then return ()
         else do pgf <- link opts cnc gr
                 writeOutputs opts pgf

unionPGFFiles :: Options -> [FilePath] -> IOE ()
unionPGFFiles opts fs = 
    do pgfs <- ioeIO $ mapM readPGF fs
       let pgf = foldl1 unionPGF pgfs
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
