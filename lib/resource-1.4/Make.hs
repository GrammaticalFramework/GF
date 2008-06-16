module Main where

import System

-- Make commands for compiling and testing resource grammars.
-- usage: runghc Make present? (lang | api | pgf | test | clean)?
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
langsLang = langs `except` ["Ara","Rus"]

-- languages for which to compile Try 
langsAPI  = langsLang `except` ["Cat","Hin","Tha"]

-- languages for which to run treebank test
langsTest = langsLang `except` ["Cat","Hin","Spa","Tha"]

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
  ifx "lang" $ do
    mapM_ (gfc pres [] . lang) langsLang
    system $ "cp */*.gfo " ++ dir
  ifx "api" $ do
    mapM_ (gfc pres presApiPath . try) langsAPI
    system $ "cp */*.gfo " ++ dir
  ifxx "pgf" $ do
    system $ "gfc -s --make --name=langs --parser=off --output-dir=" ++ dir ++ " " ++
              unwords [dir ++ "/Lang" ++ la ++ ".gfo" | (_,la) <- langsPGF] ++
              " +RTS -K100M"
  ifxx "test" $ do
    gf treeb $ unwords [dir ++ "/Lang" ++ la ++ ".gfo" | (_,la) <- langsTest]
  ifxx "clean" $ do
    system "rm */*.gfo ../alltenses/*.gfo ../present/*.gfo"
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

lang (lla,la) = lla ++ "/Lang" ++ la ++ ".gf"
try  (lla,la) = "api/Try"  ++ la ++ ".gf"

except ls es = filter (flip notElem es . snd) ls
only   ls es = filter (flip elem es . snd) ls

presApiPath = " -path=api:present "

