module GFC (mainGFC, writePGF) where
-- module Main where

import PGF
import PGF.Internal(PGF,abstract,concretes,code,funs,cats,optimizePGF,unionPGF)
import PGF.Internal(putSplitAbs)
import GF.Compile
import GF.Compile.Export
import GF.Compile.CFGtoPGF
import GF.Compile.GetGrammar
import GF.Grammar.CFG

import GF.Infra.Ident(showIdent)
import GF.Infra.UseIO
import GF.Infra.Option
import GF.Data.ErrM
import GF.System.Directory

import Data.Maybe
import PGF.Internal(encode,encodeFile,runPut)
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.ByteString as BSS
import qualified Data.ByteString.Lazy as BSL
import System.FilePath
import System.IO
import Control.Monad(unless,forM_)

mainGFC :: Options -> [FilePath] -> IO ()
mainGFC opts fs = do
  r <- appIOE (case () of
                 _ | null fs -> fail $ "No input files."
                 _ | all (extensionIs ".cf")  fs -> compileCFFiles opts fs
                 _ | all (\f -> extensionIs ".gf" f || extensionIs ".gfo" f)  fs -> compileSourceFiles opts fs
                 _ | all (extensionIs ".pgf") fs -> unionPGFFiles opts fs
                 _ -> fail $ "Don't know what to do with these input files: " ++ unwords fs)
  case r of
    Ok x    -> return x
    Bad msg -> die $ if flag optVerbosity opts == Normal
                       then ('\n':msg)
                       else msg
 where
   extensionIs ext = (== ext) .  takeExtension

compileSourceFiles :: Options -> [FilePath] -> IOE ()
compileSourceFiles opts fs = 
    do cnc_gr@(cnc,t_src,gr) <- batchCompile opts fs
       unless (flag optStopAfterPhase opts == Compile) $
              do let abs = showIdent (srcAbsName gr cnc)
                     pgfFile = outputPath opts (grammarName' opts abs<.>"pgf")
                 t_pgf <- if outputJustPGF opts
                          then maybeIO $ getModificationTime pgfFile
                          else return Nothing
                 if t_pgf >= Just t_src
                   then putIfVerb opts $ pgfFile ++ " is up-to-date."
                   else do pgf <- link opts cnc_gr
                           writePGF opts pgf
                           writeByteCode opts pgf
                           writeOutputs opts pgf

compileCFFiles :: Options -> [FilePath] -> IOE ()
compileCFFiles opts fs = do
  rules <- fmap concat $ mapM (getCFRules opts) fs
  startCat <- case rules of
                (CFRule cat _ _ : _) -> return cat
                _                    -> fail "empty CFG"
  let pgf = cf2pgf (last fs) (uniqueFuns (mkCFG startCat Set.empty rules))
  let cnc = justModuleName (last fs)
  unless (flag optStopAfterPhase opts == Compile) $
     do probs <- liftIO (maybe (return . defaultProbabilities) readProbabilitiesFromFile (flag optProbsFile opts) pgf)
        let pgf' = setProbabilities probs $ if flag optOptimizePGF opts then optimizePGF pgf else pgf
        writePGF opts pgf'
        writeOutputs opts pgf'

unionPGFFiles :: Options -> [FilePath] -> IOE ()
unionPGFFiles opts fs =
    if outputJustPGF opts
    then maybe doIt checkFirst (flag optName opts)
    else doIt
  where
    checkFirst name =
      do let pgfFile = outputPath opts (name <.> "pgf")
         sourceTime <- liftIO $ maximum `fmap` mapM getModificationTime fs
         targetTime <- maybeIO $ getModificationTime pgfFile
         if targetTime >= Just sourceTime
           then putIfVerb opts $ pgfFile ++ " is up-to-date."
           else doIt

    doIt =
      do pgfs <- mapM readPGFVerbose fs
         let pgf0 = foldl1 unionPGF pgfs
             pgf  = if flag optOptimizePGF opts then optimizePGF pgf0 else pgf0
             pgfFile = outputPath opts (grammarName opts pgf <.> "pgf")
         if pgfFile `elem` fs
           then putStrLnE $ "Refusing to overwrite " ++ pgfFile
           else writePGF opts pgf
         writeOutputs opts pgf

    readPGFVerbose f =
        putPointE Normal opts ("Reading " ++ f ++ "...") $ liftIO $ readPGF f

writeOutputs :: Options -> PGF -> IOE ()
writeOutputs opts pgf = do
  sequence_ [writeOutput opts name str 
                 | fmt <- outputFormats opts,
                   (name,str) <- exportPGF opts fmt pgf]

writeByteCode :: Options -> PGF -> IOE ()
writeByteCode opts pgf
  | elem FmtByteCode (flag optOutputFormats opts) =
             let path = outputPath opts (grammarName opts pgf <.> "bc")
             in writing opts path $
                  withBinaryFile path WriteMode
                      (\h -> do BSL.hPut h (encode addrs)
                                BSS.hPut h (code (abstract pgf)))
  | otherwise = return ()
  where
    addrs = 
      [(id,addr) | (id,(_,_,_,_,addr)) <- Map.toList (funs (abstract pgf))] ++
      [(id,addr) | (id,(_,_,_,addr))   <- Map.toList (cats (abstract pgf))]

writePGF :: Options -> PGF -> IOE ()
writePGF opts pgf =
    if flag optSplitPGF opts then writeSplitPGF else writeNormalPGF
  where
    writeNormalPGF =
       do let outfile = outputPath opts (grammarName opts pgf <.> "pgf")
          writing opts outfile $ encodeFile outfile pgf

    writeSplitPGF =
      do let outfile = outputPath opts (grammarName opts pgf <.> "pgf")
         writing opts outfile $ BSL.writeFile outfile (runPut (putSplitAbs pgf))
                                --encodeFile_ outfile (putSplitAbs pgf)
         forM_ (Map.toList (concretes pgf)) $ \cnc -> do
           let outfile = outputPath opts (showCId (fst cnc) <.> "pgf_c")
           writing opts outfile $ encodeFile outfile cnc


writeOutput :: Options -> FilePath-> String -> IOE ()
writeOutput opts file str = writing opts path $ writeUTF8File path str
  where path = outputPath opts file

-- * Useful helper functions

grammarName :: Options -> PGF -> String
grammarName opts pgf = grammarName' opts (showCId (abstractName pgf))
grammarName' opts abs = fromMaybe abs (flag optName opts)

outputFormats opts = [fmt | fmt <- flag optOutputFormats opts, fmt/=FmtByteCode]
outputJustPGF opts = null (flag optOutputFormats opts) && not (flag optSplitPGF opts)

outputPath opts file = maybe id (</>) (flag optOutputDir opts) file

writing opts path io =
    putPointE Normal opts ("Writing " ++ path ++ "...") $ liftIO io
