module Main where

import Control.Monad
import Data.Maybe
import System.Cmd
import System.Directory
import System.Environment
import System.Exit

-- Make commands for compiling and testing resource grammars.
-- usage: runghc Make (((present|alltenses)? OPT?) | (clone FILE))? LANGS?
-- where
-- - OPT = (lang | api | pgf | test | parse | clean | clone)
-- - LANGS has the form e.g. langs=Eng,Fin,Rus
-- - clone with a flag file=FILENAME clones the file to the specified languages,
--   by replacing the 3-letter language name of the original in both
--   the filename and the body
--   with each name in the list (default: all languages)
-- With no argument, lang and api are done, in this order.
-- See 'make' below for what is done by which command.

default_gf = "../../dist/build/gf/gf"

presApiPath = "-path=api:present:../present"
presSymbolPath = "" -- "-path=.:abstract:present:common:romance:scandinavian" ----

-- the languages have long directory names and short ISO codes (3 letters)
-- we also give the functors implied

langsCoding = [
  (("afrikaans","Afr"),""),
  (("amharic",  "Amh"),""),
  (("arabic",   "Ara"),""),
  (("basque",   "Eus"),""),
  (("bulgarian","Bul"),""),
  (("catalan",  "Cat"),"Romance"),
  (("chinese",  "Chi"),""),
  (("danish",   "Dan"),"Scand"),
  (("dutch",    "Dut"),""),
  (("english",  "Eng"),""),
  (("estonian", "Est"),""),
  (("finnish",  "Fin"),""),
  (("french",   "Fre"),"Romance"),
  (("german",   "Ger"),""),
  (("Greek",    "Gre"),""),
  (("hebrew",   "Heb"),""),
  (("hindi",    "Hin"),"Hindustani"),
  (("interlingua","Ina"),""),
  (("italian",  "Ita"),"Romance"),
  (("japanese", "Jpn"),""),
  (("latin",    "Lat"),""),
  (("latvian",  "Lav"),""),
  (("maltese",  "Mlt"),""),
  (("nepali",   "Nep"),""),
  (("norwegian","Nor"),"Scand"),
  (("persian",  "Pes"),""),
  (("polish",   "Pol"),""),
  (("punjabi",  "Pnb"),""),
  (("romanian", "Ron"),""),
  (("russian",  "Rus"),""),
  (("sindhi",   "Snd"),""),
  (("spanish",  "Spa"),"Romance"),
  (("swedish",  "Swe"),"Scand"),
  (("thai",     "Tha"),""),
  (("thai",     "Thb"),""),  -- Thai pronunciation
  (("turkish",  "Tur"),""),
  (("urdu",     "Urd"),"Hindustani")
  ]

implied (_,lan) = [fun | ((_,la),fun) <- langsCoding, la == lan, fun /= ""]

langs = map fst langsCoding

-- all languagues for which Lang can be compiled
langsLangAll = langs

-- languagues that are almost complete and for which Lang is normally compiled
langsLang = langs `except` langsIncomplete

-- languagues that have notpresent marked
langsPresent = langsLang `except` ["Chi","Est","Gre","Heb","Jpn","Mlt","Nep","Pes","Snd","Tha","Thb"]

-- languages for which Lang can be compiled but which are incomplete
langsIncomplete = ["Amh","Ara","Heb","Lat","Tur","Thb"]

-- languages for which to compile Try
langsAPI = langsLang `except` langsIncomplete

-- languages for which to compile Symbolic
langsSymbolic = langsLang `except` (langsIncomplete ++ ["Afr","Ina","Nep","Pnb","Snd", "Thb"])

-- languages for which to compile minimal Syntax
langsMinimal = langs `only` ["Ara","Eng","Bul","Rus"]

-- languages for which to run treebank test
langsTest = langsLang `except` ["Ara","Bul","Cat","Eus","Hin","Lav","Rus","Spa","Tha","Thb"]

-- languages for which to run demo test
langsDemo = langsLang `except` ["Ara","Hin","Ina","Lat","Lav","Tha","Thb"]

-- languages for which to compile parsing grammars
langsParse = langs `only` ["Eng"]

-- languages for which langs.pgf is built
langsPGF = langsTest `only` ["Eng","Fre","Swe"]

-- languages for which Compatibility exists (to be extended)
langsCompat = langsLang `only` ["Cat","Eng","Fin","Fre","Ita","Lav","Spa","Swe"]

treebankExx = "exx-resource.gft"
treebankResults = "exx-resource.gftb"

main = do
  xx <- getArgs
  make xx

make :: [String] -> IO ()
make xx = do
  let ifx  opt act = if null xx || elem opt xx then act >> return () else return ()
  let ifxx opt act = if            elem opt xx then act >> return () else return ()
  let pres
        | elem "present" xx = 1
        | elem "alltenses" xx = 2
        | elem "newcomp" xx = 3
        | otherwise = 0
  let dir = case pres of
              1 -> "../present"
              2 -> "../alltenses"
              3 -> "../newcomp"
              _ -> "../full"

  let optl ls = maybe ls id $ getOptLangs xx

  ifx "lang" $ do
    let lans = optl $ if (pres == 1) then langsPresent else langsLangAll
    mapM_ (gfc pres [] . lang) lans
    mapM_ (gfc pres presSymbolPath . symbol) lans ---- (optl langsAPI)
    copyl lans "*.gfo" dir
  ifx "compat" $ do
    let lans = optl langsCompat
    mapM_ (gfc pres [] . compat) lans
    copyld lans "*/Compatibility" ".gfo" dir
  ifx "api" $ do
    let lans = optl langsAPI
    mapM_ (gfc pres presApiPath . try) lans
    copy "api/Constructors.gfo api/Combinators.gfo api/Syntax.gfo" dir
    copyld lans "api/*" ".gfo" dir
  ifx "symbolic" $ do
    let lans = optl langsSymbolic
    mapM_ (gfc pres presApiPath . symbolic) lans
    copy "api/Symbolic.gfo" dir
    copyld lans "api/Symbolic" ".gfo" dir
  ifx "minimal" $ do
    let lans = optl langsMinimal
    mapM_ (gfcmin presApiPath . syntax) lans
    copyld lans "api/*" ".gfo" "../minimal"
  ifxx "pgf" $ do
    run_gfc $ ["-s","--make","--name=langs","--parser=off",
               "--output-dir=" ++ dir]
               ++ [dir ++ "/Lang" ++ la ++ ".gfo" | (_,la) <- optl langsPGF]
  ifxx "test" $ do
    let ls = optl langsTest
    gf (treeb "Lang" ls) $ unwords [dir ++ "/Lang" ++ la ++ ".gfo" | (_,la) <- ls]
  ifxx "parse" $ do
    mapM_ (gfc pres [] . parse) (optl langsParse)
    copy "parse/*.gfo parse/oald/*.gfo" dir
  ifxx "clean" $ do
    system "rm -f */*.gfo ../alltenses/*.gfo ../present/*.gfo ../prelude/*.gfo ../full/*.gfo"
  ifxx "clone" $ do
    let (pref,lang) = case getLangName xx of
          Just pl -> pl
          _ -> error "expected flag option file=ppppppLLL.gf"
    s <- readFile (pref ++ lang ++ ".gf")
    mapM_ (\la -> writeFile (pref ++ la ++ ".gf") (replaceLang lang la s)) (map snd (optl langs))
  return ()

-- pres = 0 (full), 1 (present), 2 (alltenses)
gfc pres ppath file = do
  let preproc = if (pres==1) then "-preproc=mkPresent" else ""
  let path    = if (pres==1) then ppath else ""
  putStrLn $ "Compiling " ++ file
  case pres of
    0 -> run_gfc ["-s","-src",preproc, path, file]
    3 -> run_gfc ["-s","-src","-no-pmcfg", "-new-comp", preproc, path, file]
    _ -> run_gfc ["-s","-src","-no-pmcfg",preproc, path, file]


gfcmin path file = do
  let preproc = "-preproc=mkMinimal"
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

-- | Runs the gf executable in compile mode with the given arguments.
run_gfc :: [String] -> IO ()
run_gfc args =
    do let args' = ["-batch"] ++ filter (not . null) args ++ ["+RTS"] ++ rts_flags ++ ["-RTS"]
----do let args' = ["-batch","-new-comp"] ++ filter (not . null) args ++ ["+RTS"] ++ rts_flags ++ ["-RTS"]
--- do let args' = ["-batch","-gf-lib-path=."] ++ filter (not . null) args ++ ["+RTS"] ++ rts_flags ++ ["-RTS"] --- why path? AR
       putStrLn $ "Running: " ++ default_gf ++ " " ++ unwords (map showArg args')
       e <- rawSystem default_gf args'
       case e of
         ExitSuccess -> return ()
         ExitFailure i -> putStrLn $ "gf exited with exit code: " ++ show i
  where rts_flags = ["-K100M"]
        showArg arg = "'" ++ arg ++ "'"

copy :: String -> String -> IO ()
copy from to =
    do system $ "cp " ++ from ++ " " ++ to
       return ()

copyl :: [(String,String)] -> String -> String -> IO ()
copyl lans from to = do
  echosystem $ "cp abstract/" ++ from ++ " " ++ to
  echosystem $ "cp common/"   ++ from ++ " " ++ to
  mapM_ (\lan -> echosystem $ "cp */*" ++ lan ++ from ++ " " ++ to)
        (map snd lans ++ concatMap implied lans)
  return ()

copyld :: [(String,String)] -> String -> String -> String -> IO ()
copyld lans dir from to = do
  mapM_ (\lan -> echosystem $ "cp " ++ dir ++ lan ++ from ++ " " ++ to)
        (map snd lans ++ if (take 3 dir == "api") then [] else concatMap implied lans)
  return ()

echosystem c = do
  putStrLn c
  system c
