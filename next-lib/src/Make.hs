module Main where

import Control.Monad
import Data.Maybe
import System.Cmd
import System.Directory
import System.Environment
import System.Exit

-- Make commands for compiling and testing resource grammars.
-- usage: runghc Make ((present? OPT?) | (clone FILE))? LANGS? 
-- where 
-- - OPT = (lang | api | math | pgf | test | demo | parse | clean)
-- - LANGS has the form e.g. langs=Eng,Fin,Rus
-- - clone with a flag file=FILENAME clones the file to the specified languages,
--   by replacing the 3-letter language name of the original in both 
--   the filename and the body
--   with each name in the list (default: all languages)
-- With no argument, lang and api are done, in this order.
-- See 'make' below for what is done by which command.

default_gfc = "../../bin/gfc"

presApiPath = "-path=api:present"
presSymbolPath = "-path=.:abstract:present:common:romance:scandinavian" ----

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
  (("norwegian","Nor"),""),
  (("russian",  "Rus"),""),
  (("spanish",  "Spa"),""),
  (("swedish",  "Swe"),""), 
  (("thai",     "Tha"),"to_thai")
  ]

langs = map fst langsCoding

-- languagues for which to compile Lang
langsLang = langs `except` ["Ara","Ina"]

-- languages for which to compile Try 
langsAPI  = langsLang `except` ["Ara","Hin","Ina","Tha"]

-- languages for which to compile minimal Syntax
langsMinimal = langs `only` ["Eng","Bul","Ita"]

-- languages for which to run treebank test
langsTest = langsLang `except` ["Ara","Bul","Cat","Hin","Rus","Spa","Tha"]

-- languages for which to run demo test
langsDemo = langsLang `except` ["Ara","Hin","Ina","Tha"]

-- languages for which to compile parsing grammars
langsParse = langs `only` ["Eng"]

-- languages for which langs.pgf is built
langsPGF = langsTest `only` ["Eng","Fre","Swe"]

-- languages for which Compatibility exists (to be extended)
langsCompat = langsLang `only` ["Cat","Eng","Fin","Fre","Ita","Spa","Swe"]

treebankExx = "exx-resource.gft"
treebankResults = "exx-resource.gftb"

main = do
  xx <- getArgs
  make xx

make :: [String] -> IO ()
make xx = do
  let ifx  opt act = if null xx || elem opt xx then act >> return () else return () 
  let ifxx opt act = if            elem opt xx then act >> return () else return () 
  let pres = elem "present" xx
  let dir = if pres then "../present" else "../alltenses"
   
  let optl ls = maybe ls id $ getOptLangs xx

  ifx "lang" $ do
    mapM_ (gfc pres [] . lang) (optl langsLang)
    mapM_ (gfc pres presSymbolPath . symbol) (optl langsAPI)
    copy "*/*.gfo" dir
  ifx "compat" $ do
    mapM_ (gfc pres [] . compat) (optl langsCompat)
    copy "*/Compatibility*.gfo" dir
  ifx "api" $ do
    mapM_ (gfc pres presApiPath . try) (optl langsAPI)
    mapM_ (gfc pres presApiPath . symbolic) (optl langsAPI)
    copy "*/*.gfo" dir
  ifx "minimal" $ do
    mapM_ (gfcmin presApiPath . syntax) (optl langsMinimal)
    copy "api/*.gfo" "../minimal"
  ifxx "pgf" $ do
    run_gfc $ ["-s","--make","--name=langs","--parser=off",
               "--output-dir=" ++ dir]
               ++ [dir ++ "/Lang" ++ la ++ ".gfo" | (_,la) <- optl langsPGF]
  ifxx "test" $ do
    let ls = optl langsTest
    gf (treeb "Lang" ls) $ unwords [dir ++ "/Lang" ++ la ++ ".gfo" | (_,la) <- ls] 
  ifxx "demo" $ do
    let ls = optl langsDemo
    gf (demos "Demo" ls) $ unwords ["demo/Demo" ++ la ++ ".gf" | (_,la) <- ls]
  ifxx "parse" $ do
    mapM_ (gfc pres [] . parse) (optl langsParse)
    copy "parse/*.gfo parse/oald/*.gfo" dir
  ifxx "clean" $ do
    system "rm -f */*.gfo ../alltenses/*.gfo ../present/*.gfo"
  ifxx "clone" $ do
    let (pref,lang) = case getLangName xx of
          Just pl -> pl
          _ -> error "expected flag option file=ppppppLLL.gf"
    s <- readFile (pref ++ lang ++ ".gf")
    mapM_ (\la -> writeFile (pref ++ la ++ ".gf") (replaceLang lang la s)) (map snd (optl langs))
  return ()

gfc pres ppath file = do
  let preproc = if pres then "-preproc=./mkPresent" else ""
  let path    = if pres then ppath else ""
  putStrLn $ "Compiling " ++ file
  run_gfc ["-s","-src", preproc, path, file]

gfcmin path file = do
  let preproc = "-preproc=./mkMinimal"
  putStrLn $ "Compiling minimal " ++ file
  run_gfc ["-s","-src", preproc, path, file]

gf comm file = do
  putStrLn $ "Reading " ++ file
  let cmd = "echo \"" ++ comm ++ "\" | gf -s " ++ file
  putStrLn cmd
  system cmd

treeb abstr ls = "rf -lines -tree -file=" ++ treebankExx ++ 
        " | l -treebank " ++ unlexer abstr ls ++ " | wf -file=" ++ treebankResults

demos abstr ls = "gr -number=100 | l -treebank " ++ unlexer abstr ls ++ 
           " | ps -to_html | wf -file=resdemo.html"

lang (lla,la) = lla ++ "/All" ++ la ++ ".gf"
compat (lla,la) = lla ++ "/Compatibility" ++ la ++ ".gf"
symbol (lla,la) = lla ++ "/Symbol" ++ la ++ ".gf"
try  (lla,la) = "api/Try"  ++ la ++ ".gf"
syntax (lla,la) = "api/Syntax"  ++ la ++ ".gf"
symbolic (lla,la) = "api/Symbolic"  ++ la ++ ".gf"
parse (lla,la) = "parse/Parse" ++ la ++ ".gf"

except ls es = filter (flip notElem es . snd) ls
only   ls es = filter (flip elem es . snd) ls

-- list of languages overriding the definitions above
getOptLangs args = case [ls | a <- args, let (f,ls) = splitAt 6 a, f=="langs="] of
  ls:_ -> return $ findLangs $ seps ls
  _ -> Nothing
 where
  seps = words . map (\c -> if c==',' then ' ' else c)
  findLangs ls = [lang | lang@(_,la) <- langs, elem la ls]

-- the file name has the form p....pLLL.gf, i.e. 3-letter lang name, suffix .gf
getLangName args = case [ls | a <- args, let (f,ls) = splitAt 5 a, f=="file="] of
  fi:_ -> let (nal,ferp) = splitAt 3 (drop 3 (reverse fi)) in return (reverse ferp,reverse nal)  
  _ -> Nothing

replaceLang s1 s2 = repl where
  repl s = case s of
    c:cs -> case splitAt lgs s of
      (pre,rest) | pre == s1 -> s2 ++ repl rest
      _                      -> c : repl cs
    _ -> s
  lgs = 3 -- length s1

unlexer abstr ls = 
  "-unlexer=\\\"" ++ unwords 
      [abstr ++ la ++ "=" ++ unl | 
        lla@(_,la) <- ls, let unl = unlex lla, not (null unl)] ++ 
      "\\\""
    where
      unlex lla = maybe "" id $ lookup lla langsCoding

-- | Runs the gfc executable with the given arguments.
run_gfc :: [String] -> IO ()
run_gfc args = 
    do p <- liftM (fromMaybe default_gfc) $ findExecutable "gfc"
       env <- getEnvironment
       case lookup "GF_LIB_PATH" env of
            Nothing -> putStrLn "$GF_LIB_PATH is not set."
            Just _  -> 
                do let args' = filter (not . null) args ++ ["+RTS"] ++ rts_flags ++ ["-RTS"]
                       cmd = p ++ " " ++ unwords (map showArg args')
                   putStrLn $ "Running: " ++ cmd
                   e <- system cmd
                   case e of
                     ExitSuccess -> return ()
                     ExitFailure i -> putStrLn $ "gfc exited with exit code: " ++ show i
  where rts_flags = ["-K100M"]
        showArg arg = "'" ++ arg ++ "'"

copy :: String -> String -> IO ()
copy from to = 
    do system $ "cp " ++ from ++ " " ++ to
       return ()
