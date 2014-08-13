module GF.CompileOne(OneOutput,CompiledModule,
                     compileOne --, compileSourceModule
                     ) where
import Prelude hiding (catch)
import GF.System.Catch

-- The main compiler passes
import GF.Compile.GetGrammar(getSourceModule)
import GF.Compile.Rename(renameModule)
import GF.Compile.CheckGrammar(checkModule)
import GF.Compile.Optimize(optimizeModule)
import GF.Compile.SubExOpt(subexpModule,unsubexpModule)
import GF.Compile.GeneratePMCFG(generatePMCFG)
import GF.Compile.Update(extendModule,rebuildModule)
import GF.Compile.Tags(writeTags,gf2gftags)

import GF.Grammar.Grammar
import GF.Grammar.Printer(ppModule,TermPrintQual(..))
import GF.Grammar.Binary(decodeModule,encodeModule)

import GF.Infra.Option
import GF.Infra.UseIO(FullPath,IOE,gf2gfo,liftIO,ePutStrLn,putPointE,putStrE)
import GF.Infra.CheckM(runCheck)
import GF.Data.Operations(liftErr,(+++))

import GF.System.Directory(doesFileExist,getCurrentDirectory)
import System.FilePath(dropFileName,dropExtension,takeExtensions)
import qualified Data.Map as Map
import GF.Text.Pretty(Doc,render,(<+>),($$))


type OneOutput = (Maybe FullPath,CompiledModule)
type CompiledModule = SourceModule

-- | Compile a given source file (or just load a .gfo file),
-- given a 'SourceGrammar' containing everything it depends on.
compileOne :: Options -> SourceGrammar -> FullPath -> IOE OneOutput
compileOne opts srcgr file = do

  let putpOpt v m act
       | verbAtLeast opts Verbose = putPointE Normal opts v act
       | verbAtLeast opts Normal  = putStrE m >> act
       | otherwise                = putPointE Verbose opts v act

  let path = dropFileName file
  let name = dropExtension file

  case takeExtensions file of
    ".gfo" -> reuseGFO opts srcgr file
    _ -> do
      -- for gf source, do full compilation and generate code
      b1 <- liftIO $ doesFileExist file
      if not b1
        then compileOne opts srcgr $ (gf2gfo opts file)
        else do

       sm <- putpOpt ("- parsing" +++ file) ("- compiling" +++ file ++ "... ")
             $ getSourceModule opts file
       intermOut opts (Dump Source) (ppModule Internal sm)

       compileSourceModule opts srcgr (Just file) sm

-- | For compiled gf, read the file and update environment
-- also undo common subexp optimization, to enable normal computations
reuseGFO opts srcgr file =
  do sm00 <- putPointE Verbose opts ("+ reading" +++ file) $
             liftIO (decodeModule file)
     let sm0 = (fst sm00,(snd sm00){mflags=mflags (snd sm00) `addOptions` opts})

     intermOut opts (Dump Source) (ppModule Internal sm0)

     let sm1 = unsubexpModule sm0
     cwd <- liftIO getCurrentDirectory
     (sm,warnings) <- -- putPointE Normal opts "creating indirections" $ 
                      runCheck $ extendModule cwd srcgr sm1
     warnOut opts warnings

     if flag optTagsOnly opts
       then writeTags opts srcgr (gf2gftags opts file) sm1
       else return ()

     return (Just file,sm)

compileSourceModule :: Options -> SourceGrammar -> Maybe FilePath -> SourceModule -> IOE OneOutput
compileSourceModule opts gr mb_gfFile mo0 = do

  cwd <- liftIO getCurrentDirectory
  mo1 <- runPass Extend "" . extendModule cwd gr
            =<< runPass Rebuild "" (rebuildModule cwd gr mo0)

  case mo1 of
    (_,n) | not (isCompleteModule n) -> generateTagsOr generateGFO mo1
    _ -> do
      mo2 <- runPass Rename "renaming" $ renameModule cwd gr mo1
      mo3 <- runPass TypeCheck "type checking" $ checkModule opts cwd gr mo2
      generateTagsOr compileCompleteModule mo3
  where
    compileCompleteModule mo3 = do
      mo4 <- runPass2 id Optimize "optimizing" $ optimizeModule opts gr mo3
      mo5 <- if isModCnc (snd mo4) && flag optPMCFG opts
             then runPass2' "generating PMCFG" $ generatePMCFG opts gr mb_gfFile mo4
             else runPass2' "" $ return mo4
      generateGFO mo5

  ------------------------------
    generateTagsOr compile =
       if flag optTagsOnly opts then generateTags else compile

    generateGFO mo =
      do let mb_gfo = fmap (gf2gfo opts) mb_gfFile
         maybeM (flip (writeGFO opts) mo) mb_gfo
         return (mb_gfo,mo)

    generateTags mo =
      do maybeM (flip (writeTags opts gr) mo . gf2gftags opts) mb_gfFile
         return (Nothing,mo)

    putpp s = if null s then id else putPointE Verbose opts ("  "++s++" ")
    idump pass = intermOut opts (Dump pass) . ppModule Internal

    -- * Impedance matching
    runPass = runPass' fst fst snd (liftErr . runCheck)
    runPass2 = runPass2e liftErr
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
  putPointE Normal opts ("  write file" +++ file) $ liftIO $ encodeModule file mo2


-- to output an intermediate stage
intermOut :: Options -> Dump -> Doc -> IOE ()
intermOut opts d doc
  | dump opts d = ePutStrLn (render ("\n\n--#" <+> show d $$ doc))
  | otherwise   = return ()

warnOut opts warnings
  | null warnings = return ()
  | otherwise     = liftIO $ ePutStrLn ws `catch` oops
  where
    oops _ = ePutStrLn "" -- prevent crash on character encoding problem
    ws = if flag optVerbosity opts == Normal
         then '\n':warnings
         else warnings
