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
import qualified Data.Map as Map

-- import a grammar in an environment where it extends an existing grammar
importGrammar :: Maybe PGF -> Options -> [FilePath] -> IO (Maybe PGF)
importGrammar pgf0 _    []    = return pgf0
importGrammar pgf0 opts files =
  case takeExtensions (last files) of
    ".cf"   -> fmap Just $ importCF opts files getBNFCRules bnfc2cf
    ".ebnf" -> fmap Just $ importCF opts files getEBNFRules ebnf2cf
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

ioUnionPGF :: Maybe PGF -> PGF -> IO (Maybe PGF)
ioUnionPGF Nothing    two = return (Just two)
ioUnionPGF (Just one) two =
  case msgUnionPGF one two of
    (pgf, Just msg) -> putStrLn msg >> return (Just pgf)
    (pgf,_)         -> return (Just pgf)

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
      probs <- maybe (return Map.empty) readProbabilitiesFromFile (flag optProbsFile opts)
      let pgf = cf2pgf (last files) (mkCFG startCat Set.empty rules) probs
      return $ if flag optOptimizePGF opts then optimizePGF pgf else pgf
