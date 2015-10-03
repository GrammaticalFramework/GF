import Control.Monad ( unless, forM, liftM )
import System.Exit ( ExitCode(..) )
import Data.Maybe ( isNothing, fromJust )
import System.Directory (doesDirectoryExist, getDirectoryContents, doesFileExist)
import System.FilePath ((</>), takeExtension, replaceExtension)

import Test.Framework hiding ( runTest )
import Test.Framework.TestManager ( makeBlackBoxTest )
import Test.Framework.TestTypes ( Test )
import Test.Framework.BlackBoxTest ( defaultDiff )
import Test.HUnit ( assertFailure )

import System.Process ( readProcessWithExitCode )

runTest :: FilePath -- ^ name of program under test
        -> [String] -- ^ cli arguments
        -> FilePath -- ^ stdin
        -> Maybe FilePath -- ^ stdout
        -> Maybe FilePath -- ^ stderr
        -> Test
runTest put args inF outF errF = makeBlackBoxTest testID assertion
  where testID = inF
        assertion =
          do stdin <- readFile inF
             (s,out,err) <- readProcessWithExitCode put args stdin
             unless ( s == ExitSuccess ) $ assertFailure ( "Exit code: " ++ show s )
             outDiff <- defaultDiff outF out
             assertNoDiff outF out
             assertNoDiff errF err
        assertNoDiff file str =
          defaultDiff file str >>= \d -> 
            unless ( isNothing d ) ( assertFailure ( fromJust d ) )

findFiles :: FilePath -- ^ root dir
          -> IO [FilePath]
findFiles root = do
  names <- getDirectoryContents root
  let properNames = filter (`notElem` [".", ".."]) names
  paths <- forM properNames $ \name -> do
    let path = root </> name
    isDirectory <- doesDirectoryExist path
    if isDirectory
      then findFiles path
      else return [path]
  return (concat paths)

findGfsFiles = liftM ( filter ( hasExtension ".gfs" ) ) . findFiles
  where hasExtension ext = (== ext) . takeExtension

runGfsTest :: FilePath -> IO Test
runGfsTest file = do
    outF <- maybeFile ( replaceExtension file ".out" )
    errF <- maybeFile ( replaceExtension file ".err" )
    return $ runTest  "dist/build/gf/gf" ["--run"] file outF errF
  where maybeFile f = do b <- doesFileExist f
                         return ( if b then Just f else Nothing )

main =
  findGfsFiles "lib/tests" >>= mapM runGfsTest >>= htfMain
