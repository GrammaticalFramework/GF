module Main where

import System

-- Make commands for compiling and testing resource grammars.
-- usage: runghc Make (lang | api | pgf | test | clean)?
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
  ("german",   "Ger"),
  ("interlingua","Ina"),
  ("italian",  "Ita"),
  ("norwegian","Nor"),
  ("russian",  "Rus"),
  ("spanish",  "Spa"),
  ("swedish",  "Swe")
  ]

-- languagues for which to compile Lang
langsLang = langs `except` ["Ara","Ina","Rus"]

-- languages for which to compile Try 
langsAPI  = langsLang `except` ["Bul","Cat"]

-- languages for which to run treebank test
langsTest = langsLang `except` ["Bul","Cat","Spa"]

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
  ifx "lang" $ do
    mapM_ (gfc . lang) langsLang
    system $ "cp */*.gfo ../alltenses"
  ifx "api" $ do
    mapM_ (gfc . try) langsAPI
    system $ "cp */*.gfo ../alltenses"
  ifxx "pgf" $ do
    system $ "gfc -s --make --name=langs --parser=off --output-dir=../alltenses " ++
              unwords ["../alltenses/Lang" ++ la ++ ".gfo" | (_,la) <- langsPGF] ++
              " +RTS -K100M"
  ifxx "test" $ do
    gf treeb $ unwords ["../alltenses/Lang" ++ la ++ ".gfo" | (_,la) <- langsTest]
  ifxx "clean" $ do
    system "rm */*.gfo ../alltenses/*.gfo"
  return ()

gfc file = do
  putStrLn $ "compiling " ++ file
  system $ "gfc -s " ++ file

gf comm file = do
  putStrLn $ "reading " ++ file
  system $ "echo \"" ++ comm ++ "\" | gf3 -s " ++ file

treeb = "rf -lines -term -file=" ++ treebankExx ++ 
        " | l -treebank | wf -file=" ++ treebankResults

lang (lla,la) = lla ++ "/Lang" ++ la ++ ".gf"
try  (lla,la) = "api/Try"  ++ la ++ ".gf"

except ls es = filter (flip notElem es . snd) ls
only   ls es = filter (flip elem es . snd) ls
