module GF.Devel.Compile.Compile (batchCompile) where

-- the main compiler passes
import GF.Devel.Compile.GetGrammar
import GF.Devel.Compile.Extend
----import GF.Compile.Rebuild
----import GF.Compile.Rename
----import GF.Grammar.Refresh
----import GF.Devel.CheckGrammar
----import GF.Devel.Optimize
--import GF.Compile.Evaluate ----
----import GF.Devel.OptimizeGF

import GF.Devel.Grammar.Terms
import GF.Devel.Grammar.Modules
import GF.Devel.Grammar.Judgements
import GF.Infra.Ident
import GF.Infra.CompactPrint
import GF.Devel.Grammar.PrGF
----import GF.Grammar.Lookup
import GF.Devel.ReadFiles

import GF.Infra.Option ----
import GF.Data.Operations
import GF.Devel.UseIO
import GF.Devel.Arch

import Control.Monad
import System.Directory

batchCompile :: Options -> [FilePath] -> IO GF
batchCompile opts files = do
  let defOpts = addOptions opts (options [emitCode])
  egr <- appIOE $ foldM (compileModule defOpts) emptyCompileEnv files 
  case egr of
    Ok (_,gr) -> return gr
    Bad s -> error s

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
type CompileEnv = (Int,GF)

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
  let file' = if useFileOpt then justFileName file else file -- find file itself
  files <- getAllFiles opts ps rfs file'
  ioeIOIf $ putStrLn $ "files to read:" +++ show files ----
  let names = map justModuleName files
  ioeIOIf $ putStrLn $ "modules to include:" +++ show names ----
  let sgr2 = sgr ----MGrammar [m | m@(i,_) <- modules sgr, 
                     ----      notElem (prt i) $ map fileBody names]
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
  let mos  = gfmodules srcgr

  case gf of

    -- for compiled gf, read the file and update environment
    -- also undo common subexp optimization, to enable normal computations

{- ----
    "gfo" -> do
       sm0 <- putp ("+ reading" +++ file) $ getSourceModule opts file
       let sm1 = unsubexpModule sm0
       sm <- {- putp "creating indirections" $ -} ioeErr $ extendModule mos sm1
       extendCompileEnv env sm
-}
    -- for gf source, do full compilation and generate code
    _ -> do

      let modu = unsuffixFile file
      b1 <- ioeIO $ doesFileExist file
      if not b1
        then compileOne opts env $ gfoFile $ modu 
        else do

       sm0 <- 
         putpOpt ("- parsing" +++ file) ("- compiling" +++ file ++ "... ") $ 
                                                      getSourceModule opts file
       (k',sm) <- compileSourceModule opts env sm0
       let sm1 = sm ---- 
----             if isConcr sm then shareModule sm else sm -- cannot expand Str
----       cm  <- putpp "  generating code... " $ generateModuleCode opts path sm1
----          -- sm is optimized before generation, but not in the env
----       let cm2 = unsubexpModule cm
       extendCompileEnvInt env (k',sm) ---- sm1
  where
   isConcr (_,mi) = case mi of
----     ModMod m -> isModCnc m && mstatus m /= MSIncomplete 
     _ -> False


compileSourceModule :: Options -> CompileEnv -> 
                       SourceModule -> IOE (Int,SourceModule)
compileSourceModule opts env@(k,gr) mo@(i,mi) = do

  intermOut opts (iOpt "show_gf") (prMod mo)

  let putp  = putPointE opts
      putpp = putPointEsil opts

  mo1  <- ioeErr $ extendModule gr mo
  intermOut opts (iOpt "show_extend") (prMod mo1)

  return (k,mo1) ----

{- ----
  mo1   <- ioeErr $ rebuildModule mos mo
  intermOut opts (iOpt "show_rebuild") (prMod mo1)


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

  let pname  = prefixPathName path (prt name)
  let minfo0 = minfo 
  let minfo1 = subexpModule minfo0
  let minfo2 = minfo1

  let (file,out) = (gfoFile pname, prGrammar (MGrammar [minfo2]))
  putp ("  wrote file" +++ file) $ ioeIO $ writeFile file $ compactPrint out

  return minfo2
 where 
   putp  = putPointE opts
   putpp = putPointEsil opts
-}

-- auxiliaries

pathListOpts :: Options -> FileName -> IO [InitPath]
pathListOpts opts file = return $ maybe [file] pFilePaths $ getOptVal opts pathList

----reverseModules (MGrammar ms) = MGrammar $ reverse ms

emptyCompileEnv :: CompileEnv
emptyCompileEnv = (0,emptyGF)

extendCompileEnvInt (_,gf) (k,(s,m)) = return (k, addModule s m gf)

extendCompileEnv e@(k,_) sm = extendCompileEnvInt e (k,sm)


