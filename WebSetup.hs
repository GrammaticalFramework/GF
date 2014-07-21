module WebSetup(buildWeb,installWeb,copyWeb) where

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

example_grammars =  -- :: [(pgf, subdir, src)]
   [("Letter.pgf","letter",letterSrc)
   ,("Foods.pgf","foods",foodsSrc)
   ,("Phrasebook.pgf","phrasebook",phrasebookSrc)
   ]
  where
  --foodsSrc = "Foods???.gf" -- doesn't work on Win32
    foodsSrc = ["Foods"++lang++".gf"|lang<-foodsLangs]
    foodsLangs = words "Afr Amh Bul Cat Cze Dut Eng Epo Fin Fre Ger Gle Heb Hin Ice Ita Jpn Lav Mlt Mon Nep Pes Por Ron Spa Swe Tha Tsn Tur Urd"

  --phrasebookSrc = "Phrasebook???.gf" -- doesn't work on Win32
    phrasebookSrc = ["Phrasebook"++lang++".gf"|lang<-phrasebookLangs]
    phrasebookLangs = words "Bul Cat Chi Dan Dut Eng Lav Hin Nor Spa Swe Tha" -- only fastish languages

  --letterSrc = "Letter???.gf"
    letterSrc = ["Letter"++lang++".gf"|lang<-letterLangs]
    letterLangs = words "Eng Fin Fre Heb Rus Swe"

buildWeb gf args flags pkg lbi =
    do --putStrLn "buildWeb"
       mapM_ build_pgf example_grammars
  where
    gfo_dir = buildDir lbi </> "examples"

    build_pgf (pgf,subdir,src) =
      do createDirectoryIfMissing True tmp_dir
         putStrLn $ "Building "++pgf
         execute cmd
      where
        tmp_dir = gfo_dir</>subdir
        dir = "examples"</>subdir
        cmd = gf++" -make -s -optimize-pgf --gfo-dir="++tmp_dir++
              " --gf-lib-path="++buildDir lbi </> "rgl"++
              " --output-dir="++gfo_dir++
              " "++unwords [dir</>file|file<-src]

installWeb gf args flags pki lbi = setupWeb gf args dest pki lbi
  where
    dest = NoCopyDest

copyWeb gf args flags pki lbi = setupWeb gf args dest pki lbi
  where
    dest = case copyDest flags of
             NoFlag -> NoCopyDest
             Flag d -> d

setupWeb gf args dest pkg lbi =
    do mapM_ (createDirectoryIfMissing True) [grammars_dir,cloud_dir]
       mapM_ copy_pgf example_grammars
       copyGFLogo
  where
    grammars_dir = www_dir </> "grammars"
    cloud_dir = www_dir </> "tmp" -- hmm
    logo_dir = www_dir </> "Logos"
    www_dir = datadir (absoluteInstallDirs pkg lbi dest) </> "www"
    gfo_dir = buildDir lbi </> "examples"

    copy_pgf (pgf,subdir,_) =
      do let dst = grammars_dir</>pgf
         putStrLn $ "Installing "++dst
         copyFile (gfo_dir</>pgf) dst

    gf_logo = "gf0.png"

    copyGFLogo =
      do createDirectoryIfMissing True logo_dir
         copyFile ("doc"</>"Logos"</>gf_logo) (logo_dir</>gf_logo)

execute command =
  do --putStrLn command
     e <- system command
     case e of
       ExitSuccess -> return ()
       _ -> fail "Command failed"
     return ()
