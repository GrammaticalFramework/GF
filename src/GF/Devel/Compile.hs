module GF.Devel.Compile (batchCompile) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.CompactPrint
import GF.Devel.PrGrammar
import GF.Compile.Update
import GF.Grammar.Lookup
import GF.Infra.Modules
import GF.Devel.ReadFiles

-- the main compiler passes
import GF.Devel.GetGrammar
import GF.Compile.Extend
import GF.Compile.Rebuild
import GF.Compile.Rename
import GF.Grammar.Refresh
import GF.Compile.CheckGrammar
import GF.Compile.Optimize
import GF.Compile.Evaluate ----
--import GF.Canon.Share
--import GF.Canon.Subexpressions (elimSubtermsMod,unSubelimModule)

import GF.Data.Operations
import GF.Devel.UseIO
import GF.Devel.Arch

import Control.Monad
import System.Directory

batchCompile :: Options -> [FilePath] -> IO SourceGrammar
batchCompile opts files = do
  let defOpts = addOptions opts (options [emitCode]) 
  Ok (_,gr) <- appIOE $ foldM (compileModule defOpts) emptyCompileEnv files
  return gr

-- to output an intermediate stage
intermOut :: Options -> Option -> String -> IOE ()
intermOut opts opt s = if oElem opt opts then 
  ioeIO (putStrLn ("\n\n--#" +++ prOpt opt) >> putStrLn s) 
  else return ()

prMod :: SourceModule -> String
prMod = compactPrint . prModule


-- | environment variable for grammar search path
gfGrammarPathVar = "GF_GRAMMAR_PATH"

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
  let fpath = justInitPath file
  ps0 <- ioeIO $ pathListOpts opts fpath

  let ps1 = if (useFileOpt && not useLineOpt) 
              then (ps0 ++ map (prefixPathName fpath) ps0)
              else ps0
  ps <- ioeIO $ extendPathEnv gfLibraryPath gfGrammarPathVar ps1
  let ioeIOIf = if oElem beVerbose opts then ioeIO else (const (return ()))
  ioeIOIf $ putStrLn $ "module search path:" +++ show ps ----
  let sgr = snd env
  let rfs = [] ---- files already in memory and their read times
  let file' = if useFileOpt then justFileName file else file -- to find file itself
  files <- getAllFiles opts ps rfs file'
  ioeIOIf $ putStrLn $ "files to read:" +++ show files ----
  let names = map justModuleName files
  ioeIOIf $ putStrLn $ "modules to include:" +++ show names ----
  let sgr2 = MGrammar [m | m@(i,_) <- modules sgr, 
                           notElem (prt i) $ map fileBody names]
  let env0 = (0,sgr2)
  (e,mm) <- foldIOE (compileOne opts) env0 files
  maybe (return ()) putStrLnE mm
  return e


compileOne :: Options -> CompileEnv -> FullPath -> IOE CompileEnv
compileOne opts env@(_,srcgr) file = do

  let putp s = putPointE opts ("\n" ++ s) 
  let putpp = putPointEsil opts
  let putpOpt v m act
       | oElem beVerbose opts =  putp v act
       | oElem beSilent opts  =  putpp v act
       | otherwise = ioeIO (putStrFlush ("\n" ++ m)) >> act

  let gf   = fileSuffix file
  let path = justInitPath file
  let name = fileBody file
  let mos  = modules srcgr

  case gf of

    -- for compiled gf, read the file and update environment, also source env
    "gfc" -> do
       sm0 <- putp ("+ reading" +++ file) $ getSourceModule opts file
       sm <- {- putp "creating indirections" $ -} ioeErr $ extendModule mos sm0
       extendCompileEnv env sm

    -- for gf source, do full compilation
    _ -> do

      let modu = unsuffixFile file
      b1 <- ioeIO $ doesFileExist file
      if not b1
        then compileOne opts env $ gfcFile $ modu 
        else do

       sm0 <- putpOpt ("- parsing" +++ file) ("- compiling" +++ file ++ "... ") $ 
                                           getSourceModule opts file
       (k',sm)  <- compileSourceModule opts env sm0
       cm  <- putpp "  generating code... " $ generateModuleCode opts path sm

       extendCompileEnvInt env (k',sm)


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

      let eenv = emptyEEnv
      (mo4,eenv') <- 
        ---- if oElem "check_only" opts 
          putpp "  optimizing " $ ioeErr $ optimizeModule opts (mos,eenv) mo3r
      return (k',mo4)
 where
   ----   prDebug mo = ioeIO $ putStrLn $ prGrammar $ MGrammar [mo] ---- debug
   prDebug mo = ioeIO $ print $ length $ lines $ prGrammar $ MGrammar [mo]

generateModuleCode :: Options -> InitPath -> SourceModule -> IOE SourceModule
generateModuleCode opts path minfo@(name,info) = do

  let pname = prefixPathName path (prt name)
  let minfo0 = minfo 
  let minfo1 = minfo
  let minfo2 = minfo

{- ---- restore optimizations!
  let oopts  = addOptions opts (iOpts (flagsModule minfo))
      optims = maybe "all_subs" id $ getOptVal oopts useOptimizer
      optim  = takeWhile (/='_') optims
      subs   = drop 1 (dropWhile (/='_') optims) == "subs"
  minfo1     <- return $
    case optim of
      "parametrize" -> shareModule paramOpt minfo0  -- parametrization and sharing
      "values"      -> shareModule valOpt minfo0    -- tables as courses-of-values
      "share"       -> shareModule shareOpt minfo0  -- sharing of branches
      "all"         -> shareModule allOpt minfo0    -- first parametrize then values
      "none"        -> minfo0                       -- no optimization
      _             -> shareModule shareOpt minfo0  -- sharing; default

  -- do common subexpression elimination if required by flag "subs"
  minfo2 <- 
    if subs
      then ioeErr $ elimSubtermsMod minfo1
      else return minfo1
-}

  let (file,out) = (gfcFile pname, prGrammar (MGrammar [minfo2]))
  putp ("  wrote file" +++ file) $ ioeIO $ writeFile file $ compactPrint out

  return minfo2
 where 
   putp  = putPointE opts
   putpp = putPointEsil opts
   isCompilable mi = case mi of
     ModMod m -> not $ isModCnc m && mstatus m == MSIncomplete 
     _ -> True


-- auxiliaries

pathListOpts :: Options -> FileName -> IO [InitPath]
pathListOpts opts file = return $ maybe [file] pFilePaths $ getOptVal opts pathList

reverseModules (MGrammar ms) = MGrammar $ reverse ms

emptyCompileEnv :: CompileEnv
emptyCompileEnv = (0,emptyMGrammar)

extendCompileEnvInt (_,MGrammar ss) (k,sm) = 
  return (k,MGrammar (sm:ss)) --- reverse later

extendCompileEnv e@(k,_) sm = extendCompileEnvInt e (k,sm)


