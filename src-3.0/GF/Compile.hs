module GF.Compile (batchCompile, compileToGFCC) where

-- the main compiler passes
import GF.Compile.GetGrammar
import GF.Compile.Extend
import GF.Compile.Rebuild
import GF.Compile.Rename
import GF.Compile.CheckGrammar
import GF.Compile.Optimize
import GF.Devel.OptimizeGF
import GF.Compile.GrammarToGFCC
import GF.Compile.ReadFiles
import GF.Compile.Update

import GF.Grammar.Grammar
import GF.Grammar.Refresh
import GF.Grammar.Lookup

import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.CompactPrint
import GF.Infra.Modules
import GF.Infra.UseIO
import GF.Devel.PrGrammar

import GF.Source.GrammarToSource
import qualified GF.Source.AbsGF as A
import qualified GF.Source.PrintGF as P

import GF.Data.Operations

import Control.Monad
import System.Directory
import System.FilePath
import System.Time
import qualified Data.Map as Map

import GF.GFCC.OptimizeGFCC
import GF.GFCC.CheckGFCC
import GF.GFCC.DataGFCC


-- | Compiles a number of source files and builds a 'GFCC' structure for them.
compileToGFCC :: Options -> [FilePath] -> IOE GFCC
compileToGFCC opts fs =
    do gr <- batchCompile opts fs
       let name = justModuleName (last fs)
       gc1 <- putPointE opts "linking ... " $
                let (abs,gc0) = mkCanon2gfcc opts name gr
                in ioeIO $ checkGFCCio gc0
       let opt = if oElem (iOpt "noopt") opts then id else optGFCC
           par = if oElem (iOpt "noparse") opts then id else addParsers
       return (par (opt gc1))


batchCompile :: Options -> [FilePath] -> IOE SourceGrammar
batchCompile opts files = do
  (_,gr,_) <- foldM (compileModule defOpts) emptyCompileEnv files
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
type CompileEnv = (Int,SourceGrammar,ModEnv)

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
  let (_,sgr,rfs) = env
  let file' = if useFileOpt then takeFileName file else file -- to find file itself
  files <- getAllFiles opts ps rfs file'
  ioeIOIf $ putStrLn $ "files to read:" +++ show files ----
  let names = map justModuleName files
  ioeIOIf $ putStrLn $ "modules to include:" +++ show names ----
  foldM (compileOne opts) (0,sgr,rfs) files


compileOne :: Options -> CompileEnv -> FullPath -> IOE CompileEnv
compileOne opts env@(_,srcgr,_) file = do

  let putp s = putPointE opts s
  let putpp = putPointEsil opts
  let putpOpt v m act
       | oElem beVerbose opts =  putp v act
       | oElem beSilent opts  =  putpp v act
       | otherwise = ioeIO (putStrFlush m) >> act

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
       
       extendCompileEnv env file sm

    -- for gf source, do full compilation and generate code
    _ -> do

      let gfo = gfoFile (dropExtension file)
      b1 <- ioeIO $ doesFileExist file
      if not b1
        then compileOne opts env $ gfo
        else do

       sm0 <- putpOpt ("- parsing" +++ file) ("- compiling" +++ file ++ "... ") $ 
                                           getSourceModule opts file
       (k',sm)  <- compileSourceModule opts env sm0
       let sm1 = if isConcr sm then shareModule sm else sm -- cannot expand Str
       cm  <- putpp "  generating code... " $ generateModuleCode opts gfo sm1
          -- sm is optimized before generation, but not in the env
       extendCompileEnvInt env k' gfo sm1
  where
   isConcr (_,mi) = case mi of
     ModMod m -> isModCnc m && mstatus m /= MSIncomplete 
     _ -> False


compileSourceModule :: Options -> CompileEnv -> 
                       SourceModule -> IOE (Int,SourceModule)
compileSourceModule opts env@(k,gr,_) mo@(i,mi) = do

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

generateModuleCode :: Options -> FilePath -> SourceModule -> IOE SourceModule
generateModuleCode opts file minfo = do
  let minfo1 = subexpModule minfo
      out    = prGrammar (MGrammar [minfo1])
  putp ("  wrote file" +++ file) $ ioeIO $ writeFile file $ compactPrint out
  return minfo1
 where
   putp  = putPointE opts
   putpp = putPointEsil opts


-- auxiliaries

pathListOpts :: Options -> FileName -> IO [InitPath]
pathListOpts opts file = return $ maybe [file] splitInModuleSearchPath $ getOptVal opts pathList

reverseModules (MGrammar ms) = MGrammar $ reverse ms

emptyCompileEnv :: CompileEnv
emptyCompileEnv = (0,emptyMGrammar,Map.empty)

extendCompileEnvInt (_,MGrammar ss,menv) k file sm = do
  let (mod,imps) = importsOfModule (trModule sm)
  t <- ioeIO $ getModificationTime file
  return (k,MGrammar (sm:ss),Map.insert mod (t,imps) menv) --- reverse later

extendCompileEnv e@(k,_,_) file sm = extendCompileEnvInt e k file sm


