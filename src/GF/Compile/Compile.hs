module Compile where

import Grammar
import Ident
import Option
import PrGrammar
import Update
import Lookup
import Modules
import ReadFiles
import ShellState
import MkResource

-- the main compiler passes
import GetGrammar
import Extend
import Rebuild
import Rename
import Refresh
import CheckGrammar
import Optimize
import GrammarToCanon
import Share

import qualified CanonToGrammar as CG

import qualified GFC
import qualified MkGFC
import GetGFC

import Operations
import UseIO
import Arch

import Monad

-- in batch mode: write code in a file

batchCompile f = liftM fst $ compileModule defOpts emptyShellState f
  where
    defOpts = options [beVerbose, emitCode] 
batchCompileOpt f = liftM fst $ compileModule defOpts emptyShellState f
  where
    defOpts = options [beVerbose, emitCode, optimizeCanon] 

batchCompileOld f = compileOld defOpts f
  where
    defOpts = options [beVerbose, emitCode] 

-- compile with one module as starting point
-- command-line options override options (marked by --#) in the file
-- As for path: if it is read from file, the file path is prepended to each name.
-- If from command line, it is used as it is.

compileModule :: Options -> ShellState -> FilePath -> 
                 IOE (GFC.CanonGrammar, (SourceGrammar,[(FilePath,ModTime)]))
compileModule opts st0 file | oElem showOld opts = do
  let putp = putPointE opts
  let path = [] ----
  grammar1 <- putp ("- parsing old gf" +++ file) $ getOldGrammar opts file
  let mods = modules grammar1
  let env = compileEnvShSt st0 []
  (_,sgr,cgr) <- foldM (comp putp path) env mods
  return $ (reverseModules cgr,       -- to preserve dependency order
            (reverseModules sgr,[]))  
 where
   comp putp path env sm0 = do
     (k',sm)  <- makeSourceModule opts env sm0
     cm  <- putp "  generating code... " $ generateModuleCode opts path sm
     extendCompileEnvInt env (k',sm,cm)

compileModule opts1 st0 file = do
  opts0 <- ioeIO $ getOptionsFromFile file
  let useFileOpt = maybe False (const True) $ getOptVal opts0 pathList
  let opts = addOptions opts1 opts0 
  let ps0  = pathListOpts opts
  let fpath = justInitPath file
  let ps = if useFileOpt 
             then (map (prefixPathName fpath) ps0)
             else ps0
  ioeIO $ print ps ----
  let putp = putPointE opts
  let st = st0 --- if useFileOpt then emptyShellState else st0
  let rfs = readFiles st
  let file' = if useFileOpt then justFileName file else file -- to find file itself
  files <- getAllFiles ps rfs file'
  ioeIO $ print files ----
  let names = map (fileBody . justFileName) files
  ioeIO $ print names ----
  let env0 = compileEnvShSt st names
  (_,sgr,cgr) <- foldM (compileOne opts) env0 files
  t <- ioeIO getNowTime
  return $ (reverseModules cgr,       -- to preserve dependency order
            (reverseModules sgr, --- keepResModules opts sgr, --- keep all so far
             [(f,t) | f <- files]))   -- pass on the time of creation

compileEnvShSt :: ShellState -> [ModName] -> CompileEnv
compileEnvShSt st fs = (0,sgr,cgr) where
  cgr = MGrammar [m | m@(i,_) <- modules (canModules st), notInc i]
  sgr = MGrammar [m | m@(i,_) <- modules (srcModules st), notIns i]
  notInc i = notElem (prt i) $ map fileBody fs
  notIns i = notElem (prt i) $ map fileBody fs

pathListOpts :: Options -> [InitPath]
pathListOpts opts = maybe [""] pFilePaths $ getOptVal opts pathList

reverseModules (MGrammar ms) = MGrammar $ reverse ms

keepResModules :: Options -> SourceGrammar -> SourceGrammar
keepResModules opts gr = 
  if oElem retainOpers opts 
    then MGrammar $ reverse [(i,mi) | (i,mi@(ModMod m)) <- modules gr, isModRes m]
    else emptyMGrammar


-- the environment

type CompileEnv = (Int,SourceGrammar, GFC.CanonGrammar)

emptyCompileEnv :: CompileEnv
emptyCompileEnv = (0,emptyMGrammar,emptyMGrammar)

extendCompileEnvInt (_,MGrammar ss, MGrammar cs) (k,sm,cm) = 
  return (k,MGrammar (sm:ss), MGrammar (cm:cs)) --- reverse later

extendCompileEnv (k,s,c) (sm,cm) = extendCompileEnvInt (k,s,c) (k,sm,cm)

compileOne :: Options -> CompileEnv -> FullPath -> IOE CompileEnv
compileOne opts env file = do

  let putp = putPointE opts
  let gf   = fileSuffix file
  let path = justInitPath file
  let name = fileBody file

  case gf of
    -- for canonical gf, just read the file and update environment
    "gfc" -> do
       cm <- putp ("+ reading" +++ file) $ getCanonModule file
       sm <- ioeErr $ CG.canon2sourceModule cm
       extendCompileEnv env (sm, cm)

    -- for compiled resource, parse and organize, then update environment
    "gfr" -> do
       sm0  <- putp ("| parsing" +++ file) $ getSourceModule file
       let mos = case env of (_,gr,_) -> modules gr
       sm <- {- putp "creating indirections" $ -} ioeErr $ extendModule mos sm0
       let gfc = gfcFile name 
       cm <- putp ("+ reading" +++ gfc) $ getCanonModule gfc
       extendCompileEnv env (sm,cm)

    -- for gf source, do full compilation
    _ -> do
       sm0 <- putp ("- parsing" +++ file) $ getSourceModule file
       (k',sm)  <- makeSourceModule opts env sm0
       cm  <- putp "  generating code... " $ generateModuleCode opts path sm
       extendCompileEnvInt env (k',sm,cm)

-- dispatch reused resource at early stage

makeSourceModule :: Options -> CompileEnv -> SourceModule -> IOE (Int,SourceModule)
makeSourceModule opts env@(k,gr,can) mo@(i,mi) = case mi of

  ModMod m -> case mtype m of
    MTReuse c -> do
      sm <- ioeErr $ makeReuse gr i (extends m) c
      let mo2 = (i, ModMod sm)
          mos = modules gr
      --- putp "  type checking reused" $ ioeErr $ showCheckModule mos mo2
      return $ (k,mo2)
    _ -> compileSourceModule opts env mo
  _ -> compileSourceModule opts env mo
 where
   putp = putPointE opts

compileSourceModule :: Options -> CompileEnv -> 
                       SourceModule -> IOE (Int,SourceModule)
compileSourceModule opts env@(k,gr,can) mo@(i,mi) = do

  let putp = putPointE opts
      mos  = modules gr

  mo1   <- ioeErr $ rebuildModule mos mo

  mo1b  <- ioeErr $ extendModule mos mo1

  case mo1b of
    (_,ModMod n) | not (isCompleteModule n) -> do
      return (k,mo1b)   -- refresh would fail, since not renamed
    _ -> do
      mo2:_ <- putp "  renaming " $ ioeErr $ renameModule mos mo1b

      (mo3:_,warnings) <- putp "  type checking" $ ioeErr $ showCheckModule mos mo2
      putStrE warnings

      (k',mo3r:_) <- ioeErr $ refreshModule (k,mos) mo3

      mo4:_ <- putp "  optimizing " $ ioeErr $ evalModule mos mo3r

      return (k',mo4)
 where
   ----   prDebug mo = ioeIO $ putStrLn $ prGrammar $ MGrammar [mo] ---- debug
   prDebug mo = ioeIO $ print $ length $ lines $ prGrammar $ MGrammar [mo]

generateModuleCode :: Options -> InitPath -> SourceModule -> IOE GFC.CanonModule
generateModuleCode opts path minfo@(name,info) = do
  let pname = prefixPathName path (prt name)
  minfo0     <- ioeErr $ redModInfo minfo
  minfo'     <- return $ if optim 
                then shareModule fullOpt minfo0   -- parametrization and sharing
                else shareModule basicOpt minfo0  -- sharing only

  -- for resource, also emit gfr
  case info of
    ModMod m | emitsGFR m && emit && nomulti -> do
      let (file,out) = (gfrFile pname, prGrammar (MGrammar [minfo]))
      ioeIO $ writeFile file out >> putStr ("  wrote file" +++ file)
    _ -> return ()
  (file,out) <- do
      code <- return $ MkGFC.prCanonModInfo minfo'
      return (gfcFile pname, code)
  if isCompilable info && emit && nomulti 
     then ioeIO $ writeFile file out >> putStr ("  wrote file" +++ file)
     else ioeIO $ putStrFlush $ "no need to save module" +++ prt name
  return minfo'
 where 
   emitsGFR m = isModRes m && isCompilable info
     ---- isModRes m || (isModCnc m && mstatus m == MSIncomplete)
   isCompilable mi = case mi of
     ModMod m -> not $ isModCnc m && mstatus m == MSIncomplete 
     _ -> True
   nomulti = not $ oElem makeMulti opts
   emit  = oElem emitCode opts && not (oElem notEmitCode opts)
   optim = oElem optimizeCanon opts

-- for old GF: sort into modules, write files, compile as usual

compileOld :: Options -> FilePath -> IOE GFC.CanonGrammar
compileOld opts file = do
  let putp = putPointE opts
  grammar1 <- putp ("- parsing old gf" +++ file) $ getOldGrammar opts file
  files <- mapM writeNewGF $ modules grammar1
  (_,_,grammar) <- foldM (compileOne opts) emptyCompileEnv files
  return grammar

writeNewGF :: SourceModule -> IOE FilePath
writeNewGF m@(i,_) = do
  let file = gfFile $ prt i
  ioeIO $ writeFile file $ prGrammar (MGrammar [m])
  ioeIO $ putStrLn $ "wrote file" +++ file
  return file

