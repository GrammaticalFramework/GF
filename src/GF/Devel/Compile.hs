module GF.Devel.Compile (batchCompile) where

-- the main compiler passes
import GF.Devel.GetGrammar
import GF.Compile.Extend
import GF.Compile.Rebuild
import GF.Compile.Rename
import GF.Grammar.Refresh
import GF.Devel.CheckGrammar
import GF.Devel.Optimize
--import GF.Compile.Evaluate ----
import GF.Devel.OptimizeGF
--import GF.Canon.Share
--import GF.Canon.Subexpressions (elimSubtermsMod,unSubelimModule)

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.CompactPrint
import GF.Devel.PrGrammar
import GF.Compile.Update
import GF.Grammar.Lookup
import GF.Infra.Modules
import GF.Devel.ReadFiles

import GF.Data.Operations
import GF.Devel.UseIO
import GF.Devel.Arch

import Control.Monad
import System.Directory
import System.FilePath
import qualified Data.Map as Map

batchCompile :: Options -> [FilePath] -> IOE SourceGrammar
batchCompile opts files = do
  (_,gr) <- foldM (compileModule defOpts) emptyCompileEnv files
  return gr
  where
    defOpts = addOptions opts (options [emitCode])

-- to output an intermediate stage
intermOut :: Options -> Option -> String -> IOE ()
intermOut opts opt s = if oElem opt opts then 
  ioeIO (putStrLn ("\n\n--#" +++ prOpt opt) >> putStrLn s) 
  else return ()

prMod :: SourceModule -> String
prMod = compactPrint . prModule


-- | the environment
type CompileEnv = (Int,SourceGrammar)

-- | compile with one module as starting point
-- command-line options override options (marked by --#) in the file
-- As for path: if it is read from file, the file path is prepended to each name.
-- If from command line, it is used as it is.

compileModule :: Options -> CompileEnv -> FilePath -> IOE CompileEnv
compileModule opts1 env file = do
  opts0 <- ioeIO $ getOptionsFromFile file
  let useFileOpt = maybe False (const True) $ getOptVal opts0 pathList
  let useLineOpt = maybe False (const True) $ getOptVal opts1 pathList
  let opts = addOptions opts1 opts0 
  let fpath = dropFileName file
  ps0 <- ioeIO $ pathListOpts opts fpath

  let ps1 = if (useFileOpt && not useLineOpt) 
              then (ps0 ++ map (combine fpath) ps0)
              else ps0
  ps <- ioeIO $ extendPathEnv ps1
  let ioeIOIf = if oElem beVerbose opts then ioeIO else (const (return ()))
  ioeIOIf $ putStrLn $ "module search path:" +++ show ps ----
  let sgr = snd env
  let rfs = Map.empty ---- files already in memory and their read times
  let file' = if useFileOpt then takeFileName file else file -- to find file itself
  files <- getAllFiles opts ps rfs file'
  ioeIOIf $ putStrLn $ "files to read:" +++ show files ----
  let names = map justModuleName files
  ioeIOIf $ putStrLn $ "modules to include:" +++ show names ----
  let sgr2 = MGrammar [m | m@(i,_) <- modules sgr, 
                           notElem (prt i) $ map dropExtension names]
  foldM (compileOne opts) (0,sgr2) files


compileOne :: Options -> CompileEnv -> FullPath -> IOE CompileEnv
compileOne opts env@(_,srcgr) file = do

  let putp s = putPointE opts ("\n" ++ s) 
  let putpp = putPointEsil opts
  let putpOpt v m act
       | oElem beVerbose opts =  putp v act
       | oElem beSilent opts  =  putpp v act
       | otherwise = ioeIO (putStrFlush ("\n" ++ m)) >> act

  let gf   = takeExtensions file
  let path = dropFileName file
  let name = dropExtension file
  let mos  = modules srcgr

  case gf of

    -- for compiled gf, read the file and update environment
    -- also undo common subexp optimization, to enable normal computations
    ".gfo" -> do
       sm0 <- putp ("+ reading" +++ file) $ getSourceModule opts file
       let sm1 = unsubexpModule sm0
       sm <- {- putp "creating indirections" $ -} ioeErr $ extendModule mos sm1
       extendCompileEnv env sm

    -- for gf source, do full compilation and generate code
    _ -> do

      let modu = dropExtension file
      b1 <- ioeIO $ doesFileExist file
      if not b1
        then compileOne opts env $ gfoFile $ modu 
        else do

       sm0 <- putpOpt ("- parsing" +++ file) ("- compiling" +++ file ++ "... ") $ 
                                           getSourceModule opts file
       (k',sm)  <- compileSourceModule opts env sm0
       let sm1 = if isConcr sm then shareModule sm else sm -- cannot expand Str
       cm  <- putpp "  generating code... " $ generateModuleCode opts path sm1
          -- sm is optimized before generation, but not in the env
       let cm2 = unsubexpModule cm
       extendCompileEnvInt env (k',sm1)
  where
   isConcr (_,mi) = case mi of
     ModMod m -> isModCnc m && mstatus m /= MSIncomplete 
     _ -> False


compileSourceModule :: Options -> CompileEnv -> 
                       SourceModule -> IOE (Int,SourceModule)
compileSourceModule opts env@(k,gr) mo@(i,mi) = do

  let putp  = putPointE opts
      putpp = putPointEsil opts
      mos   = modules gr

  mo1   <- ioeErr $ rebuildModule mos mo
  intermOut opts (iOpt "show_rebuild") (prMod mo1)

  mo1b  <- ioeErr $ extendModule mos mo1
  intermOut opts (iOpt "show_extend") (prMod mo1b)

  case mo1b of
    (_,ModMod n) | not (isCompleteModule n) -> do
      return (k,mo1b)   -- refresh would fail, since not renamed
    _ -> do
      mo2:_ <- putpp "  renaming " $ ioeErr $ renameModule mos mo1b
      intermOut opts (iOpt "show_rename") (prMod mo2)

      (mo3:_,warnings) <- putpp "  type checking" $ ioeErr $ showCheckModule mos mo2
      if null warnings then return () else putp warnings $ return ()
      intermOut opts (iOpt "show_typecheck") (prMod mo3)


      (k',mo3r:_) <- putpp "  refreshing " $ ioeErr $ refreshModule (k,mos) mo3
      intermOut opts (iOpt "show_refresh") (prMod mo3r)

      let eenv = () --- emptyEEnv
      (mo4,eenv') <- 
        ---- if oElem "check_only" opts 
          putpp "  optimizing " $ ioeErr $ optimizeModule opts (mos,eenv) mo3r
      return (k',mo4)
 where
   ----   prDebug mo = ioeIO $ putStrLn $ prGrammar $ MGrammar [mo] ---- debug
   prDebug mo = ioeIO $ print $ length $ lines $ prGrammar $ MGrammar [mo]

generateModuleCode :: Options -> InitPath -> SourceModule -> IOE SourceModule
generateModuleCode opts path minfo@(name,info) = do

  let pname  = path </> prt name
  let minfo0 = minfo 
  let minfo1 = subexpModule minfo0
  let minfo2 = minfo1

  let (file,out) = (gfoFile pname, prGrammar (MGrammar [minfo2]))
  putp ("  wrote file" +++ file) $ ioeIO $ writeFile file $ compactPrint out

  return minfo2
 where 
   putp  = putPointE opts
   putpp = putPointEsil opts


-- auxiliaries

pathListOpts :: Options -> FileName -> IO [InitPath]
pathListOpts opts file = return $ maybe [file] splitInModuleSearchPath $ getOptVal opts pathList

reverseModules (MGrammar ms) = MGrammar $ reverse ms

emptyCompileEnv :: CompileEnv
emptyCompileEnv = (0,emptyMGrammar)

extendCompileEnvInt (_,MGrammar ss) (k,sm) = 
  return (k,MGrammar (sm:ss)) --- reverse later

extendCompileEnv e@(k,_) sm = extendCompileEnvInt e (k,sm)


