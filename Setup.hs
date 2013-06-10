
import Distribution.Simple
import Distribution.Simple.LocalBuildInfo
import Distribution.Simple.BuildPaths
import Distribution.Simple.Utils
import Distribution.Simple.Setup
import Distribution.PackageDescription hiding (Flag)
import Control.Monad
import Data.List(isPrefixOf,intersect)
import Data.Maybe(listToMaybe)
import System.IO
import qualified Control.Exception as E
import System.Cmd
import System.FilePath
import System.Directory
import System.Process
import System.Exit
--import Control.Concurrent(forkIO)
--import Control.Concurrent.Chan(newChan,writeChan,readChan)

import WebSetup

tryIOE :: IO a -> IO (Either E.IOException a)
tryIOE = E.try

main :: IO ()
main = defaultMainWithHooks simpleUserHooks{ preBuild =gfPreBuild
                                           , postBuild=buildRGL
                                           , preInst  =gfPreInst
                                           , postInst =gfPostInst
                                           , preCopy  =const . checkRGLArgs
                                           , postCopy =gfPostCopy
                                           , sDistHook=sdistRGL
                                           , runTests =testRGL
                                           }
  where
    gfPreBuild args  = gfPre args . buildDistPref
    gfPreInst args = gfPre args . installDistPref

    gfPre args distFlag =
      do h <- checkRGLArgs args
         extractDarcsVersion distFlag
         return h

    gfPostInst args flags pkg lbi =
      do installRGL args flags pkg lbi
         let gf = default_gf pkg lbi
         installWeb gf args flags pkg lbi

    gfPostCopy args flags pkg lbi =
      do copyRGL args flags pkg lbi
         let gf = default_gf pkg lbi
         copyWeb gf args flags pkg lbi

--------------------------------------------------------
-- Commands for building the Resource Grammar Library
--------------------------------------------------------

data Mode = AllTenses | Present deriving Show
all_modes = ["present","alltenses"]
default_modes = [Present,AllTenses]

data RGLCommand
  = RGLCommand
      { cmdName   :: String
      , cmdIsDef  :: Bool
      , cmdAction :: [Mode] -> [String] -> PackageDescription -> LocalBuildInfo -> IO ()
      }

rglCommands =
  [ RGLCommand "prelude" True  $ \mode args pkg lbi -> do
       putStrLn $ "Compiling [prelude]"
       let prelude_src_dir = rgl_src_dir     </> "prelude"
           prelude_dst_dir = rgl_dst_dir lbi </> "prelude"
       createDirectoryIfMissing True prelude_dst_dir
       files <- ls prelude_src_dir
       run_gfc pkg lbi (["-s", "--gfo-dir="++prelude_dst_dir] ++ [prelude_src_dir </> file | file <- files])
  , RGLCommand "lang"    True  $ \modes args pkg lbi -> do
       parallel_
         [do mapM_ (gfc1 mode pkg lbi . lang) (optml mode langsLang args)
             mapM_ (gfc1 mode pkg lbi . symbol) (optml mode langsAPI args)
          | mode <- modes]
  , RGLCommand "compat"  True  $ \modes args pkg lbi -> do
         mapM_ (gfc modes pkg lbi . compat) (optl langsCompat args)
  , RGLCommand "api"     True  $ \modes args pkg lbi -> do
       parallel_
         [do mapM_ (gfc1 mode pkg lbi . try) (optml mode langsAPI args)
             mapM_ (gfc1 mode pkg lbi . symbolic) (optml mode langsSymbolic args)
          | mode <- modes]
  , RGLCommand "pgf"     False $ \modes args pkg lbi ->
     parallel_ [
       do let dir = getRGLBuildDir lbi mode
          createDirectoryIfMissing True dir
          sequence_ [run_gfc pkg lbi ["-s","-make","-name=Lang"++la,
                                       dir ++ "/Lang" ++ la ++ ".gfo"]
                      | (_,la) <- optl langsPGF args]
          run_gfc pkg lbi (["-s","-make","-name=Lang"]++
                           ["Lang" ++ la ++ ".pgf"|(_,la)<-optl langsPGF args])
       | mode <- modes]
  , RGLCommand "demo"    False $ \modes args pkg lbi -> do
       let ls = optl langsDemo args
       gf (demos "Demo" ls) ["demo/Demo" ++ la ++ ".gf" | (_,la) <- ls] pkg lbi
       return ()
  , RGLCommand "parse"   False $ \mode args pkg lbi -> do
       mapM_ (gfc mode pkg lbi . parse) (optl langsParse args)
  , RGLCommand "none"    False $ \mode args pkg lbi -> do
       return ()
  ]
  where
    optl = optml AllTenses
    optml mode ls args = getOptLangs (shrink ls) args
      where
        shrink = case mode of
                   Present -> intersect langsPresent
                   _ -> id

--------------------------------------------------------

checkRGLArgs args = do
  let args' = filter (\arg -> not (arg `elem` all_modes ||
                                   rgl_prefix `isPrefixOf` arg ||
                                   langs_prefix `isPrefixOf` arg)) args
  if null args'
    then return emptyHookedBuildInfo
    else die $ "Unrecognised flags: " ++ intercalate ", " args'

buildRGL args flags pkg lbi = do
  let cmds = getRGLCommands args
  let modes = getOptMode args
  mapM_ (\cmd -> cmdAction cmd modes args pkg lbi) cmds

installRGL args flags pkg lbi = do
  let modes = getOptMode args
  let inst_gf_lib_dir = datadir (absoluteInstallDirs pkg lbi NoCopyDest) </> "lib"
  copyAll "prelude"   (rgl_dst_dir lbi </> "prelude") (inst_gf_lib_dir </> "prelude")
  sequence_ [copyAll (show mode) (getRGLBuildDir lbi mode) (inst_gf_lib_dir </> getRGLBuildSubDir lbi mode)|mode<-modes]

copyRGL args flags pkg lbi = do
  let modes = getOptMode args
      dest = case copyDest flags of
               NoFlag -> NoCopyDest
               Flag d -> d
  let inst_gf_lib_dir = datadir (absoluteInstallDirs pkg lbi dest) </> "lib"
  copyAll "prelude"   (rgl_dst_dir lbi </> "prelude") (inst_gf_lib_dir </> "prelude")
  sequence_ [copyAll (show mode) (getRGLBuildDir lbi mode) (inst_gf_lib_dir </> getRGLBuildSubDir lbi mode)|mode<-modes]

copyAll s from to = do
  putStrLn $ "Installing [" ++ s ++ "] " ++ to
  createDirectoryIfMissing True to
  mapM_ (\file -> copyFile (from </> file) (to </> file)) =<< ls from

sdistRGL pkg mb_lbi hooks flags = do
  paths <- getRGLFiles rgl_src_dir []
  let pkg' = pkg{dataFiles=paths}
  sDistHook simpleUserHooks pkg' mb_lbi hooks flags
  where
    getRGLFiles dir paths = foldM (processFile dir) paths =<< ls dir

    processFile dir paths file = do
      let path = dir </> file
      print path
      isFile <- doesFileExist path
      if isFile
        then if takeExtension file == ".gf" || file == "LICENSE"
               then return (path : paths)
               else return paths
        else getRGLFiles path paths

testRGL args _ pkg lbi = do
  let paths = case args of
                []    -> ["testsuite"]
                paths -> paths
  mapM_ walk paths
  where
    walk path = mapM_ (walkFile . (path </>)) =<< ls path

    walkFile fpath = do
      exists <- doesFileExist fpath
      if exists
        then if takeExtension fpath == ".gfs"
               then do let in_file   = fpath
                           gold_file = addExtension fpath ".gold"
                           out_file  = addExtension fpath ".out"
                       putStr (in_file++" ... ")
                       hFlush stdout
                       res <- runTest in_file out_file gold_file
                       putStrLn res
               else return ()
        else walk fpath

    runTest in_file out_file gold_file = do
      writeFile out_file =<< readProcess (default_gf pkg lbi) ["-run"] =<< readFile in_file
      exists <- doesFileExist gold_file
      if exists
        then do out <- compatReadFile out_file
                gold <- compatReadFile gold_file
                return $! if out == gold then "OK" else "FAIL"
        else return "MISSING GOLD"

    -- Avoid failures caused by Win32/Unix text file incompatibility
    compatReadFile path =
      do h <- openFile path ReadMode
         hSetNewlineMode h universalNewlineMode
         hGetContents h

rgl_src_dir     = "lib" </> "src"
rgl_dst_dir lbi = buildDir lbi </> "rgl"

-- the languages have long directory names and short ISO codes (3 letters)
-- we also give the decodings for postprocessing linearizations, as long as grammars
-- don't support all flags needed; they are used in tests

langsCoding = [
  (("amharic",  "Amh"),""),
  (("arabic",   "Ara"),""),
  (("bulgarian","Bul"),""),
  (("catalan",  "Cat"),""),
  (("chinese",  "Chi"),""),
  (("danish",   "Dan"),""),
  (("dutch",    "Dut"),""),
  (("english",  "Eng"),""),
  (("finnish",  "Fin"),""),
  (("french",   "Fre"),""),
  (("greek",    "Gre"),""),
  (("hebrew",   "Heb"),""),
  (("hindi",    "Hin"),"to_devanagari"),
  (("german",   "Ger"),""),
  (("interlingua","Ina"),""),
  (("italian",  "Ita"),""),
  (("japanese", "Jpn"),""),
  (("latin",    "Lat"),""),
  (("latvian",    "Lav"),""),
  (("maltese",  "Mlt"),""),
  (("norwegian","Nor"),""),
  (("persian",  "Pes"),""),
  (("polish",   "Pol"),""),
  (("punjabi",   "Pnb"),""),
  (("romanian", "Ron"),""),
  (("russian",  "Rus"),""),
  (("sindhi",   "Snd"),""),
  (("spanish",  "Spa"),""),
  (("swedish",  "Swe"),""),
  (("thai",     "Tha"),"to_thai"),
  (("turkish",  "Tur"),""),
  (("urdu",     "Urd"),"")
  ]

langs = map fst langsCoding

-- default set of languages to compile
-- defaultLangs = langs `only` words "Eng Fre Ger Ita Spa Swe"

-- languagues for which to compile Lang
langsLang = langs -- `except` ["Amh","Ara","Lat","Tur"]
--langsLang = langs `only` ["Fin"] --test

-- languagues that have notpresent marked
langsPresent = langsLang `except` ["Chi","Gre","Heb","Jpn","Mlt","Nep","Pes","Snd","Tha","Thb"]

-- languages for which to compile Try
langsAPI  = langsLang `except` langsIncomplete -- ["Ina","Amh","Ara"]

langsIncomplete = ["Amh","Ara","Heb","Ina","Lat","Tur"]

-- languages for which to compile Symbolic
langsSymbolic  = langsAPI `except` ["Jpn"]

-- languages for which to run demo test
langsDemo = langsLang `except` ["Ara","Hin","Ina","Lav","Tha"]

-- languages for which to compile parsing grammars
langsParse = langs `only` ["Eng"]

-- languages for which langs.pgf is built
langsPGF = langsLang `except` ["Ara","Hin","Ron","Tha"]

-- languages for which Compatibility exists (to be extended)
langsCompat = langsLang `only` ["Cat","Eng","Fin","Fre","Ita","Lav","Spa","Swe"]

gfc modes pkg lbi file = parallel_ [gfc1 mode pkg lbi file | mode<-modes]
gfc1 mode pkg lbi file = do
  let dir = getRGLBuildDir lbi mode
      preproc = case mode of
                  AllTenses -> ""
                  Present   -> "-preproc="++({-rgl_src_dir </>-} "mkPresent")
  createDirectoryIfMissing True dir
  putStrLn $ "Compiling [" ++ show mode ++ "] " ++ file
  run_gfc pkg lbi ["-s", "-no-pmcfg", preproc, "--gfo-dir="++dir, file]

gf comm files pkg lbi = do
  putStrLn $ "Reading " ++ unwords files
  let gf = default_gf pkg lbi
  putStrLn ("executing: " ++ comm ++ "\n" ++
            "in " ++ gf)
  out <- readProcess gf ("-s":files) comm
  putStrLn out

demos abstr ls = "gr -number=100 | l -treebank " ++ unlexer abstr ls ++
           " | ps -to_html | wf -file=resdemo.html"

lang   (lla,la) = rgl_src_dir </> lla </> ("All"           ++ la ++ ".gf")
compat (lla,la) = rgl_src_dir </> lla </> ("Compatibility" ++ la ++ ".gf")
symbol (lla,la) = rgl_src_dir </> lla </> ("Symbol"        ++ la ++ ".gf")

try    (lla,la) = rgl_src_dir </> "api" </> ("Try"    ++ la ++ ".gf")
syntax (lla,la) = rgl_src_dir </> "api" </> ("Syntax" ++ la ++ ".gf")

symbolic (lla,la) = rgl_src_dir </> "api"   </> ("Symbolic" ++ la ++ ".gf")
parse    (lla,la) = rgl_src_dir </> "parse" </> ("Parse"    ++ la ++ ".gf")

except ls es = filter (flip notElem es . snd) ls
only   ls es = filter (flip elem es . snd) ls

getOptMode args =
    if null explicit_modes
    then default_modes
    else explicit_modes
  where
    explicit_modes =
      [Present|have "present"]++
      [AllTenses|have "alltenses"]

    have mode = mode `elem` args

-- list of languages overriding the definitions above
getOptLangs defaultLangs args =
    case [ls | arg <- args,
               let (f,ls) = splitAt (length langs_prefix) arg,
               f==langs_prefix] of
      ('+':ls):_ -> foldr addLang defaultLangs (seps ls)
      ('-':ls):_ -> foldr removeLang defaultLangs (seps ls)
      ls:_ -> findLangs langs (seps ls)
      _    -> defaultLangs
  where
    seps = words . map (\c -> if c==',' then ' ' else c)
    findLangs langs ls = [lang | lang@(_,la) <- langs, la `elem` ls]
    removeLang l ls = [lang | lang@(_,la) <- ls, la/=l]
    addLang l ls = if null (findLangs ls [l])
                   then findLangs langs [l]++ls
                   else ls

getRGLBuildSubDir lbi mode =
  case mode of
    AllTenses -> "alltenses"
    Present   -> "present"


getRGLBuildDir lbi mode = rgl_dst_dir lbi </> getRGLBuildSubDir lbi mode

getRGLCommands args =
  let cmds0 = [cmd | arg <- args,
                     let (prefix,name) = splitAt (length rgl_prefix) arg,
                     prefix == rgl_prefix,
                     cmd <- rglCommands,
                     cmdName cmd == name]
  in if null cmds0
       then [cmd | cmd <- rglCommands, cmdIsDef cmd]
       else cmds0

langs_prefix = "langs="
rgl_prefix = "rgl-"

unlexer abstr ls =
  "-unlexer=\\\"" ++ unwords
      [abstr ++ la ++ "=" ++ unl |
        lla@(_,la) <- ls, let unl = unlex lla, not (null unl)] ++
      "\\\""
    where
      unlex lla = maybe "" id $ lookup lla langsCoding

-- | Runs the gf executable in compile mode with the given arguments.
run_gfc :: PackageDescription -> LocalBuildInfo -> [String] -> IO ()
run_gfc pkg lbi args =
    do let args' = ["-batch","-gf-lib-path="++rgl_src_dir]
                   ++ ["+RTS","-K32M","-RTS"] -- not needed with new-comp
                   ++ filter (not . null) args
           gf = default_gf pkg lbi
           gf_cmdline = gf ++ " " ++ unwords (map showArg args')
--     putStrLn $ "Running: " ++ gf_cmdline
       e <- rawSystem gf args'
       case e of
         ExitSuccess   -> return ()
         ExitFailure i -> do putStrLn $ "Ran: " ++ gf_cmdline
                             die $ "gf exited with exit code: " ++ show i
  where
    showArg arg = if ' ' `elem` arg then "'" ++ arg ++ "'" else arg

default_gf pkg lbi = buildDir lbi </> exeName' </> exeNameReal
  where
    exeName' = (exeName . head . executables) pkg
    exeNameReal = exeName' <.> (if null $ takeExtension exeName' then exeExtension else "")

-- | Create autogen module with detailed version info by querying darcs
extractDarcsVersion distFlag =
  do info <- tryIOE askDarcs
     createDirectoryIfMissing True autogenPath
     updateFile versionModulePath $ unlines $
       ["module "++modname++" where",
        "{-# NOINLINE darcs_info #-}",
        "darcs_info = "++show (either (const (Left ())) Right info)]
  where
    dist = fromFlagOrDefault "dist" distFlag
    autogenPath = dist</>"build"</>"autogen"
    versionModulePath = autogenPath</>"DarcsVersion_gf.hs"
    modname = "DarcsVersion_gf"

    askDarcs =
      do tags <- lines `fmap` readProcess "darcs" ["show","tags"] ""
         let from = case tags of
                      [] -> []
                      tag:_ -> ["--from-tag="++tag]
         changes <- lines `fmap` readProcess "darcs" ("changes":from) ""
         let dates = init' (filter ((`notElem` [""," "]).take 1) changes)
         whatsnew <- tryIOE $ lines `fmap` readProcess "darcs" ["whatsnew","-s"] ""
         return (listToMaybe tags,listToMaybe dates,
                 length dates,either (const 0) length whatsnew)

    init' [] = []
    init' xs = init xs

-- | Only update the file if contents has changed
updateFile path new =
  do old <- tryIOE $ readFile path
     when (Right new/=old) $ seq (either (const 0) length old) $
                                 writeFile path new

-- | List files, excluding "." and ".."
ls path = filter (`notElem` [".",".."]) `fmap` getDirectoryContents path


-- | For parallel RGL module compilation
-- Unfortunately, this has no effect unless Setup.hs is compiled with -threaded
parallel_ ms = sequence_ ms {-
  do c <- newChan
     ts <- sequence [ forkIO (m >> writeChan c ()) | m <- ms]
     sequence_ [readChan c | _ <- ts]
--}
