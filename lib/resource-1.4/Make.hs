module Main where

import System

langs = [
--  ("arabic",   "Ara"),
--  ("bulgarian","Bul"),
--  ("catalan",  "Cat"),
  ("danish",   "Dan"),
  ("english",  "Eng"),
  ("finnish",  "Fin"),
  ("french",   "Fre"),
  ("german",   "Ger"),
--  ("interlingua","Ina"),
  ("italian",  "Ita"),
  ("norwegian","Nor"),
--  ("russian",  "Rus"),
  ("spanish",  "Spa"),
  ("swedish",  "Swe")
  ]


main = do
  xx <- getArgs
  make xx

make xx = case xx of
  _ -> do
--    mapM_ (gfc . lang) langs
--    system $ "cp */*.gfo ../alltenses"
    mapM_ (gfc . try) langs
    system $ "cp */*.gfo ../alltenses"

gfc file = do
  putStrLn $ "compiling " ++ file
  system $ "gfc -s " ++ file

lang (lla,la) = lla ++ "/Lang" ++ la ++ ".gf"
try  (lla,la) = "api/Try"  ++ la ++ ".gf"
