module GF.Command.Importing (importGrammar, importSource) where

import PGF
import PGF.Internal(optimizePGF,unionPGF,msgUnionPGF)

import GF.Compile
import GF.Compile.Multi (readMulti)
import GF.Compile.GetGrammar (getBNFCRules, getEBNFRules)
import GF.Grammar (SourceGrammar) -- for cc command
import GF.Grammar.BNFC
import GF.Grammar.EBNF
import GF.Grammar.CFG
import GF.Compile.CFGtoPGF
import GF.Infra.UseIO(die,tryIOE)
import GF.Infra.Option
import GF.Data.ErrM

import System.FilePath
import qualified Data.Set as Set

-- import a grammar in an environment where it extends an existing grammar
importGrammar :: PGF -> Options -> [FilePath] -> IO PGF
importGrammar pgf0 _ [] = return pgf0
importGrammar pgf0 opts files =
  case takeExtensions (last files) of
    ".cf"   -> importCF opts files getBNFCRules bnfc2cf
    ".ebnf" -> importCF opts files getEBNFRules ebnf2cf
    ".gfm"  -> do
      ascss <- mapM readMulti files
      let cs = concatMap snd ascss
      importGrammar pgf0 opts cs
    s | elem s [".gf",".gfo"] -> do
      res <- tryIOE $ compileToPGF opts files
      case res of
        Ok pgf2 -> ioUnionPGF pgf0 pgf2
        Bad msg -> do putStrLn ('\n':'\n':msg)
                      return pgf0
    ".pgf" -> do
      pgf2 <- mapM readPGF files >>= return . foldl1 unionPGF
      ioUnionPGF pgf0 pgf2
    ext -> die $ "Unknown filename extension: " ++ show ext

ioUnionPGF :: PGF -> PGF -> IO PGF
ioUnionPGF one two = case msgUnionPGF one two of
  (pgf, Just msg) -> putStrLn msg >> return pgf
  (pgf,_)         -> return pgf

importSource :: Options -> [FilePath] -> IO SourceGrammar
importSource opts files = fmap (snd.snd) (batchCompile opts files)

-- for different cf formats
importCF opts files get convert = impCF
  where
    impCF = do
      rules <- fmap (convert . concat) $ mapM (get opts) files
      startCat <- case rules of
                    (Rule cat _ _ : _) -> return cat
                    _                  -> fail "empty CFG"
      let pgf = cf2pgf (last files) (uniqueFuns (mkCFG startCat Set.empty rules))
      probs <- maybe (return . defaultProbabilities) readProbabilitiesFromFile (flag optProbsFile opts) pgf
      return $ setProbabilities probs 
             $ if flag optOptimizePGF opts then optimizePGF pgf else pgf
