module GF.Command.Importing (importGrammar, importSource) where

import PGF
import PGF.Data

import GF.Compile
import GF.Grammar.Grammar (SourceGrammar) -- for cc command
import GF.Infra.UseIO
import GF.Infra.Option
import GF.Data.ErrM
import GF.Source.CF

import Data.List (nubBy)
import System.FilePath

-- import a grammar in an environment where it extends an existing grammar
importGrammar :: PGF -> Options -> [FilePath] -> IO PGF
importGrammar pgf0 _ [] = return pgf0
importGrammar pgf0 opts files =
  case takeExtensions (last files) of
    ".cf" -> do
       s  <- fmap unlines $ mapM readFile files 
       let cnc = justModuleName (last files)
       gf <- case getCF cnc s of
               Ok g -> return g
               Bad s -> error s ---- 
       Ok gr <- appIOE $ compileSourceGrammar opts gf
       epgf <- appIOE $ link opts (cnc ++ "Abs") gr
       case epgf of
         Ok pgf -> return pgf
         Bad s -> error s ----
    s | elem s [".gf",".gfo"] -> do
      res <- appIOE $ compileToPGF opts files
      case res of
        Ok pgf2 -> do return $ unionPGF pgf0 pgf2
        Bad msg -> do putStrLn msg
                      return pgf0
    ".pgf" -> do
      pgf2 <- mapM readPGF files >>= return . foldl1 unionPGF
      return $ unionPGF pgf0 pgf2
    ext -> die $ "Unknown filename extension: " ++ show ext

importSource :: SourceGrammar -> Options -> [FilePath] -> IO SourceGrammar
importSource src0 opts files = do
  src <- appIOE $ batchCompile opts files
  case src of
    Ok gr -> return gr
    Bad msg -> do 
      putStrLn msg
      return src0
