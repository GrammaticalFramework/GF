module Compile where

import Grammar
import Ident
import Option
import PrGrammar
import Update
import Lookup
import Modules
import ModDeps
import ReadFiles
import ShellState
import MkResource

-- the main compiler passes
import GetGrammar
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

compileModule :: Options -> ShellState -> FilePath -> 
                 IOE (GFC.CanonGrammar, (SourceGrammar,[(FilePath,ModTime)]))
compileModule opts st file = do
  let ps   = pathListOpts opts
  ioeIO $ print ps ----
  let putp = putPointE opts
  let rfs  = readFiles st
  files <- getAllFiles ps rfs file
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
    then MGrammar $ reverse [(i,mi) | (i,mi) <- modules gr, isResourceModule mi]
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
      putp "  type checking reused" $ ioeErr $ showCheckModule mos mo2
      return $ (k,mo2)
    _ -> compileSourceModule opts env mo
 where
   putp = putPointE opts

compileSourceModule :: Options -> CompileEnv -> SourceModule -> 
                       IOE (Int,SourceModule)
compileSourceModule opts env@(k,gr,can) mo@(i,mi) = do

  let putp = putPointE opts
      mos  = modules gr

  mo2:_ <- putp "  renaming " $ ioeErr $ renameModule mos mo

  (mo3:_,warnings) <- putp "  type checking" $ ioeErr $ showCheckModule mos mo2
  putStrE warnings

  (k',mo3r:_) <- ioeErr $ refreshModule (k,mos) mo3

  mo4:_ <- putp "  optimizing" $ ioeErr $ evalModule mos mo3r

  return (k',mo4)

generateModuleCode :: Options -> InitPath -> SourceModule -> IOE GFC.CanonModule
generateModuleCode opts path minfo@(name,info) = do
  let pname = prefixPathName path (prt name)
  minfo0     <- ioeErr $ redModInfo minfo
  minfo'     <- return $ if optim 
                then shareModule fullOpt minfo0   -- parametrization and sharing
                else shareModule basicOpt minfo0  -- sharing only

  -- for resource, also emit gfr
  case info of
    ModMod m | mtype m == MTResource && emit && nomulti -> do
      let (file,out) = (gfrFile pname, prGrammar (MGrammar [minfo]))
      ioeIO $ writeFile file out >> putStr ("  wrote file" +++ file)
    _ -> return ()
  (file,out) <- do
      code <- return $ MkGFC.prCanonModInfo minfo'
      return (gfcFile pname, code)
  if emit && nomulti 
     then ioeIO $ writeFile file out >> putStr ("  wrote file" +++ file)
     else return ()
  return minfo'
 where 
   nomulti = not $ oElem makeMulti opts
   emit  = oElem emitCode opts
   optim = oElem optimizeCanon opts

-- for old GF: sort into modules, write files, compile as usual

compileOld :: Options -> FilePath -> IOE GFC.CanonGrammar
compileOld opts file = do
  let putp = putPointE opts
  grammar1 <- putp ("- parsing old gf" +++ file) $ getOldGrammar file
  files <- mapM writeNewGF $ modules grammar1
  (_,_,grammar) <- foldM (compileOne opts) emptyCompileEnv files
  return grammar

writeNewGF :: SourceModule -> IOE FilePath
writeNewGF m@(i,_) = do
  let file = gfFile $ prt i
  ioeIO $ writeFile file $ prGrammar (MGrammar [m])
  ioeIO $ putStrLn $ "wrote file" +++ file
  return file

