import Distribution.Simple(defaultMainWithHooks,UserHooks(..),simpleUserHooks)
import Distribution.Simple.LocalBuildInfo(LocalBuildInfo(..),absoluteInstallDirs,datadir)
import Distribution.Simple.BuildPaths(exeExtension)
import Distribution.Simple.Utils(intercalate)
import Distribution.Simple.Setup(BuildFlags(..),Flag(..),InstallFlags(..),CopyDest(..),CopyFlags(..),SDistFlags(..))
import Distribution.PackageDescription(PackageDescription(..),HookedBuildInfo(..),emptyHookedBuildInfo)
import Control.Monad(unless,when)
import Data.List(isPrefixOf,intersect)
import System.Process(readProcess)
import System.FilePath((</>),(<.>))
import System.Directory(createDirectoryIfMissing,copyFile,getDirectoryContents)

import WebSetup

main :: IO ()
main = defaultMainWithHooks simpleUserHooks{ preBuild  = gfPreBuild
                                           , postBuild = gfPostBuild
                                           , preInst   = gfPreInst
                                           , postInst  = gfPostInst
                                           , preCopy   = const . checkRGLArgs
                                           , postCopy  = gfPostCopy
                                           , sDistHook = sdistError
                                           }
  where
    gfPreBuild args  = gfPre args . buildDistPref
    gfPreInst args = gfPre args . installDistPref

    gfPre args distFlag =
      do h <- checkRGLArgs args
         return h

    gfPostBuild args flags pkg lbi =
      do buildRGL args flags (flags,pkg,lbi)
--       let gf = default_gf lbi
--       buildWeb gf (pkg,lbi)

    gfPostInst args flags pkg lbi =
      do installRGL args flags (pkg,lbi)
         installWeb (pkg,lbi)

    gfPostCopy args flags  pkg lbi =
      do copyRGL args flags (pkg,lbi)
         copyWeb flags (pkg,lbi)

--------------------------------------------------------
-- Commands for building the Resource Grammar Library
--------------------------------------------------------

data Mode = AllTenses | Present deriving Show
all_modes = ["alltenses","present"]
default_modes = [AllTenses,Present]

data RGLCommand
  = RGLCommand
      { cmdName   :: String
      , cmdIsDef  :: Bool
      , cmdAction :: [Mode] -> [String] -> Info -> IO ()
      }

type Info = (BuildFlags,PackageDescription,LocalBuildInfo)
bf (i,_,_) = i
--pd (_,i,_) = i
lbi (_,_,i) = i

rglCommands :: [RGLCommand]
rglCommands =
  [ RGLCommand "prelude" True  $ \mode args bi -> do
       putStrLn $ "Compiling [prelude]"
       let prelude_src_dir = rgl_src_dir    </> "prelude"
           prelude_dst_dir = rgl_dst_dir (lbi bi) </> "prelude"
       createDirectoryIfMissing True prelude_dst_dir
       files <- getDirectoryContents prelude_src_dir
       run_gfc bi (["-s", "--gfo-dir="++prelude_dst_dir] ++ [prelude_src_dir </> file | file <- files, file /= "." && file /= ".."])

  , RGLCommand "all"     True  $ gfcp [l,s,c,t,sc]
  , RGLCommand "lang"    False $ gfcp [l,s]
  , RGLCommand "api"     False $ gfcp [t,sc]
  , RGLCommand "compat"  False $ gfcp [c]
  , RGLCommand "web"     True  $ \ _ _ bi -> buildWeb (default_gf (lbi bi)) bi

  , RGLCommand "pgf"     False $ \modes args bi ->
     parallel_ [
       do let dir = getRGLBuildDir (lbi bi) mode
          createDirectoryIfMissing True dir
          sequence_ [run_gfc bi ["-s","-make","-name=Lang"++la,
                                       dir ++ "/Lang" ++ la ++ ".gfo"]
                      | (_,la) <- optl langsPGF args]
          run_gfc bi (["-s","-make","-name=Lang"]++
                           ["Lang" ++ la ++ ".pgf"|(_,la)<-optl langsPGF args])
       | mode <- modes]
  , RGLCommand "demo"    False $ \modes args bi -> do
       let ls = optl langsDemo args
       gf bi (demos "Demo" ls) ["demo/Demo" ++ la ++ ".gf" | (_,la) <- ls]
       return ()
  , RGLCommand "parse"   False $ \modes args bi ->
       gfc bi modes (summary parse) (map parse (optl langsParse args))
  , RGLCommand "none"    False $ \modes args bi ->
       return ()
  ]
  where
    gfcp cs modes args bi = parallel_ [gfcp' bi mode args cs|mode<-modes]

    gfcp' bi mode args cs = gfcn bi mode (unwords ss) (concat fss)
      where (ss,fss) = unzip [(summary f,map f as)|c<-cs,let (f,as)=c mode args]

    summary f = f ("*","*")

    l mode args = (lang,optml mode langsLang args)
    s mode args = (symbol,optml mode langsAPI args)
    c mode args = (compat,optl langsCompat args)
    t mode args = (try,optml mode langsAPI args)
    sc mode args = (symbolic,optml mode langsSymbolic args)

    optl = optml AllTenses
    optml mode ls args = getOptLangs (shrink ls) args
      where
        shrink = case mode of
                   Present -> intersect langsPresent
                   _ -> id

--------------------------------------------------------

checkRGLArgs :: [String] -> IO HookedBuildInfo
checkRGLArgs args = do
  let args' = filter (\arg -> not (arg `elem` all_modes ||
                                   rgl_prefix `isPrefixOf` arg ||
                                   langs_prefix `isPrefixOf` arg)) args
  unless (null args') $
    putStrLn $ "Unrecognised flags: " ++ intercalate ", " args'
  return emptyHookedBuildInfo

buildRGL :: [String] -> BuildFlags -> Info -> IO ()
buildRGL args flags bi = do
  let cmds = getRGLCommands args
  let modes = getOptMode args
  mapM_ (\cmd -> cmdAction cmd modes args bi) cmds

installRGL :: [String] -> InstallFlags -> (PackageDescription, LocalBuildInfo) -> IO ()
installRGL args flags bi = do
  let modes = getOptMode args
  let inst_gf_lib_dir = datadir (uncurry absoluteInstallDirs bi NoCopyDest) </> "lib"
  copyAll "prelude"   (rgl_dst_dir (snd bi) </> "prelude") (inst_gf_lib_dir </> "prelude")
  sequence_ [copyAll (show mode) (getRGLBuildDir (snd bi) mode) (inst_gf_lib_dir </> getRGLBuildSubDir mode)|mode<-modes]

copyRGL :: [String] -> CopyFlags -> (PackageDescription, LocalBuildInfo) -> IO ()
copyRGL args flags bi = do
  let modes = getOptMode args
      dest = case copyDest flags of
               NoFlag -> NoCopyDest
               Flag d -> d
  let inst_gf_lib_dir = datadir (uncurry absoluteInstallDirs bi dest) </> "lib"
  copyAll "prelude"   (rgl_dst_dir (snd bi) </> "prelude") (inst_gf_lib_dir </> "prelude")
  sequence_ [copyAll (show mode) (getRGLBuildDir (snd bi) mode) (inst_gf_lib_dir </> getRGLBuildSubDir mode)|mode<-modes]

copyAll :: String -> FilePath -> FilePath -> IO ()
copyAll s from to = do
  putStrLn $ "Installing [" ++ s ++ "] " ++ to
  createDirectoryIfMissing True to
  mapM_ (\file -> when (file /= "." && file /= "..") $ copyFile (from </> file) (to </> file)) =<< getDirectoryContents from

{-
sdistRGL :: PackageDescription -> Maybe LocalBuildInfo -> UserHooks -> SDistFlags -> IO ()
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
-}

-- | Cabal doesn't know how to correctly create the source distribution, so
-- we print an error message with the correct instructions when someone tries
-- `cabal sdist`.
sdistError :: PackageDescription -> Maybe LocalBuildInfo -> UserHooks -> SDistFlags -> IO ()
sdistError _ _ _ _ = fail "Error: Use `make sdist` to create the source distribution file"

rgl_src_dir = "lib" </> "src"
rgl_dst_dir lbi = buildDir lbi </> "rgl"

-- the languages have long directory names and short ISO codes (3 letters)
-- we also give the decodings for postprocessing linearizations, as long as grammars
-- don't support all flags needed; they are used in tests

langsCoding :: [((String, String), String)]
langsCoding = [
  (("afrikaans","Afr"),""),
  (("amharic",  "Amh"),""),
  (("arabic",   "Ara"),""),
  (("basque",   "Eus"),""),
  (("bulgarian","Bul"),""),
  (("catalan",  "Cat"),""),
  (("chinese",  "Chi"),""),
  (("danish",   "Dan"),""),
  (("dutch",    "Dut"),""),
  (("english",  "Eng"),""),
  (("estonian", "Est"),""),
  (("finnish",  "Fin"),""),
  (("french",   "Fre"),""),
  (("ancient_greek","Grc"),""),
  (("greek",    "Gre"),""),
  (("hebrew",   "Heb"),""),
  (("hindi",    "Hin"),"to_devanagari"),
  (("german",   "Ger"),""),
  (("icelandic","Ice"),""),
  (("interlingua","Ina"),""),
  (("italian",  "Ita"),""),
  (("japanese", "Jpn"),""),
  (("latin",    "Lat"),""),
  (("latvian",    "Lav"),""),
  (("maltese",  "Mlt"),""),
  (("mongolian","Mon"),""),
  (("nepali",   "Nep"),""),
  (("norwegian","Nor"),""),
  (("nynorsk",  "Nno"),""),
  (("persian",  "Pes"),""),
  (("polish",   "Pol"),""),
  (("portuguese", "Por"), ""),
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

langs :: [(String, String)]
langs = map fst langsCoding

-- default set of languages to compile
-- defaultLangs = langs `only` words "Eng Fre Ger Ita Spa Swe"

-- languagues for which to compile Lang
langsLang = langs -- `except` ["Amh","Ara","Lat","Tur"]
--langsLang = langs `only` ["Fin"] --test

-- languages that have notpresent marked
langsPresent = langsLang `except` ["Afr","Chi","Eus","Gre","Heb","Ice","Jpn","Mlt","Mon","Nep","Pes","Snd","Tha","Thb","Est"]

-- languages for which to compile Try
langsAPI  = langsLang `except` langsIncomplete -- ["Ina","Amh","Ara"]

langsIncomplete = ["Amh","Ara","Grc","Heb","Ina","Lat","Tur"]

-- languages for which to compile Symbolic
langsSymbolic  = langsAPI `except` ["Afr","Ice","Mon","Nep"]

-- languages for which to run demo test
langsDemo = langsLang `except` ["Ara","Hin","Ina","Lav","Tha"]

-- languages for which to compile parsing grammars
langsParse = langs `only` ["Eng"]

-- languages for which langs.pgf is built
langsPGF = langsLang `except` ["Ara","Hin","Ron","Tha"]

-- languages for which Compatibility exists (to be extended)
langsCompat = langsLang `only` ["Cat","Eng","Fin","Fre","Ita","Lav","Spa","Swe"]

gfc :: Info -> [Mode] -> [Char] -> [[Char]] -> IO ()
gfc bi modes summary files =
    parallel_ [gfcn bi mode summary files | mode<-modes]

gfcn :: Info -> Mode -> [Char] -> [[Char]] -> IO ()
gfcn bi mode summary files = do
  let dir = getRGLBuildDir (lbi bi) mode
      preproc = case mode of
                  AllTenses -> ""
                  Present   -> "-preproc="++({-rgl_src_dir </>-} "mkPresent")
  createDirectoryIfMissing True dir
  putStrLn $ "Compiling [" ++ show mode ++ "] " ++ summary
  run_gfc bi (["-s", "-no-pmcfg", preproc, "--gfo-dir="++dir] ++ files)

gf :: Info -> String -> [String] -> IO ()
gf bi comm files = do
  putStrLn $ "Reading " ++ unwords files
  let gf = default_gf (lbi bi)
  putStrLn ("executing: " ++ comm ++ "\n" ++
            "in " ++ gf)
  out <- readProcess gf ("-s":files) comm
  putStrLn out

demos :: String -> [(String, String)] -> String
demos abstr ls = "gr -number=100 | l -treebank " ++ unlexer abstr ls ++ " | ps -to_html | wf -file=resdemo.html"

lang   (lla,la) = rgl_src_dir </> lla </> ("All"           ++ la ++ ".gf")
compat (lla,la) = rgl_src_dir </> lla </> ("Compatibility" ++ la ++ ".gf")
symbol (lla,la) = rgl_src_dir </> lla </> ("Symbol"        ++ la ++ ".gf")

try    (lla,la) = rgl_src_dir </> "api" </> ("Try"    ++ la ++ ".gf")
syntax (lla,la) = rgl_src_dir </> "api" </> ("Syntax" ++ la ++ ".gf")

symbolic (lla,la) = rgl_src_dir </> "api"   </> ("Symbolic" ++ la ++ ".gf")
parse    (lla,la) = rgl_src_dir </> "parse" </> ("Parse"    ++ la ++ ".gf")

except :: (Eq b) => [(a, b)] -> [b] -> [(a, b)]
except ls es = filter (flip notElem es . snd) ls

only :: (Eq b) => [(a, b)] -> [b] -> [(a, b)]
only ls es = filter (flip elem es . snd) ls

getOptMode :: [String] -> [Mode]
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
getOptLangs :: [(String, String)] -> [String] -> [(String, String)]
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

getRGLBuildSubDir :: Mode -> String
getRGLBuildSubDir mode =
  case mode of
    AllTenses -> "alltenses"
    Present   -> "present"


getRGLBuildDir :: LocalBuildInfo -> Mode -> FilePath
getRGLBuildDir lbi mode = rgl_dst_dir lbi </> getRGLBuildSubDir mode

getRGLCommands :: [String] -> [RGLCommand]
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

unlexer :: String -> [(String, String)] -> String
unlexer abstr ls =
  "-unlexer=\\\"" ++ unwords
      [abstr ++ la ++ "=" ++ unl |
        lla@(_,la) <- ls, let unl = unlex lla, not (null unl)] ++
      "\\\""
    where
      unlex lla = maybe "" id $ lookup lla langsCoding

-- | Runs the gf executable in compile mode with the given arguments.
run_gfc :: Info -> [String] -> IO ()
run_gfc bi args =
    do let args' = numJobs (bf bi)++["-batch","-gf-lib-path="++rgl_src_dir]
                   ++ filter (not . null) args
           gf = default_gf (lbi bi)
       execute gf args'

-- | Get path to locally-built gf
default_gf :: LocalBuildInfo -> FilePath
default_gf lbi = buildDir lbi </> exeName' </> exeNameReal
  where
    exeName' = "gf"
    exeNameReal = exeName' <.> exeExtension

-- | For parallel RGL module compilation
-- Unfortunately, this has no effect unless Setup.hs is compiled with -threaded
parallel_ :: (Foldable t, Monad m) => t (m a) -> m ()
parallel_ ms = sequence_ ms {-
  do c <- newChan
     ts <- sequence [ forkIO (m >> writeChan c ()) | m <- ms]
     sequence_ [readChan c | _ <- ts]
--}
