module GF.Compile (batchCompile, link, srcAbsName, compileToPGF) where

import GF.Compile.GrammarToPGF(mkCanon2pgf)
import GF.Compile.ReadFiles(ModEnv,getOptionsFromFile,getAllFiles,
                            importsOfModule)
import GF.CompileOne(compileOne)

import GF.Grammar.Grammar(SourceGrammar,msrc,modules,emptySourceGrammar,
                          abstractOfConcrete,prependModule)

import GF.Infra.Ident(Ident,identS,showIdent)
import GF.Infra.Option
import GF.Infra.UseIO(IOE,FullPath,liftIO,getLibraryDirectory,putIfVerb,
                      justModuleName,extendPathEnv,putStrE,putPointE)
import GF.Data.Operations(raise,(+++),err)

import Control.Monad(foldM,when)
import GF.System.Directory(doesFileExist,getModificationTime)
import System.FilePath((</>),isRelative,dropFileName)
import qualified Data.Map as Map(empty,insert,lookup,elems)
import Data.List(nub)
import Data.Time(UTCTime)
import GF.Text.Pretty(render,($$),(<+>),nest)

import PGF.Internal(optimizePGF)
import PGF(PGF,defaultProbabilities,setProbabilities,readProbabilitiesFromFile)

-- | Compiles a number of source files and builds a 'PGF' structure for them.
compileToPGF :: Options -> [FilePath] -> IOE PGF
compileToPGF opts fs = link opts =<< batchCompile opts fs

link :: Options -> (Ident,t,SourceGrammar) -> IOE PGF
link opts (cnc,_,gr) =
  putPointE Normal opts "linking ... " $ do
    let abs = srcAbsName gr cnc
    pgf <- mkCanon2pgf opts gr abs
    probs <- liftIO (maybe (return . defaultProbabilities) readProbabilitiesFromFile (flag optProbsFile opts) pgf)
    when (verbAtLeast opts Normal) $ putStrE "OK"
    return $ setProbabilities probs 
           $ if flag optOptimizePGF opts then optimizePGF pgf else pgf

srcAbsName gr cnc = err (const cnc) id $ abstractOfConcrete gr cnc

batchCompile :: Options -> [FilePath] -> IOE (Ident,UTCTime,SourceGrammar)
batchCompile opts files = do
  (gr,menv) <- foldM (compileModule opts) emptyCompileEnv files
  let cnc = identS (justModuleName (last files))
      t = maximum . map fst $ Map.elems menv
  return (cnc,t,gr)
{-
-- to compile a set of modules, e.g. an old GF or a .cf file
compileSourceGrammar :: Options -> SourceGrammar -> IOE SourceGrammar
compileSourceGrammar opts gr = do
  cwd <- liftIO getCurrentDirectory
  (_,gr',_) <- foldM (\env -> compileSourceModule opts cwd env Nothing)
                     emptyCompileEnv
                     (modules gr)
  return gr'
-}

-- | compile with one module as starting point
-- command-line options override options (marked by --#) in the file
-- As for path: if it is read from file, the file path is prepended to each name.
-- If from command line, it is used as it is.

compileModule :: Options -- ^ Options from program command line and shell command.
              -> CompileEnv -> FilePath -> IOE CompileEnv
compileModule opts1 env@(_,rfs) file =
  do file <- getRealFile file
     opts0 <- getOptionsFromFile file
     let curr_dir = dropFileName file
     lib_dir  <- liftIO $ getLibraryDirectory (addOptions opts0 opts1)
     let opts = addOptions (fixRelativeLibPaths curr_dir lib_dir opts0) opts1
     ps0 <- extendPathEnv opts
     let ps = nub (curr_dir : ps0)
     putIfVerb opts $ "module search path:" +++ show ps ----
     files <- getAllFiles opts ps rfs file
     putIfVerb opts $ "files to read:" +++ show files ----
     let names = map justModuleName files
     putIfVerb opts $ "modules to include:" +++ show names ----
     foldM (compileOne' opts) env files
  where
    getRealFile file = do
      exists <- liftIO $ doesFileExist file
      if exists
        then return file
        else if isRelative file
               then do lib_dir <- liftIO $ getLibraryDirectory opts1
                       let file1 = lib_dir </> file
                       exists <- liftIO $ doesFileExist file1
                       if exists
                         then return file1
                         else raise (render ("None of these files exists:" $$ nest 2 (file $$ file1)))
               else raise (render ("File" <+> file <+> "does not exist."))

compileOne' :: Options -> CompileEnv -> FullPath -> IOE CompileEnv
compileOne' opts env@(srcgr,_) file =
    extendCompileEnv env =<< compileOne opts srcgr file

-- auxiliaries

--reverseModules (MGrammar ms) = MGrammar $ reverse ms

-- | The environment
type CompileEnv = (SourceGrammar,ModEnv)

emptyCompileEnv :: CompileEnv
emptyCompileEnv = (emptySourceGrammar,Map.empty)

extendCompileEnv (gr,menv) (mfile,mo) = do
  menv2 <- case mfile of
    Just file -> do
      let (mod,imps) = importsOfModule mo
      t <- liftIO $ getModificationTime file
      return $ Map.insert mod (t,imps) menv
    _ -> return menv
  return (prependModule gr mo,menv2) --- reverse later
