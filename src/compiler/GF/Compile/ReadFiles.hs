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
             getOptionsFromFile) where

import GF.Infra.UseIO
import GF.Infra.Option
import GF.Infra.Ident
import GF.Infra.Modules
import GF.Data.Operations
import GF.Grammar.Lexer
import GF.Grammar.Parser
import GF.Grammar.Grammar
import GF.Grammar.Binary

import Control.Monad
import Data.Char
import Data.List
import Data.Maybe(isJust)
import qualified Data.ByteString.Char8 as BS
import qualified Data.Map as Map
import System.Time
import System.Directory
import System.FilePath
import Text.PrettyPrint

type ModName = String
type ModEnv  = Map.Map ModName (ClockTime,[ModName])


-- | Returns a list of all files to be compiled in topological order i.e.
-- the low level (leaf) modules are first.
getAllFiles :: Options -> [InitPath] -> ModEnv -> FileName -> IOE [FullPath]
getAllFiles opts ps env file = do
  -- read module headers from all files recursively
  ds <- liftM reverse $ get [] [] (justModuleName file)
  ioeIO $ putIfVerb opts $ "all modules:" +++ show [name | (name,_,_,_,_,_) <- ds]
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
    get :: [ModName]          -- ^ keeps the current path in the dependency graph to avoid cycles
        -> [ModuleInfo]       -- ^ a list of already traversed modules
        -> ModName            -- ^ the current module
        -> IOE [ModuleInfo]   -- ^ the final 
    get trc ds name
      | name `elem` trc = ioeErr $ Bad $ "circular modules" +++ unwords trc
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
    findModule :: ModName -> IOE ModuleInfo
    findModule name = do
      (file,gfTime,gfoTime) <- do
          mb_gfFile <- ioeIO $ getFilePath ps (gfFile name)
          case mb_gfFile of
            Just gfFile -> do gfTime  <- ioeIO $ getModificationTime gfFile
                              mb_gfoTime <- ioeIO $ catch (liftM Just $ getModificationTime (gf2gfo opts gfFile))
                                                          (\_->return Nothing)
                              return (gfFile, Just gfTime, mb_gfoTime)
            Nothing     -> do mb_gfoFile <- ioeIO $ getFilePath (maybe id (:) (flag optGFODir opts) ps) (gfoFile name)
                              case mb_gfoFile of
                                Just gfoFile -> do gfoTime <- ioeIO $ getModificationTime gfoFile
                                                   return (gfoFile, Nothing, Just gfoTime)
                                Nothing      -> ioeErr $ Bad (render (text "File" <+> text (gfFile name) <+> text "does not exist." $$
                                                                      text "searched in:" <+> vcat (map text ps)))


      let mb_envmod = Map.lookup name env
          (st,t) = selectFormat opts (fmap fst mb_envmod) gfTime gfoTime

      (mname,imps) <- case st of
                        CSEnv  -> return (name, maybe [] snd mb_envmod)
                        CSRead -> ioeIO $ fmap importsOfModule (decodeModHeader ((if isGFO file then id else gf2gfo opts) file))
                        CSComp -> do s <- ioeIO $ BS.readFile file
                                     case runP pModHeader s of
                                       Left (Pn l c,msg) -> ioeBad (file ++ ":" ++ show l ++ ":" ++ show c ++ ": " ++ msg)
                                       Right mo          -> return (importsOfModule mo)
      ioeErr $ testErr (mname == name)
                       ("module name" +++ mname +++ "differs from file name" +++ name)
      return (name,st,t,isJust gfTime,imps,dropFileName file)

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
selectFormat :: Options -> Maybe ClockTime -> Maybe ClockTime -> Maybe ClockTime -> (CompStatus,Maybe ClockTime)
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

type ModuleInfo = (ModName,CompStatus,Maybe ClockTime,Bool,[ModName],InitPath)

importsOfModule :: SourceModule -> (ModName,[ModName])
importsOfModule (m,mi) = (modName m,depModInfo mi [])
  where
    depModInfo mi =
      depModType (mtype mi)  .
      depExtends (extend mi) .
      depWith    (mwith mi)  .
      depExDeps  (mexdeps mi).
      depOpens   (opens mi)

    depModType (MTAbstract)       xs = xs
    depModType (MTResource)       xs = xs
    depModType (MTInterface)      xs = xs
    depModType (MTConcrete m2)    xs = modName m2:xs
    depModType (MTInstance m2)    xs = modName m2:xs

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

-- | options can be passed to the compiler by comments in @--#@, in the main file
getOptionsFromFile :: FilePath -> IOE Options
getOptionsFromFile file = do
  s <- ioe $ catch (fmap Ok $ BS.readFile file)
                   (\_ -> return (Bad $ "File " ++ file ++ " does not exist"))
  let ls = filter (BS.isPrefixOf (BS.pack "--#")) $ BS.lines s
      fs = map (BS.unpack . BS.unwords . BS.words . BS.drop 3) ls
  ioeErr $ parseModuleOptions fs

getFilePath :: [FilePath] -> String -> IO (Maybe FilePath)
getFilePath paths file = get paths
  where
    get []     = return Nothing
    get (p:ps) = do
      let pfile = p </> file
      exist <- doesFileExist pfile
      if not exist
        then get ps
        else do pfile <- canonicalizePath pfile
                return (Just pfile)
