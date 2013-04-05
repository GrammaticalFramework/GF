module GF.Compile (batchCompile, link, compileToPGF, compileSourceGrammar) where
import Prelude hiding (catch)
import GF.System.Catch

-- the main compiler passes
import GF.Compile.GetGrammar
import GF.Compile.Rename
import GF.Compile.CheckGrammar
import GF.Compile.Optimize(optimizeModule)
import GF.Compile.SubExOpt
import GF.Compile.GeneratePMCFG
import GF.Compile.GrammarToPGF
import GF.Compile.ReadFiles
import GF.Compile.Update
import GF.Compile.Refresh
import GF.Compile.Coding
import GF.Compile.Tags

import GF.Grammar.Grammar
import GF.Grammar.Lookup
import GF.Grammar.Printer
import GF.Grammar.Binary

import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.UseIO
import GF.Infra.CheckM
import GF.Data.Operations

import Control.Monad
import System.IO
import GF.System.Directory
import System.FilePath
import qualified Data.Map as Map
--import qualified Data.Set as Set
import Data.List(nub)
import Data.Maybe (isNothing)
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint

import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.Optimize
import PGF.Probabilistic


-- | Compiles a number of source files and builds a 'PGF' structure for them.
compileToPGF :: Options -> [FilePath] -> IOE PGF
compileToPGF opts fs =
    do gr <- batchCompile opts fs
       let name = justModuleName (last fs)
       link opts (identC (BS.pack name)) gr

link :: Options -> Ident -> SourceGrammar -> IOE PGF
link opts cnc gr = do
  let isv = (verbAtLeast opts Normal)
  putPointE Normal opts "linking ... " $ do
    let abs = err (const cnc) id $ abstractOfConcrete gr cnc
    pgf <- mkCanon2pgf opts gr abs
    probs <- ioeIO (maybe (return . defaultProbabilities) readProbabilitiesFromFile (flag optProbsFile opts) pgf)
    ioeIO $ when (verbAtLeast opts Normal) $ putStrFlush "OK"     
    return $ setProbabilities probs 
           $ if flag optOptimizePGF opts then optimizePGF pgf else pgf

batchCompile :: Options -> [FilePath] -> IOE SourceGrammar
batchCompile opts files = do
  (_,gr,_) <- foldM (compileModule opts) emptyCompileEnv files
  return gr

-- to compile a set of modules, e.g. an old GF or a .cf file
compileSourceGrammar :: Options -> SourceGrammar -> IOE SourceGrammar
compileSourceGrammar opts gr = do
  (_,gr',_) <- foldM (\env -> compileSourceModule opts env Nothing)
                     (0,emptySourceGrammar,Map.empty)
                     (modules gr)
  return gr'


-- to output an intermediate stage
intermOut :: Options -> Dump -> Doc -> IOE ()
intermOut opts d doc
  | dump opts d = ioeIO (hPutStrLn stderr (render (text "\n\n--#" <+> text (show d) $$ doc)))
  | otherwise   = return ()

warnOut opts warnings
  | null warnings = return ()
  | otherwise     = ioeIO $ hPutStrLn stderr ws `catch` oops
  where
    oops _ = hPutStrLn stderr "" -- prevent crash on character encoding problem
    ws = if flag optVerbosity opts == Normal
         then '\n':warnings
         else warnings

-- | the environment
type CompileEnv = (Int,SourceGrammar,ModEnv)

-- | compile with one module as starting point
-- command-line options override options (marked by --#) in the file
-- As for path: if it is read from file, the file path is prepended to each name.
-- If from command line, it is used as it is.

compileModule :: Options -- ^ Options from program command line and shell command.
              -> CompileEnv -> FilePath -> IOE CompileEnv
compileModule opts1 env file = do
  file <- getRealFile file
  opts0 <- getOptionsFromFile file
  curr_dir <- return $ dropFileName file
  lib_dir  <- ioeIO $ getLibraryDirectory (addOptions opts0 opts1)
  let opts = addOptions (fixRelativeLibPaths curr_dir lib_dir opts0) opts1
  ps0 <- ioeIO $ extendPathEnv opts
  let ps = nub (curr_dir : ps0)
  ioeIO $ putIfVerb opts $ "module search path:" +++ show ps ----
  let (_,sgr,rfs) = env
  files <- getAllFiles opts ps rfs file
  ioeIO $ putIfVerb opts $ "files to read:" +++ show files ----
  let names = map justModuleName files
  ioeIO $ putIfVerb opts $ "modules to include:" +++ show names ----
  foldM (compileOne opts) (0,sgr,rfs) files
  where
    getRealFile file = do
      exists <- ioeIO $ doesFileExist file
      if exists
        then return file
        else if isRelative file
               then do lib_dir <- ioeIO $ getLibraryDirectory opts1
                       let file1 = lib_dir </> file
                       exists <- ioeIO $ doesFileExist file1
                       if exists
                         then return file1
                         else ioeErr $ Bad (render (text "None of these files exists:" $$ nest 2 (text file $$ text file1)))
               else ioeErr $ Bad (render (text "File" <+> text file <+> text "does not exist."))

compileOne :: Options -> CompileEnv -> FullPath -> IOE CompileEnv
compileOne opts env@(_,srcgr,_) file = do

  let putpOpt v m act
       | verbAtLeast opts Verbose = putPointE Normal opts v act
       | verbAtLeast opts Normal  = ioeIO (putStrFlush m) >> act
       | otherwise                = putPointE Verbose opts v act

  let path = dropFileName file
  let name = dropExtension file

  case takeExtensions file of

    -- for compiled gf, read the file and update environment
    -- also undo common subexp optimization, to enable normal computations
    ".gfo" -> do
       sm00 <- putPointE Verbose opts ("+ reading" +++ file) $ ioeIO (decodeModule file)
       let sm0 = (fst sm00, (snd sm00) {mflags = mflags (snd sm00) `addOptions` opts})

       intermOut opts (Dump Source) (ppModule Internal sm0)

       let sm1 = unsubexpModule sm0
       (sm,warnings) <- {- putPointE Normal opts "creating indirections" $ -} ioeErr $ runCheck $ extendModule srcgr sm1
       warnOut opts warnings

       if flag optTagsOnly opts
         then writeTags opts srcgr (gf2gftags opts file) sm1
         else return ()

       extendCompileEnv env file sm

    -- for gf source, do full compilation and generate code
    _ -> do

      b1 <- ioeIO $ doesFileExist file
      if not b1
        then compileOne opts env $ (gf2gfo opts file)
        else do

       sm00 <- putpOpt ("- parsing" +++ file) ("- compiling" +++ file ++ "... ") $ 
                                           getSourceModule opts file
       enc <- ioeIO $ mkTextEncoding (renameEncoding (flag optEncoding (mflags (snd sm00))))
       let sm = decodeStringsInModule enc sm00

       intermOut opts (Dump Source) (ppModule Internal sm)

       compileSourceModule opts env (Just file) sm
  where
   isConcr (_,m) = isModCnc m && mstatus m /= MSIncomplete

compileSourceModule :: Options -> CompileEnv -> Maybe FilePath -> SourceModule -> IOE CompileEnv
compileSourceModule opts env@(k,gr,_) mb_gfFile mo@(i,mi) = do

  mo1  <- runPass Rebuild "" (rebuildModule gr mo)
  mo1b <- runPass Extend "" (extendModule gr mo1)

  case mo1b of
    (_,n) | not (isCompleteModule n) ->
      if tagsFlag then generateTags k mo1b else generateGFO k mo1b
    _ -> do
      mo2 <- runPass Rename "renaming" $ renameModule gr mo1b
      mo3 <- runPass TypeCheck "type checking" $ checkModule opts gr mo2
      if tagsFlag then generateTags k mo3 else compileCompleteModule k mo3
  where
    compileCompleteModule k mo3 = do
      (k',mo3r:_) <- runPass2 (head.snd) Refresh "refreshing" $
                     refreshModule (k,gr) mo3
      mo4 <- runPass2 id Optimize "optimizing" $ optimizeModule opts gr mo3r
      mo5 <- if isModCnc (snd mo4) && flag optPMCFG opts
             then runPass2' "generating PMCFG" $ generatePMCFG opts gr mb_gfFile mo4
             else runPass2' "" $ return mo4
      generateGFO k' mo5

  ------------------------------
    tagsFlag = flag optTagsOnly opts

    generateGFO k mo =
      do let mb_gfo = fmap (gf2gfo opts) mb_gfFile
         maybeM (flip (writeGFO opts) mo) mb_gfo
         extendCompileEnvInt env k mb_gfo mo

    generateTags k mo =
      do maybeM (flip (writeTags opts gr) mo . gf2gftags opts) mb_gfFile
         extendCompileEnvInt env k Nothing mo

    putpp s = if null s then id else putPointE Verbose opts ("  "++s++" ")
    idump pass = intermOut opts (Dump pass) . ppModule Internal

    -- * Impedance matching
    runPass = runPass' fst fst snd (ioeErr . runCheck)
    runPass2 = runPass2e ioeErr
    runPass2' = runPass2e id id Canon
    runPass2e lift f = runPass' id f (const "") lift

    runPass' ret dump warn lift pass pp m =
        do out <- putpp pp $ lift m
           warnOut opts (warn out)
           idump pass (dump out)
           return (ret out)

    maybeM f = maybe (return ()) f


writeGFO :: Options -> FilePath -> SourceModule -> IOE ()
writeGFO opts file mo = do
  let mo1 = subexpModule mo
      mo2 = case mo1 of
              (m,mi) -> (m,mi{jments=Map.filter (\x -> case x of {AnyInd _ _ -> False; _ -> True}) (jments mi)})
  putPointE Normal opts ("  write file" +++ file) $ ioeIO $ encodeModule file mo2

-- auxiliaries

--reverseModules (MGrammar ms) = MGrammar $ reverse ms

emptyCompileEnv :: CompileEnv
emptyCompileEnv = (0,emptySourceGrammar,Map.empty)

extendCompileEnvInt (_,gr,menv) k mfile mo = do
  menv2 <- case mfile of
    Just file -> do
      let (mod,imps) = importsOfModule mo
      t <- ioeIO $ getModificationTime file
      return $ Map.insert mod (t,imps) menv
    _ -> return menv
  return (k,prependModule gr mo,menv2) --- reverse later

extendCompileEnv e@(k,_,_) file mo = extendCompileEnvInt e k (Just file) mo
