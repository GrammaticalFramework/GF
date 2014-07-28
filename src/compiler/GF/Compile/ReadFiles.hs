----------------------------------------------------------------------
-- |
-- Module      : ReadFiles
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/11 23:24:34 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.26 $
--
-- Decide what files to read as function of dependencies and time stamps.
--
-- make analysis for GF grammar modules. AR 11\/6\/2003--24\/2\/2004
--
-- to find all files that have to be read, put them in dependency order, and
-- decide which files need recompilation. Name @file.gf@ is returned for them,
-- and @file.gfo@ otherwise.
-----------------------------------------------------------------------------

module GF.Compile.ReadFiles 
           ( getAllFiles,ModName,ModEnv,importsOfModule,
             gfoFile,gfFile,isGFO,gf2gfo,
             parseSource,lift,
             getOptionsFromFile,getPragmas) where

import Prelude hiding (catch)
import GF.System.Catch
import GF.Infra.UseIO
import GF.Infra.Option
import GF.Infra.Ident
import GF.Data.Operations
import GF.Grammar.Lexer
import GF.Grammar.Parser
import GF.Grammar.Grammar
import GF.Grammar.Binary

import System.IO(mkTextEncoding)
import qualified Data.ByteString.UTF8 as UTF8
import GF.Text.Coding(decodeUnicodeIO)

import Control.Monad
import Data.Maybe(isJust)
import qualified Data.ByteString.Char8 as BS
import qualified Data.Map as Map
import Data.Time(UTCTime)
import GF.System.Directory
import System.FilePath
import GF.Text.Pretty

type ModName = String
type ModEnv  = Map.Map ModName (UTCTime,[ModName])


-- | Returns a list of all files to be compiled in topological order i.e.
-- the low level (leaf) modules are first.
--getAllFiles :: (MonadIO m,ErrorMonad m) => Options -> [InitPath] -> ModEnv -> FileName -> m [FullPath]
getAllFiles opts ps env file = do
  -- read module headers from all files recursively
  ds <- reverse `fmap` get [] [] (justModuleName file)
  putIfVerb opts $ "all modules:" +++ show [name | (name,_,_,_,_,_) <- ds]
  return $ paths ds
  where
    -- construct list of paths to read
    paths ds = concatMap mkFile ds
      where
        mkFile (f,st,time,has_src,imps,p) =
          case st of 
            CSComp             -> [p </> gfFile f]
            CSRead | has_src   -> [gf2gfo opts (p </> gfFile f)]
                   | otherwise -> [p </> gfoFile f]
            CSEnv              -> []

    -- | traverses the dependency graph and returns a topologicaly sorted
    -- list of ModuleInfo. An error is raised if there is circular dependency
 {- get :: [ModName]          -- ^ keeps the current path in the dependency graph to avoid cycles
        -> [ModuleInfo]       -- ^ a list of already traversed modules
        -> ModName            -- ^ the current module
        -> IOE [ModuleInfo]   -- ^ the final -}
    get trc ds name
      | name `elem` trc = raise $ "circular modules" +++ unwords trc
      | (not . null) [n | (n,_,_,_,_,_) <- ds, name == n]     --- file already read
                        = return ds
      | otherwise       = do
           (name,st0,t0,has_src,imps,p) <- findModule name
           ds <- foldM (get (name:trc)) ds imps
           let (st,t) | has_src &&
                        flag optRecomp opts == RecompIfNewer &&
                        (not . null) [f | (f,st,t1,_,_,_) <- ds, elem f imps && liftM2 (>=) t0 t1 /= Just True]
                                  = (CSComp,Nothing)
                      | otherwise = (st0,t0)
           return ((name,st,t,has_src,imps,p):ds)

    -- searches for module in the search path and if it is found
    -- returns 'ModuleInfo'. It fails if there is no such module
  --findModule :: ModName -> IOE ModuleInfo
    findModule name = do
      (file,gfTime,gfoTime) <- do
          mb_gfFile <- getFilePath ps (gfFile name)
          case mb_gfFile of
            Just gfFile -> do gfTime  <- modtime gfFile
                              mb_gfoTime <- maybeIO $ modtime (gf2gfo opts gfFile)
                              return (gfFile, Just gfTime, mb_gfoTime)
            Nothing     -> do mb_gfoFile <- getFilePath (maybe id (:) (flag optGFODir opts) ps) (gfoFile name)
                              case mb_gfoFile of
                                Just gfoFile -> do gfoTime <- modtime gfoFile
                                                   return (gfoFile, Nothing, Just gfoTime)
                                Nothing      -> raise (render ("File" <+> gfFile name <+> "does not exist." $$
                                                                      "searched in:" <+> vcat ps))


      let mb_envmod = Map.lookup name env
          (st,t) = selectFormat opts (fmap fst mb_envmod) gfTime gfoTime

      (st,(mname,imps)) <-
                      case st of
                        CSEnv  -> return (st, (name, maybe [] snd mb_envmod))
                        CSRead -> do mb_mo <- liftIO $ decodeModuleHeader ((if isGFO file then id else gf2gfo opts) file)
                                     case mb_mo of
                                       Just mo -> return (st,importsOfModule mo)
                                       Nothing
                                         | isGFO file -> raise (file ++ " is compiled with different GF version and I can't find the source file")
                                         | otherwise  -> do mo <- parseModHeader opts file
                                                            return (CSComp,importsOfModule mo)
                        CSComp -> do mo <- parseModHeader opts file
                                     return (st,importsOfModule mo)
      testErr (mname == name)
              ("module name" +++ mname +++ "differs from file name" +++ name)
      return (name,st,t,isJust gfTime,imps,dropFileName file)

modtime path = liftIO $ getModificationTime path

isGFO :: FilePath -> Bool
isGFO = (== ".gfo") . takeExtensions

gfoFile :: FilePath -> FilePath
gfoFile f = addExtension f "gfo"

gfFile :: FilePath -> FilePath
gfFile f = addExtension f "gf"

gf2gfo :: Options -> FilePath -> FilePath
gf2gfo opts file = maybe (gfoFile (dropExtension file))
                         (\dir -> dir </> gfoFile (dropExtension (takeFileName file)))
                         (flag optGFODir opts)

-- From the given Options and the time stamps computes
-- whether the module have to be computed, read from .gfo or
-- the environment version have to be used
selectFormat :: Options -> Maybe UTCTime -> Maybe UTCTime -> Maybe UTCTime -> (CompStatus,Maybe UTCTime)
selectFormat opts mtenv mtgf mtgfo =
  case (mtenv,mtgfo,mtgf) of
    (_,_,Just tgf)         | fromSrc  -> (CSComp,Nothing)
    (Just tenv,_,_)        | fromComp -> (CSEnv, Just tenv)
    (_,Just tgfo,_)        | fromComp -> (CSRead,Just tgfo)
    (Just tenv,_,Just tgf) | tenv > tgf -> (CSEnv, Just tenv)
    (_,Just tgfo,Just tgf) | tgfo > tgf -> (CSRead,Just tgfo)
    (Just tenv,_,Nothing) -> (CSEnv,Just tenv) -- source does not exist
    (_,Just tgfo,Nothing) -> (CSRead,Just tgfo)  -- source does not exist
    _ -> (CSComp,Nothing)
  where
    fromComp = flag optRecomp opts == NeverRecomp
    fromSrc  = flag optRecomp opts == AlwaysRecomp


-- internal module dep information


data CompStatus =
   CSComp -- compile: read gf
 | CSRead -- read gfo
 | CSEnv  -- gfo is in env
  deriving Eq

type ModuleInfo = (ModName,CompStatus,Maybe UTCTime,Bool,[ModName],InitPath)

importsOfModule :: SourceModule -> (ModName,[ModName])
importsOfModule (m,mi) = (modName m,depModInfo mi [])
  where
    depModInfo mi =
      depModType (mtype mi)  .
      depExtends (mextend mi) .
      depWith    (mwith mi)  .
      depExDeps  (mexdeps mi).
      depOpens   (mopens mi)

    depModType (MTAbstract)       xs = xs
    depModType (MTResource)       xs = xs
    depModType (MTInterface)      xs = xs
    depModType (MTConcrete m2)    xs = modName m2:xs
    depModType (MTInstance (m2,_))    xs = modName m2:xs

    depExtends es xs = foldr depInclude xs es

    depWith (Just (m,_,is)) xs = modName m : depInsts is xs
    depWith Nothing         xs = xs

    depExDeps eds xs = map modName eds ++ xs

    depOpens os xs = foldr depOpen xs os

    depInsts is xs = foldr depInst xs is

    depInclude (m,_) xs = modName m:xs

    depOpen (OSimple n  ) xs = modName n:xs
    depOpen (OQualif _ n) xs = modName n:xs

    depInst (m,n) xs = modName m:modName n:xs

    modName = showIdent


parseModHeader opts file =
  do --ePutStrLn file
     (_,parsed) <- parseSource opts pModHeader =<< lift (BS.readFile file)
     case parsed of
       Right mo          -> return mo
       Left (Pn l c,msg) ->
                  raise (file ++ ":" ++ show l ++ ":" ++ show c ++ ": " ++ msg)

parseSource opts p raw =
  do (coding,utf8) <- toUTF8 opts raw
     return (coding,runP p utf8)

toUTF8 opts0 raw =
  do opts <- getPragmas raw
     let given = flag optEncoding opts -- explicitly given encoding
         coding = getEncoding $ opts0 `addOptions` opts
     utf8 <- if coding=="UTF-8"
             then return raw
             else lift $ do --ePutStrLn $ "toUTF8 from "++coding
                            enc <- mkTextEncoding coding
                            -- decodeUnicodeIO uses a lot of stack space,
                            -- so we need to split the file into smaller pieces
                            ls <- mapM (decodeUnicodeIO enc) (BS.lines raw)
                            return $ UTF8.fromString (unlines ls)
     return (given,utf8)

--lift io = ioe (fmap Ok io `catch` (return . Bad . show))
lift io = liftIO io

-- | options can be passed to the compiler by comments in @--#@, in the main file
getOptionsFromFile :: (MonadIO m,ErrorMonad m) => FilePath -> m Options
getOptionsFromFile file = do
  s <- either (\_ -> raise $ "File " ++ file ++ " does not exist") return =<<
       liftIO (try $ BS.readFile file)
  opts <- getPragmas s
  -- The coding flag should not be inherited by other files
  return (addOptions opts (modifyFlags $ \ f -> f{optEncoding=Nothing}))


getPragmas :: (ErrorMonad m) => BS.ByteString -> m Options
getPragmas = parseModuleOptions . 
             map (BS.unpack . BS.unwords . BS.words . BS.drop 3) .
             filter (BS.isPrefixOf (BS.pack "--#")) . BS.lines

--getFilePath :: MonadIO m => [FilePath] -> String -> m (Maybe FilePath)
getFilePath paths file =
   liftIO $ do --ePutStrLn $ "getFilePath "++show paths++" "++show file
               get paths
  where
    get []     = return Nothing
    get (p:ps) = do
      let pfile = p </> file
      exist <- doesFileExist pfile
      if not exist
        then get ps
        else do pfile <- canonicalizePath pfile
                return (Just pfile)
