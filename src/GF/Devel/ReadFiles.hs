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

module GF.Devel.ReadFiles 
           ( getAllFiles,ModName,getOptionsFromFile,importsOfModule,
             gfoFile,gfFile,isGFO ) where

import GF.Infra.Option
import GF.Data.Operations
import GF.Devel.UseIO
import GF.Source.AbsGF hiding (FileName)
import GF.Source.LexGF
import GF.Source.ParGF

import Control.Monad
import Data.Char
import Data.List
import qualified Data.ByteString.Char8 as BS
import qualified Data.Map as Map
import System
import System.Time
import System.Directory
import System.FilePath

type ModName = String
type ModEnv  = Map.Map ModName (ClockTime,[ModName])


-- | Returns a list of all files to be compiled in topological order i.e.
-- the low level (leaf) modules are first.
getAllFiles :: Options -> [InitPath] -> ModEnv -> FileName -> IOE [FullPath]
getAllFiles opts ps env file = do
  -- read module headers from all files recursively
  ds <- liftM reverse $ get [] [] (justModuleName file)
  if oElem beVerbose opts
    then ioeIO $ putStrLn $ "all modules:" +++ show [name | (name,_,_,_,_) <- ds]
    else return ()
  return $ paths ds
  where
    -- construct list of paths to read
    paths cs = [mk (p </> f) | (f,st,_,_,p) <- cs, mk <- mkFile st]
      where
        mkFile CSComp = [gfFile ]
        mkFile CSRead = [gfoFile]
        mkFile _      = []

    -- | traverses the dependency graph and returns a topologicaly sorted
    -- list of ModuleInfo. An error is raised if there is circular dependency
    get :: [ModName]          -- ^ keeps the current path in the dependency graph to avoid cycles
        -> [ModuleInfo]       -- ^ a list of already traversed modules
        -> ModName            -- ^ the current module
        -> IOE [ModuleInfo]   -- ^ the final 
    get trc ds name
      | name `elem` trc = ioeErr $ Bad $ "circular modules" +++ unwords trc
      | (not . null) [n | (n,_,_,_,_) <- ds, name == n]     --- file already read
                        = return ds
      | otherwise       = do
           (name,st0,t0,imps,p) <- findModule name
           ds <- foldM (get (name:trc)) ds imps
           let (st,t) | (not . null) [f | (f,CSComp,_,_,_) <- ds, elem f imps]
                                  = (CSComp,Nothing)
                      | otherwise = (st0,t0)
           return ((name,st,t,imps,p):ds)

    -- searches for module in the search path and if it is found
    -- returns 'ModuleInfo'. It fails if there is no such module
    findModule :: ModName -> IOE ModuleInfo
    findModule name = do
      (file,gfTime,gfoTime) <- do
          mb_gfFile <- ioeIO $ getFilePathMsg "" ps (gfFile name)
          case mb_gfFile of
            Just gfFile -> do gfTime  <- ioeIO $ getModificationTime gfFile
                              mb_gfoTime <- ioeIO $ catch (liftM Just $ getModificationTime (replaceExtension gfFile "gfo"))
                                                        (\_->return Nothing)
                              return (gfFile, Just gfTime, mb_gfoTime)
            Nothing     -> do mb_gfoFile <- ioeIO $ getFilePathMsg "" ps (gfoFile name)
                              case mb_gfoFile of
                                Just gfoFile -> do gfoTime <- ioeIO $ getModificationTime gfoFile
                                                   return (gfoFile, Nothing, Just gfoTime)
                                Nothing      -> ioeErr $ Bad ("File " ++ gfFile name ++ " does not exist.")


      let mb_envmod = Map.lookup name env
          (st,t) = selectFormat opts (fmap fst mb_envmod) gfTime gfoTime

      imps <- if st == CSEnv
                then return (maybe [] snd mb_envmod)
                else do s <- ioeIO $ BS.readFile file
                        (mname,imps) <- ioeErr ((liftM importsOfModule . pModHeader . myLexer) s)
                        ioeErr $ testErr  (mname == name)
                                          ("module name" +++ mname +++ "differs from file name" +++ name)
                        return imps

      return (name,st,t,imps,dropFileName file)


isGFO :: FilePath -> Bool
isGFO = (== ".gfo") . takeExtensions

gfoFile :: FilePath -> FilePath
gfoFile f = addExtension f "gfo"

gfFile :: FilePath -> FilePath
gfFile f = addExtension f "gf"


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
    (_,_,        Nothing) -> (CSRead,Nothing)  -- source does not exist
    _ -> (CSComp,Nothing)
  where
    fromComp = oElem isCompiled opts -- i -gfo
    fromSrc  = oElem fromSource opts


-- internal module dep information


data CompStatus =
   CSComp -- compile: read gf
 | CSRead -- read gfo
 | CSEnv  -- gfo is in env
  deriving Eq

type ModuleInfo = (ModName,CompStatus,Maybe ClockTime,[ModName],InitPath)

 
importsOfModule :: ModDef -> (ModName,[ModName])
importsOfModule (MModule _ typ body) = modType typ (modBody body [])
  where
    modType (MTAbstract  m)      xs = (modName m,xs)
    modType (MTResource m)       xs = (modName m,xs)
    modType (MTInterface m)      xs = (modName m,xs)
    modType (MTConcrete m m2)    xs = (modName m,modName m2:xs)
    modType (MTInstance m m2)    xs = (modName m,modName m2:xs)
    modType (MTTransfer m o1 o2) xs = (modName m,open o1 (open o2 xs))

    modBody (MBody e o _)            xs = extend e (opens o xs)
    modBody (MNoBody is)             xs = foldr include xs is
    modBody (MWith i os)             xs = include i (foldr open xs os)
    modBody (MWithBody i os o _)     xs = include i (foldr open (opens o xs) os)
    modBody (MWithE is i os)         xs = foldr include (include i (foldr open xs os)) is
    modBody (MWithEBody is i os o _) xs = foldr include (include i (foldr open (opens o xs) os)) is
    modBody (MReuse m)               xs = modName m:xs
    modBody (MUnion is)              xs = foldr include xs is

    include (IAll   m)   xs = modName m:xs
    include (ISome  m _) xs = modName m:xs
    include (IMinus m _) xs = modName m:xs

    open (OName n)     xs = modName n:xs
    open (OQualQO _ n) xs = modName n:xs
    open (OQual _ _ n) xs = modName n:xs

    extend NoExt    xs = xs
    extend (Ext is) xs = foldr include xs is

    opens NoOpens     xs = xs
    opens (OpenIn os) xs = foldr open xs os

    modName (PIdent (_,s)) = s


-- | options can be passed to the compiler by comments in @--#@, in the main file
getOptionsFromFile ::  FilePath -> IO Options
getOptionsFromFile file = do
  s <- readFileIfStrict file
  let ls = filter (BS.isPrefixOf (BS.pack "--#")) $ BS.lines s
  return $ fst $ getOptions "-" $ map (BS.unpack . BS.unwords . BS.words . BS.drop 3) ls
