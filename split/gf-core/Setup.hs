import Distribution.Simple(defaultMainWithHooks,UserHooks(..),simpleUserHooks)
import Distribution.Simple.LocalBuildInfo(LocalBuildInfo(..),absoluteInstallDirs,datadir)
import Distribution.Simple.Setup(BuildFlags(..),Flag(..),InstallFlags(..),CopyDest(..),CopyFlags(..),SDistFlags(..))
import Distribution.PackageDescription(PackageDescription(..),emptyHookedBuildInfo)

import WebSetup

-- | Notice about RGL not built anymore
noRGLmsg :: IO ()
noRGLmsg = putStrLn "Notice: the RGL is not built as part of GF anymore. See https://github.com/GrammaticalFramework/gf-rgl"

-- | Cabal doesn't know how to correctly create the source distribution, so
-- we print an error message with the correct instructions when someone tries
-- `cabal sdist`.
sdistError :: PackageDescription -> Maybe LocalBuildInfo -> UserHooks -> SDistFlags -> IO ()
sdistError _ _ _ _ = fail "Use `make sdist` to create the source distribution file"

main :: IO ()
main = defaultMainWithHooks simpleUserHooks
  { preBuild  = gfPreBuild
  , postBuild = gfPostBuild
  , preInst   = gfPreInst
  , postInst  = gfPostInst
  , postCopy  = gfPostCopy
  , sDistHook = sdistError
  }
  where
    gfPreBuild args  = gfPre args . buildDistPref
    gfPreInst args = gfPre args . installDistPref

    gfPre args distFlag = do
      return emptyHookedBuildInfo

    gfPostBuild args flags pkg lbi = do
      noRGLmsg

    gfPostInst args flags pkg lbi = do
      noRGLmsg
      saveInstallPath args flags (pkg,lbi)
      installWeb (pkg,lbi)

    gfPostCopy args flags  pkg lbi = do
      noRGLmsg
      saveCopyPath args flags (pkg,lbi)
      copyWeb flags (pkg,lbi)

saveInstallPath :: [String] -> InstallFlags -> (PackageDescription, LocalBuildInfo) -> IO ()
saveInstallPath args flags bi = do
  let
    dest = NoCopyDest
    dir = datadir (uncurry absoluteInstallDirs bi dest)
  writeFile dataDirFile dir

saveCopyPath :: [String] -> CopyFlags -> (PackageDescription, LocalBuildInfo) -> IO ()
saveCopyPath args flags bi = do
  let
    dest = case copyDest flags of
      NoFlag -> NoCopyDest
      Flag d -> d
    dir = datadir (uncurry absoluteInstallDirs bi dest)
  writeFile dataDirFile dir

-- | Name of file where installation's data directory is recording
-- This is a last-resort way in which the seprate RGL build script
-- can determine where to put the compiled RGL files
dataDirFile :: String
dataDirFile = "DATA_DIR"
