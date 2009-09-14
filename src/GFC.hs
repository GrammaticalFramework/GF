module GFC (mainGFC) where
-- module Main where

import PGF
import PGF.CId
import PGF.Data
import GF.Compile
import GF.Compile.Export

import GF.Grammar.CF ---- should this be on a deeper level? AR 15/10/2008

import GF.Infra.UseIO
import GF.Infra.Option
import GF.Data.ErrM

import Data.Maybe
import Data.Binary
import System.FilePath
import System.IO


mainGFC :: Options -> [FilePath] -> IOE ()
mainGFC opts fs = 
    case () of
      _ | null fs -> fail $ "No input files."
      _ | all (extensionIs ".cf")  fs -> compileCFFiles opts fs
      _ | all (\f -> extensionIs ".gf" f || extensionIs ".gfo" f)  fs -> compileSourceFiles opts fs
      _ | all (extensionIs ".pgf") fs -> unionPGFFiles opts fs
      _ -> fail $ "Don't know what to do with these input files: " ++ unwords fs
 where extensionIs ext = (== ext) .  takeExtension

compileSourceFiles :: Options -> [FilePath] -> IOE ()
compileSourceFiles opts fs = 
    do gr <- batchCompile opts fs
       let cnc = justModuleName (last fs)
       if flag optStopAfterPhase opts == Compile 
         then return ()
         else do pgf <- link opts cnc gr
                 writePGF opts pgf
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
                 writePGF opts pgf
                 writeOutputs opts pgf

unionPGFFiles :: Options -> [FilePath] -> IOE ()
unionPGFFiles opts fs = 
    do pgfs <- mapM readPGFVerbose fs
       let pgf = foldl1 unionPGF pgfs
           pgfFile = grammarName opts pgf <.> "pgf"
       if pgfFile `elem` fs 
         then putStrLnE $ "Refusing to overwrite " ++ pgfFile
         else writePGF opts pgf
       writeOutputs opts pgf
  where readPGFVerbose f = putPointE Normal opts ("Reading " ++ f ++ "...") $ ioeIO $ readPGF f

writeOutputs :: Options -> PGF -> IOE ()
writeOutputs opts pgf = do
  sequence_ [writeOutput opts name str 
                 | fmt <- flag optOutputFormats opts, 
                   (name,str) <- exportPGF opts fmt pgf]

writePGF :: Options -> PGF -> IOE ()
writePGF opts pgf = do
  let outfile = grammarName opts pgf <.> "pgf"
  putPointE Normal opts ("Writing " ++ outfile ++ "...") $ ioeIO $ encodeFile outfile pgf

grammarName :: Options -> PGF -> String
grammarName opts pgf = fromMaybe (showCId (absname pgf)) (flag optName opts)

writeOutput :: Options -> FilePath-> String -> IOE ()
writeOutput opts file str =
    do let path = case flag optOutputDir opts of
                    Nothing  -> file
                    Just dir -> dir </> file
       writeOutputFile opts path str

writeOutputFile :: Options -> FilePath -> String -> IOE ()
writeOutputFile opts outfile output = 
      do putPointE Normal opts ("Writing " ++ outfile ++ "...") $ ioeIO $ writeFile outfile output
