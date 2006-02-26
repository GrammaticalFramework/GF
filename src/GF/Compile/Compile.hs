----------------------------------------------------------------------
-- |
-- Module      : Compile
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/05 20:02:19 $
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.45 $
--
-- The top-level compilation chain from source file to gfc\/gfr.
-----------------------------------------------------------------------------

module GF.Compile.Compile (compileModule, compileEnvShSt, compileOne,
		CompileEnv, TimedCompileEnv,gfGrammarPathVar,pathListOpts,
	       getGFEFiles) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Option
import GF.Grammar.PrGrammar
import GF.Compile.Update
import GF.Grammar.Lookup
import GF.Infra.Modules
import GF.Infra.ReadFiles
import GF.Compile.ShellState
import GF.Compile.MkResource
---- import MkUnion

-- the main compiler passes
import GF.Compile.GetGrammar
import GF.Compile.Extend
import GF.Compile.Rebuild
import GF.Compile.Rename
import GF.Grammar.Refresh
import GF.Compile.CheckGrammar
import GF.Compile.Optimize
import GF.Compile.GrammarToCanon
import GF.Canon.Share
import GF.Canon.Subexpressions (elimSubtermsMod,unSubelimModule)
import GF.UseGrammar.Linear (unoptimizeCanonMod) ----

import qualified GF.Canon.CanonToGrammar as CG

import qualified GF.Canon.GFC as GFC
import qualified GF.Canon.MkGFC as MkGFC
import GF.Canon.GetGFC

import GF.Data.Operations
import GF.Infra.UseIO
import GF.System.Arch

import Control.Monad
import System.Directory

-- | environment variable for grammar search path
gfGrammarPathVar = "GF_GRAMMAR_PATH"

-- | in batch mode: write code in a file
batchCompile f = liftM fst $ compileModule defOpts emptyShellState f
  where
    defOpts = options [emitCode] 
batchCompileOpt f = liftM fst $ compileModule defOpts emptyShellState f
  where
    defOpts = options [emitCode, optimizeCanon] 

batchCompileOld f = compileOld defOpts f
  where
    defOpts = options [emitCode] 

-- | compile with one module as starting point
-- command-line options override options (marked by --#) in the file
-- As for path: if it is read from file, the file path is prepended to each name.
-- If from command line, it is used as it is.
compileModule :: Options -> ShellState -> FilePath -> IOE TimedCompileEnv
----             IOE (GFC.CanonGrammar, (SourceGrammar,[(FilePath,ModTime)]))

compileModule opts st0 file | 
     oElem showOld opts || 
     elem suff ["cf","ebnf","gfm"] = do
  let putp  = putPointE opts
  let putpp = putPointEsil opts
  let path = [] ----
  grammar1 <- case suff of
    "cf"   -> putp ("- parsing" +++ suff +++ file) $ getCFGrammar opts file
    "ebnf" -> putp ("- parsing" +++ suff +++ file) $ getEBNFGrammar opts file
    "gfm"  -> putp ("- parsing" +++ suff +++ file) $ getSourceGrammar opts file
    _      -> putp ("- parsing old gf" +++ file)   $ getOldGrammar opts file
  let mods = modules grammar1
  let env = compileEnvShSt st0 []
  foldM (comp putpp path) env mods
 where
   suff = fileSuffix file
   comp putpp path env sm0 = do
     (k',sm)  <- makeSourceModule opts (fst env) sm0
     cm  <- putpp "  generating code... " $ generateModuleCode opts path sm
     ft <- getReadTimes file ---
     extendCompileEnvInt env (k',sm,cm) ft

compileModule opts1 st0 file = do
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
  let st = st0 --- if useFileOpt then emptyShellState else st0
  let rfs = readFiles st
  let file' = if useFileOpt then justFileName file else file -- to find file itself
  files <- getAllFiles opts ps rfs file'
  ioeIOIf $ putStrLn $ "files to read:" +++ show files ----
  let names = map justModuleName files
  ioeIOIf $ putStrLn $ "modules to include:" +++ show names ----
  let env0 = compileEnvShSt st names
  (e,mm) <- foldIOE (compileOne opts) env0 files
  maybe (return ()) putStrLnE mm
  return e

getReadTimes file = do
  t <- ioeIO getNowTime
  let m = justModuleName file
  return $ (m,t) : [(resModName m,t) | not (isGFC file)]

compileEnvShSt :: ShellState -> [ModName] -> TimedCompileEnv
compileEnvShSt st fs = ((0,sgr,cgr),fts) where
  cgr = MGrammar [m | m@(i,_) <- modules (canModules st), notInc i]
  sgr = MGrammar [m | m@(i,_) <- modules (srcModules st), notIns i]
  notInc i = notElem (prt i) $ map fileBody fs
  notIns i = notElem (prt i) $ map fileBody fs
  fts = readFiles st

pathListOpts :: Options -> FileName -> IO [InitPath]
pathListOpts opts file = return $ maybe [file] pFilePaths $ getOptVal opts pathList

reverseModules (MGrammar ms) = MGrammar $ reverse ms

keepResModules :: Options -> SourceGrammar -> SourceGrammar
keepResModules opts gr = 
  if oElem retainOpers opts 
    then MGrammar $ reverse [(i,mi) | (i,mi@(ModMod m)) <- modules gr, isModRes m]
    else emptyMGrammar


-- | the environment
type CompileEnv = (Int,SourceGrammar, GFC.CanonGrammar)

emptyCompileEnv :: TimedCompileEnv
emptyCompileEnv = ((0,emptyMGrammar,emptyMGrammar),[])

extendCompileEnvInt ((_,MGrammar ss, MGrammar cs),fts) (k,sm,cm) ft = 
  return ((k,MGrammar (sm:ss), MGrammar (cm:cs)),ft++fts) --- reverse later

extendCompileEnv e@((k,_,_),_) (sm,cm) = extendCompileEnvInt e (k,sm,cm)

extendCompileEnvCanon ((k,s,c),fts) cgr ft = 
  return ((k,s, MGrammar (modules cgr ++ modules c)),ft++fts)

type TimedCompileEnv = (CompileEnv,[(FilePath,ModTime)])

compileOne :: Options -> TimedCompileEnv -> FullPath -> IOE TimedCompileEnv
compileOne opts env@((_,srcgr,cancgr0),_) file = do

  let putp = putPointE opts
  let putpp = putPointEsil opts
  let putpOpt v m act
       | oElem beVerbose opts =  putp v act
       | oElem beSilent opts  =  putpp v act
       | otherwise = ioeIO (putStrFlush m) >> act

  let gf   = fileSuffix file
  let path = justInitPath file
  let name = fileBody file
  let mos  = modules srcgr

  case gf of
    -- for multilingual canonical gf, just read the file and update environment
    "gfcm" -> do
       cgr <- putp ("+ reading" +++ file) $ getCanonGrammar file
       ft <- getReadTimes file
       extendCompileEnvCanon env cgr ft

    -- for canonical gf, read the file and update environment, also source env
    "gfc" -> do
       cm <- putp ("+ reading" +++ file) $ getCanonModule file
       let cancgr = updateMGrammar (MGrammar [cm]) cancgr0 
       sm <- ioeErr $ CG.canon2sourceModule $ unoptimizeCanonMod cancgr $ unSubelimModule cm
       ft <- getReadTimes file
       extendCompileEnv env (sm, cm) ft

    -- for compiled resource, parse and organize, then update environment
    "gfr" -> do
       sm0 <- putp ("| reading" +++ file) $ getSourceModule opts file
       sm <- {- putp "creating indirections" $ -} ioeErr $ extendModule mos sm0
---- experiment with not optimizing gfr 
----      sm:_  <- putp "  optimizing " $ ioeErr $ evalModule mos sm1
       let gfc = gfcFile name 
       cm  <- putp ("+ reading" +++ gfc) $ getCanonModule gfc
       ft  <- getReadTimes file
       extendCompileEnv env (sm,cm) ft

    -- for gf source, do full compilation
    _ -> do
       sm0 <- putpOpt ("- parsing" +++ file) ("- compiling" +++ file ++ "... ") $ 
                                           getSourceModule opts file
       (k',sm)  <- makeSourceModule opts (fst env) sm0
       cm  <- putpp "  generating code... " $ generateModuleCode opts path sm
       ft <- getReadTimes file

       sm':_ <- case snd sm of
----         ModMod n | isModRes n -> putp "  optimizing " $ ioeErr $ evalModule mos sm
         _ -> return [sm]

       extendCompileEnvInt env (k',sm',cm) ft

-- | dispatch reused resource at early stage
makeSourceModule :: Options -> CompileEnv -> SourceModule -> IOE (Int,SourceModule)
makeSourceModule opts env@(k,gr,can) mo@(i,mi) = case mi of

  ModMod m -> case mtype m of
    MTReuse c -> do
      sm <- ioeErr $ makeReuse gr i (extend m) c
      let mo2 = (i, ModMod sm)
          mos = modules gr
      --- putp "  type checking reused" $ ioeErr $ showCheckModule mos mo2
      return $ (k,mo2)
{- ---- obsolete
    MTUnion ty imps -> do
      mo' <- ioeErr $ makeUnion gr i ty imps
      compileSourceModule opts env mo'
-}

    _ -> compileSourceModule opts env mo
  _ -> compileSourceModule opts env mo
 where
   putp = putPointE opts

compileSourceModule :: Options -> CompileEnv -> 
                       SourceModule -> IOE (Int,SourceModule)
compileSourceModule opts env@(k,gr,can) mo@(i,mi) = do

  let putp  = putPointE opts
      putpp = putPointEsil opts
      mos   = modules gr

  if (oElem showOld opts && oElem emitCode opts) 
    then do
      let (file,out) = (gfFile (prt i), prGrammar (MGrammar [mo]))
      putp ("  wrote file" +++ file) $ ioeIO $ writeFile file out
    else return ()

  mo1   <- ioeErr $ rebuildModule mos mo

  mo1b  <- ioeErr $ extendModule mos mo1

  case mo1b of
    (_,ModMod n) | not (isCompleteModule n) -> do
      return (k,mo1b)   -- refresh would fail, since not renamed
    _ -> do
      mo2:_ <- putpp "  renaming " $ ioeErr $ renameModule mos mo1b

      (mo3:_,warnings) <- putpp "  type checking" $ ioeErr $ showCheckModule mos mo2
      if null warnings then return () else putp warnings $ return ()

      (k',mo3r:_) <- ioeErr $ refreshModule (k,mos) mo3

      mo4 <- 
----        case snd mo1b of
----          ModMod n | isModCnc n -> 
        putpp "  optimizing " $ ioeErr $ optimizeModule opts mos mo3r
----        _ -> return [mo3r]
      return (k',mo4)
 where
   ----   prDebug mo = ioeIO $ putStrLn $ prGrammar $ MGrammar [mo] ---- debug
   prDebug mo = ioeIO $ print $ length $ lines $ prGrammar $ MGrammar [mo]

generateModuleCode :: Options -> InitPath -> SourceModule -> IOE GFC.CanonModule
generateModuleCode opts path minfo@(name,info) = do
  let pname = prefixPathName path (prt name)
  minfo0     <- ioeErr $ redModInfo minfo
  let oopts  = addOptions opts (iOpts (flagsModule minfo))
      optims = maybe "share" id $ getOptVal oopts useOptimizer
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
  minfo' <- 
    if subs
      then ioeErr $ elimSubtermsMod minfo1
      else return minfo1

  -- for resource, also emit gfr. 
  --- Also for incomplete, to create timestamped gfc/gfr files
  case info of
    ModMod m | emitsGFR m && emit && nomulti -> do
      let rminfo = if isCompilable info then minfo 
                   else (name,emptyModInfo) 
      let (file,out) = (gfrFile pname, prGrammar (MGrammar [rminfo]))
      putp ("  wrote file" +++ file) $ ioeIO $ writeFile file out
    _ -> return ()
  (file,out) <- do
      code <- return $ MkGFC.prCanonModInfo minfo'
      return (gfcFile pname, code)
  if emit && nomulti ---- && isCompilable info 
     then putp  ("  wrote file" +++ file) $ ioeIO $ writeFile file out
     else putpp ("no need to save module" +++ prt name) $ return ()
  return minfo'
 where 
   putp  = putPointE opts
   putpp = putPointEsil opts

   emitsGFR m = isModRes m ---- && isCompilable info
     ---- isModRes m || (isModCnc m && mstatus m == MSIncomplete)
   isCompilable mi = case mi of
     ModMod m -> not $ isModCnc m && mstatus m == MSIncomplete 
     _ -> True
   nomulti = not $ oElem makeMulti opts
   emit  = oElem emitCode opts && not (oElem notEmitCode opts)

-- for old GF: sort into modules, write files, compile as usual

compileOld :: Options -> FilePath -> IOE GFC.CanonGrammar
compileOld opts file = do
  let putp = putPointE opts
  grammar1 <- putp ("- parsing old gf" +++ file) $ getOldGrammar opts file
  files <- mapM writeNewGF $ modules grammar1
  ((_,_,grammar),_) <- foldM (compileOne opts) emptyCompileEnv files
  return grammar

writeNewGF :: SourceModule -> IOE FilePath
writeNewGF m@(i,_) = do
  let file = gfFile $ prt i
  ioeIO $ writeFile file $ prGrammar (MGrammar [m])
  ioeIO $ putStrLn $ "wrote file" +++ file
  return file

--- this function duplicates a lot of code from compileModule.
--- It does not really belong here either.
-- It selects those .gfe files that a grammar depends on and that
-- are younger than corresponding gf

getGFEFiles :: Options -> FilePath -> IO [FilePath]
getGFEFiles opts1 file = useIOE [] $ do
  opts0 <- ioeIO $ getOptionsFromFile file
  let useFileOpt = maybe False (const True) $ getOptVal opts0 pathList
  let useLineOpt = maybe False (const True) $ getOptVal opts1 pathList
  let opts = addOptions opts1 opts0 
  let fpath = justInitPath file
  ps0 <- ioeIO $ pathListOpts opts fpath

  let ps1 = if (useFileOpt && not useLineOpt) 
              then (map (prefixPathName fpath) ps0)
              else ps0
  ps <- ioeIO $ extendPathEnv gfLibraryPath gfGrammarPathVar ps1
  let file' = if useFileOpt then justFileName file else file -- to find file itself
  files <- getAllFiles opts ps [] file'
  efiles <- ioeIO $ filterM doesFileExist [suffixFile "gfe" (unsuffixFile f) | f <- files]
  es <- ioeIO $ mapM (uncurry selectLater) [(f, init f) | f <- efiles] -- init gfe == gf
  return $ filter ((=='e') . last) es
