module WebSetup(buildWeb,installWeb,copyWeb,numJobs,execute) where

import System.Directory(createDirectoryIfMissing,copyFile,doesDirectoryExist)
import System.FilePath((</>),dropExtension)
import System.Process(rawSystem)
import System.Exit(ExitCode(..))
import Distribution.Simple.Setup(BuildFlags(..),Flag(..),CopyDest(..),copyDest)
import Distribution.Simple.LocalBuildInfo(datadir,buildDir,absoluteInstallDirs)
import Distribution.Simple.Utils(die)

{-
   To test the GF web services, the minibar and the grammar editor, use
   "cabal install" (or "runhaskell Setup.hs install") to install gf as usual.
   Then start the server with the command "gf -server" and open
   http://localhost:41296/ in your web browser (Firefox, Safari, Opera or
   Chrome). The example grammars listed below will be available in the minibar.
-}

{-
  Update 2018-07-04

  The example grammars have now been removed from the GF repository.
  This script will look for them in ../gf-contrib and build them from there if possible.
  If not, the user will be given a message and nothing is build or copied.
  (Unfortunately cabal install seems to hide all messages from stdout,
  so users won't see this message unless they check the log.)
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

contrib_dir :: FilePath
contrib_dir = ".."</>"gf-contrib"

buildWeb gf (flags,pkg,lbi) = do
  contrib_exists <- doesDirectoryExist contrib_dir
  if contrib_exists
  then mapM_ build_pgf example_grammars
  else putStr $ unlines
    [ "---"
    , "Example grammars are no longer included in the main GF repository, but have moved to gf-contrib."
    , "If you want these example grammars to be built, clone this repository in the same top-level directory as GF:"
    , "https://github.com/GrammaticalFramework/gf-contrib.git"
    , "---"
    ]
  where
    gfo_dir = buildDir lbi </> "examples"

    build_pgf (pgf,subdir,src) =
      do createDirectoryIfMissing True tmp_dir
         putStrLn $ "Building "++pgf
         execute gf args
      where
        tmp_dir = gfo_dir</>subdir
        dir = contrib_dir</>subdir
        args = numJobs flags++["-make","-s"] -- ,"-optimize-pgf"
               ++["--gfo-dir="++tmp_dir,
                  "--gf-lib-path="++buildDir lbi </> "rgl",
                  "--name="++dropExtension pgf,
                  "--output-dir="++gfo_dir]
               ++[dir</>file|file<-src]

installWeb = setupWeb NoCopyDest

copyWeb flags = setupWeb dest
  where
    dest = case copyDest flags of
             NoFlag -> NoCopyDest
             Flag d -> d

setupWeb dest (pkg,lbi) = do
  mapM_ (createDirectoryIfMissing True) [grammars_dir,cloud_dir]
  contrib_exists <- doesDirectoryExist contrib_dir
  if contrib_exists
  then mapM_ copy_pgf example_grammars
  else return () -- message already displayed from buildWeb
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

execute command args =
  do let cmdline = command ++ " " ++ unwords (map showArg args)
--   putStrLn $ "Running: " ++ cmdline
--   appendFile "running" (cmdline++"\n")
     e <- rawSystem command args
     case e of
       ExitSuccess   -> return ()
       ExitFailure i -> do putStrLn $ "Ran: " ++ cmdline
                           die $ command++" exited with exit code: " ++ show i
  where
    showArg arg = if ' ' `elem` arg then "'" ++ arg ++ "'" else arg

-- | This function is used to enable parallel compilation of the RGL and
-- example grammars
numJobs flags =
    if null n
    then ["-j","+RTS","-A20M","-N","-RTS"]
    else ["-j="++n,"+RTS","-A20M","-N"++n,"-RTS"]
  where
    -- buildNumJobs is only available in Cabal>=1.20
    n = case buildNumJobs flags of
          Flag mn | mn/=Just 1-> maybe "" show mn
          _ -> ""
