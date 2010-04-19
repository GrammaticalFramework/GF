module Main where

import Distribution.Simple
import Distribution.Simple.LocalBuildInfo
import Distribution.Simple.BuildPaths
import Distribution.Simple.Utils
import Distribution.Simple.Setup
import Distribution.PackageDescription hiding (Flag)
import Control.Monad
import Data.Maybe
import System.IO
import System.Cmd
import System.FilePath
import System.Directory
import System.Environment
import System.Process
import System.Exit

main :: IO ()
main = defaultMainWithHooks simpleUserHooks{ preBuild =checkRGLArgs
                                           , postBuild=buildRGL
                                           , preInst  =checkRGLArgs
                                           , postInst =installRGL
                                           , preCopy  =checkRGLArgs
                                           , postCopy =copyRGL
                                           , sDistHook=sdistRGL
                                           , runTests =testRGL
                                           }

--------------------------------------------------------
-- Commands for building the Resource Grammar Library
--------------------------------------------------------

data Mode
  = AllTenses
  | Present
  | Minimal
  deriving Show

data RGLCommand
  = RGLCommand
      { cmdName   :: String
      , cmdIsDef  :: Bool
      , cmdAction :: Mode -> [String] -> PackageDescription -> LocalBuildInfo -> IO ()
      }

rglCommands =
  [ RGLCommand "prelude" True  $ \mode args pkg lbi -> do
       putStrLn $ "Compiling [prelude]"
       let prelude_src_dir = rgl_src_dir     </> "prelude"
           prelude_dst_dir = rgl_dst_dir lbi </> "prelude"
       createDirectoryIfMissing True prelude_dst_dir
       files <- getDirectoryContents prelude_src_dir
       run_gfc pkg lbi (["-s", "--gfo-dir="++prelude_dst_dir] ++ [prelude_src_dir </> file | file <- files, take 1 file /= "."])
  , RGLCommand "lang"    True  $ \mode args pkg lbi -> do
       mapM_ (gfc mode pkg lbi . lang) (optl langsLang args)
       mapM_ (gfc mode pkg lbi . symbol) (optl langsAPI args)
  , RGLCommand "compat"  True  $ \mode args pkg lbi -> do
       mapM_ (gfc mode pkg lbi . compat) (optl langsCompat args)
  , RGLCommand "api"     True  $ \mode args pkg lbi -> do
       mapM_ (gfc mode pkg lbi . try) (optl langsAPI args)
       mapM_ (gfc mode pkg lbi . symbolic) (optl langsAPI args)
  , RGLCommand "pgf"     False $ \mode args pkg lbi -> do
       let dir = getRGLBuildDir lbi mode
       createDirectoryIfMissing True dir
       sequence_ [run_gfc pkg lbi ["-s","-make","-name=Lang"++la,dir ++ "/Lang" ++ la ++ ".gfo"] | (_,la) <- optl langsPGF args]
       run_gfc pkg lbi (["-s","-make","-name=Lang"]++["Lang" ++ la ++ ".pgf" | (_,la) <- optl langsPGF args])
  , RGLCommand "demo"    False $ \mode args pkg lbi -> do
       let ls = optl langsDemo args
       gf (demos "Demo" ls) ["demo/Demo" ++ la ++ ".gf" | (_,la) <- ls] pkg lbi
       return ()
  , RGLCommand "parse"   False $ \mode args pkg lbi -> do
       mapM_ (gfc mode pkg lbi . parse) (optl langsParse args)
  , RGLCommand "none"    False $ \mode args pkg lbi -> do
       return ()
  ]
  where
    optl ls args = fromMaybe ls $ getOptLangs args

--------------------------------------------------------

checkRGLArgs args flags = do
  let args' = filter (\arg -> not (arg == "present" ||
                                   arg == "minimal" ||
                                   take (length rgl_prefix) arg == rgl_prefix ||
                                   take (length langs_prefix) arg == langs_prefix)) args
  if null args'
    then return emptyHookedBuildInfo
    else die $ "Unrecognised flags: " ++ intercalate ", " args'

buildRGL args flags pkg lbi = do
  let cmds = getRGLCommands args
  let mode = getOptMode args
  mapM_ (\cmd -> cmdAction cmd mode args pkg lbi) cmds

installRGL args flags pkg lbi = do
  let mode = getOptMode args
  let inst_gf_lib_dir = datadir (absoluteInstallDirs pkg lbi NoCopyDest) </> "lib"
  copyAll "prelude"   (rgl_dst_dir lbi </> "prelude") (inst_gf_lib_dir </> "prelude")
  copyAll (show mode) (getRGLBuildDir lbi mode) (inst_gf_lib_dir </> getRGLBuildSubDir lbi mode)

copyRGL args flags pkg lbi = do
  let mode = getOptMode args
      dest = case copyDest flags of
               NoFlag -> NoCopyDest
               Flag d -> d
  let inst_gf_lib_dir = datadir (absoluteInstallDirs pkg lbi dest) </> "lib"
  copyAll "prelude"   (rgl_dst_dir lbi </> "prelude") (inst_gf_lib_dir </> "prelude")
  copyAll (show mode) (getRGLBuildDir lbi mode) (inst_gf_lib_dir </> getRGLBuildSubDir lbi mode)

copyAll s from to = do
  putStrLn $ "Installing [" ++ s ++ "] " ++ to
  createDirectoryIfMissing True to
  files <- fmap (filter (\f -> take 1 f /= ".")) $ getDirectoryContents from
  mapM_ (\file -> copyFile (from </> file) (to </> file)) files

sdistRGL pkg mb_lbi hooks flags = do
  paths <- getRGLFiles rgl_src_dir []
  let pkg' = pkg{dataFiles=paths}
  sDistHook simpleUserHooks pkg' mb_lbi hooks flags
  where
    getRGLFiles dir paths = do
      files <- getDirectoryContents dir
      foldM (processFile dir) paths [file | file <- files, file /= "." && file /= ".."]

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
  sequence_ [walk path | path <- paths]
  where
    walk path = do
      files <- getDirectoryContents path
      sequence_ [walkFile (path </> file) | file <- files, file /= "." && file /= ".."]

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
                       putStrLn (if res then "OK" else "FAIL")
               else return ()
        else walk fpath

    runTest in_file out_file gold_file = do
      inp <- readFile in_file
      out <- readProcess (default_gf pkg lbi) ["-run"] inp
      writeFile out_file out
      exists <- doesFileExist gold_file
      if exists
        then do gold <- readFile gold_file
                return $! (out == gold)
        else return False


rgl_src_dir     = "lib" </> "src"
rgl_dst_dir lbi = buildDir lbi </> "rgl"

-- the languages have long directory names and short ISO codes (3 letters)
-- we also give the decodings for postprocessing linearizations, as long as grammars
-- don't support all flags needed; they are used in tests
 
langsCoding = [
  (("arabic",   "Ara"),""),
  (("bulgarian","Bul"),""),
  (("catalan",  "Cat"),""),
  (("danish",   "Dan"),""),
  (("english",  "Eng"),""),
  (("finnish",  "Fin"),""),
  (("french",   "Fre"),""),
  (("hindi",    "Hin"),"to_devanagari"),
  (("german",   "Ger"),""),
  (("interlingua","Ina"),""),
  (("italian",  "Ita"),""),
  (("latin",    "Lat"),""),
  (("norwegian","Nor"),""),
  (("polish",   "Pol"),""),
  (("romanian", "Ron"),""),
  (("russian",  "Rus"),""),
  (("spanish",  "Spa"),""),
  (("swedish",  "Swe"),""), 
  (("thai",     "Tha"),"to_thai"),
  (("turkish",  "Tur"),"")
  ]

langs = map fst langsCoding

-- languagues for which to compile Lang
langsLang = langs `except` ["Ara","Lat","Tur"]

-- languages for which to compile Try 
langsAPI  = langsLang `except` ["Hin","Ina","Rus","Tha"]

-- languages for which to run demo test
langsDemo = langsLang `except` ["Ara","Hin","Ina","Tha"]

-- languages for which to compile parsing grammars
langsParse = langs `only` ["Eng"]

-- languages for which langs.pgf is built
langsPGF = langsLang `except` ["Ara","Hin","Ron","Tha"]

-- languages for which Compatibility exists (to be extended)
langsCompat = langsLang `only` ["Cat","Eng","Fin","Fre","Ita","Spa","Swe"]

gfc mode pkg lbi file = do
  let dir = getRGLBuildDir lbi mode
      preproc = case mode of
                  AllTenses -> ""
                  Present   -> "-preproc="++(rgl_src_dir </> "mkPresent")
                  Minimal   -> "-preproc="++(rgl_src_dir </> "mkMinimal")
  createDirectoryIfMissing True dir
  putStrLn $ "Compiling [" ++ show mode ++ "] " ++ file
  run_gfc pkg lbi ["-s", preproc, "--gfo-dir="++dir, file]

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

getOptMode args
  | elem "present" args = Present
  | elem "minimal" args = Minimal
  | otherwise           = AllTenses

-- list of languages overriding the definitions above
getOptLangs args = case [ls | arg <- args, let (f,ls) = splitAt (length langs_prefix) arg, f==langs_prefix] of
  ls:_ -> return $ findLangs $ seps ls
  _    -> Nothing
 where
  seps = words . map (\c -> if c==',' then ' ' else c)
  findLangs ls = [lang | lang@(_,la) <- langs, elem la ls]

getRGLBuildSubDir lbi mode =
  case mode of
    AllTenses -> "alltenses"
    Present   -> "present"
    Minimal   -> "minimal"

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
    do let args' = ["-batch","-gf-lib-path="++rgl_src_dir] ++ filter (not . null) args
           gf = default_gf pkg lbi
       putStrLn $ "Running: " ++ gf ++ " " ++ unwords (map showArg args')
       e <- rawSystem gf args'
       case e of
         ExitSuccess   -> return ()
         ExitFailure i -> die $ "gf exited with exit code: " ++ show i
  where showArg arg = "'" ++ arg ++ "'"

default_gf pkg lbi = buildDir lbi </> exeName' </> exeNameReal
  where
    exeName' = (exeName . head . executables) pkg
    exeNameReal = exeName' <.> (if null $ takeExtension exeName' then exeExtension else "")
