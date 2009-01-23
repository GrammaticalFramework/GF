module GF.Compile (batchCompile, link, compileToPGF, compileSourceGrammar) where

-- the main compiler passes
import GF.Compile.GetGrammar
import GF.Compile.Extend
import GF.Compile.Rebuild
import GF.Compile.Rename
import GF.Compile.CheckGrammar
import GF.Compile.Optimize
import GF.Compile.OptimizeGF
import GF.Compile.OptimizeGFCC
import GF.Compile.GrammarToGFCC
import GF.Compile.ReadFiles
import GF.Compile.Update
import GF.Compile.Refresh

import GF.Compile.Coding
import GF.Text.UTF8 ----

import GF.Grammar.Grammar
import GF.Grammar.Lookup
import GF.Grammar.PrGrammar
import GF.Grammar.Binary

import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.Modules
import GF.Infra.UseIO

import GF.Source.GrammarToSource
import qualified GF.Source.AbsGF as A
import qualified GF.Source.PrintGF as P

import GF.Data.Operations

import Control.Monad
import System.Directory
import System.FilePath
import qualified Data.Map as Map
import qualified Data.Set as Set
import Data.List(nub)
import Data.Maybe (isNothing)
import Data.Binary

import PGF.Check
import PGF.CId
import PGF.Data
import PGF.Macros


-- | Compiles a number of source files and builds a 'PGF' structure for them.
compileToPGF :: Options -> [FilePath] -> IOE PGF
compileToPGF opts fs =
    do gr <- batchCompile opts fs
       let name = justModuleName (last fs)
       link opts name gr

link :: Options -> String -> SourceGrammar -> IOE PGF
link opts cnc gr = do
       let isv = (verbAtLeast opts Normal)
       gc1 <- putPointE Normal opts "linking ... " $
                let (abs,gc0) = mkCanon2gfcc opts cnc gr
                in case checkPGF gc0 of
		     Ok (gc,b) -> do 
                       case (isv,b) of
                         (True, True) -> ioeIO $ putStrLn "OK" 
                         (False,True) -> return ()
                         _            -> ioeIO $ putStrLn $ "Corrupted PGF"
		       return gc
		     Bad s -> fail s
       return $ buildParser opts $ optimize opts gc1

optimize :: Options -> PGF -> PGF
optimize opts = cse . suf
  where os  = flag optOptimizations opts
        cse = if OptCSE  `Set.member` os then cseOptimize    else id
        suf = if OptStem `Set.member` os then suffixOptimize else id

buildParser :: Options -> PGF -> PGF
buildParser opts = 
    case flag optBuildParser opts of
      BuildParser         -> addParsers opts
      DontBuildParser     -> id
      BuildParserOnDemand -> mapConcretes (\cnc -> cnc { cflags = Map.insert (mkCId "parser") "ondemand" (cflags cnc) })

batchCompile :: Options -> [FilePath] -> IOE SourceGrammar
batchCompile opts files = do
  (_,gr,_) <- foldM (compileModule opts) emptyCompileEnv files
  return gr

-- to compile a set of modules, e.g. an old GF or a .cf file
compileSourceGrammar :: Options -> SourceGrammar -> IOE SourceGrammar
compileSourceGrammar opts gr@(MGrammar ms) = do
  (_,gr',_) <- foldM compOne (0,emptySourceGrammar,Map.empty) ms
  return gr'
 where
  compOne env mo = do
    (k,mo') <- compileSourceModule opts env mo
    extendCompileEnvInt env k Nothing mo'    --- file for the same of modif time...

-- to output an intermediate stage
intermOut :: Options -> Dump -> String -> IOE ()
intermOut opts d s = if dump opts d then 
  ioeIO (putStrLn ("\n\n--#" +++ show d) >> putStrLn s) 
  else return ()


-- | the environment
type CompileEnv = (Int,SourceGrammar,ModEnv)

-- | compile with one module as starting point
-- command-line options override options (marked by --#) in the file
-- As for path: if it is read from file, the file path is prepended to each name.
-- If from command line, it is used as it is.

compileModule :: Options -- ^ Options from program command line and shell command.
              -> CompileEnv -> FilePath -> IOE CompileEnv
compileModule opts1 env file = do
  opts0 <- getOptionsFromFile file
  let opts = addOptions opts0 opts1
  let fdir = dropFileName file
  let ps0 = flag optLibraryPath opts
  ps1 <- ioeIO $ extendPathEnv $ fdir : ps0
  let ps2 = ps1 ++ map (fdir </>) ps0
  ps <- ioeIO $ fmap nub $ mapM canonicalizePath ps2
  ioeIO $ putIfVerb opts $ "module search path:" +++ show ps ----
  let (_,sgr,rfs) = env
  files <- getAllFiles opts ps rfs file
  ioeIO $ putIfVerb opts $ "files to read:" +++ show files ----
  let names = map justModuleName files
  ioeIO $ putIfVerb opts $ "modules to include:" +++ show names ----
  foldM (compileOne opts) (0,sgr,rfs) files

compileOne :: Options -> CompileEnv -> FullPath -> IOE CompileEnv
compileOne opts env@(_,srcgr,_) file = do

  let putpOpt v m act
       | verbAtLeast opts Verbose = putPointE Normal opts v act
       | verbAtLeast opts Normal  = ioeIO (putStrFlush m) >> act
       | otherwise                = putPointE Verbose opts v act

  let gf   = takeExtensions file
  let path = dropFileName file
  let name = dropExtension file
  let mos  = modules srcgr

  case gf of

    -- for compiled gf, read the file and update environment
    -- also undo common subexp optimization, to enable normal computations
    ".gfo" -> do
       sm0 <- putPointE Normal opts ("+ reading" +++ file) $ ioeIO (decodeFile file)
       let sm1 = unsubexpModule sm0
       sm <- {- putPointE Normal opts "creating indirections" $ -} ioeErr $ extendModule mos sm1
       
       extendCompileEnv env file sm

    -- for gf source, do full compilation and generate code
    _ -> do

      let gfo = gfoFile (dropExtension file)
      b1 <- ioeIO $ doesFileExist file
      if not b1
        then compileOne opts env $ gfo
        else do

       sm00 <- putpOpt ("- parsing" +++ file) ("- compiling" +++ file ++ "... ") $ 
                                           getSourceModule opts file
       let sm0 = decodeStringsInModule sm00
       (k',sm)  <- compileSourceModule opts env sm0
       let sm1 = if isConcr sm then shareModule sm else sm -- cannot expand Str
       cm  <- putPointE Verbose opts "  generating code... " $ generateModuleCode opts gfo sm1
          -- sm is optimized before generation, but not in the env
       extendCompileEnvInt env k' (Just gfo) sm1
  where
   isConcr (_,m) = isModCnc m && mstatus m /= MSIncomplete && isNothing (mwith m)

compileSourceModule :: Options -> CompileEnv -> SourceModule -> IOE (Int,SourceModule)
compileSourceModule opts env@(k,gr,_) mo@(i,mi) = do

  let putp  = putPointE Normal opts
      putpp = putPointE Verbose opts
      mos   = modules gr

  mo1   <- ioeErr $ rebuildModule mos mo
  intermOut opts DumpRebuild (prModule mo1)

  mo1b  <- ioeErr $ extendModule mos mo1
  intermOut opts DumpExtend (prModule mo1b)

  case mo1b of
    (_,n) | not (isCompleteModule n) -> do
      return (k,mo1b)   -- refresh would fail, since not renamed
    _ -> do
      mo2:_ <- putpp "  renaming " $ ioeErr $ renameModule mos mo1b
      intermOut opts DumpRename (prModule mo2)

      (mo3:_,warnings) <- putpp "  type checking" $ ioeErr $ showCheckModule mos mo2
      if null warnings then return () else putp warnings $ return ()
      intermOut opts DumpTypeCheck (prModule mo3)

      (k',mo3r:_) <- putpp "  refreshing " $ ioeErr $ refreshModule (k,mos) mo3
      intermOut opts DumpRefresh (prModule mo3r)

      let eenv = () --- emptyEEnv
      (mo4,eenv') <- 
        ---- if oElem "check_only" opts 
          putpp "  optimizing " $ ioeErr $ optimizeModule opts (mos,eenv) mo3r
      return (k',mo4)
 where
   ----   prDebug mo = ioeIO $ putStrLn $ prGrammar $ MGrammar [mo] ---- debug
   prDebug mo = ioeIO $ print $ length $ lines $ prGrammar $ MGrammar [mo]

generateModuleCode :: Options -> FilePath -> SourceModule -> IOE SourceModule
generateModuleCode opts file minfo = do
  let minfo1 = subexpModule minfo
      minfo2 = case minfo1 of
                 (m,mi) -> (m,mi{jments=Map.filter (\x -> case x of {AnyInd _ _ -> False; _ -> True}) (jments mi)
                                , positions=Map.empty})
  putPointE Normal opts ("  wrote file" +++ file) $ ioeIO $ encodeFile file minfo2
  return minfo1

-- auxiliaries

reverseModules (MGrammar ms) = MGrammar $ reverse ms

emptyCompileEnv :: CompileEnv
emptyCompileEnv = (0,emptyMGrammar,Map.empty)

extendCompileEnvInt (_,MGrammar ss,menv) k mfile sm = do
  let (mod,imps) = importsOfModule sm
  menv2 <- case mfile of
    Just file -> do
      t <- ioeIO $ getModificationTime file
      return $ Map.insert mod (t,imps) menv
    _ -> return menv
  return (k,MGrammar (sm:ss),menv2) --- reverse later

extendCompileEnv e@(k,_,_) file sm = extendCompileEnvInt e k (Just file) sm


