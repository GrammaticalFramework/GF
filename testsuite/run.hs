import Data.List(partition)
import System.IO
import Distribution.Simple.BuildPaths(exeExtension)
import System.Process(readProcess)
import System.Directory(doesFileExist,getDirectoryContents)
import System.FilePath((</>),(<.>),takeExtension)
import System.Exit(exitSuccess,exitFailure)

main = 
   do res <- walk "testsuite"
      let cnt = length res
          (good,bad) = partition ((=="OK").fst) res
          ok = length good
          fail = ok<cnt
      putStrLn $ show ok++"/"++show cnt++ " passed/tests"
      let overview = "dist/test/gf-tests.html"
      writeFile overview (toHTML bad)
      if ok<cnt 
        then do putStrLn $ overview++" contains an overview of the failed tests"
                exitFailure
        else exitSuccess
  where
    toHTML res =
        "<!DOCTYPE html>\n"
        ++ "<meta charset=\"UTF-8\">\n"
        ++ "<style>\n"
        ++ "pre { max-width: 500px; overflow: scroll; }\n"
        ++ "th,td { vertical-align: top; text-align: left; }\n"
        ++ "</style>\n"
        ++ "<table border=1>\n<tr><th>Result<th>Input<th>Gold<th>Output\n"
        ++ unlines (map testToHTML res)
        ++ "</table>\n"

    testToHTML (res,(input,gold,output)) =
      "<tr>"++concatMap (td.pre) [res,input,gold,output]
    pre s = "<pre>"++s++"</pre>"
    td s = "<td>"++s

    walk path = fmap concat . mapM (walkFile . (path </>)) =<< ls path

    walkFile fpath = do
      exists <- doesFileExist fpath
      if exists
        then if takeExtension fpath == ".gfs"
               then do let in_file   = fpath
                           gold_file = fpath <.> ".gold"
                           out_file  = fpath <.> ".out"
                       res <- runTest in_file out_file gold_file
                       putStrLn $ fst res++": "++in_file
                       return [res]
               else return []
        else walk fpath

    runTest in_file out_file gold_file = do
      input <- readFile in_file
      writeFile out_file =<< run_gf input
      exists <- doesFileExist gold_file
      if exists
        then do out <- compatReadFile out_file
                gold <- compatReadFile gold_file
                let info = (input,gold,out)
                return $! if out == gold then ("OK",info) else ("FAIL",info)
        else do out <- compatReadFile out_file
                return ("MISSING GOLD",(input,"",out))
    -- Avoid failures caused by Win32/Unix text file incompatibility
    compatReadFile path =
      do h <- openFile path ReadMode
         hSetNewlineMode h universalNewlineMode
         hGetContents h

-- Should consult the Cabal configuration!
run_gf = readProcess default_gf ["-run","-gf-lib-path="++gf_lib_path]
default_gf = "dist/build/gf/gf"<.>exeExtension
gf_lib_path = "dist/build/rgl"

-- | List files, excluding "." and ".."
ls path = filter (`notElem` [".",".."]) `fmap` getDirectoryContents path
