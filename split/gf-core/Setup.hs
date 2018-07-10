import Distribution.Simple(defaultMainWithHooks,UserHooks(..),simpleUserHooks)
import Distribution.Simple.LocalBuildInfo(LocalBuildInfo(..),absoluteInstallDirs,datadir)
import Distribution.Simple.Setup(BuildFlags(..),Flag(..),InstallFlags(..),CopyDest(..),CopyFlags(..),SDistFlags(..))
import Distribution.PackageDescription(PackageDescription(..),emptyHookedBuildInfo)
import System.FilePath((</>))

import WebSetup

-- | Notice about RGL not built anymore
noRGLmsg :: IO ()
noRGLmsg = putStrLn "RGL is not built as part of GF anymore."

-- | Cabal doesn't know how to correctly create the source distribution, so
-- we print an error message with the correct instructions when someone tries
-- `cabal sdist`.
sdistError :: PackageDescription -> Maybe LocalBuildInfo -> UserHooks -> SDistFlags -> IO ()
sdistError _ _ _ _ = fail "Error: Use `make sdist` to create the source distribution file"

main :: IO ()
main = defaultMainWithHooks simpleUserHooks{ preBuild  = gfPreBuild
                                           , postBuild = gfPostBuild
                                           , preInst   = gfPreInst
                                           , postInst  = gfPostInst
                                           -- , preCopy   = const . checkRGLArgs
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
    inst_gf_lib_dir = datadir (uncurry absoluteInstallDirs bi dest) </> "lib"
  writeFile "GF_LIB_PATH" inst_gf_lib_dir

saveCopyPath :: [String] -> CopyFlags -> (PackageDescription, LocalBuildInfo) -> IO ()
saveCopyPath args flags bi = do
  let
    dest = case copyDest flags of
      NoFlag -> NoCopyDest
      Flag d -> d
    inst_gf_lib_dir = datadir (uncurry absoluteInstallDirs bi dest) </> "lib"
  writeFile "GF_LIB_PATH" inst_gf_lib_dir
