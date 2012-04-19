module WebSetup(installWeb,copyWeb) where

import System.Directory(createDirectoryIfMissing,copyFile,removeFile)
import System.FilePath((</>))
import System.Cmd(system)
import System.Exit(ExitCode(..))
import Distribution.Simple.Setup(Flag(..),CopyDest(..),copyDest)
import Distribution.Simple.LocalBuildInfo(datadir,buildDir,absoluteInstallDirs)

{-
   To test the GF web services, the minibar and the grammar editor, use
   "cabal install" (or "runhaskell Setup.hs install") to install gf as usual.
   Then start the server with the command "gf -server" and open
   http://localhost:41296/ in your web browser (Firefox, Safari, Opera or
   Chrome). The example grammars listed below will be available in the minibar.
-}

example_grammars =  -- :: [(pgf, tmp, src)]
   [("Foods.pgf","foods",foodsSrc),
    ("Letter.pgf","letter",letterSrc)]
  where
    foodsDir ="contrib"</>"summerschool"</>"foods"
  --foodsSrc = foodsDir</>"Foods???.gf" -- doesn't work on Win32
    foodsSrc = unwords [foodsDir</>"Foods"++lang++".gf"|lang<-foodsLangs]
    foodsLangs = words "Afr Amh Bul Cat Cze Dut Eng Epo Fin Fre Ger Gle Heb Hin Ice Ita Jpn Lav Mlt Mon Nep Pes Por Ron Spa Swe Tha Tsn Tur Urd"

    letterDir = "examples"</>"letter"
  --letterSrc = letterDir</>"Letter???.gf"
    letterSrc = unwords [letterDir</>"Letter"++lang++".gf"|lang<-letterLangs]
    letterLangs = words "Eng Fin Fre Heb Rus Swe"


installWeb gf args flags pki lbi = setupWeb gf args dest pki lbi
  where
    dest = NoCopyDest

copyWeb gf args flags pki lbi = setupWeb gf args dest pki lbi
  where
    dest = case copyDest flags of
             NoFlag -> NoCopyDest
             Flag d -> d

setupWeb gf args dest pkg lbi =
    do putStrLn "setupWeb"
       mapM_ (createDirectoryIfMissing True) [grammars_dir,cloud_dir]
       mapM_ build_pgf example_grammars
       copyGFLogo
  where
    grammars_dir = www_dir </> "grammars"
    cloud_dir = www_dir </> "tmp" -- hmm
    logo_dir = www_dir </> "Logos"
    www_dir = datadir (absoluteInstallDirs pkg lbi dest) </> "www"
    gfo_dir = buildDir lbi </> "gfo"

    build_pgf (pgf,tmp,src) =
      do createDirectoryIfMissing True tmp_dir
         execute cmd
         copyFile pgf (grammars_dir</>pgf)
         putStrLn (grammars_dir</>pgf)
         removeFile pgf
      where
        tmp_dir = gfo_dir</>tmp
        cmd = gf++" -make -s -optimize-pgf --gfo-dir="++tmp_dir++
              " --gf-lib-path=dist"</>"build"</>"rgl"++
           -- " --output-dir="++grammars_dir++  -- has no effect?!
              " "++src

    gf_logo = "gf0.png"

    copyGFLogo =
      do createDirectoryIfMissing True logo_dir
         copyFile ("doc"</>"Logos"</>gf_logo) (logo_dir</>gf_logo)

execute command =
  do putStrLn command
     e <- system command
     case e of
       ExitSuccess -> return ()
       _ -> fail "Command failed"
     return ()
