{-# OPTIONS_GHC -fwarn-unused-imports #-}

import Control.Monad(when)
import System.Directory(createDirectoryIfMissing,doesFileExist,
                        getDirectoryContents,copyFile,removeFile)
import System.FilePath((</>))
import System.Process(system)
import System.Exit(ExitCode(..))

import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.Simple.LocalBuildInfo(datadir,buildDir,absoluteInstallDirs)

main :: IO ()
main = defaultMainWithHooks simpleUserHooks{ postInst = instWWW
                                           , postCopy = copyWWW
                                           }
--------------------------------------------------------------------------------
-- To test the GF web service and minibar, use "cabal install" (or
-- "runhaskell Setup.hs install") to install the program pgf-http, the
-- example grammars listed below, and the minibar. Then start the server with
-- the command "pgf-http" and open http://localhost:41296/minibar/minibar.html
-- in your web browser (Firefox, Safari, Opera or Chrome).

example_grammars =
 -- (pgf, tmp, src)
   [("Foods.pgf","foods",
     ".."</>".."</>"contrib"</>"summerschool"</>"foods"</>"Foods???.gf"),
    ("Letter.pgf","letter",
     ".."</>".."</>"examples"</>"letter"</>"Letter???.gf")]

minibar_src = ".."</>"www"</>"minibar"

--------------------------------------------------------------------------------
instWWW args flags pki lbi = setupWWW args dest pki lbi
  where
    dest = NoCopyDest

copyWWW args flags pki lbi = setupWWW args dest pki lbi
  where
    dest = case copyDest flags of
             NoFlag -> NoCopyDest
             Flag d -> d

setupWWW args dest pkg lbi =
    do mapM_ (createDirectoryIfMissing True) [grammars_dir,minibar_dir]
       mapM_ build_pgf example_grammars
       copy_minibar
       create_root_index
  where
    grammars_dir = www_dir </> "grammars"
    minibar_dir = www_dir </> "minibar"
    www_dir = datadir (absoluteInstallDirs pkg lbi dest) </> "www"
    gfo_dir = buildDir lbi </> "gfo"

    build_pgf (pgf,tmp,src) =
      do createDirectoryIfMissing True tmp_dir
         execute cmd
         copyFile pgf (grammars_dir</>pgf)
         removeFile pgf
      where
        tmp_dir = gfo_dir</>tmp
        cmd = "gf -make -s -optimize-pgf --gfo-dir="++tmp_dir++
           -- " --output-dir="++grammars_dir++  -- has no effect?!
              " "++src

    copy_minibar =
      do files <- getDirectoryContents minibar_src
         mapM_ copy files
      where
        copy file =
            do isFile <- doesFileExist src 
               when isFile $ copyFile src (minibar_dir</>file)
          where
            src = minibar_src</>file

    create_root_index = writeFile (www_dir</>"index.html") index_html

    index_html = "<h1>PGF service</h1>\n<h2>Available demos</h2>\n"
                 ++"<ul><li><a href=\"minibar/minibar.html\">Minibar</a></ul>"
                 ++"Additional grammars can be installed in"
                 ++"<blockquote><code>"++grammars_dir++"</code></blockquote>"
                 ++"<a href=\"http://www.grammaticalframework.org/\">"
                 ++"Grammatical Framework</a>"
execute command =
  do putStrLn command
     e <- system command
     case e of
       ExitSuccess -> return ()
       _ -> fail "Command failed"
     return ()
