module Main where

import System

-- Make commands for compiling and testing resource grammars.
-- usage: runghc Make ((present? OPT?) | (clone FILE))? LANGS? 
-- where 
-- - OPT = (lang | api | math | pgf | test | demo | clean)
-- - LANGS has the form e.g. langs=Eng,Fin,Rus
-- - clone with a flag file=FILENAME clones the file to the specified languages,
--   by replacing the 3-letter language name of the original in both the filename and the body
--   with each name in the list (default: all languages)
-- With no argument, lang and api are done, in this order.
-- See 'make' below for what is done by which command.

langs = [
  ("arabic",   "Ara"),
  ("bulgarian","Bul"),
  ("catalan",  "Cat"),
  ("danish",   "Dan"),
  ("english",  "Eng"),
  ("finnish",  "Fin"),
  ("french",   "Fre"),
  ("hindi",    "Hin"),
  ("german",   "Ger"),
  ("interlingua","Ina"),
  ("italian",  "Ita"),
  ("norwegian","Nor"),
  ("russian",  "Rus"),
  ("spanish",  "Spa"),
  ("swedish",  "Swe"),
  ("thai",     "Tha")
  ]

-- languagues for which to compile Lang
langsLang = langs `except` ["Ara"]

-- languages for which to compile Try 
langsAPI  = langsLang `except` ["Bul","Cat","Hin","Ina","Rus","Tha"]

-- languages for which to compile Mathematical 
langsMath = langsAPI

-- languages for which to run treebank test
langsTest = langsLang `except` ["Bul","Cat","Hin","Rus","Spa","Tha"]

-- languages for which to run demo test
langsDemo = langsLang `except` ["Bul","Hin","Ina","Rus","Tha"] ---- fix utf8 for Bul,Rus

-- languages for which langs.pgf is built
langsPGF = langsTest `only` ["Eng","Fre","Swe"]

treebankExx = "exx-resource.gft"
treebankResults = "exx-resource.gftb"

main = do
  xx <- getArgs
  make xx

make xx = do
  let ifx  opt act = if null xx || elem opt xx then act >> return () else return () 
  let ifxx opt act = if            elem opt xx then act >> return () else return () 
  let pres = elem "present" xx
  let dir = if pres then "../present" else "../alltenses"
   
  let optl ls = maybe ls id $ getOptLangs xx

  ifx "lang" $ do
    mapM_ (gfc pres [] . lang) (optl langsLang)
    system $ "cp */*.gfo " ++ dir
  ifx "api" $ do
    mapM_ (gfc pres presApiPath . try) (optl langsAPI)
    system $ "cp */*.gfo " ++ dir
  ifx "math" $ do
    mapM_ (gfc False [] . math) (optl langsMath)
    system $ "cp mathematical/*.gfo ../mathematical"
    mapM_ (gfc False [] . symbolic) (optl langsMath)
    system $ "cp mathematical/Symbolic*.gfo ../mathematical"
  ifxx "pgf" $ do
    system $ "gfc -s --make --name=langs --parser=off --output-dir=" ++ dir ++ " " ++
              unwords [dir ++ "/Lang" ++ la ++ ".gfo" | (_,la) <- optl langsPGF] ++
              " +RTS -K100M"
  ifxx "test" $ do
    gf treeb $ unwords [dir ++ "/Lang" ++ la ++ ".gfo" | (_,la) <- optl langsTest]
  ifxx "demo" $ do
    gf demos $ unwords ["demo/Demo" ++ la ++ ".gf" | (_,la) <- optl langsDemo]
  ifxx "clean" $ do
    system "rm */*.gfo ../alltenses/*.gfo ../present/*.gfo"
  ifxx "clone" $ do
    let (pref,lang) = case getLangName xx of
          Just pl -> pl
          _ -> error "expected flag option file=ppppppLLL.gf"
    s <- readFile (pref ++ lang ++ ".gf")
    mapM_ (\la -> writeFile (pref ++ la ++ ".gf") (replaceLang lang la s)) (map snd (optl langs))
  return ()

gfc pres ppath file = do
  let preproc = if pres then " -preproc=./mkPresent " else ""
  let path    = if pres then ppath else ""
  putStrLn $ "compiling " ++ file
  system $ "gfc -s -src " ++ preproc ++ path ++ file

gf comm file = do
  putStrLn $ "reading " ++ file
  system $ "echo \"" ++ comm ++ "\" | gf3 -s " ++ file

treeb = "rf -lines -tree -file=" ++ treebankExx ++ 
        " | l -treebank | wf -file=" ++ treebankResults

demos = "gr -number=100 | l -treebank | ps -to_utf8 -to_html | wf -file=resdemo.html"

lang (lla,la) = lla ++ "/Lang" ++ la ++ ".gf"
try  (lla,la) = "api/Try"  ++ la ++ ".gf"
math (lla,la) = "mathematical/Mathematical"  ++ la ++ ".gf"
symbolic (lla,la) = "mathematical/Symbolic"  ++ la ++ ".gf"

except ls es = filter (flip notElem es . snd) ls
only   ls es = filter (flip elem es . snd) ls

presApiPath = " -path=api:present "

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

